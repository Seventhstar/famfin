class BalancesController < InheritedResources::Base
  before_action :set_balance, only: [:show, :edit, :update, :destroy]
  before_action :fill_values, only: [:edit, :new, :index]
  before_action :authenticate_user! 

  def new
    @balance = Balance.new
    @balance.date = Date.today.beginning_of_month
  end

  def create
    @balance = Balance.new(balance_params)

    respond_to do |format|
      if @balance.save
        format.html { redirect_to balances_url, notice: 'Баланс успешно сохранен.' }
        format.json { render :show, status: :created, location: @balance }
      else
        format.html { render :new }
        format.json { render json: @balance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @balance.update(balance_params)
        format.html { redirect_to balances_url, notice: 'Баланс успешно обновлен.' }
      else
        flash.now[:danger] = @balance.errors.full_messages
        format.html { render :edit }
      end
    end

  end


  private
    def set_balance
      @balance = Balance.find(params[:id])
    end

    def fill_values
      @accounts = Account.order(:name)
    end

    def balance_params
      params.require(:balance).permit(:date, :amount, :account_id)
    end
end

