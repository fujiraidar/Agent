class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|

      t.integer :engineer_id, null: false
      t.string :language, null: false
      t.integer :experience_year, null: false
      t.timestamps
    end
  end
end
