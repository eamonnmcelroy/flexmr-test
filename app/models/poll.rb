class Poll < ApplicationRecord
  belongs_to :user
  has_many :poll_options
  has_many :poll_responses

  accepts_nested_attributes_for :poll_options, reject_if: :all_blank, allow_destroy: true

  validates :question, :title, presence: true

  # For radio button collection in views
  def option_collection
    poll_options.map {|po| [po.text,po.id] }
  end

  # for inserting into pie chart in views
  # There is probably a much better way of
  # doing this but for now this will do
  def pie_chart_data
    data = poll_responses.group(:poll_option_id).count
    output = {}
    data.each do |id,n|
      output[self.poll_options.find_by_id(id).text] = n
    end
    output
  end

end
