require 'zooz/request'
require 'zooz/response/verify'
require 'active_support/core_ext/module/delegation'

module Zooz
  class Request
    class Verify
      attr_accessor :trx_id, :requestor
      attr_reader :errors
      delegate :sandbox, :sandbox=, :unique_id, :unique_id=, :app_key,
        :app_key=, :response_type, :response_type=, :cmd, :cmd=, :is_sandbox?,
        :to => :requestor

      def initialize
        @errors = []
        @requestor = Request.new
        @requestor.cmd = 'verifyTrx'
      end

      def request
        return false unless valid?
        @requestor.set_param('trxId', @trx_id)
        verify_response = Response::Verify.new
        verify_response.request = self
        verify_response.response = @requestor.request
        unless verify_response.response
          @errors += @requestor.errors
          return false
        end
        verify_response
      end

      def valid?
        @errors = []
        @errors << 'trx_id is required' if @trx_id.nil?
        @errors += @requestor.errors unless @requestor.valid?
        @errors.empty?
      end
    end
  end
end
