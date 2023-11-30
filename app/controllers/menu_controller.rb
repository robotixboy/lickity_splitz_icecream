class MenuController < ApplicationController

    def testing
        @temp_order = TempOrder.new
        @temp_orders = TempOrder.all

        @food = Food.find_by(id: 5)
        @testingFoods = Food.where("id < ?", 3)
        Time.zone = 'Eastern Time (US & Canada)'
        session["Time"] = Time.zone.now
        
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

    def login
        session[:employee] = nil
        session[:authorization_key] = nil
        session[:customer] = nil
    end

    def show #shows the menu item clicked on
        session[:employee] = nil
        session[:authorization_key] = nil
        session[:customer]
        @food = Food.find(params[:id])
    end

    def iceCreamMenu #ice cream menu
        session[:employee] = nil
        session[:authorization_key] = nil
        session[:customer] = Customer.find_by(first_name: session[:firstName],phone_number: session[:phoneNumber]) || nil
        if !session[:customer].nil?
            @customers_temp_orders = TempOrder.where(customer_id: session[:customer]["id"])
        end

        Time.zone = 'Eastern Time (US & Canada)'
        session["Time"] = Time.zone.now
        
        @total = 0
        if @customers_temp_orders
          @customers_temp_orders.each do |foodItem|
            @total += (foodItem.total_cost).to_f
          end
        end
    end

    def orderingMenu #Grabs value from previous page and Adds logged in customer information to the session
        session[:employee] = nil
        session[:authorization_key] = nil
        session[:customer] = Customer.find_by(first_name: session[:firstName],phone_number: session[:phoneNumber]) || nil
        if !session[:customer].nil?
            @customers_temp_orders = TempOrder.where(customer_id: session[:customer]["id"])
        end

        Time.zone = 'Eastern Time (US & Canada)'
        session["Time"] = Time.zone.now
        
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
        if session[:customer].nil? || session[:customer].blank?
            redirect_to :root
        end
        @orders = Order.where(customer_id: session["customer"]["id"])
    end

    def order
        session[:employee] = nil
        session[:authorization_key] = nil
        Time.zone = 'Eastern Time (US & Canada)'
        session["Time"] = Time.zone.now
        @temp_order = TempOrder.new
        @temp_orders = TempOrder.all

        @foods = Food.all
        session[:customer] = Customer.find_by(first_name: session[:firstName],phone_number: session[:phoneNumber])
        if session[:customer] != nil
            @customers_temp_orders = TempOrder.where(customer_id: session[:customer].id)
            @total = 0
            if @customers_temp_orders
                @customers_temp_orders.each do |foodItem|
                    @total += (foodItem.total_cost).to_f
                end
            end
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

    def deleteTempOrderItem
        @customersTempFood = TempOrder.find_by(customer_id: session[:customer]["id"], food_id: params[:foodId])
        if !@customersTempFood.nil?
            @customersTempFood.destroy
            updatingCustomersOrder()
            redirect_to ordering_menu_path
        else
            puts "Error ------------------"
            redirect_to ordering_menu_path
        end
    end

    def updatingCustomersOrder
        puts TempOrder.where(customer_id: session[:customer]["id"])
    end
end
