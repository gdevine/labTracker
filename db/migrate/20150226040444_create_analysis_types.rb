class CreateAnalysisTypes < ActiveRecord::Migration
  def change
    create_table :analysis_types do |t|
      t.string :name
      t.string :instrument
      t.text :description

      t.timestamps null: false
    end
  end
end
