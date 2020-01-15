class CreateEngineers < ActiveRecord::Migration[5.2]
  def change
    create_table :engineers do |t|

      t.integer :user_id, null: false
      t.string :surname, null: false
      t.string :name, null: false
      t.integer :age, null: false
      t.string :profile_image_id
      t.text :introduction
      t.integer :rank, null: false
      t.integer :offer, null: false
      t.integer :follows_count
      t.timestamps
    end
  end
end
