class ExpensePlansController < InheritedResources::Base
  before_action :set_expense_plan, only: [:show, :edit, :update, :destroy]
  before_action :fill_values, only: [:edit, :new, :index, :create]
  before_action :authenticate_user!


  def new
    @expense_plan = Balance.new
    @expense_plan.date = Date.today.beginning_of_month
  end


  def create
    @expense_plan = ExpensePlan.new(expense_plan_params)

    respond_to do |format|
      if @expense_plan.save
        format.html { redirect_to expense_plans_url, notice: 'План успешно сохранен.' }
        format.json { render :show, status: :created, location: @expense_plan }
      else
        format.html { render :new }
        format.json { render json: @expense_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense_plan.update(expense_plan_params)
        format.html { redirect_to expense_plans_url, notice: 'План успешно обновлен.' }
      else
        flash.now[:danger] = @expense_plan.errors.full_messages
        format.html { render :edit }
      end
    end

  end


  private

    def set_expense_plan
      @expense_plan = ExpensePlan.find(params[:id])
    end

    def expense_plan_params
      params.require(:expense_plan).permit(:date, :amount, :expense_type_id, :comment)
    end

    def fill_values
      @expense_types = ExpenseType.order(:name)
    end

end

