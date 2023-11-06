class CustomersController < ApplicationController
  def create
    @customer = Customer.new(customer_params)
    firstName = params[:customer][:first_name]
    phoneNumber = params[:customer][:phone_number]
    customerFound = Customer.find_by(first_name: firstName, phone_number: phoneNumber)

    if customerFound.blank?
      if @customer.save
        redirect_to menu_order_path
      else
        render 'home'
      end
    else
      redirect_to menu_order_path
    end
    session[:phoneNumber] = phoneNumber
    session[:firstName] = firstName
    session[:customer] = Customer.find_by(first_name: session[:firstName],phone_number: session[:phoneNumber]) || nil
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :phone_number)
  end
end

