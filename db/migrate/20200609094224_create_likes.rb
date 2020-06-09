class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :liker, index: true
      t.references :liked, index: true
      t.boolean :match, default: false

      t.timestamps
    end
  end
end
