# frozen_string_literal: true

class StaticPagesController < ApplicationController

  before_action :authenticate_user!, only: [:my_profile]

  layout :resolve_layout

  def home
    if current_user
    end
    @questions = Question.all
  end

  def my_profile
    @signed_up_at = current_user.created_at
  end

  private

  def resolve_layout
    if user_signed_in?
      'application'
    else
      'blank'
    end
  end

end
