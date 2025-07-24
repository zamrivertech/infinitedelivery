class ParcelsController < ApplicationController
  def index
    @branches = Branch.order(:name)
    @parcels = Parcel.includes(:sender, :recipient, :origin_branch, :destination_branch)

    if params[:query].present?
      keyword = "%#{params[:query].downcase}%"
      @parcels = @parcels.where(
        "LOWER(parcel_code) LIKE :q OR LOWER(contents_description) LIKE :q OR LOWER(tracking_status) LIKE :q",
        q: keyword
      )
    end

    if params[:branch_id].present?
      @parcels = @parcels.where(origin_branch_id: params[:branch_id])
    end

    if params[:status].present?
      @parcels = @parcels.where(tracking_status: params[:status])
    end

    @parcels = @parcels.order(created_at: :desc)
  end

  def show
    @parcel = Parcel.find(params[:id])
  end

  def new
    @parcel = Parcel.new
  end

  def create
    @parcel = Parcel.new(parcel_params)
    if @parcel.save
      redirect_to parcels_path, notice: "Encomenda registrada com sucesso."
    else
      flash.now[:alert] = "Erro ao registrar encomenda."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @parcel = Parcel.find(params[:id])
  end

  def update
    @parcel = Parcel.find(params[:id])
    if @parcel.update(parcel_params)
      redirect_to parcels_path, notice: "Encomenda atualizada com sucesso."
    else
      flash.now[:alert] = "Erro ao atualizar encomenda."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @parcel = Parcel.find(params[:id])
    @parcel.destroy
    redirect_to parcels_path, notice: "Encomenda removida."
  end

  private

  def parcel_params
    params.require(:parcel).permit(
      :parcel_code, :parcel_type, :contents_description, :weight_kg, :dimensions_cm,
      :fragile, :insurance_required, :value_mzn, :special_instructions,
      :delivery_type, :delivery_priority, :expected_delivery_date,
      :tracking_status, :received_by_recipient, :receipt_pdf_link, :internal_notes,
      :sender_id, :recipient_id, :registered_by_id, :origin_branch_id, :destination_branch_id
    )
  end
end
