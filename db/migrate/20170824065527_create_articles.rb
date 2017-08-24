class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer  :user_id, comment: "作者"
      t.string   :title, comment: "文章标题"
      t.string   :abstract, comment: "摘要" 
      t.text     :body, comment: "主体"
      t.integer  :status, default: 1, comment: "状态"
      t.integer  :position, comment: "排序"
      t.boolean  :published, default: true, comment: "发布"
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
