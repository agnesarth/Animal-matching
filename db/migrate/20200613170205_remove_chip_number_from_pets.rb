class RemoveChipNumberFromPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :chip_number, :string
  end
end
