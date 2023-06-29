class SuppliesController < ApplicationController
	before_action :set_supply, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:mass_stock_update]
  before_action :authenticate_admin

  def create
    @supply = Supply.new(supply_params)
    respond_to do |format|
      if @supply.save
        format.html { redirect_to supplies_path,
                      notice: {
                        message: I18n.t('activerecord.controllers.actions.created',
                        model_name: I18n.t('activerecord.models.supply.one') )
                      }
                    }
        format.json { render :show, status: :created, location: @supply }
      else
        format.html { render :new }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @supply.destroy
    respond_to do |format|
      format.html { redirect_to supplies_path,
                    alert: {
                      message: I18n.t('activerecord.controllers.actions.destroyed',
                      model_name: I18n.t('activerecord.models.supply.one') )
                    }
                  }
      format.json { head :no_content }
    end
  end

  def edit
    @expense_types = ExpenseType.all
  end

	def index
		@supplies = Supply.order(:name).page(params[:page]).per(25)
	end

	def new
		@supply = Supply.new
	end

  def show
    @transactions = @supply.outflow_items.order(:created_at).page(params[:page])
  end

  def update
    respond_to do |format|
      if @supply.update(supply_params)
        format.html { redirect_to supplies_path,
                      notice: {
                        message: I18n.t('activerecord.controllers.actions.updated',
                        model_name: I18n.t('activerecord.models.supply.one') )
                      }
                    }
        format.json { render :show, status: :ok, location: @supply }
      else
        format.html { render :edit }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

 private
   def set_supply
     @supply = Supply.find(params[:id])
   end

   def supply_params
     params.require(:supply).permit(:name, :price, :unit, :stock,
      mass_stock: [:supply_id, :stock])
   end
end