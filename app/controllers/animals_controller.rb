class AnimalsController < ApplicationController
    before_action :set_target_animal, only: %i[show edit update destroy]

    def new
        @animal = Animal.new
    end

    def create
        animal = Animal.new(animal_params)
        if animal.save
            redirect_to user_path(:id), flash: {
                success: ["「#{animal.species}」のデータを作成しました"]
            }
        else
            redirect_to new_animal_path(:id), flash: {
                danger: animal.errors.full_messages
            }
        end
    end

    def show
        
        @comment = Comment.new(animal_id: @animal.id)
    end
    
    def edit
        # @board = Board.find(params[:id])
    end

    def update
        @animal.update(animal_params)
        redirect_to user_path, flash: {
            success: ["「#{@animal.species}」のデータを編集しました"]
        }
    end

    def destroy
        # board.delete
        @animal.destroy
        redirect_to user_path(:id), flash: {
            success: ["「#{@animal.species}」のデータを削除しました"]
        }
    end

    private

    def animal_params
        params.require(:animal).permit(:image, :image2, :image3, :species, :body, :sex, :color, :price).merge(user_id: current_user.id)
    end

    def set_target_animal
        @animal = Animal.find(params[:id])
    end

    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end
end
