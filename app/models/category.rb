class Category < ApplicationRecord
    has_many :books
    # chúng ta sử dụng validation uniqueness với scope là một mảng chứa trường status. Đồng thời, 
    # chúng ta sử dụng conditions để chỉ định rằng validation uniqueness chỉ được áp dụng khi status có giá trị là 0 hoặc 1.
    enum status: { 'Close': 0, 'Open': 1, delete_category: 2 }
    validates :name_category, presence: true
    validate :unique_name_category_with_status
  
    private
  
    def unique_name_category_with_status
      name_category_without_whitespace = name_category.strip # Loại bỏ không gian trắng từ tên danh mục
      
      existing_record = Category.where("TRIM(name_category) = ? AND status IN (0, 1)", name_category_without_whitespace).first
      if existing_record.present? && existing_record != self
        errors.add(:name_category, "has already been taken with status")
      end
    end
end
