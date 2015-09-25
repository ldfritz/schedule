class Event
  attr_reader :start_date, :start_time, :end_date, :end_time, :desc

  def initialize(event_arr)
    @start_date, @start_time, @end_date, @end_time, @desc = Event.parse(event_arr)
  end

  include Comparable
  def <=>(other)
    start = start_date.to_s + start_time.to_s
    other_start = other.start_date.to_s + other.start_time.to_s
    if start != other_start
      start <=> other_start
    else
      desc <=> other.desc
    end
  end

  def self.parse(event_arr)
    desc = event_arr.pop
    start_date, start_time = Event.parse_time(event_arr.shift)
    end_date, end_time = Event.parse_time(event_arr.shift)
    [start_date, start_time, end_date, end_time, desc]
  end

  def self.parse_time(date_str)
    require "date"
    date = date_str ? Date.parse(date_str) : nil
    time = if date_str =~ /T/
      DateTime.parse(date_str).strftime("%H:%M")
    else
      nil
    end
    [date, time]
  end
end
