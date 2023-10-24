class EmployeeController < ApplicationController

    @my_array = []

    def login
        @employee = Employee.new
        @addition = Addition.new
        @additions = Addition.all
        @foods = Food.all
        #reset_session
    end

    def addition
        session[:addition] ||= []

        session[:addition] << params[:your_variable]
        
        puts session[:addition]
        puts "==============================================="

        redirect_to employee_index_url
    end

    def addingFood
        @food = Food.new
        @food.food_additions = (session[:addition] || []).map { |json_str| JSON.parse(json_str) }
        @food.food_modifiables = ""
        @food.food_name = params[:food_name]
        @food.inital_cost = params[:inital_cost]
    
        session[:addition] = []
    
        if @food.save
            redirect_to employee_index_url
        else
            puts @food.errors.full_messages
            render root_url # Render the 'home' template if saving fails
        end
    end
    
      

    private
    def employee_params
        params.require(:employees).permit(:username, :password, :phone_number, :authorization_key)
    end

end
