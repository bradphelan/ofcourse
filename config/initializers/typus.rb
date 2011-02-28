Typus.setup do |config|

  # Application name.
  config.admin_title = "ofcourse"
  # config.admin_sub_title = ""

  # When mailer_sender is set, password recover is enabled. This email
  # address will be used in Admin::Mailer.
  # config.mailer_sender = "admin@example.com"

  # Define paperclip attachment styles.
  # config.file_preview = :medium
  # config.file_thumbnail = :thumb

  # Authentication: +:none+, +:http_basic+
  # Run `rails g typus:migration` if you need an advanced authentication system.
  # config.authentication = :none

  # Define username and password for +:http_basic+ authentication
  # config.username = "admin"
  # config.password = "columbia"

  # Pagination options:
  # These options are passed to `will_paginate`. You can see the available
  # options in the plugin source. (https://github.com/mislav/will_paginate/blob/rails3/lib/will_paginate/view_helpers.rb)
  # config.pagination = { :previous_label => "&larr; " + Typus::I18n.t("Previous"),
  #                       :next_label => Typus::I18n.t("Next") + " &rarr;" }

  # Define authentication: +:none+, +:http_basic+, +:session+
  config.authentication = :devise

  # Define master_role.
  config.master_role = "admin"

  # Define relationship.
  # config.relationship = "typus_users"

  # Define user_class_name.
  config.user_class_name = "User"

  # Define user_fk.
  config.user_fk = "user_id"
end

