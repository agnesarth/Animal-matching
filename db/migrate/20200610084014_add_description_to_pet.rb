class AddDescriptionToPet < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :description, :text
  end
end
