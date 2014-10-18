module Vibe
  # Raised when Vibe returns the HTTP status code 422
  module Error
    class UnprocessableEntity < ServiceError
      def initialize(env)
        super(env)
      end
    end
  end # Error
end
