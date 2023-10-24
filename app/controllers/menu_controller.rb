class MenuController < ApplicationController
    def login
        
    end

    def order
        @temp_order = TempOrder.new
        @temp_orders = TempOrder.all

        @foods = Food.all
        session[:customer] = Customer.find_by(first_name: session[:firstName],phone_number: session[:phoneNumber])
        @customers_temp_orders = TempOrder.where(customer_id: session[:customer].id)

        puts "THIS IS THE BEGINNING OF THE TESTING!!!!!"
        puts session[:customer].id
        puts @customers_temp_orders

        puts "THIS IS THE ENDING OF THE TESTING!!!!!"

    end
end
