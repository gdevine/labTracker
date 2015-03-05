class ChangeRoleToDefault < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => 'unassigned'
  end
end
