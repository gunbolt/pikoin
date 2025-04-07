require "test_helper"

class Accounts::RecordsControllerTest < ActionDispatch::IntegrationTest
  test "edit" do
    sign_in

    record = create(:transfer).expense_record

    get edit_account_record_path(record.account, record)

    assert_response :not_found
  end

  test "update" do
    sign_in

    record = create(:transfer).expense_record

    put account_record_path(record.account, record)

    assert_response :not_found
  end

  test "destroy" do
    sign_in

    record = create(:transfer).expense_record

    delete account_record_path(record.account, record)

    assert_response :not_found
  end
end
