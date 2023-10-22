class EmployeeController < ApplicationController

    @my_array = []

    def login
        @employee = Employee.new
        @addition = Addition.new
        @additions = Addition.all
        #reset_session
    end

    def addition
        session[:addition] ||= []

        session[:addition] << params[:your_variable].to_json
        
        puts session[:addition]
        puts "==============================================="

        redirect_to employee_index_url
    end

    def addingFood
        puts "DELETE"
        @food = Food.new
        @food.food_additions = session[:addition] || []
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
