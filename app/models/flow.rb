class Flow < ActiveRecord::Base

  belongs_to :user

  enum_attr :category, in: [
    ['in',    1, '收入'],
    ['out',   2, '支出']
  ]

  enum_attr :paytype, in: [
    ['alipay',  1,  '支付宝'],
    ['wxpay',   2,  '微信'],
    ['cash',    3,  '现金'],
    ['bcard',   4,  '银行卡']
  ]
  before_create :set_index
  after_create :set_settlement

  def set_index
  	time = Time.now
  	self.index_day = Concerns::IndexTime.index_day(time)
  	self.index_month = Concerns::IndexTime.index_month(time)
  	self.index_year = Concerns::IndexTime.index_year(time)
  end

  def set_settlement
  	settlement = user.settlements.where(index_day: self.index_day).first_or_initialize
  	settlement.amount =  self.in? ? settlement.amount.to_f + self.amount.to_f : settlement.amount.to_f - self.amount.to_f
  	settlement.save
  	self.update_column(:settlement_id, settlement.id)
  end
  

end