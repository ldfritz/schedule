require_relative "lib/schedule"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.test_files = FileList['test/test*.rb']
end

desc "Print the rest of this month's schedule"
task :print do
  require "date"
  today = Date.parse(DateTime.now.strftime("%Y-%m-%d"))
  first_of_next_month = today + 1
  until today.month != first_of_next_month.month
    first_of_next_month += 1
  end
#  first_of_month_after = first_of_next_month + 27
#  until first_of_month_after.month != first_of_next_month.month
#    first_of_month_after += 1
#  end
  schedule = Schedule.load_file("schedule.yaml")
  schedule = schedule.find_all {|d, _| d >= today and d < first_of_next_month }
#  schedule = schedule.find_all {|d, _| d >= first_of_next_month and d < first_of_month_after }
  schedule.each do |date, events|
    puts date.strftime("%a %Y-%m-%d")
    events.each do |event|
      print "  "
      if event.end_date and event.end_date != event.start_date
        print event.start_date.strftime("%m/%d")
        print " " + event.start_time if event.start_time
        print "-" + event.end_date.strftime("%m/%d")
        print " " + event.end_time if event.end_time
        print " "
      elsif event.start_time or event.end_time
        print event.start_time if event.start_time
        print "-" + event.end_time if event.end_time
        print " "
      end
      print event.desc + "\n"
    end
    puts
  end
end

task :default => :print
