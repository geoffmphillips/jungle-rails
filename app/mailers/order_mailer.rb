class OrderMailer < ApplicationMailer
  default from: 'orders@jungle.com', to: 'geoffreymartinphillips@gmail.com'

  layout "mailer"

  def purchase_email params
    puts params
    @email = params[:email]
    @order = params[:order]
    @line_items = params[:line_items]

    mail(to: "geoffreymartinphillips@gmail.com", subject: 'Order confirmation for order#')
  end

  def get_product
    @product = Product.find(product_id)
  end
end
