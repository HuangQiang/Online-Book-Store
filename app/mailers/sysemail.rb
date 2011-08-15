class Sysemail < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sysemail.sent.subject
  #
  def sent(customer,sent_at=Time.now)
    subject  'active your account,from Co_coder online bookstore'
    recipients customer.email
	from 'lzy08386042@gmail.com'
	sent_on   sent_at
	body   :customer => customer
	content_type "text/html"

  end
  

end
