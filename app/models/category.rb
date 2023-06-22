class Category < ApplicationRecord
    has_many :books
    # chúng ta sử dụng validation uniqueness với scope là một mảng chứa trường status. Đồng thời, 
    # chúng ta sử dụng conditions để chỉ định rằng validation uniqueness chỉ được áp dụng khi status có giá trị là 0 hoặc 1.
    enum status: { 'Close': 0, 'Open': 1, delete_category: 2 }
    validates :name_category, presence: true
    validate :unique_name_category_with_status
  
    private
  
    def unique_name_category_with_status
      existing_record = Category.where(name_category: name_category, status: [0, 1]).first
      if existing_record.present? && existing_record != self
        errors.add(:name_category, "has already been taken with status [0, 1]")
      end
    end
end
