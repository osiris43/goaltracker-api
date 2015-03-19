class ProgressEvent < ActiveRecord::Base
  belongs_to :goal

  def as_json(options={})
    {
      :id => id,
      :progress => number,
      :goal => goal.activity.description
    }
  end
end
