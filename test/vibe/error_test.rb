require 'helper'

describe 'error' do

  before do
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
  end

  describe 'VibeError class' do
    before do
      @message = 'abcd'
    end

    it 'should set error message' do
      error = Vibe::Error::VibeError.new @message
      error.to_s.must_equal @message
    end
  end

  describe 'BadRequest class' do
    before do
      @env = {
        :status_code => 400,
        :body        => 'abcd'
      }
    end

    it 'should set error message' do
      error = Vibe::Error::BadRequest.new @env
      error.to_s.must_equal @env[:body]
    end
  end


  describe 'Forbidden class' do
    before do
      @env = {
        :status_code => 403,
        :body        => 'abcd'
      }
    end

    it 'should set error message' do
      error = Vibe::Error::BadRequest.new @env
      error.to_s.must_equal @env[:body]
    end
  end


  describe 'InternalServerError class' do
    before do
      @env = {
        :status_code => 500,
        :body        => 'abcd'
      }
    end

    it 'should set error message' do
      error = Vibe::Error::InternalServerError.new @env
      error.to_s.must_equal @env[:body]
    end
  end

  describe 'NotFound class' do
    before do
      @env = {
        :status_code => 500,
        :body        => 'abcd'
      }
    end

    it 'should set error message' do
      error = Vibe::Error::NotFound.new @env
      error.to_s.must_equal @env[:body]
    end
  end

  describe 'ServiceUnavailable class' do
    before do
      @env = {
        :status_code => 503,
        :body        => 'abcd'
      }
    end

    it 'should set error message' do
      error = Vibe::Error::ServiceUnavailable.new @env
      error.to_s.must_equal @env[:body]
    end
  end

  describe 'Unauthorized class' do
    before do
      @env = {
        :status_code => 401,
        :body        => 'abcd'
      }
    end

    it 'should set error message' do
      error = Vibe::Error::Unauthorized.new @env
      error.to_s.must_equal @env[:body]
    end
  end

  describe 'UnprocessableEntity class' do
    before do
      @env = {
        :status_code => 422,
        :body        => 'abcd'
      }
    end

    it 'should set error message' do
      error = Vibe::Error::UnprocessableEntity.new @env
      error.to_s.must_equal @env[:body]
    end
  end

  describe 'ClientError class' do
    before do
      @message = 'test'
      @attributes = {
        :problem => 'a',
        :summary => 'b',
        :resolution => 'c'
      }
    end

    it 'should set error message' do
      error = Vibe::Error::ClientError.new @message
      error.to_s.must_equal @message
    end

    it 'should generate error message' do
      error = Vibe::Error::ClientError.new @message
      ret = error.generate_message @attributes
      ret.to_s.must_equal "\nProblem:\n #{@attributes[:problem]}"+ "\nSummary:\n #{@attributes[:summary]}"+ "\nResolution:\n #{@attributes[:resolution]}"
    end
  end

  describe 'InvalidOptions class' do
    before do
      @valid = ['abcd']
      @invalid = ['efgh']
    end

    it 'should set error message' do
      error = Vibe::Error::InvalidOptions.new @invalid, @valid
      eq = Vibe::Error::ClientError.new 'asfsd'
      eq = eq.generate_message :problem => "Invalid option #{@invalid.join(', ')} provided for this request.",
        :summary => "Vibe gem checks the request parameters passed to ensure that Vibe api is not hit unnecessairly and to fail fast.",
        :resolution => "Valid options are: #{@valid.join(', ')}, make sure these are the ones you are using"

      error.to_s.must_equal eq
    end
  end

  describe 'RequiredParams class' do
    before do
      @provided = {
        'abcd' => 'asfsdg'
      }
      @required = ['efgh']
    end

    it 'should set error message' do
      error = Vibe::Error::RequiredParams.new @provided, @required
      eq = Vibe::Error::ClientError.new 'asfsd'
      eq = eq.generate_message :problem => "Missing required parameters: #{@provided.keys.join(', ')} provided for this request.",
        :summary => "Vibe gem checks the request parameters passed to ensure that Vibe api is not hit unnecessairly and to fail fast.",
        :resolution => "Required parameters are: #{@required.join(', ')}, make sure these are the ones you are using"

      error.to_s.must_equal eq
    end
  end

  describe 'UnknownValue class' do
    before do
      @key = 'abcd'
      @value = 'efgh'
      @permitted = 'asfsdfsfdsfhb'
    end

    it 'should set error message' do
      error = Vibe::Error::UnknownValue.new @key, @value, @permitted
      eq = Vibe::Error::ClientError.new 'asfsd'
      eq = eq.generate_message :problem => "Wrong value of '#{@value}' for the parameter: #{@key} provided for this request.",
      :summary => "Vibe gem checks the request parameters passed to ensure that Vibe api is not hit unnecessairly and fails fast.",
      :resolution => "Permitted values are: #{@permitted}, make sure these are the ones you are using"

      error.to_s.must_equal eq
    end
  end

end
