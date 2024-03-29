# frozen_string_literal: true

class OmniauthController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :developer

  def developer
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = Admin.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Developer") if is_navigational_format?
    else
      redirect_to new_admin_session_path
    end
  end

  def failure
    redirect_to new_admin_session_path
  end
end
