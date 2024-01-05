module LikesHelper
  def like_or_unlike(movie, like)
    if like
      button_to "♡ Unlike", movie_like_path(movie, like), method: :delete
    else
      button_to "♥️ Like", movie_likes_path(movie)
    end
  end
end
