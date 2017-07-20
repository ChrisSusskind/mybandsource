ActiveAdmin.register Genre do
  menu priority: 4
  config.batch_actions = true

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
    f.inputs 'Genre Details' do
      f.input :name
      f.input :description
      f.input :picture
    end
    f.actions
  end

end
