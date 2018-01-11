class Settlement < ActiveRecord::Base

  belongs_to :user
  has_many :flows

  enum_attr :category, in: [
    ['profit',   1, '+'],
    ['loss',     2, '-']
  ]

  before_create :set_index
  before_save  :update_left

  def update_left
    time = Time.now
    index_month = Concerns::IndexTime.index_month(time)
    index_year = Concerns::IndexTime.index_year(time)
    self.month_left = user.settlements.where(index_month: index_month).sum(:amount)
    self.year_left = user.settlements.where(index_year: index_year).sum(:amount)
  end
  
  def set_index
    time = Time.now
    self.index_month = Concerns::IndexTime.index_month(time)
    self.index_year = Concerns::IndexTime.index_year(time)
  end

end