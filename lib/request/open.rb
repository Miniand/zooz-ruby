require File.dirname(__FILE__) + '/../request'
require File.dirname(__FILE__) + '/../response/open'
require 'active_support/core_ext/module/delegation'

module Zooz
  class Request
    class Open
      attr_accessor :amount, :currency_code, :requestor
      attr_reader :errors
      delegate :sandbox, :sandbox=, :unique_id, :unique_id=, :app_key,
        :app_key=, :response_type, :response_type=, :cmd, :cmd=, :is_sandbox?,
        :to => :requestor

      def initialize
        @errors = []
        @requestor = Request.new
        @requestor.cmd = 'openTrx'
      end

      def request
        return false unless valid?
        @requestor.set_param('amount', @amount)
        @requestor.set_param('currencyCode', @currency_code)
        open_response = Response::Open.new
        open_response.request = self
        open_response.response = @requestor.request
        unless open_response.response
          @errors += @requestor.errors
          return false
        end
        open_response
      end

      def valid?
        @errors = []
        @errors << 'amount is required' if @amount.nil?
        @errors << 'currency_code is required' if @currency_code.nil?
        @errors += @requestor.errors unless @requestor.valid?
        @errors.empty?
      end
    end
  end
end
