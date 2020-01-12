class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|

      t.integer :engineer_id
      t.integer :company_id
      t.string :job
      t.integer :status
      t.string :salary
      t.timestamps
    end
  end
end
