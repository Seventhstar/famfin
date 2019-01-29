class StatisticsController < ApplicationController

  before_action :authenticate_user!

  def show

    @groups = ExpenseType.order(:id).pluck(:id, :name)
    @users  = User.order(:id).pluck(:id, :username)

    @expense_plans = ExpensePlan.all.map{ |ep| { expense_type: ep.expense_type_id, amount: ep.amount} }
    # puts "@expense_plans #{@expense_plans}"
    # //.pluck(:date, :expense_type_id, :amount )

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

    @total_amount = 0 
    @over = 0 
    @rest = 0 

    @expenses_talbe = []                    

    @expenses.each do |e|
      type    = @groups[e[0]-1][1]
      amount  = e[1]
      @total_amount = @total_amount + amount

      epa  = @expense_plans.select {|ep| ep[:expense_type] == e[0] }
      plan = epa.present? ? epa[0][:amount] : 0
      diff = plan > 0 ? plan - amount : 0
      if diff >0
        @rest = @rest + diff
      else
        @over = @over - diff
      end

      @expenses_talbe.push({type: type, amount: amount.to_sum, plan: plan.to_sum, diff: diff.to_sum})
    end
    @total_diff = @rest - @over
    # puts "@expenses #{@expenses}"

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

  end

end