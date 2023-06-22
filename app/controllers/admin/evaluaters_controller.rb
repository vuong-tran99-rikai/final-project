class Admin::EvaluatersController < ApplicationController
  before_action :admin_user, only: [:index]
  def index
    @evaluaters = Evaluater.includes([:book]).includes([:user])
  end

  # private

  # def evaluater_params
  #   params.require(:evaluater).permit(:book_id, :level, :comment, :user_id)
  # end
end
