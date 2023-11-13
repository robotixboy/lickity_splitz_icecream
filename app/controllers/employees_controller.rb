class EmployeesController < ApplicationController
    def home
        @employee = Employee.new
        @addition = Addition.new
        @additions = Addition.all
        @foods = Food.all
        @temp_order = TempOrder.new
        @temp_orders = TempOrder.all
        @orders = Order.all
        @order = Order.new
        @foodTag = FoodTag.new
        @foodTags = FoodTag.all
    end

    def show
        @food = Food.find(params[:id])
        @additions = Addition.all
    end
      
      

    def updatingFoodAdditions
        @food = Food.find(params[:id])
        @food.food_additions = params[:foodAdditions]
        #@food.food_additions = []
        puts "------------------------------"
        puts params[:foodAdditions]
        
        if @food.save
            redirect_to employee_index_url
        else
            render root_url
        end
    end

    def addition #This is how we are storing each addition into an array before we add it to the food item
        session[:addition] ||= []
        session[:addition] << params[:your_variable]
        redirect_to employee_index_url
    end

    def addingFood #Adding a food to the Food DB table: This will reset the session array 
        @food = Food.new
        @food.food_additions = (session[:addition] || []).map { |json_str| JSON.parse(json_str) } || []
        @food.food_modifiables = ""
        @food.food_name = params[:food_name]
        @food.inital_cost = params[:inital_cost]
        @food.isBreakfast = params[:isBreakfast]
        @food.description = params[:description] || ""
        @food.tag = params[:tag]
    
        session[:addition] = []
    
        if @food.save
            redirect_to employee_index_url
        else
            render root_url
        end
    end

    def admin
        session[:isCompleted] ||= true
        @employee = Employee.new
    end

    def orders
        puts session[:isCompleted]
        @orders = Order.all
        @order = Order.new
    end

    def changingTag
        @food = Food.find(params[:id])
        @food.tag = params[:newTag]
        if @food.save
            redirect_to employee_index_url
        else
            render 'home'
        end
    end

    def deletingTags
        @tag = FoodTag.find(params[:id])
        @foods = Food.where(tag: @tag.food_Tag_Name)
        @foods.each do |food|
          food.update(tag: nil)
        end
        if @tag.destroy
          redirect_to employee_index_url
        else
          render 'home'
        end
    end

    def deletingAdditions
        @addition = Addition.find(params[:id])
        if @addition.destroy
            redirect_to employee_index_url
        else
            render 'home'
        end
    end

    def completingOrder
        @order = Order.find(params[:id])
      
        # Use a 3-way toggle for completed_order
        @order.completed_order = case @order.completed_order
        when 0 then 1
        when 1 then 2
        else 1
        end
      
        if @order.save
          redirect_to orders_path, notice: "Order updated successfully."
        else
          render :edit
        end
    end
    
    def create
        @employee = Employee.new(employee_params)
        if @employee.save
          redirect_to  employees_home_url
        else
          render 'home'
        end
    end
      
    private
    def employee_params
        params.require(:employee).permit(:username, :password, :phone_number, :authorization_key)
    end   

    private
    def order_params
        params.require(:order).permit(:completed_order)
    end
end