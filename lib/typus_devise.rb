module Typus
  module Orm
    module ActiveRecord
      module User

        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods

          def enable_as_typus_devise_user

            extend ClassMethodsMixin

            validates :role, :presence => true

            serialize :preferences

            include InstanceMethods

          end

        end

        module ClassMethodsMixin

          def authenticate(email, password)
            resource = find_for_database_authentication({ :email=>email })
            r = resource && resource.valid_password?( password ) ? resource : nil
          end

          def generate(*args)
          end

        end

        module InstanceMethods

          def name
            fullname = []
            if respond_to?(:first_name) && respond_to?(:last_name)
              full_name = [first_name, last_name].delete_if { |s| s.blank? }
            end
            full_name.any? ? full_name.join(" ") : email
          end

          def resources
            Typus::Configuration.roles[role].compact
          end

          def applications
            Typus.applications.delete_if { |a| application(a).empty? }
          end

          def application(name)
            Typus.application(name).delete_if { |r| !resources.keys.include?(r) }
          end

          def can?(action, resource, options = {})
            resource = resource.model_name if resource.is_a?(Class)

            return false if !resources.include?(resource)
            return true if resources[resource].include?("all")

            action = options[:special] ? action : action.acl_action_mapper

            resources[resource].extract_settings.include?(action)
          end

          def cannot?(*args)
            !can?(*args)
          end

          def is_root?
            role == Typus.master_role
          end

          def is_not_root?
            !is_root?
          end

          def locale
            (preferences && preferences[:locale]) ? preferences[:locale] : ::I18n.default_locale
          end

          def locale=(locale)
            options = { :locale => locale }
            self.preferences ||= {}
            self.preferences[:locale] = locale
          end

        end

      end
    end
  end
end

