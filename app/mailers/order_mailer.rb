class OrderMailer < ApplicationMailer
  default from: 'orders@jungle.com'

  def purchase_email
    @email = params[:email]
    @order = params[:order]
    @line_items = params[:line_items]

    mail(to: @email, subject: 'Order confirmation for order# ' + @order.id)
  end

  def get_product
    @product = Product.find(product_id)
  end
end
