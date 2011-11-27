$LOAD_PATH.unshift(File.dirname(__FILE__))
require "flying/version"
require "flying/bots/up"
require "flying/monitor"

require "flying/aliases/aliases"

module Flying
  @monitor = nil
  def self.start(&block)
    begin
      @monitor.perform
    rescue Interrupt => e
    end
  end
  
  def self.an_error_ocurred(value = '')
    return @an_error_ocurred if value == ''
    @an_error_ocurred = value
  end
  
  def self.add_bot(bot)
    @monitor ||= Flying::Monitor.new
    @monitor.add_bot(bot)
  end
end
