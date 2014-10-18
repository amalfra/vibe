module Vibe
  # Raised when Vibe returns the HTTP status code 503
  module Error
    class ServiceUnavailable < ServiceError
      def initialize(env)
        super(env)
      end
    end
  end # Error
end
