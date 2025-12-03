class PrivateMessagesController < ApplicationController
  before_action :require_user
  before_action :find_conversation


  def index
    @messages = @conversation.private_messages.order(:created_at)

    @message = @conversation.private_messages.new

    @other_user = (@conversation.sender == current_user) ? @conversation.recipient : @conversation.sender
  end

  def create
    @message = @conversation.private_messages.new(message_params)
    @message.user = current_user

    if @message.save
      flash[:success] = "Message sent!"
      redirect_to conversation_private_messages_path(@conversation)
    else
      flash[:error] = "Message could not be sent!"
      redirect_to conversation_private_messages_path(@conversation)
    end
  end

  private

  def find_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:private_message).permit(:body)
  end
end