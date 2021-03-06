class SignupsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(authentication_token: params[:token])

    render json: { response: 'Bad request' } and return unless user

    ChecksInfluenceJob.perform_later(user, params[:email])

    render json: { response: 'Submitted successfully' }
  end
end
