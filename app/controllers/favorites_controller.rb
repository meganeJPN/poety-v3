class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(poeet_id: params[:poeet_id])
    redirect_to poeets_path, notice: "#{favorite.poeet.user.name}さんのポイートをお気に入りに登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to poeets_path, notice: "#{favorite.poeet.user.name}さんのポイートをお気に入りから解除しました"
  end
end
