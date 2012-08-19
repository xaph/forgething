class Todo < ActiveRecord::Base
  attr_accessible :description, :name, :user_id

  validates_presence_of :name
end
