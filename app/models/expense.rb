class Expense < ApplicationRecord
  belongs_to :shop
  belongs_to :account
  belongs_to :expense_type
  belongs_to :user

  def shop_name()
    shop.try(:name)
  end

  def account_name()
    account.try(:name)
  end

  def expense_type_name()
    expense_type.try(:name)
  end

  def user_name()
    user.try(:name)
  end

  def report_sum()
    report_amount==0 || report_amount.nil? ? amount : report_amount
  end

end
