module Xeroizer
  module ApplicationHttpProxy

    def self.included(base)
      base.send :include, InstanceMethods
    end

    module InstanceMethods

      # URL end-point for this model.
      def url
        @application.xero_url + '/' + api_controller_name
      end

      def http_get(extra_params = {})
        application.cache[:client].fetch(cache_key(extra_params)) do
          application.http_get(application.client, url, extra_params)
        end
      end

      def http_put(xml, extra_params = {})
        application.http_put(application.client, url, xml, extra_params)
      end

      def http_post(xml, extra_params = {})
        application.http_post(application.client, url, xml, extra_params)
      end

      private

      def cache_key(params)
        application.cache[:prefix].to_s + url + params.to_a.sort.to_s
      end
    end

  end
end