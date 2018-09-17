class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
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

  def self.authenticate_with_credentials email, password
    user = User.find_by_email(email)
    user.authenticate(password)
  end

  private

  def session_params
    params.require(:session).permit(
      :email,
      :password,
    )
  end
end
