class AddBirthdateToPet < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :birthdate, :datetime
  end
end
