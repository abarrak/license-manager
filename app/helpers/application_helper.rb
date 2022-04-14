module ApplicationHelper
  def greeting_phrase
    now      = Time.zone.now
    today    = Date.current.to_time
    morning  = today.beginning_of_day
    noon     = today.noon
    evening  = today.change hour: 17
    night    = today.change hour: 20
    tomorrow = today.tomorrow

    if (morning..noon).cover? now then t 'good_morning'
    elsif (noon..evening).cover? now then t 'good_afternoon'
    elsif (evening..night).cover? now then t 'good_evening'
    elsif (night..tomorrow).cover? now then t 'good_night'
    end
  end
end
