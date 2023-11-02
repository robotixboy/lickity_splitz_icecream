class MenuController < ApplicationController
    def login
    end

    def show
        session[:customer]
        @food = Food.find(params[:id])
    end

    def orderingMenu
        session[:customer] = Customer.find_by(first_name: session[:firstName],phone_number: session[:phoneNumber])
        puts "------------------------------------------"
        puts session[:customer]
        puts "------------------------------------------"
        @viewableMenu = params[:value]
        @lunchAndDinnerMenu = Food.where(isBreakfast: true)
        @breakfastMenu = Food.where(isBreakfast: false)
    end

    def confirmation
        @customers_temp_orders = TempOrder.where(customer_id: session[:customer]["id"])
        puts @customers_temp_orders
    end

    def order
        @temp_order = TempOrder.new
        @temp_orders = TempOrder.all

        @foods = Food.all
        session[:customer] = Customer.find_by(first_name: session[:firstName],phone_number: session[:phoneNumber])
        puts session[:customer]
        @customers_temp_orders = TempOrder.where(customer_id: session[:customer].id)
    end
end
