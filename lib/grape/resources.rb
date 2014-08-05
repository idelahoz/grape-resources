require "grape"
require "grape/resources/version"

module Grape
  class API
    include Grape::Resources
    class << self
      def resources_for( clazz )
        singular_name = clazz.name.underscore
        plural_name   = clazz.name.pluralize.underscore

        raise Error("To use grape_resources on a given class it should inherit from ActiveRecord::Base.") unless clazz < ActiveRecord::Base

        route('GET', ["/#{plural_name}"], {} ) do                   
          result = Grape::Resources.list(clazz, params)
          result
        end

        route('GET', ["/#{singular_name}/:id"], {}) do
          result = Grape::Resources.find(clazz, params)
          error!( "#{singular_name} not found", 404) if result.nil?
          result
        end

        route('POST', ["/#{singular_name}"], {})
        route('PUT', ["/#{singular_name}/:id"], {})
        route('DELETE', ["/#{singular_name}/:id"], {})
      end
    end
  end

  module Resources
    def self.list(clazz, params)
      result = clazz.all.to_a
    end

    def self.find(clazz, params)
      result = clazz.find_by_id( params[:id])      
    end
  end
end


