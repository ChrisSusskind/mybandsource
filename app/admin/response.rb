ActiveAdmin.register Response do

  permit_params :upvotes, :comments, :reported

  index do
    actions
    selectable_column
    id_column
    column :upvotes
    column :comment
    column :user_id
    column :review_id
    column :created_at
    column :updated_at
    column :reported
  end

  filter :id
  filter :upvotes
  filter :comment
  filter :user_id
  filter :review_id
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :upvotes
      row :comment
      row :user
      row 'Responded To' do |resp|
        resp.review.comment
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs 'Response Details' do
      f.input :comment
      f.input :upvotes
      f.input :reported
    end
    f.actions
  end

end
