require File.dirname(__FILE__) + '/../response'
require 'active_support/core_ext/module/delegation'

module Zooz
  class Response
    class Verify
      attr_accessor :request, :response
      delegate :success?, :errors, :parsed_response, :get_parsed_singular,
        :to => :response
      delegate :is_sandbox?, :unique_id, :app_key, :trx_id, :to => :request
    end
  end
end
