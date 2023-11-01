class EmployeeController < ApplicationController

    def login
        @employee = Employee.new
        @addition = Addition.new
        @additions = Addition.all
        @foods = Food.all
        @temp_order = TempOrder.new
        @temp_orders = TempOrder.all
        @orders = Order.all
        @order = Order.new
        #reset_session #This can be used to completly reset the session// This can fix cookie errors
    end

    def addition #This is how we are storing each addition into an array before we add it to the food item
        session[:addition] ||= []
        session[:addition] << params[:your_variable]
        redirect_to employee_index_url
    end

    def addingFood #Adding a food to the Food DB table: This will reset the session array 
        @food = Food.new
        @food.food_additions = (session[:addition] || []).map { |json_str| JSON.parse(json_str) }
        @food.food_modifiables = ""
        @food.food_name = params[:food_name]
        @food.inital_cost = params[:inital_cost]
        @food.isBreakfast = params[:isBreakfast]
    
        session[:addition] = []
    
        if @food.save
            redirect_to employee_index_url
        else
            render root_url
        end
    end
    
      

    private
    def employee_params
        params.require(:employees).permit(:username, :password, :phone_number, :authorization_key)
    end

end
