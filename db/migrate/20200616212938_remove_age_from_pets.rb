class RemoveAgeFromPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :age, :integer
  end
end
