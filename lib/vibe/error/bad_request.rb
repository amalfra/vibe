module Vibe
  module Error
    # Raised when Vibe returns the HTTP status code 400
    class BadRequest < ServiceError
      def initialize(env)
        super(env)
      end
    end
  end
end
