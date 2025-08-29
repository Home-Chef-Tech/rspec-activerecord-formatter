require_relative "helpers/collector"
require_relative "helpers/report"

class ActiveRecordProgressFormatter < ::RSpec::Core::Formatters::ProgressFormatter
  attr_reader :collector, :colorizer, :report

  ::RSpec::Core::Formatters.register self, :start, :dump_summary,
                                           :example_started, :example_group_started,
                                           :example_group_finished, :example_passed,
                                           :example_pending

  def initialize(output)
    super

    @colorizer  = ::RSpec::Core::Formatters::ConsoleCodes
    @collector  = ActiveRecordFormatterHelpers::Collector.new
    @report     = ActiveRecordFormatterHelpers::Report.new(collector)
    RSpec.configure do |config|
      config.add_setting :progress_color, :default => true
    end
  end

  def start(_start_notification)
    output.puts "Recording and reporting ActiveRecord select and creation counts."
    super
  end

  def example_passed(_notification)
    if RSpec.configuration.progress_color
      super(_notification)
    else
      print '.'
    end
  end

  def example_pending(_notification)
    if RSpec.configuration.progress_color
      super(_notification)
    else
      print '*'
    end
  end

  def example_group_started(example_group)
    collector.group_started(example_group.group)
    super
  end

  def example_group_finished(example_group)
    collector.group_finished(example_group.group)
  end

  def example_started(example)
    collector.reset_example(example)
  end

  def dump_summary(summary)
    base = ActiveRecordFormatterBase.new(summary, collector)
    output.puts base.colorized_summary

    output.puts "\nOutputting Detailed Profile Data to #{report.report_path}"
    report.write
  end
end
