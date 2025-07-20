class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to contacts_path, notice: "Contacto criado com sucesso"
    else
      @contacts = Contact.all
      render :index, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name)
  end
end
