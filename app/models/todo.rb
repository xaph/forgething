# ForgeThing - Simple todo app
# Copyright (C) 2012  Zafer Cakmak
# 
# This file is part of ForgeThing.
# 
# ForgeThing is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# ForgeThing is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with ForgeThing.  If not, see <http://www.gnu.org/licenses/>.

class Todo < ActiveRecord::Base
  attr_accessible :description, :name, :due_date, :user_id, :tag_ids

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :user_id, :message => "must be unique"

  belongs_to :user
  has_and_belongs_to_many :tags

  default_scope where("deleted_at IS NULL").order("starred DESC, created_at ASC")

  def self.active
  	where("completed_at IS NULL")
  end
end
