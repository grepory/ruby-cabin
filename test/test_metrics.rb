$: << File.dirname(__FILE__)
$: << File.join(File.dirname(__FILE__), "..", "lib")

require "rubygems"
require "minitest-patch"
require "cabin"
require "cabin/metrics"
require "minitest/autorun" if __FILE__ == $0

describe Cabin::Metrics do
  before do
    @metrics = Cabin::Metrics.new
  end

  #test "gauge" do
    #gauge = @metrics.gauge(self) { 3 }
    #assert_equal(3, gauge.value)
    ## metrics.first == [identifier, Gauge]
    #assert_equal(3, @metrics.first.last.value)
  #end

  test "counter" do
    counter = @metrics.counter(self)
    0.upto(30) do |i|
      assert_equal(i, counter.value)
      counter.incr
    end
    31.downto(0) do |i|
      assert_equal(i, counter.value)
      counter.decr
    end
  end

  test "meter counter" do
    meter = @metrics.meter(self)
    30.times do |i|
      assert_equal(i, meter.value)
      meter.mark
    end
  end

  test "meter time-based averages" # TODO(sissel): implement

  test "timer counter" do
    timer = @metrics.timer(self)
    30.times do |i|
      assert_equal(i, timer.count)
      timer.time { true }
    end
  end

  test "metrics from logger" do
    @logger = Cabin::Channel.new
    meter = @logger.metrics.meter(self)
    assert_equal(0, meter.value)
  end

  test "timer histogram" # TODO(sissel): implement
  test "histogram" # TODO(sissel): implement
end # describe Cabin::Channel do
