module Vibe
  # Raised when Vibe returns the HTTP status code 500
  module Error
    class InternalServerError < ServiceError
      def initialize(env)
        super(env)
      end
    end
  end # Error
end
