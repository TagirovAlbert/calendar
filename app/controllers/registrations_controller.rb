class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource

    if resource.valid?
      begin
        resource.transaction do
          resource.save!
        end
        UserMailer.welcome(resource).deliver
        flash[:notice] = "Successfully registered"
        sign_in(resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:notice] = " Please try again"
        clean_up_passwords resource
        respond_with resource
      end
    else
      clean_up_passwords resource
      respond_with resource
    end

  end

  def update_resource(resource, params)
    if current_user.provider == "facebook"
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
    end
  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :age,:login, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :login, :password, :password_confirmation, :current_password)
  end



end
