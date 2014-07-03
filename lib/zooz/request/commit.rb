require 'zooz/request'
require 'zooz/response/commit'
require 'active_support/core_ext/module/delegation'

module Zooz
  class Request
    class Commit
      attr_accessor :transaction_id, :requestor
      attr_reader :errors
      delegate :sandbox, :sandbox=, :unique_id, :unique_id=, :app_key,
               :app_key=, :response_type, :response_type=, :cmd, :cmd=, :is_sandbox?, :developer_id, :developer_id=,
               :to => :requestor

      def initialize
        @errors = []
        @requestor = Request.new
        @requestor.cmd = 'commitTransaction'
      end

      def request
        return false unless valid?
        @requestor.set_param('ver', '1.0.6')
        @requestor.set_param('transactionID', @transaction_id)
        open_response = Response::Commit.new
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
        @errors << 'transaction_id is required' if @transaction_id.nil?
        @errors += @requestor.errors unless @requestor.valid?
        @errors.empty?
      end
    end
  end
end
