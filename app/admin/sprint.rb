ActiveAdmin.register Sprint do
  permit_params :title, :started_at, :finished_at, :state

  index do
    selectable_column
    column :title
    column :started_at
    column :finished_at
    column :state
    actions
  end

  filter :title
  filter :started_at
  filter :finished_at
  filter :state

  form do |f|
    f.inputs "Sprint details" do
      f.input :title
      f.input :started_at, as: :date_picker
      f.input :finished_at, as: :date_picker
      f.input :state
    end
    f.actions
  end
end
