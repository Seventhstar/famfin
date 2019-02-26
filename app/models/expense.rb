class Expense < ApplicationRecord
  belongs_to :shop
  belongs_to :account
  belongs_to :expense_type
  belongs_to :user
  has_many :expense_rows,  dependent: :destroy 
  accepts_nested_attributes_for :expense_rows, allow_destroy: true

  def shop_name()
    shop.try(:name)
  end

  def account_name()
    account.try(:name)
  end

  def expense_type_name()
    expense_type.try(:name)
  end

  def expense_type_names()
    n = ''
    if expense_rows.count >0
      expense_rows.each do |er|
        n += er.expense_type_name + ', '
      end
      n.chomp!(', ')
    else
      n = expense_type_name 
    end
    n
  end

  def expense_kind_name()
    expense_type.try(:expense_kind).try(:name)
  end

  def user_name()
    user.try(:name)
  end

  def report_sum()
    report_amount==0 || report_amount.nil? ? amount : report_amount
  end

end
