class Lexique < ActiveRecord::Base
  validates_presence_of :keyword, :description
end
