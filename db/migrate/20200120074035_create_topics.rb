class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|

      t.integer :company_id, null: false
      t.string :language, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
