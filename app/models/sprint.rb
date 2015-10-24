class Sprint < ActiveRecord::Base
  scope :pending, ->{where("sprints.state = 0")}
  scope :started, ->{where("sprints.state = 1")}
  scope :finished, ->{where("sprints.state = 2")}

  validates :started_at, :presence => true
  validates :finished_at, :presence => true
  validates :state, :presence => true

  def status
    _state = state
    case _state
      when 0 then ['Pending','orange']
      when 1 then ['Active','yes']
      when 2 then ['Stopped','gray']
    end
  end
end
