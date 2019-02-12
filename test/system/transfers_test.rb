require "application_system_test_case"

class TransfersTest < ApplicationSystemTestCase
  setup do
    @transfer = transfers(:one)
  end

  test "visiting the index" do
    visit transfers_url
    assert_selector "h1", text: "Transfers"
  end

  test "creating a Transfer" do
    visit transfers_url
    click_on "New Transfer"

    fill_in "Account from", with: @transfer.account_from_id
    fill_in "Account to", with: @transfer.account_to_id
    fill_in "Amount", with: @transfer.amount
    fill_in "Comment", with: @transfer.comment
    fill_in "Date", with: @transfer.date
    click_on "Create Transfer"

    assert_text "Transfer was successfully created"
    click_on "Back"
  end

  test "updating a Transfer" do
    visit transfers_url
    click_on "Edit", match: :first

    fill_in "Account from", with: @transfer.account_from_id
    fill_in "Account to", with: @transfer.account_to_id
    fill_in "Amount", with: @transfer.amount
    fill_in "Comment", with: @transfer.comment
    fill_in "Date", with: @transfer.date
    click_on "Update Transfer"

    assert_text "Transfer was successfully updated"
    click_on "Back"
  end

  test "destroying a Transfer" do
    visit transfers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transfer was successfully destroyed"
  end
end
