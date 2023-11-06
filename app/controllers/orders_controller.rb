class OrdersController < ApplicationController
    def create
        @order = Order.new(order_params)
        @order.list_food_id = order_params[:list_food_id].to_json
        @order.list_food_notes = order_params[:list_food_notes].to_json
        @order.order_id = rand(1000000..9999999)
        @order.customer_id = session[:customer]["id"]
        @order.completed_order = 0
        if @order.save
          @customersFoodItems = TempOrder.where(customer_id: session[:customer]["id"])
          puts "START OF TESTING -----------------------"
          puts @customersFoodItems
          puts "END OF TESTING -----------------------"
          puts !@customersFoodItems.empty?
          if !@customersFoodItems.empty?
            puts "DELETED"
              @customersFoodItems.each(&:destroy)
          end

          redirect_to root_url
        else
          render root_url # Render the 'home' template if saving fails
        end
        reset_session
    end
    
    private
    def order_params
        params.require(:order).permit(:customer_id, :order_id, :list_food_id, :list_food_notes, :total_cost, :completed_order)
    end
end
