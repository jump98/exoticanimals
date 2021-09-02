class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        # Success
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # flash[:notice] = 'ログインしました'
        redirect_to user, flash: {
          info: ["ログインしました。"]
        } 
      else
        message  = "まだメールアドレスの確認がとれていません。"
        message += "登録メールを確認し、登録完了をおこなってください。"
        redirect_to root_url, flash: {
          info: message
        }
      end
    else
      # Failure
      redirect_to login_path, flash: {
        danger: ["メールアドレスとパスワードが一致しません。"]
      }
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, flash: {
          info: ["ログアウトしました。"]
        } 
  end
end