require 'json'
require 'action_pack'
require 'active_support/core_ext/class/attribute'
require 'active_support/log_subscriber'

module Lograge
  class SqlLogSubscriber < ActiveSupport::LogSubscriber

    def sql(event)
      return if Lograge.ignore?(event)
      payload = event.payload
      data = extract_request(event, payload)
      data = before_format(data, payload)
      formatted_message = Lograge.formatter.call(data)
      logger.send(Lograge.log_level, formatted_message)
    end

    def unpermitted_parameters(event)
      Thread.current[:lograge_unpermitted_params] ||= []
      Thread.current[:lograge_unpermitted_params].concat(event.payload[:keys])
    end

    def logger
      Lograge.logger.presence || super
    end

    private

    def extract_request(event, payload)
      payload = event.payload
      data = initial_data(event, payload)
      data.merge!(extract_unpermitted_params)
      data.merge!(custom_options(event))
    end

    def initial_data(event, payload)
      {
        sql: payload[:sql],
        duration: event.duration
      }
    end

    def custom_options(event)
      Lograge.custom_options(event) || {}
    end

    def before_format(data, payload)
      Lograge.before_format(data, payload)
    end

    def extract_unpermitted_params
      unpermitted_params = Thread.current[:lograge_unpermitted_params]
      return {} unless unpermitted_params

      Thread.current[:lograge_unpermitted_params] = nil
      { unpermitted_params: unpermitted_params }
    end
  end
end
