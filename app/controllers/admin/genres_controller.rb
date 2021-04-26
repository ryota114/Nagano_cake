class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
  end 
  
  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end 
  
  def edit
    @genre = Genre.find(params[:id])
  end 
  
  def update
    @genre = Genre.find(params[:id])
    @genre.update(edit_genre_params)
    redirect_to admin_genres_path
  end 
  
  
  private

  # require.(:genre)をつけるとエラーが出た。genreが空？
  # 下記のように削除するとひとまず実装できた。
  def genre_params
    params.permit(:name)
  end
  
  def edit_genre_params
    params.require(:genre).permit(:name)
  end

  
end
