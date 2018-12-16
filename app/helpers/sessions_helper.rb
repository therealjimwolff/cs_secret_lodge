module SessionsHelper

    # Logs in given user
    def log_in(user)
        session[:user_id] = user.id
    end

    # Returns current logged in user
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find(user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find(user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    # Returns true if the given user is current user
    def current_user?(user)
        current_user == user
    end
         

    # Returns true if user logged in
    def logged_in?
        !current_user.nil?
    end

    # Remembers given user
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # Forgets given user
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # Log out current user
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end


end
