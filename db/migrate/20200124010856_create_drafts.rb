class CreateDrafts < ActiveRecord::Migration[5.2]
  def change
    create_table :drafts do |t|

      t.integer :engineer_id, null: false
      t.string :title
      t.text :body
      t.string :language
      t.timestamps
    end
  end
end
