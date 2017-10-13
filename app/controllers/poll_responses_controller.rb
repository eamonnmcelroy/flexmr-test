class PollResponsesController < ApplicationController
  before_action :find_poll
  before_action :ensure_user_is_admin, only: :index
  before_action :ensure_user_can_vote, only: [:new, :create]

  def index
  end

  def new
    @poll_response = @poll.poll_responses.new
  end

  def create
    @poll_response = @poll.poll_responses.new(create_params)
    @poll_response.user_id = current_user.id
    if @poll_response.save
      flash[:success] = 'Response successfully submitted'
      redirect_to polls_path
    else
      flash[:alert] = 'Something has gone wrong, please try again later'
      redirect_to polls_path
    end
  end

  private

  def find_poll
    @poll = Poll.find(params[:poll_id])
  end

  def create_params
    params.require(:poll_response).permit(:poll_option_id) 
  end

  def ensure_user_can_vote
    unless current_user.can_vote_on?(@poll)
      flash[:alert] = 'You have already voted on this poll'
      redirect_to polls_path
    end
  end

end
