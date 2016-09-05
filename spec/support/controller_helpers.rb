module ControllerHelpers
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin) # Using factory girl as an example
    end
  end

  def login_user(user = nil)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user) if user.nil?
      sign_in user
  end
end