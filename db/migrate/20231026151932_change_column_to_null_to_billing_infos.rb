class ChangeColumnToNullToBillingInfos < ActiveRecord::Migration[7.0]
  def up
    change_column_null :billing_infos, :email, true
  end

  def down
    change_column_null :billing_infos, :email, false
  end
end
