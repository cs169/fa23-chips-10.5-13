class AddIssueToNewsItems < ActiveRecord::Migration[5.2]
  def change
    add_column :news_items, :issue, :integer
  end
end
