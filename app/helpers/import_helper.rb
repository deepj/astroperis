# frozen_string_literal: true

module ImportHelper
  def time_spent_in_hhmmss(start_time, end_time)
    return "" if start_time.blank? || end_time.blank?

    seconds = (end_time - start_time).to_i
    seconds_to_hhmmss(seconds)
  end

  def seconds_to_hhmmss(seconds)
    [seconds / 3600, seconds / 60 % 60, seconds % 60].map { _1.to_s.rjust(2, "0") }.join(":")
  end
end
