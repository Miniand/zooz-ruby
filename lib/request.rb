require 'httparty'

# The ZooZ Request class formats and sends requests to the ZooZ API.
module Zooz
  class Request
    attr_accessor :sandbox, :unique_id, :app_key, :response_type, :cmd
    attr_reader :errors, :params

    def initialize
      @params = {}
      @errors = []
      @response_type = 'NVP'
      @sandbox = false
    end

    # Set a request parameter.
    def set_param name, value
      @params[name] = value
    end

    # Get a request parameter.
    def get_param
      @params[name]
    end

    # Whether the request will be sent to sandbox.
    def is_sandbox?
      @sandbox == true
    end

    # Get the URL of the API, based on whether in sandbox mode or not.
    def url
      (is_sandbox? ? 'https://sandbox.zooz.co' : 'https://app.zooz.com') +
        '/mobile/SecuredWebServlet'
    end

    # Send a request to the server, returns a Zooz::Response object or false.
    # If returning false, the @errors attribute is populated.
    def request
      return false unless valid?
      http_response = HTTParty.post(url, :format => :plain,
        :query => @params.merge({ :cmd => @cmd }),
        :headers => {
          'ZooZ-Unique-ID' => @unique_id,
          'ZooZ-App-Key' => @app_key,
          'ZooZ-Response-Type' => @response_type,
        })
      response = Response.new
      response.request = self
      response.http_response = http_response
      unless response.success?
        @errors = response.errors
        return false
      end
      response
    end

    # Whether the request object is valid for requesting.
    def valid?
      @errors = []
      @errors << 'unique_id is required' if @unique_id.nil?
      @errors << 'app_key is required' if @app_key.nil?
      @errors << 'cmd is required' if @cmd.nil?
      @errors << 'response_type is required' if @response_type.nil?
      @errors.empty?
    end
  end
end