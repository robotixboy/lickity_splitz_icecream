class CustomersController < ApplicationController
  def create
    @customer = Customer.new(customer_params)
    firstName = params[:customer][:first_name]
    phoneNumber = params[:customer][:phone_number]
    customerFound = Customer.find_by(first_name: firstName, phone_number: phoneNumber)

    if customerFound.blank?
      if @customer.save
        redirect_to menu_order_path # Redirect to HotCrossBuns_url upon successful registration
        puts "WELCOME !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        session[:phoneNumber] = phoneNumber
        session[:firstName] = firstName
      else
        render 'home' # Render the 'home' template if saving fails
      end
    else
      redirect_to menu_order_path # Redirect to HotCrossBuns_url upon successful registration
      puts "WELCOME BACK!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      session[:phoneNumber] = phoneNumber
      session[:firstName] = firstName
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :phone_number)
  end
end

