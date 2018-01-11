class CreateTables < ActiveRecord::Migration
  def change
    create_table :flows do |t|
      t.integer  :settlement_id
      t.integer  :user_id
      t.integer  :category,       default: 1, 		comment: "类别"
      t.string   :title
      t.integer  :paytype,		  default: 1,		comment: "支付方式"
      t.decimal  :price,          :precision => 15, :scale => 6, :default => 0.0
      t.decimal  :qty,			  :precision => 15, :scale => 6, :default => 0.0
      t.decimal  :amount,		  :precision => 10, :scale => 2, :default => 0.0
      t.integer  :index_day
      t.integer  :index_month
      t.integer  :index_year
      t.string   :description,		         		comment: "说明"
      t.timestamps
    end

    create_table :settlements do |t|
      t.integer  :user_id
      t.integer  :category,       default: 1, 		comment: "类别"
      t.decimal  :amount,		  :precision => 10, :scale => 2, :default => 0.0
      t.decimal  :month_left,	  :precision => 10, :scale => 2, :default => 0.0
      t.decimal  :year_left,	  :precision => 10, :scale => 2, :default => 0.0
      t.integer  :index_day
      t.integer  :index_month
      t.integer  :index_year
      t.timestamps
    end
  end
end
