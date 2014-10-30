module Vibe
  # Raised for Errors related to Client
  module Error
    class ClientError < VibeError
      attr_reader :problem, :summary, :resolution

      def initialize(message)
        super(message)
      end

      def generate_message(attributes)
        "\nProblem:\n #{attributes[:problem]}"+
        "\nSummary:\n #{attributes[:summary]}"+
        "\nResolution:\n #{attributes[:resolution]}"
      end
    end
  end # Error
end
