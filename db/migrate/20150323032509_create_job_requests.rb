class CreateJobRequests < ActiveRecord::Migration
  def change
    create_table :job_requests do |t|
      t.integer :analysis_type_id
      t.integer :researcher_id
      t.string :samples
      t.string :project
      t.text :comments

      t.timestamps null: false
    end
  end
end
