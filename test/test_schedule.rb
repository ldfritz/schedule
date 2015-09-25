$LOAD_PATH.unshift("#{File.expand_path(File.dirname(__FILE__))}/../lib")

require "schedule"
require "minitest/autorun"

class TestSchedule < Minitest::Test # :nodoc:
  def setup
    @schedule = Schedule.new([
      Event.new(["2015-02-14T18:00", "2015-02-14T20:00", "Valentine's dinner"]),
      Event.new(["2015-02-14", "Valentine's Day"]),
      Event.new(["2015-02-15T08:00", "wake up"])
    ])
  end

  def test_events_for_date
    assert_equal(0, @schedule["2015-02-13"].length)
    assert_equal(2, @schedule["2015-02-14"].length)
    assert_equal("Valentine's Day", @schedule["2015-02-14"].first.desc)
  end

  def test_iterate_dates
    expected = "14\t2\n15\t1"
    assert_equal(expected, @schedule.collect {|date, events| date.strftime("%d\t#{events.length}") }.join("\n"))
  end
end
