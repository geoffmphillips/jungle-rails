class OrderMailer < ApplicationMailer
  default from: 'orders@jungle.com', to: 'geoffreymartinphillips@gmail.com'

  layout "mailer"

  def purchase_email order
    @order = order
    @line_items = LineItem.where(order_id: order.id)
    @order_total = @order.total_cents / 100.0

    mail(to: @order.email, subject: "Order confirmation for order# #{@order.id}")
  end

  def get_product id
    Product.find(id)
  end

  helper_method :get_product
end
