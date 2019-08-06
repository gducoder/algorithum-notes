class Adddefaultvaluetojobstatus < ActiveRecord::Migration[5.2]
  def change
    change_column :jobs, :status, :string, :default => "Job Created"
  end
end
