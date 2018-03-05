class Devises::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    return unless current_user
    save_oauth request.env["omniauth.auth"]
    redirect_after_save_oauth request.env["omniauth.params"]
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
end
