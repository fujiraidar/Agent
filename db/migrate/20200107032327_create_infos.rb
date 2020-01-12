class CreateInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :infos do |t|

      t.integer :engineer_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :language, null: false
      t.integer :favorites_count
      t.timestamps
    end
  end
end
