require 'helper'

describe 'configuration' do
 
  describe '.api_key' do
    it 'should return default key' do
      Vibe.api_key.must_equal Vibe::Configuration::DEFAULT_API_KEY
    end
  end

  describe '.user_agent' do
    it 'should return default user agent' do
      Vibe.user_agent.must_equal Vibe::Configuration::DEFAULT_USER_AGENT
    end
  end
 
  describe '.method' do
    it 'should return default http method' do
      Vibe.method.must_equal Vibe::Configuration::DEFAULT_METHOD
    end
  end
 
  after do
    Vibe.reset
  end

  describe '.configure' do
    Vibe::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do
        Vibe.configure do |config|
          config.send("#{key}=", key)
          Vibe.send(key).must_equal key
        end
      end
    end
  end

  Vibe::Configuration::VALID_CONFIG_KEYS.each do |key|
    describe ".#{key}" do
      it 'should return the default value' do
        Vibe.send(key).must_equal Vibe::Configuration.const_get("DEFAULT_#{key.upcase}")
      end
    end
  end
end
