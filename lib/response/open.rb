require File.dirname(__FILE__) + '/../response'
require 'active_support/core_ext/module/delegation'

module Zooz
  class Response
    class Open
      attr_accessor :request, :response
      delegate :success?, :errors, :parsed_response, :get_parsed_singular,
        :to => :response
      delegate :is_sandbox?, :unique_id, :app_key, :amount, :currency_code,
        :to => :request

      def token
        get_parsed_singular('token')
      end

      def session_token
        get_parsed_singular('sessionToken')
      end
    end
  end
end
