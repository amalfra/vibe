module Vibe
  # Raised when Vibe returns the HTTP status code 403
  module Error
    class Forbidden < ServiceError
      def initialize(env)
        super(env)
      end
    end
  end # Error
end
