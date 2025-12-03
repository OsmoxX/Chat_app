class ConversationsController < ApplicationController
  before_action :require_user

  def index
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)

    @users = User.where.not(id: current_user.id)
  end

  def create
    if Conversation.between(current_user.id, params[:user_id]).present?
      @conversation = Conversation.between(current_user.id, params[:user_id]).first
    else
      @conversation = Conversation.create!(sender_id: current_user.id, recipient_id: params[:user_id])
    end
    redirect_to conversation_private_messages_path(@conversation)
  end

end