require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  context 'validations' do
    should "require poll" do
      @comment = build :comment
      @comment.poll = nil
      refute @comment.valid?
    end

    should "require user" do
      @comment = build :comment
      @comment.user = nil
      refute @comment.valid?
    end

    should "be an acceptable length" do
      @comment.build :comment
      @comment.comment = nil
      refute @comment.valid?

      @comment.comment = 'a'*1024
      assert @comment.valid?

      @comment.comment = 'a'*1025
      refute @comment.valid?
    end
  end

  context 'can_destroy?' do
    setup do
      @comment = create :comment
      @owner = @comment.user
      @anon = create :user
      @admin = create :admin_user
    end

    should "be true for owner" do
      @comment.can_destroy? @owner
    end

    should "be false for anon" do
      @comment.can_destroy? @anon
    end

    should "be true for admin" do
      @comment.can_destroy? @admin
    end
  end

  context 'can_comment_on_poll?' do
    setup do
      @poll = create(:poll)
      @response = create :poll_response, poll: @poll, poll_option: @poll.poll_options.first
      @answered_user = @response.user
      @unanswered_user = create(:user)
      @admin = create :admin_user
      @poll.reload
    end

    should "be true for user that has answered" do
      assert Comment.can_comment_on_poll? @answered_user
    end

    should "be true for admin" do
      assert Comment.can_comment_on_poll? @admin
    end

    should "be false for user that has not answered" do
      refute Comment.can_comment_on_poll? @unanswered_user
    end
  end

  context 'user_commented_on_poll?' do
    setup do
      @comment = create :comment
      @user_comment = @comment.user
      @poll_comment = @comment.poll

      @anon_user = create :user
      @anon_poll = create :poll
    end

    should "be true when user has commented on poll" do
      assert Comment.user_commented_on_poll? @user_comment, @poll_comment
    end

    should "be false  when user has not commented on poll" do
      refute Comment.user_commented_on_poll? @anon_user, @poll_comment
      refute Comment.user_commented_on_poll? @user_comment, @anon_poll
      refute Comment.user_commented_on_poll? @anon_user, @anon_poll
    end
  end

end
