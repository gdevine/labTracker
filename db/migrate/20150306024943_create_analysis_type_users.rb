class CreateAnalysisTypeUsers < ActiveRecord::Migration
  def change
    create_table :analysis_type_users do |t|
      t.integer :analysis_type_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
