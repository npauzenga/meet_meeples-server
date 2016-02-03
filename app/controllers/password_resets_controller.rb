class PasswordResetsController < ApplicationController
  def create
    reset = CreatePasswordResetOrganizer.call(email: password_params[:email])
    if reset.success?
      render json: reset.message, status: :created
    else
      render json: reset.errors, status: :not_found
    end
  end

  def update
    update = UpdatePasswordOrganizer.call(password: user_params[:password],
                                          token:    params[:id])
    if update.success?
      render json: update.message, status: :ok
    else
      render json: update.errors, status: :internal_server_error
    end
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end

  def password_params
    params.require(:password_reset).permit(:email)
  end
end
