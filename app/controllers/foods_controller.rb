class FoodsController < ApplicationController
    def create
        @food = Food.new(food_params)
        
        if @food.save
            redirect_to employees_home_url
        else
            render root_url # Render the 'home' template if saving fails
        end
    end

    private
    def food_params
        params.require(:food).permit(:food_name, :food_additions, :food_modifiables, :inital_cost, :isBreakfast, :description)
    end
end
