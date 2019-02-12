class Receipt < ApplicationRecord
  belongs_to :account
  belongs_to :receipts_type

    def account_name()
    account.try(:name)
  end

  def receipts_type_name()
    receipts_type.try(:name)
  end

end
