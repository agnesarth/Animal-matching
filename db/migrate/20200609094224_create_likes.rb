class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :pet, foreign_key: true
      t.integer :liked_pet_id
      t.boolean :match, default: false

      t.belongs_to :pet, foreign_key: true

      t.timestamps
    end
  end
end
