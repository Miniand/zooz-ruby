require 'active_support/core_ext/module/delegation'
require 'cgi'

# The base level ZooZ response class encapsulates responses from the ZooZ API
# and reports on success and errors.
module Zooz
  class Response
    attr_accessor :http_response, :request
    attr_reader :errors
    delegate :body, :code, :message, :headers, :to => :http_response,
      :prefix => :http
    delegate :is_sandbox?, :unique_id, :app_key, :to => :request

    def initialize
      @errors = []
    end

    # Gets a singular offset from the response data, useful because CGI returns
    # single parameters embedded in an array.
    def get_parsed_singular(offset)
      (parsed_response[offset] || []).first
    end

    # Get a parsed response as an object from the response text.
    def parsed_response
      CGI::parse(http_body.strip)
    end

    # Get the ZooZ status code, 0 for success.
    def status_code
      get_parsed_singular('statusCode')
    end

    # Get the ZooZ error message, returned when status_code is not 0.
    def error_message
      get_parsed_singular('errorMessage')
    end

    # Whether the request was successful, populates the @errors array on error.
    def success?
      @errors = []
      unless http_code.to_s[0] == '2'
        @errors << "HTTP status #{http_code}: #{http_message}"
      end
      unless status_code
        @errors << "Unable to parse ZooZ response"
      end
      unless status_code == '0'
        @errors << "ZooZ error #{status_code}: #{error_message}"
      end
      @errors.empty?
    end
  end
end
