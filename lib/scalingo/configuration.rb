require 'faraday'
require_relative 'version'

module Scalingo
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {Scalingo::Api}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :token,
      :endpoint,
      :auth_endpoint,
      :region,
      :user_agent,
      :proxy,
      :parse_json,
    ].freeze

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set an token
    DEFAULT_TOKEN = nil

    # The endpoint that will be used to connect if none is set
    DEFAULT_ENDPOINT = 'https://api.scalingo.com/v1'.freeze

    # The endpoint to exchange the token with a JWT
    DEFAULT_AUTH_ENDPOINT = 'https://auth.scalingo.com/v1'.freeze

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # The user agent that will be sent to the Api endpoint if none is set
    DEFAULT_USER_AGENT = "Scalingo Ruby Gem #{Scalingo::VERSION}".freeze

    # Parse json by default, only changed when getting text result (e.g. Logs)
    DEFAULT_PARSE_JSON = true

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter       = DEFAULT_ADAPTER
      self.token         = DEFAULT_TOKEN
      self.endpoint      = DEFAULT_ENDPOINT
      self.auth_endpoint = DEFAULT_AUTH_ENDPOINT
      self.region        = nil
      self.user_agent    = DEFAULT_USER_AGENT
      self.proxy         = DEFAULT_PROXY
      self.parse_json    = DEFAULT_PARSE_JSON
    end
  end
end

