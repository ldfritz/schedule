$LOAD_PATH.unshift("#{File.expand_path(File.dirname(__FILE__))}/../lib")

require "schedule"
require "minitest/autorun"

class TestEvent < Minitest::Test # :nodoc:
  def setup
    @e1 = Event.new(["2015-02-14T18:00", "2015-02-14T20:00", "Valentine's dinner"])
    @e2 = Event.new(["2015-02-14", "Valentine's Day"])
  end

  def test_dates_and_times_and_description
    assert_equal(Date.parse("2015-02-14"), @e1.start_date)
    assert_equal("18:00", @e1.start_time)
    assert_equal(Date.parse("2015-02-14"), @e1.end_date)
    assert_equal("20:00", @e1.end_time)
    assert_equal("Valentine's dinner", @e1.desc)
    assert_equal(Date.parse("2015-02-14"), @e2.start_date)
    assert_nil(@e2.start_time)
    assert_nil(@e2.end_date)
    assert_nil(@e2.end_time)
    assert_equal("Valentine's Day", @e2.desc)
  end
end
