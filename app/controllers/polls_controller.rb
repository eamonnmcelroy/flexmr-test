class PollsController < ApplicationController

  skip_before_action :ensure_user_logged_in, only: :index
  before_action :ensure_user_is_admin, only: [:new, :create, :destroy]

  def index
    @polls = Poll.all
  end

  def new
    @poll = Poll.new
  end

  def create
    @poll = current_user.polls.new(create_params)
    if @poll.save
      flash[:success] = 'Poll successfully created'
      redirect_to polls_path
    else
      render :new
    end
  end

  # Not used
  def destroy
    if @poll.destroy
      flash[:success] = 'Poll successfully removed'
      redirect_to polls_path
    else
      flash[:alert] = 'Poll was not removed, please try again later'
      redirect_to polls_path
    end
  end

  private

  def create_params
    params.require(:poll).permit(:title, :question, poll_options_attributes: [:text, :_destroy])
  end
end
