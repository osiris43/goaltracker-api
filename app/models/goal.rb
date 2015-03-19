class Goal < ActiveRecord::Base
  belongs_to :activity
  belongs_to :unit
  belongs_to :timeframe
  has_many :progress_events

  def as_json(options={})
    {
      :id => id,
      :activity => activity.description,
      :measurement => "#{measurement} #{unit.description}",
      :timeframe => timeframe.description
    }
  end
end
