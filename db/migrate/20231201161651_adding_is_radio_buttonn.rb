class AddingIsRadioButtonn < ActiveRecord::Migration[7.0]
  def change
    add_column :additions, :isRadioButton, :boolean
  end
end
