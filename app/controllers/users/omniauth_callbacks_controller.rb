class Users::OmniauthCallbacksController < ApplicationController






      def facebook
        @user = User.find_for_facebook_oauth(env["omniauth.auth"])

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
          print "почти редиректнулся"
        else
          session["devise.facebook_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end



  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end
end
