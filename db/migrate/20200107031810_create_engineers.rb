class CreateEngineers < ActiveRecord::Migration[5.2]
  def change
    create_table :engineers do |t|

      t.integer :profile_image, null: false
      t.text :introduction, null: false
      t.integer :rank, null: false
      t.integer :offer, null: false
      t.timestamps
    end
  end
end
