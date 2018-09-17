class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate_with_credentials(session_params)
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(
      :email,
      :password,
    )
  end
end
