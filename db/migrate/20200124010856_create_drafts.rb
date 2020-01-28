class CreateDrafts < ActiveRecord::Migration[5.2]
  def change
    create_table :drafts do |t|

      t.integer :engineer_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :language, null: false
      t.timestamps
    end
  end
end
