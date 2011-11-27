# This class instance holds the current monitoring.
module Flying
  class Monitor
    
    def initialize
      # This is where each bot instance is saved.
      @bots = []
      @an_error_ocurred = false
      @first_attempt = true
      @total_attempts = 0
    end
    
    def add_bot(bot)
      @bots << bot
    end
    
    # Loops through each bot, making them perform verifications
    def perform
      puts "Running..."
      looping = true
      
      while(looping) do
        @bots.each { |bot|
          has_error = bot.error
          assessment = bot.assess
          if has_error == false && assessment == false
            @an_error_ocurred = true
            puts bot.message
          elsif has_error && assessment
            puts "\e[32m" + bot.referer + " is back online." + "\e[0m"
          end
        }
        if @first_attempt
          if @an_error_ocurred
            puts "Some services are down. I'll continue monitoring the targets anyway."
          else
            puts "Everything's working fine. I'll continue monitoring the targets."
          end
          
          @first_attempt = false
        end
        @total_attempts += 1
        sleep(5)
      end
      
    end
    
  end
end