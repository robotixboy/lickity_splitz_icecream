class AdditionsController < ApplicationController
    @my_array = []

    def create
        @addition = Addition.new(addition_params)

        if @addition.save
            redirect_to employees_home_url
        else
            render root_url
        end
    end


    private
    def addition_params
        params.require(:addition).permit(:addition_name, :cost, :isRadioButton)
    end
end
