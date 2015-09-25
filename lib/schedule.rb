require_relative "event"

class Schedule
  def self.load_file(filename)
    require "yaml"
    raw_events = YAML.load_file(filename)
    events = raw_events.collect {|event| Event.new(event) }
    Schedule.new(events)
  end

  def initialize(events = nil)
    @events = events || []
    self
  end

  def [](date)
    date = Date.parse(date)
    @events.find_all do |event|
      date == event.start_date or (event.end_date and date >= event.start_date and date <= event.end_date)
    end.sort
  end

  def first_date
    @events.inject(Date.parse("9999-01-01")) do |t, i|
      t = i.start_date < t ? i.start_date : t
      t
    end
  end

  def last_date
    @events.inject(Date.parse("0001-01-01")) do |t, i|
      new_t = i.start_date > t ? i.start_date : t
      (i.end_date and i.end_date > new_t) ? i.end_date : new_t
    end
  end

  include Enumerable
  def each(&blk)
    date = first_date
    while date <= last_date
      yield(date, self[date.strftime("%Y-%m-%d")])
      date += 1
    end
  end
end
