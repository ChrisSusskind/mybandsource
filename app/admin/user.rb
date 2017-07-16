ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

  permit_params :name, :email, :password, :location, :picture, :bio, :is_artist, :real_name, :facebook_url, :soundcloud_url, :spotify_url, :itunes_url, :twitter_url, :genre, :banner_picture

  index do
    actions
    selectable_column
    id_column
    column :email
    column :name
    column :real_name
    column :is_artist
    column :bio
    column :location
    column :genre
    column :facebook_url
    column :soundcloud_url
    column :spotify_url
    column :itunes_url
    column :twitter_url
    column :last_sign_in_at
    column :created_at
    column :updated_at
  end

  filter :email
  filter :name
  filter :real_name
  filter :is_artist
  filter :bio
  filter :location
  filter :genre
  filter :facebook_url
  filter :soundcloud_url
  filter :spotify_url
  filter :itunes_url
  filter :twitter_url
  filter :last_sign_in_at
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :email
      row :name
      row :real_name
      row :location
      row :bio
      row :is_artist
      row :genre
      row :picture
      row :banner_picture
      row :facebook_url
      row :soundcloud_url
      row :spotify_url
      row :itunes_url
      row :twitter_url
      row :average_rating
    end
  end


  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :name
      f.input :real_name
      f.input :location
      f.input :is_artist
      f.input :bio
      f.input :genre_id, as: :select, collection: Genre.all.collect { |genre| [genre.name, genre.id] }
      f.input :facebook_url
      f.input :soundcloud_url
      f.input :spotify_url
      f.input :itunes_url
      f.input :twitter_url
      f.input :picture
      f.input :banner_picture
    end
    f.actions
  end

end
