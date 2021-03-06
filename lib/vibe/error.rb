module Vibe
  module Error
    class VibeError < StandardError
      attr_reader :response_message, :response_headers

      def initialize(message)
        super(message)
        @response_message = message
      end
    end
  end # Error
end

%w[
  service_error
  not_found
  forbidden
  bad_request
  unauthorized
  service_unavailable
  internal_server_error
  unprocessable_entity
  client_error
  invalid_options
  required_params
  unknown_value
].each do |error|
  require "vibe/error/#{error}"
end
