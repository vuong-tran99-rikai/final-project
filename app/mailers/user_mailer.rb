class UserMailer < ApplicationMailer
    def welcome_email(invoice)
        @invoice = invoice
        mail(to: @invoice.user.email, subject: 'Your Order')
    end
end
