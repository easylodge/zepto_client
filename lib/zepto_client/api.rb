
require "httparty"

require "zepto_client/endpoints/agreements"
require "zepto_client/endpoints/contacts_receivable"
require "zepto_client/endpoints/contacts"
require "zepto_client/endpoints/payment_requests"
require "zepto_client/endpoints/unassigned_agreements"

module ZeptoClient
  class Api
    include Endpoints::Agreements
    include Endpoints::ContactsReceivable
    include Endpoints::Contacts
    include Endpoints::PaymentRequests

    attr_accessor :api_key, :base_url

    def initialize(api_key, base_url)
      @api_key = api_key
      @base_url = base_url
    end

    private

    def http
      @http ||= HTTParty
    end

    def headers
      @headers ||= { "Authorization": "Bearer #{@api_key}"}
    end

    def get(endpoint)
      response = HTTParty.get(@base_url + endpoint, headers: headers)
      response.parsed_response.deep_symbolize_keys
    rescue
      { errors: "Failed to connect to Zepto" }
    end

    def patch(endpoint, body)
      response = HTTParty.patch(@base_url + endpoint, headers: headers, body: body)
      response.parsed_response.deep_symbolize_keys
    rescue
      { errors: "Failed to connect to Zepto" }
    end

    def post(endpoint, body)
      response = HTTParty.post(@base_url + endpoint, headers: headers, body: body)
      response.parsed_response.deep_symbolize_keys
    rescue
      { errors: "Failed to connect to Zepto" }
    end

    def delete(endpoint, body)
      response = HTTParty.post(@base_url + endpoint, headers: headers)
      response.parsed_response.deep_symbolize_keys
    rescue
      { errors: "Failed to connect to Zepto" }
    end

  end
end