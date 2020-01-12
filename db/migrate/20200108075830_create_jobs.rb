class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|

      t.integer :company_id
      t.string :job
      t.integer :status
      t.string :salary
      t.timestamps
    end
  end
end
