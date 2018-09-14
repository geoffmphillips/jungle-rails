class OrdersController < ApplicationController

  before_filter :authorize
  helper_method :get_product

  def show
    @order = Order.find(params[:id])
    @line_items = LineItem.where(order_id: @order.id)
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)
    # @order = Order.find(params[:id])
    # @line_items = LineItem.where(order_id: @order.id)

    if order.valid?
      empty_cart!
      params = {order: @order, line_items: @line_items}
      OrderMailer.purchase_email(params).deliver_now
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  def get_product product_id
    @product = Product.find(product_id)
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: "geoffreymartinphillips@gmail.com",
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

end
