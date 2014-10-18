%w{version error configuration client}.each do |local|
  require "vibe/#{local}"
end

module Vibe
  extend Configuration

  # Alias for Vibe::Client.new
  #
  # @return [Vibe::Client]
  def self.new(options = { }, &block)
    @api_client = Vibe::Client.new(options, &block)
  end
end
