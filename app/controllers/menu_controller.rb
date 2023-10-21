class MenuController < ApplicationController
    def login
        
    end

    def order
        session[:customer] = Customer.find_by(first_name: session[:firstName],phone_number: session[:phoneNumber])
    end
end
