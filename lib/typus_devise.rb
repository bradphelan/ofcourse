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

        end

        module InstanceMethods

          def name
            full_name = []
            if respond_to?(:first_name) && respond_to?(:last_name)
              full_name = [first_name, last_name].delete_if { |s| s.blank? }
            end
            full_name.any? ? full_name.join(" ") : email
          end

          # This includes lots of stuff we don't need but
          # is easier than copy and pasting
          include Typus::EnableAsTypusUser::InstanceMethods

          def password_required?
            encrypted_password.blank? || !password.blank?
          end

        end

      end
    end
  end
end

module Typus

  module Authentication

    module Session

      def authenticate
        if user_signed_in?
          u = current_user
          session[:typus_user_id] = u.id
        else
          back_to = request.env['PATH_INFO'] unless [
            admin_dashboard_path, 
            admin_path
          ].include?(request.env['PATH_INFO'])

          redirect_to new_user_session(:back_to => back_to)
        end

      end

      def admin_user
        current_user
      end

    end

  end

end
