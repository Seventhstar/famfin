class ExpensesController < InheritedResources::Base
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :fill_values, only: [:edit, :new, :index, :create]
  before_action :authenticate_user!
  before_action :check_amount, only: [:create, :update]

  def index
    @expenses = Expense.order(date: :desc).joins(:shop)
    @json_expenses = @expenses.map{|e| {
      id: e.id, 
      date: e.date.try('strftime',"%d.%m.%Y"),
      sortdate: e.date,
      month: t(e.date.try('strftime',"%B")) + " " + e.date.try('strftime',"%Y"),
      shop: e.shop_name,
      amount: e.amount,
      account: e.account_name,
      expense_type: e.expense_type_names,
      expense_kind: e.expense_kind_name,
      user: e.user_name,
      comment: e.comment
    }}

  end

  def new
    # fill_values
    if params[:from]
      from = Expense.find(params[:from])
      attrs = from.attributes.except!([:id, :created_at, :updated_at, :user_id])
      @expense = Expense.new(attrs)
    else
      @expense = Expense.new
    end

    @user = current_user
    @expense.date = Date.today
  end

  def edit
    # puts @expense.account
  end


  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to expenses_url, notice: 'Расход успешно сохранен.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expenses_url, notice: 'Расход успешно обновлен.' }
      else
        flash.now[:danger] = @expense.errors.full_messages
        format.html { render :edit }
      end
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def fill_values
      @shops = Shop.order(:name)
      @accounts = Account.order(:name)
      @expense_types = ExpenseType.order(:name)
      @expense_kinds = ExpenseKind.order(:name)
      @users = User.order(:username)
      @rows = @expense.expense_rows if @expense.present?
    end

    def check_amount
      expense_params[:amount] = expense_params[:amount].gsub!(' ','') if !expense_params[:amount].nil?
    end

    def expense_params
      params.require(:expense).permit(:date, :shop_id, :amount, :report_amount,
                                      :account_id, :expense_type_id, :user_id, :comment,
                                      expense_rows_attributes: [:id, :expense_type_id, :amount, :comment, :_destroy])
    end
end

