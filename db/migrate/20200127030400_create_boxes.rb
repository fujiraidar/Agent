class CreateBoxes < ActiveRecord::Migration[5.2]
  def change
    create_table :boxes do |t|

      t.integer :engineer_id
      t.integer :company_id
      t.timestamps
    end
  end
end
