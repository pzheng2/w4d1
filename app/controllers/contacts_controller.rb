class ContactsController < ApplicationController

  def index
    user = User.find_by_id(params[:user_id])
    my_contacts = user.shared_contacts
    render json: my_contacts
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    contact = Contact.find_by_id(params[:id])
    render json: contact
  end

  def update
    contact = Contact.find_by_id(params[:id])
    if contact.update(contact_params)
      render json: "Updated"
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    contact = Contact.find_by_id(params[:id])
    if contact.destroy
      render json: "Destroyed"
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end

end
