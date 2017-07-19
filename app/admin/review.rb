ActiveAdmin.register Review do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters


  permit_params :comment, :rating, :upvotes, :reported

  index do
    actions
    selectable_column
    id_column
    column :comment
    column :rating
    column :upvotes
    column :receiving_user
    column :leaving_user
    column :reported
    column :updated_at
    column :created_at
  end

  filter :id
  filter :comment
  filter :upvotes
  filter :rating
  filter :receiving_user
  filter :leaving_user
  filter :reported
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :comment
      row :upvotes
      row :rating
      row :leaving_user
      row :receiving_user
      row :reported
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Review Details" do
      f.input :comment
      f.input :upvotes
      f.input :rating
      f.input :reported
    end
    f.actions
  end

end
