class AddJobAssignedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :job_assigned, :boolean, default: false
  end
end
