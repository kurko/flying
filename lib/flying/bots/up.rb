require "net/http"

module Flying
  module Bot
    class Up
      attr_reader :message
      
      def initialize
        @message = "Ok."
      end
      
      def assess(referer, *options)
        begin
          response_code = get_http_response_code(referer)
        rescue
          Flying.an_error_ocurred(true)
          set_error_message(referer, false, $!)
          return false
        end
        return true if ["200", "302"].include? response_code
        Flying.an_error_ocurred(true)
        set_error_message(referer, response_code.to_s)
        false
      end
      
      def set_error_message(referer, response_code, error_details = '')
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
        @message = referer + ": " + @message
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