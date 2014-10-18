module Vibe
  # Raised when Vibe returns the HTTP status code 401
  module Error
    class Unauthorized < ServiceError
      def initialize(env)
        super(env)
      end
    end
  end # Error
end
