class Transfer < ApplicationRecord
  belongs_to :account
  belongs_to :account_to, class_name: "Account", foreign_key: :account_to_id


  def account_name()
    account.try(:name)
  end

  def account_to_name()
    account_to.try(:name)
  end


end
