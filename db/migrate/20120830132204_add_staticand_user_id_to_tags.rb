class AddStaticandUserIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :static, :boolean
    add_column :tags, :user_id, :integer
  end
end
