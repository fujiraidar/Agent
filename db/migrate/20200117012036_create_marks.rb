class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|

      t.integer :engineer_id, null: false
      t.integer :company_id, null: false
      t.timestamps
    end
  end
end