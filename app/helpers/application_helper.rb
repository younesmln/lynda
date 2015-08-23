module ApplicationHelper

	def flash_message
		message = ''
	    if not flash.empty?
	        flash.each do |key,msg|
            message = "<div class='test'><p> #{msg} </p></div>"
	        end
	        #flash.clear
      end
	    message.html_safe
  end

  def error_message_for object
    render partial: 'application/error_messages', locals: {object: object}
  end

  def current_user
    if session[:user_id]
      @current_user ||= AdminUser.find(session[:user_id])
    else
      false
    end
  end

end
