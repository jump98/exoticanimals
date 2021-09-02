class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update]
    before_action :admin_user,     only: :destroy

    # def index
    #     @users = User.where(activated: true).paginate(page: params[:page])
    # end

    def show
        if logged_in?
            @animals = Animal.includes(:user).where(user_id: current_user.id)
        else
            redirect_to root_url
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            @user.send_activation_email
            redirect_to root_url, flash: {
                info: ["確認メールをお送りしました。メールをご確認ください！"]
            }
            # 保存の成功をここで扱う。
        else
            redirect_to new_user_path, flash: {
                danger: @user.errors.full_messages
            }
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            redirect_to @user, flash: {
                success: ["登録情報を更新しました。"]
            }
            # 更新に成功した場合を扱う。
        else
            redirect_to edit_user_path, flash: {
                info: @user.errors.full_messages
            }
        end
    end
    
    def destroy
        User.find(params[:id]).destroy
        redirect_to users_url, flash: {
            success: ["登録情報を削除しました。"]
        }
    end

    private

    def user_params
        params.require(:user).permit(
            :name,
            :email,
            :password,
            :password_confirmation,
            :postal_code,
            :prefecture,
            :city,
            :town,
            :address,
            :building,
            :LINE_id,
        )
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
        unless logged_in?
        store_location
        redirect_to login_url, flash: {
            danger: ["ログインしてください。"]
        }
        end
    end

    # 正しいユーザーかどうか確認
    def correct_user
        @user = User.find(params[:id])
        # redirect_to(root_url) unless current_user?(@user)
        redirect_to(root_url) unless @user == current_user
    end
    
    def admin_user
        redirect_to(root_url) unless current_user.admin?
    end
end