class User < ApplicationRecord
  acts_as_authentic

  has_many :polls

  def can_vote_on?(poll)
    !poll.poll_responses.where(user_id: self.id).present?
  end
end
