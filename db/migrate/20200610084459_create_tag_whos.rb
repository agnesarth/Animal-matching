class CreateTagWhos < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_whos do |t|
      t.references :tag, foreign_key: true
      t.references :pet, foreign_key: true

      t.timestamps
    end
  end
end
