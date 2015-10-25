ActiveAdmin.register Sprint do
  permit_params :title, :started_at, :finished_at, :state

  scope :all, :default => true
  scope :pending
  scope :started
  scope :finished

  index do
    selectable_column
    column :title
    column :started_at
    column :finished_at
    column :state do |sprint|
      _status = sprint.status
      status_tag(_status[0], class:_status[1])
    end
    actions
  end

  filter :title
  filter :started_at
  filter :finished_at
  filter :state

  form do |f|
    f.inputs I18n.t('sprint.form_title') do
      f.input :title
      f.input :started_at, as: :date_picker
      f.input :finished_at, as: :date_picker
      f.input :state
    end
    f.actions
  end
end
