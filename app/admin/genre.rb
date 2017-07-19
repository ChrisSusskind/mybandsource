ActiveAdmin.register Genre do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :name, :description, :picture

  index do
    actions
    selectable_column
    id_column
    column :name
    column :description
    column :picture
  end

  filter :name
  filter :description
  filter :picture

  show do
    attributes_table do
      row :name
      row :description
      row :picture
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Genre Details" do
      f.input :name
      f.input :description
      f.input :picture
    end
    f.actions
  end

end
