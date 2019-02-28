module Api::V1
  class AnswersController < ApplicationController
    before_action :set_list, only: [:show, :update, :destroy]

    def create
      current_user

    end

    def answers_params
    end
  end
end
