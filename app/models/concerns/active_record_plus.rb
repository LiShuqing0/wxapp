# -*- encoding : utf-8 -*-
module ActiveRecordPlus

  extend ActiveSupport::Concern

  included do 
    # has_many :attenders
  end

  # add your instance methods here
  def foo
    "foo"
  end

  def tras_to!(st, do_save = true)
    self.status = st 
    save if do_save
  end

  # 如: FW_TYPE = { 1 => "退货", 3 => "换货" }
  # <%= obj.h(:fw_type) %> => "退货"
  def h(sym, class_name = nil)
    h_val = send(sym)
    return "" if h_val.nil?
    clazz = class_name.nil? ? self.class : class_name.constantize
    if h_val.is_a?(String)
      eval("#{clazz}::#{sym.to_s.upcase}.with_indifferent_access['#{h_val}']")
    else
      eval("#{clazz}::#{sym.to_s.upcase}[#{h_val}]")
    end
  end

  # 如: Setting.card_type = { 1 => "身份证", 3 => "军团证" }
  # <%= obj.s(:card_type) %> => "退货"
  def s(sym)
    h_val = send(sym)
    return "" if h_val.blank?
    if h_val.is_a?(String)
      eval("Setting.#{sym}['#{h_val}']")
    else
      eval("Setting.#{sym}[#{h_val}]")
    end
  end

   # 不显示英文字段，只显示内容
  def error_msg
    errors.values.flatten.join(" ")
  end

  # 记录抓取日志，log_column是记录日志的字段，content_hash是记录的内容 ，如{"更新时间" => Time.new.strftime("%Y-%m-%d %H:%M:%S").to_s}
  def write_log(content_hash = {}, log_column = "log")
    return if content_hash.blank?
    unless self.send(log_column).blank?
      xml = Nokogiri::XML(self.send(log_column))
    else
      xml = Nokogiri::XML::Document.new()
      xml.encoding = "UTF-8"
      xml << "<logs>"
    end
    node = xml.root.add_child("<log>").first
    node["操作时间"] = Time.new.strftime("%Y-%m-%d %H:%M:%S").to_s
    content_hash.each do |k, v|
      node[k.to_s] = v
    end

    update({log_column.to_sym => xml.to_s})
  end

  def wlog(do_want, username = "系统", content_hash = {})
    content_hash.merge!({"操作人" => username, "事件" => do_want})
    log_column = content_hash[:log_column] || "log"
    write_log(content_hash, log_column)
  end

  def ilog(do_want, current_uesr, content_hash = {})
    content_hash.merge!({"操作人" => "[#{current_uesr.id}]#{current_uesr.real_name}", "事件" => do_want})
    log_column = content_hash[:log_column] || "log"
    write_log(content_hash, log_column)
  end

  # good.update_log({"操作" => "抓取报价"}, {"更新时间" => Time.now.to_s})
  # update goods set log = UpdateXML(log,'/logs/log[attribute::操作="抓取报价"]/attribute::更新时间',concat('更新时间=\"',now(),'\"')) where id = 39639
  def update_log(condition_hash = {}, value_hash = {}, log_column = "log")
    return nil unless log = self.send(log_column)
    return nil unless log_doc = Nokogiri::XML(log) rescue nil
    selector = "log"
    condition_hash.each{|k, v| selector += "[#{k.to_s}='#{v}']"}
    return nil if log_doc.search(selector).first.blank?
    value_hash.each{|k, v| log_doc.search(selector).map{|dom| dom[k.to_s] = v}}
    update({log_column.to_sym => log_doc.to_s})
  end

  def uniq_log(condition_hash = {}, log_column = "log")
    return nil unless log = self.send(log_column)
    return nil unless log_doc = Nokogiri::XML(log) rescue nil
    selector = "log"
    condition_hash.each{|k, v| selector += "[#{k.to_s}='#{v}']"}
    return nil if log_doc.search(selector).first.blank?
    size = log_doc.search(selector).size
    return true if size == 1
    log_doc.search(selector)[1..size-1].map(&:remove)
    update({log_column.to_sym => log_doc.to_s})
  end

  def write_or_update(condition_hash = {}, log_column = "log")
    write_log(condition_hash) unless update_log(condition_hash, {"更新时间" => Time.now.to_s})
  end

  # 更新后除去特殊字段（默认时间戳）的改变
  def pcs(*args)
    args = ["updated_at", "created_at"] if args.blank?
    previous_changes.select{|k, v| !args.include?(k) }
  end


  # add your static(class) methods here
  module ClassMethods
    def to_opts(name = "name", id = "id", scope_method = nil)
      m = scope_method || "all"
      send(m).map{|wb|[wb.send(name), wb.send(id)]}
    end
  end
end
