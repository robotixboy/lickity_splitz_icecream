class FoodTagsController < ApplicationController
    def create
      @foodTag = FoodTag.new(food_tags_params)
      puts "=================================="
      puts @foodTag.food_Tag_Name
      if @foodTag.save
        redirect_to employee_index_url
      else
        render 'home'
      end
    end
  
    private
  
    def food_tags_params
      params.require(:food_tag).permit(:food_Tag_Name)
    end
  end
