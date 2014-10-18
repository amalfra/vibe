module Vibe
  # Raised when Vibe returns any of the HTTP status codes
  module Error
    class ServiceError < VibeError
      attr_accessor :http_headers

      def initialize(env)
        super(generate_message(env))
        @http_headers = env[:response_headers]
      end

      def generate_message(env)
        if ENV['DEBUG']
          "#{env[:method].to_s.upcase} #{env[:url].to_s}: #{env[:status]} #{env[:body]}"
        else
          env[:body]
        end
      end
    end
  end # Error
end
