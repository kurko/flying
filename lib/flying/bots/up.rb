require "net/http"

module Flying
  module Bot
    class Up
      attr_reader :message, :error, :referer
      #
      # => Name
      #
      # How a service is known. Useful reusing and setting dependencies.
      #
      #   e.g. `site "etc.com", :as => :google`
      #   name is :google.
      #
      # => Dependency
      #
      # When a service depends on another, it has dependencies. This is
      # an array with the Name of each service.
      #
      attr_accessor :name, :dependency

      def initialize(referer, options = {})
        @referer = referer
        @options = options
        @message = "Ok."
        @error = false
        @name = options[:as] if options.include?(:as)
        @dependency = []
        
        # Dependency can be one or an array of symbols, whereas @dependency 
        # must be only a flat array
        if options.include?(:depends_on)
          @dependency << options[:depends_on] if options[:depends_on].kind_of? Symbol
          @dependency = options[:depends_on] if options[:depends_on].kind_of? Array
        end
      end
      
      # Starts assessment of the current service using variables set during
      # initialization
      def assess
        @error = false
        begin
          response_code = get_http_response_code(@referer)
        rescue
          Flying.an_error_ocurred(true)
          set_error_message(@referer, false, $!)
          return false
        end
        return true if ["200", "302"].include? response_code
        Flying.an_error_ocurred(true)
        set_error_message(@referer, response_code.to_s)
        false
      end
      
      def set_error_message(referer, response_code, error_details = '')
        @error = true
        case response_code
        when false
          @message = message_unreachable
        when "404"
          @message = message_not_found
        when "501"
          @message = message_server_error
        else
          @message = message_unknown_error + "(#{error_details})"
        end
        @message = "\e[31m" + referer + ": " + @message + "\e[0m"
      end
      
      def get_http_response_code referer
        Net::HTTP.get_response(URI(referer)).code
      end
      
      # Messages
      def message_unknown_error
        "An unknown error ocurred."
      end
      
      def message_unreachable
        "It is unreachable (is the url correct?)."
      end
      
      def message_not_found
        "The target was simply not found (404)."
      end

      def message_server_error
        "We got a response saying there's a server error (501)"
      end
    end
  end
end