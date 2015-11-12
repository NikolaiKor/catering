ActiveAdmin.register User do
  permit_params :email

  controller do
    def create
      generated_password = Devise.friendly_token.first(8)
      puts 'password: ' + generated_password
      _user = User.create!(email: @_params[:user][:email], password: generated_password)
      redirect_to admin_user_path(_user)
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :sign_in_count
    actions
  end

  filter :name
  filter :email
  filter :sign_in_count
  filter :current_sign_in_at
  filter :last_sign_in_at
  filter :current_sign_in_ip
  filter :last_sign_in_ip
  filter :locked_at


  # show do
  #   panel 'User information' do
  #     column('Information'){}
  #     column('value')
  #     column :id
  #     column :name
  #     column :email
  #     column :sign_in_count
  #     column :current_sign_in_at
  #     column :last_sign_in_at
  #     column :current_sign_in_ip
  #     column :last_sign_in_ip
  #     column :locked_at
  #   end
  # end

  form do |f|
    f.inputs I18n.t('user.form_title') do
      f.input :email
    end
    f.actions
  end


end
