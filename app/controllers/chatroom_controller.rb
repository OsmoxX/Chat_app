class ChatroomController < ApplicationController
  before_action :require_user
  def index
    @message = Message.new
    login_time = session[:login_time]
    login_time = Time.parse(login_time) if login_time.is_a?(String)
    @messages = Message.custom_display(login_time)
    @users = User.where.not(id: current_user.id)
  end
end
