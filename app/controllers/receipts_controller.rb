class ReceiptsController < InheritedResources::Base
  before_action :set_receipt, only: [:show, :edit, :update, :destroy]
  before_action :fill_values, only: [:edit, :new]
  before_action :authenticate_user!

  def index
    @receipts = Receipt.order(date: :desc)
  end

  def new
    # fill_values
    @receipt = Receipt.new
    # @receipt.user = current_user
    @receipt.date = Date.today
  end

  def edit
    # puts @receipt.account
  end


  def create
    @receipt = Receipt.new(receipt_params)

    respond_to do |format|
      if @receipt.save
        format.html { redirect_to receipts_url, notice: 'Поступление успешно сохранено.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to receipts_url, notice: 'Поступление успешно обновлено.' }
      else
        flash.now[:danger] = @receipt.errors.full_messages
        format.html { render :edit }
      end
    end

  end

  private
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end

    def fill_values
      @accounts = Account.order(:name)
      @receipts_types = ReceiptsType.order(:name)
      @users = User.order(:username)
    end

    def receipt_params
      params.require(:receipt).permit(:date, :amount, :account_id, :receipts_type_id, :user_id, :comment)
    end
end

