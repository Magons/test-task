# frozen_string_literal: true

# Overrides for Device's SessionsController
class UserSessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: :create

  respond_to :js

  def create
    login_error = true
    catch :warden do
      self.resource = warden.authenticate!(auth_options)
      login_error = false
    end

    unless login_error
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      l = after_sign_in_path_for(resource)
      respond_with resource, location: l do |format|
        format.js { render js: "window.location = '#{l}'" }
      end
    else
      user_params = params.require(:user).permit(:email, :password, :remember_me)
      self.resource = User.new(user_params)
      msg = _('Invalid email or password.')
      flash.now[:warning] = msg
      resource.errors[:base] << msg
      respond_with resource do |format|
        format.js { render 'new' }
      end
    end
  end

end
