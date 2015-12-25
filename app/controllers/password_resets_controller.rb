class PasswordResetsController < ApplicationController
  def create
    reset = PasswordResetOrganizer.call(email: password_params[:email])
    if reset.success?
      render json: reset.message, status: :created
    else
      render json: reset.errors, status: :not_found
    end
  end

  def update
  end

  private

  def password_params
    params.require(:password_reset).permit(:email)
  end
end
