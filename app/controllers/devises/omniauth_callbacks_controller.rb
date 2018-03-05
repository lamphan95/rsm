class Devises::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :load_user, only: %i(facebook linkedin)

  def google_oauth2
    if current_user
      save_oauth request.env["omniauth.auth"]
      redirect_after_save_oauth request.env["omniauth.params"]
    else
      load_user
      sign_in_social Settings.omniauth.google_oauth2
    end
  end

  def facebook
    sign_in_social Settings.omniauth.facebook
  end

  def linkedin
    sign_in_social Settings.omniauth.linkedin
  end

  private

  def save_oauth auth
    if current_user.email == auth.info.email
      if current_user.oauth
        flash[:danger] = t "devise.omniauth_callbacks.account_connected"
      else
        oauth = Oauth.new user_id: current_user.id, token: auth.credentials.token,
          expires_at: Time.at(auth.credentials.expires_at),
          refresh_token: auth.credentials.refresh_token
        if oauth.save
          flash[:success] = t "devise.omniauth_callbacks.connect_gmail"
        else
          flash[:danger] = t "devise.omniauth_callbacks.connect_gmail_failure"
        end
      end
    else
      flash[:danger] = t "devise.omniauth_callbacks.account_invalid"
    end
  end

  def redirect_after_save_oauth request
    if request && request["apply_id"] && request["job_id"]
      redirect_to employers_job_apply_url job_id: request["job_id"].to_i,
        id: request["apply_id"].to_i
    else
      redirect_to employers_dashboards_url
    end
  end

  def load_user
    @user = User.find_by email: request.env["omniauth.auth"].info.email
  end

  def new_user data
    @user = User.new email: data.email, name: data.name,
      password: Devise.friendly_token.first(Setings.password.length),
      remote_picture_url: data.image
  end

  def sign_in_social provider
    if @user && @user.persisted?
      sign_in @user
      flash[:success] = t "devise.omniauth_callbacks.success",
        kind: provider
    else
      new_user request.env["omniauth.auth"].info
      @user.skip_confirmation!
      if @user.save
        sign_in @user
        flash[:success] = t "devise.omniauth_callbacks.success",
          kind: provider
      else
        flash[:danger] = t "devise.omniauth_callbacks.failure",
          kind: provider
      end
    end
    redirect_to root_url
  end
end
