require "grape/resources/version"

module Grape

  module Resources
    def self.included(base)
        base.extend(ClassMethods)
    end

    module ClassMethods
        def resources_for(clazz)
          singular_name = clazz.name.underscore
          plural_name   = clazz.name.pluralize.underscore

          raise Error("To use grape_resources on a given class it should inherit from ActiveRecord::Base.") unless clazz < ActiveRecord::Base

          route('GET', ["/#{plural_name}"], {})
          route('GET', ["/#{singular_name}/:id"], {})
          route('POST', ["/#{singular_name}"], {})
          route('PUT', ["/#{singular_name}/:id"], {})
          route('DELETE', ["/#{singular_name}/:id"], {})
        end
    end
  end
end
