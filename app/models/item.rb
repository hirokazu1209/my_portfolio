class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category

  # 今月・前月・前々月のYYYYMMをリスト化
  def generate_month_options
    today = Date.today
    (0..2).map { |i| (today - i.months).strftime('%Y%m').to_i }
  end

  # 対象月のcreated_atを取得
  scope :by_target_month, ->(target_month) {
    where("TO_CHAR(created_at, 'YYYYMM') = ?", target_month.to_s)
  }
end
