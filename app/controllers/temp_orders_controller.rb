class TempOrdersController < ApplicationController
    def create
        @temp_order = TempOrder.new(temp_order_params)
    
        if @temp_order.save
          redirect_to root_url
        else
          render root_url # Render the 'home' template if saving fails
        end
    end
      
    private
    def temp_order_params
        params.require(:temp_order).permit(:customer_id, :food_id, :food_modifications, :total_cost)
    end
end
