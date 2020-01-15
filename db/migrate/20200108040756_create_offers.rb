class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|

      t.integer :engineer_id, null: false
      t.integer :company_id, null: false
      t.string :title, null: false
      t.text :job, null: false
      t.integer :status, null: false
      t.string :salary, null: false
      t.timestamps
    end
  end
end
