class StatisticsController < ApplicationController

  def show
    @groups = ExpenseType.order(:id).pluck(:id, :name)
    @expenses = Expense.joins(:expense_type)
                        .select("expenses.amount as amount, 
                                  expense_types.id as expense_type_id,
                                expense_types.name as expense_typename,
                                case when expense_types.parent_id is null then expense_types.id
                                else expense_types.parent_id
                                end as parent,
                                case when expense_types.parent_id is null then expense_types.name
                                else ''
                                end as parent_name ")
                        .map{ |e| { group: e.parent,
                                    type: e.expense_typename,
                                    amount: e.amount}}
                        .group_by{ |i| i[:group] }
                        .map{ |x, y| [x, y.inject(0){ |sum, i| sum + i[:amount] }] }
                        .sort_by { |k| k[1] }
                        .reverse!

    # puts @expenses, @expenses.class
                        # .group('expense_types.name')
                        # .sum("expenses.amount")
                        # .sort_by { |k| k[1] }
                        # .reverse!


  end

end