module ApplicationHelper

  def current_user_subscribed?
    signed_in? && current_user.subscribed?
  end

  def admin?
    signed_in? && current_user.admin?
  end


  def titlize(str)
    str.gsub('_', ' ').captalize
  end

end
