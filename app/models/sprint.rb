class Sprint < ActiveRecord::Base
  validates :started_at, :presence => true
  validates :finished_at, :presence => true
  validates :state, :presence => true
end
