$LOAD_PATH.unshift(File.dirname(__FILE__))
require "flying/version"
require "flying/bots/up"

require "flying/aliases/aliases"

module Flying
  @an_error_ocurred = false
  @first_attempt = true
  @total_attempts = 0

  def self.start(&block)
    begin
      puts "Running..."
      looping = true
      while(looping) do
        yield
        if @an_error_ocurred
          puts "Stopped assessing targets."
          break
        end
        if @first_attempt
          puts "Everything's working fine. I'll continue monitoring the targets."
          @first_attempt = false
        end
        @total_attempts += 1
        sleep(5)
      end
    rescue Interrupt => e
    end
  end
  
  def self.an_error_ocurred(value = '')
    return @an_error_ocurred if value == ''
    @an_error_ocurred = value
  end
end
