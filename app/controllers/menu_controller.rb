class MenuController < ApplicationController
    def login
        session[:customer] = nil
    end

    def show #shows the menu item clicked on
        session[:customer]
        @food = Food.find(params[:id])
    end

    def orderingMenu #Grabs value from previous page and Adds logged in customer information to the session
        session[:customer] = Customer.find_by(first_name: session[:firstName],phone_number: session[:phoneNumber]) || nil
        if !session[:customer].nil?
            @customers_temp_orders = TempOrder.where(customer_id: session[:customer]["id"])
        end
        @total = 0
        if @customers_temp_orders
          @customers_temp_orders.each do |foodItem|
            @total += (foodItem.total_cost).to_f
          end
        end

        @viewableMenu = params[:value]
        @lunchAndDinnerMenu = Food.where(isBreakfast: false)
        @breakfastMenu = Food.where(isBreakfast: true)
    end

    def confirmation
        @customers_temp_orders = TempOrder.where(customer_id: session[:customer]["id"])
    end

    def order
        @temp_order = TempOrder.new
        @temp_orders = TempOrder.all

        @foods = Food.all
        session[:customer] = Customer.find_by(first_name: session[:firstName],phone_number: session[:phoneNumber])
        if session[:customer] != nil
            @customers_temp_orders = TempOrder.where(customer_id: session[:customer].id)
        end
    end

    def set_isBreakfast_true
        session[:isBreakfast] = true
        redirect_to ordering_menu_path
    end

    def set_isBreakfast_false
        session[:isBreakfast] = false
        redirect_to ordering_menu_path
    end
end
