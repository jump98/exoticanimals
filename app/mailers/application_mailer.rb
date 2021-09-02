class ApplicationMailer < ActionMailer::Base
  default from: "postmaster@yohokafun.com"
  layout 'mailer'
end