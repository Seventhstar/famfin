require "application_system_test_case"

class ExpensePlansTest < ApplicationSystemTestCase
  setup do
    @expense_plan = expense_plans(:one)
  end

  test "visiting the index" do
    visit expense_plans_url
    assert_selector "h1", text: "Expense Plans"
  end

  test "creating a Expense plan" do
    visit expense_plans_url
    click_on "New Expense Plan"

    fill_in "Amount", with: @expense_plan.amount
    fill_in "Comment", with: @expense_plan.comment
    fill_in "Date", with: @expense_plan.date
    fill_in "Expense type", with: @expense_plan.expense_type_id
    click_on "Create Expense plan"

    assert_text "Expense plan was successfully created"
    click_on "Back"
  end

  test "updating a Expense plan" do
    visit expense_plans_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @expense_plan.amount
    fill_in "Comment", with: @expense_plan.comment
    fill_in "Date", with: @expense_plan.date
    fill_in "Expense type", with: @expense_plan.expense_type_id
    click_on "Update Expense plan"

    assert_text "Expense plan was successfully updated"
    click_on "Back"
  end

  test "destroying a Expense plan" do
    visit expense_plans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Expense plan was successfully destroyed"
  end
end
