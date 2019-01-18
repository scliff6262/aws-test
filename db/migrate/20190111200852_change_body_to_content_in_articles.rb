class ChangeBodyToContentInArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :body, :content
  end
end
