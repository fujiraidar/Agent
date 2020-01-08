class CreateEngineers < ActiveRecord::Migration[5.2]
  def change
    create_table :engineers do |t|

      t.string :profile_image_id, null: false
      t.text :introduction, null: false
      t.integer :rank, null: false
      t.integer :offer, null: false
      t.timestamps
    end
  end
end
