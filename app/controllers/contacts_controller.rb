class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    contact = Contact.new(contact_params)
    return unless contact.save

    ContactMailer.contact_mail(contact).deliver
    ContactMailer.reply_mail(contact).deliver
    redirect_to root_path, notice: 'お問い合わせメールが送信されました'
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :content)
    end
end
