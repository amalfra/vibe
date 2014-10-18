require 'helper'

describe 'client' do

  before do
    @keys = Vibe::Configuration::VALID_CONFIG_KEYS
  end

  describe 'with module configuration' do
    before do
      Vibe.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      Vibe.reset
    end

    it "should inherit module configuration" do
      api = Vibe::Client.new
      @keys.each do |key|
        api.send(key).must_equal key
      end
    end

    describe 'with class configuration' do
      before do
        @config = {
          :api_key    => 'ak'
        }
      end

      it 'should override module configuration after' do
        api = Vibe::Client.new

        @config.each do |key, value|
          api.send("#{key}=", value)
        end
      end

    end

  end

end
