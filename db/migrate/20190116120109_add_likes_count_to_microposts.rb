class AddLikesCountToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :likes_count, :integer
  end
end
