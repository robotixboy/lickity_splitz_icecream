class OrdersController < ApplicationController
    def create
        #creates the object Order to start creating
        @order = Order.new(order_params)
        #Takes all the information that sent through the form
        @order.list_food_id = order_params[:list_food_id].to_json
        @order.list_food_notes = order_params[:list_food_notes].to_json
        @order.customer_id = session[:customer]["id"]
        @order.completed_order = 0

        #This while loop will loop through random numbers until an order id that isnt in the database has been chosen
        possibleOrderId = rand(1000000..9999999)
        while Order.find_by(order_id: possibleOrderId) != nil do
          possibleOrderId = rand(1000000..9999999)
        end
        @order.order_id = possibleOrderId

        #If the order was able to be saved we need to destory all the temp  orders that are using the customer logged in
        if @order.save
          @customersFoodItems = TempOrder.where(customer_id: session[:customer]["id"])
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
