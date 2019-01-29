require 'test_helper'

class ExpensePlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expense_plan = expense_plans(:one)
  end

  test "should get index" do
    get expense_plans_url
    assert_response :success
  end

  test "should get new" do
    get new_expense_plan_url
    assert_response :success
  end

  test "should create expense_plan" do
    assert_difference('ExpensePlan.count') do
      post expense_plans_url, params: { expense_plan: { amount: @expense_plan.amount, comment: @expense_plan.comment, date: @expense_plan.date, expense_type_id: @expense_plan.expense_type_id } }
    end

    assert_redirected_to expense_plan_url(ExpensePlan.last)
  end

  test "should show expense_plan" do
    get expense_plan_url(@expense_plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_expense_plan_url(@expense_plan)
    assert_response :success
  end

  test "should update expense_plan" do
    patch expense_plan_url(@expense_plan), params: { expense_plan: { amount: @expense_plan.amount, comment: @expense_plan.comment, date: @expense_plan.date, expense_type_id: @expense_plan.expense_type_id } }
    assert_redirected_to expense_plan_url(@expense_plan)
  end

  test "should destroy expense_plan" do
    assert_difference('ExpensePlan.count', -1) do
      delete expense_plan_url(@expense_plan)
    end

    assert_redirected_to expense_plans_url
  end
end
