class AddressesController < ApplicationController
  before_action :set_entity
  before_action :set_address, only: [:edit, :update, :destroy]

  def new
    @address = @entity.addresses.build
  end

  def create
    @address = @entity.addresses.build(address_params)
    if @address.save
      redirect_to @entity, notice: "Endereço adicionado com sucesso."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @address.update(address_params)
      redirect_to @entity, notice: "Endereço atualizado."
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to @entity, notice: "Endereço removido."
  end

  private

  def set_entity
    @entity = Entity.find(params[:entity_id])
  end

  def set_address
    @address = @entity.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(
      :address_type, :street_line_1, :street_line_2, :neighborhood, :city,
      :region, :postal_code, :country, :residency_status, :latitude, :longitude
    )
  end
end
