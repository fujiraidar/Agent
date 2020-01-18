class CreateHelps < ActiveRecord::Migration[5.2]
  def change
    create_table :helps do |t|

      t.integer :user_id, null: false
      t.string :language, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.integer :comments_count
      t.timestamps
    end
  end
end
