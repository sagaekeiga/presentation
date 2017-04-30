class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
 
  def create
    @contact = Contact.new(contact_params)
    MailSenderMailer.inquiry(@contact).deliver 
    respond_to do |format|
         if @contact.save
                    format.html { redirect_to root_path, notice: 'お問い合わせメールが送信されました。' }
         else
           format.html { render action: 'new' }
         end
       end
  end
 
    private
    def contact_params
      params.require(:contact).permit(:email, :name, :message)
    end
end
