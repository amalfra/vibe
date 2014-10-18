module Vibe
  # Raised when Vibe returns the HTTP status code 404
  module Error
    class NotFound < ServiceError
      def initialize(env)
        super(env)
      end
    end
  end # Error
end
