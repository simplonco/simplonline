
class Log < ActiveRecord::Base

  validates :trace, presence: true

  def self.create_for(user)
    trace = {user_id: user.id}
    create(trace: JSON.generate(trace))
  end
end
