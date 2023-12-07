# frozen_string_literal: true

class ChangeCheckboxColumnToNullToBillingInfos < ActiveRecord::Migration[7.0]
  def up
    change_column_null :billing_infos, :same_address_flag, true
    change_column_null :billing_infos, :save_info_flag, true
  end

  def down
    change_column_null :billing_infos, :same_address_flag, false
    change_column_null :billing_infos, :save_info_flag, false
  end
end
