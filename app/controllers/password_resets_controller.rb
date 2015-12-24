class PasswordResetsController < ApplicationController
  def create
    reset = PasswordResetOrganizer.call(email: password_params[:password_reset][:email])
    if reset.success?
      render json: { password: reset.message }, status: :created
      redirect_to root_url
    else
      render json: reset.errors, status: :not_found
      redirect_to root_url
    end
  end

  def update
  end

  private

  def password_params
    params.require(:password_reset).permit(:email)
  end
end
