module RequestSpecHelper
  # Logs in a user using Devise routes
  def login_as(user)
    post user_session_path, params: {
      user: { email: user.email, password: user.password || "password123" }
    }
    follow_redirect! if response.status == 302
  end

  # Parse JSON response
  def json_response
    JSON.parse(response.body)
  end
end
