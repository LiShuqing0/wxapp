class Article < ActiveRecord::Base
  enum_attr :status, in: [
    ['audit_pass',   1, '已审核'],
    ['draft',  0, '草稿'],
    ['deleted',  -1, '已删除']
  ]
  IS_PUBLISHED = { true => "是", false => "否"}

  scope :show, -> {where(status: [DRAFT, AUDIT_PASS])}
end