class AddSomeFieldsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :image_file_name, :string, default: "placeholder.png"
    add_column :movies, :duration, :string
    add_column :movies, :director, :string
  end
end
