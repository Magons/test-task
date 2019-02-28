module Api::V1
  class AnswersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      current_user.update(poll: true)
      current_user.answers.create(answers_params.values)
    end

    def answers_params
      params.require(:answers)
    end
  end
end
