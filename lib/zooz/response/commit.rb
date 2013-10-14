require 'zooz/response'
require 'active_support/core_ext/module/delegation'

module Zooz
  class Response
    class Commit
      attr_accessor :request, :response
      delegate :success?, :errors, :parsed_json_response, :get_parsed_singular,
        :to => :response
      delegate :is_sandbox?, :unique_id, :app_key, :transaction_id,
        :to => :request
    end
  end
end

