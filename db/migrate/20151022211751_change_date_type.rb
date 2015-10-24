class ChangeDateType < ActiveRecord::Migration
  def change
    change_column :sprints, :started_at, :date
    change_column :sprints, :finished_at, :date
  end
end
