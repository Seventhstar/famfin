class TransfersController < InheritedResources::Base
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]
  before_action :fill_values, only: [:edit, :new, :index, :create]
  before_action :authenticate_user! 


  def new
    @transfer = Transfer.new
    @transfer.date = Date.today
  end

  def create
    @transfer = Transfer.new(transfer_params)

    respond_to do |format|
      if @transfer.save
        format.html { redirect_to transfers_url, notice: 'Баланс успешно сохранен.' }
        format.json { render :show, status: :created, location: @transfer }
      else
        format.html { render :new }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to transfers_url, notice: 'Баланс успешно обновлен.' }
      else
        flash.now[:danger] = @transfer.errors.full_messages
        format.html { render :edit }
      end
    end

  end


  private
    def set_transfer 
      @transfer = Transfer.find(params[:id])
    end

    def fill_values
      @accounts = Account.order(:name)
    end

    def transfer_params
      params.require(:transfer).permit(:date, :amount, :account_id, :account_to_id, :comment)
    end
end

