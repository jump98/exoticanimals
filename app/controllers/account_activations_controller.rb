class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      redirect_to user, flash: {
        success: ["登録完了しました!"]
      }
    else
      redirect_to root_url, flash: {
        danger: ["登録完了することができませんでした。"]
      }
    end
  end
end