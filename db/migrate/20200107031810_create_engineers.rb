class CreateEngineers < ActiveRecord::Migration[5.2]
  def change
    create_table :engineers do |t|

      t.integer :user_id
      t.string :surname
      t.string :name
      t.integer :age
      t.string :profile_image_id
      t.text :introduction, null: false
      t.integer :rank, null: false
      t.integer :offer, null: false
      t.integer :follows_count
      t.timestamps
    end
  end
end
