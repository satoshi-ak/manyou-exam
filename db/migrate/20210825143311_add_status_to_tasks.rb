class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :string
    add_column :tasks, :priority, :string
  end
end