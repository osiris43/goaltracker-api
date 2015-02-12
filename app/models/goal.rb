class Goal < ActiveRecord::Base
  belongs_to :activity
  belongs_to :unit
  belongs_to :timeframe
end
