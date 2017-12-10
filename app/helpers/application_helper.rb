module ApplicationHelper
  def avatar_url(user)
    if user.image
      "http://graph.facebook.com/#{user.uid}/picture?type=large"
    else
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
    end
  end

  def get_sub_total
    sub_total = 0
    if session[:cart_obj] && session[:cart_obj].size > 0  
      session[:cart_obj].each do |d| 
        sub_total += d[:price].to_f
      end 
    end
    return sub_total
  end

  def products_in_cart 
    return session[:cart_obj] && session[:cart_obj].size > 0   
  end
  
end
