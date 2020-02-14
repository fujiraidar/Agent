class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|

      t.integer :company_id, null: false
      t.string :title, null: false
      t.text :job, null: false
      t.integer :status, null: false
      t.string :salary, null: false
      t.string :job_image_id
      t.timestamps
    end
  end
end