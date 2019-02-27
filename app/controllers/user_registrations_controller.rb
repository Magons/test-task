# frozen_string_literal: true

# Overrides for Device's RegistrationsController
class UserRegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, only: :create

  respond_to :js

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      expire_data_after_sign_in!
      l = after_inactive_sign_up_path_for(resource)
      respond_with resource, location: l do |format|
        format.js { render js: "window.location = '#{l}'" }
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource do |format|
        format.js { render 'new' }
      end
    end
  end

  protected

  def after_sign_up_path_for(_resource)
    sign_up_success_path
  end

  def after_inactive_sign_up_path_for(_resource)
    sign_up_unconfirmed_path
  end

  def after_update_path_for(_resource)
    my_profile_path
  end

end
