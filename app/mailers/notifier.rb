class Notifier < ActionMailer::Base
  default :from => "Sam Ruby <from@example.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received
    @greeting = "Hi"

    mail :to => "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped
    @greeting = "Hi"

    mail :to => "to@example.org"
  end
  
   def order_shipped(order)
     @order = order

    mail :to => order.email, :subject => 'Pragmatic Store Order Shipped'
  end
  
  def order_received(order)
    @order = order
    
    mail :to => order.email, :subject => 'Pragmatic Store Order Confirmation'
  end
end
