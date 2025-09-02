class ParcelsController < ApplicationController
  before_action :set_parcel, only: [:show, :edit, :update, :destroy]

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

  def show; end

  def new
    @parcel = Parcel.new(parcel_code: generate_parcel_code)
  end

  def create
    @parcel = Parcel.new(parcel_params)
    if @parcel.save
      redirect_to @parcel, notice: "Encomenda registrada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @parcel.update(parcel_params)
      redirect_to @parcel, notice: "Encomenda atualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @parcel.destroy
    redirect_to parcels_path, notice: "Encomenda removida."
  end

  private

  def set_parcel
    @parcel = Parcel.find(params[:id])
  end

  def parcel_params
    params.require(:parcel).permit(
      :parcel_code, :contents_description, :weight_kg, :dimensions_cm,
      :fragile, :insurance_required, :value_mzn, :special_instructions,
      :delivery_type, :delivery_priority, :expected_delivery_date,
      :tracking_status, :received_by_recipient, :receipt_pdf_link, :internal_notes,
      :sender_id, :recipient_id, :origin_branch_id, :destination_branch_id
    )
  end

  def generate_parcel_code
    prefix = "TT"
    sequence = (Parcel.maximum(:id).to_i + 1).to_s.rjust(3, "0")
    "#{prefix}-#{sequence}"
  end
end
