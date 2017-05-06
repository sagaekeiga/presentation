module UsersHelper
  def current_user?(user)
    user == current_user
  end
  
  def time_now
    current_user.login_t = Time.now
    current_user.save
  end
  
end
