%w{version error configuration cache client}.each do |local|
  puts "Including #{local}" if ENV['DEBUG']
  require "vibe/#{local}"
end

module Vibe
  extend Configuration

  # Alias for Vibe::Client.new
  #
  # @return [Vibe::Client]
  def self.new(options = {}, &block)
    @api_client = Vibe::Client.new(options, &block)
  end
end
