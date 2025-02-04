class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :created_at}
  validates :study_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  # 対象月のcreated_atを取得
  scope :by_target_month, ->(target_month) {
    where("TO_CHAR(updated_at, 'YYYYMM') = ?", target_month.to_s)
  }
end
