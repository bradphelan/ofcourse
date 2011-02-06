module DeviseControllerSpecHelpers

  # Sets the expected environment for a devise controller.
  def it_behaves_like_a_devise_controller resource
    before :each do
      request.env["devise.mapping"] = Devise.mappings[resource]
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller

  config.extend(DeviseControllerSpecHelpers, :type => :controller)
end

