class Tag < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :user_id, :message => "must be unique"

  has_and_belongs_to_many :todos
  belongs_to :user
end
