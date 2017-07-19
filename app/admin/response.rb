ActiveAdmin.register Response do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters


  permit_params :upvotes, :comments, :user, :review, :reported

  index do
    actions
    selectable_column
    id_column
    column :upvotes
    column :comment
    column :user
    column :review
    column :created_at
    column :updated_at
    column :reported
  end

  filter :id
  filter :upvotes
  filter :comment
  filter :user
  filter :review
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
      row :id
      row :upvotes
      row :comment
      row :user
      row :review
      row :created_at
      row :updated_at
      row :reported
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
    f.inputs "Response Details" do
      f.input :comment
      f.input :reported
    end
    f.actions
  end


end
