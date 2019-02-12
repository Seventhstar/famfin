class Balance < ApplicationRecord
  belongs_to :account

  def account_name()
    account.try(:name)
  end

end
