class MenuController < ApplicationController
    def login
        
    end

    def order
        @temp_order = TempOrder.new
        @temp_orders = TempOrder.all
        @foods = Food.all
        session[:customer] = Customer.find_by(first_name: session[:firstName],phone_number: session[:phoneNumber])
    end
end
