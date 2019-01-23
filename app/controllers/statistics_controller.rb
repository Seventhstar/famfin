class StatisticsController < ApplicationController

  def show
    @groups = ExpenseType.order(:id).pluck(:id, :name)
    @users  = User.order(:id).pluck(:id, :username)
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
    @by_user = Expense.joins(:account)
                        .select("expenses.amount as amount, 
                                accounts.id as accounts_id,
                                accounts.user_id as user_id,
                                accounts.name as accounts_name
                                ")
                        .map{ |e| { account: e.accounts_name,
                                    user_id: e.user_id,
                                    amount: e.amount}}
                        .group_by{ |i| i[:user_id] }
                        .map{ |x, y| [x, y.inject(0){ |sum, i| sum + i[:amount] }] }

    # puts @by_user
                            # .map{ |x, y| [x, y.inject(0){ |sum, i| sum + i[:amount] }] }
                        # .sort_by { |k| k[1] }
                        # .reverse!

  end

end