ActiveAdmin.register User do
  menu priority: 4
  config.batch_actions = true

  # To allow passwords in the form
  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      super
    end
  end

  filter :name
  filter :email
  filter :is_artist
  filter :featured
  filter :real_name
  filter :bio
  filter :location
  filter :genres_list
  filter :last_sign_in_at
  filter :created_at
  filter :updated_at


  permit_params :email, :name, :real_name, :location, :is_artist, :featured,
                :bio, :real_name, :facebook_url, :soundcloud_url,
                :spotify_url, :itunes_url, :twitter_url, :picture, :banner_picture,
                :password, :password_confirmation, :genre_id, genres_list: []

  index do
    actions
    selectable_column
    id_column
    column :email
    column :name
    column :real_name
    column :is_artist
    column :featured
    column :bio
    column :location
    column :genre_id
    column :facebook_url
    column :soundcloud_url
    column :spotify_url
    column :itunes_url
    column :twitter_url
    column :last_sign_in_at
    column :created_at
    column :updated_at
  end


  show title: :name do |user|
    attributes_table do
      row :email
      row :name
      row :real_name
      row :location
      row :bio
      row user.is_artist ? :genre_id : :genres_list
      row :picture
      row :banner_picture
    end

    panel 'Review History' do
      table_for(user.left_reviews) do
        column('Recipient', sortable: :created_at) do |review|
          link_to review.receiving_user.name, admin_review_path(review)
        end
        column :comment
        column :upvotes
        column :reported
      end
    end

    active_admin_comments
  end


  sidebar 'Stats', only: :show do
    attributes_table_for user do
      row :is_artist
      row :featured
      row('Rating')       { status_tag(user.average_rating || 'N/A') }
      row('Upvotes')      { Review.select(:upvotes).where(leaving_user: user).sum(:upvotes) }
      row('Created')      { time_ago_in_words(user.created_at) + " ago" }
      row('Updated')      { time_ago_in_words(user.updated_at) + " ago" }
    end
  end

  sidebar 'External Links', only: :show do
    attributes_table_for user do
      row('Facebook')   { user.facebook_url }
      row('Soundcloud') { user.soundcloud_url }
      row('Spotify')    { user.spotify_url }
      row('Itunes')     { user.itunes_url }
      row('Twitter')    { user.twitter_url }
    end
  end


  form title: :name do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :name
      f.input :real_name
      f.input :location
      f.input :is_artist
      f.input :featured
      f.input :bio
      f.input :genres_list, as: :check_boxes, collection: Genre.pluck(:name)
      f.input :facebook_url
      f.input :soundcloud_url
      f.input :spotify_url
      f.input :itunes_url
      f.input :twitter_url
      f.input :picture
      f.input :banner_picture
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end





end
