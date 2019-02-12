class ReceiptsController < InheritedResources::Base
  before_action :set_receipt, only: [:show, :edit, :update, :destroy]
  before_action :fill_values, only: [:edit, :new, :index, :create]
  before_action :authenticate_user!

  def index
    @receipts = Receipt.order(date: :desc)
    @json_receipts = @receipts.map{|e| {
      id: e.id, 
      date: e.date.try('strftime',"%d.%m.%Y"),
      sortdate: e.date,
      month: t(e.date.try('strftime',"%B")) + " " + e.date.try('strftime',"%Y"),
      amount: e.amount,
      account: e.account_name,
      receipts_type: e.receipts_type_name,
      comment: e.comment
    }}
  end

  def new
    @receipt = Receipt.new
    @receipt.date = Date.today
    puts "new"
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

