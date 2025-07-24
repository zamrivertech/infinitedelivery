class EntitiesController < ApplicationController
  before_action :set_entity, only: %i[edit update destroy]

def index
  @roles = Role.order(:name) # for select input
  @entity_attributes = [
    "Nome", "Nacionalidade", "Identificação", "Gênero",
    "Nascimento", "Naturalidade", "Endereço", "Envio", "Recepção",
    "Contacto", "Papel"
  ]

  base = Entity.includes(:contacts, :role)

  if params[:query].present?
    keyword = "%#{params[:query].downcase}%"

    base = base.joins("LEFT JOIN contacts ON contacts.entity_id = entities.id")
               .where(
                 "LOWER(entities.full_name) LIKE :q OR LOWER(entities.nationality) LIKE :q OR LOWER(entities.id_number) LIKE :q OR LOWER(contacts.value) LIKE :q",
                 q: keyword
               )
  end

  if params[:role_id].present?
    base = base.where(role_id: params[:role_id])
  end

  @entities = base
  .left_joins(:sent_parcels, :received_parcels)
  .select(
    "entities.*",
    "COUNT(DISTINCT parcels_sent.id) AS sent_count",
    "COUNT(DISTINCT parcels_received.id) AS received_count"
  )
  .joins("LEFT JOIN parcels AS parcels_sent ON parcels_sent.sender_id = entities.id")
  .joins("LEFT JOIN parcels AS parcels_received ON parcels_received.recipient_id = entities.id")
  .group("entities.id")
  .distinct



end


  def new
    @entity = Entity.new
    @entity.contacts.build
  end

def create
  @entity = Entity.new(entity_params)

  if @entity.save
    redirect_to entities_path, notice: "Entidade criada com sucesso!"
  else
    @entity.contacts.build if @entity.contacts.empty?
    flash.now[:alert] = "Erro ao criar entidade. Verifique os campos obrigatórios."
    render :new, status: :unprocessable_entity
  end
end

  def edit
  end

  def update
    if @entity.update(entity_params)
      redirect_to entities_path, notice: "Entidade atualizada com sucesso!"
    else
      @entity.contacts.build if @entity.contacts.empty?
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entity.destroy
    redirect_to entities_path, notice: "Entidade removida com sucesso!"
  end

  private

    def set_entity
      @entity = Entity.find(params[:id])
      @entity.contacts.build if @entity.contacts.empty?
    end

    def entity_params
      params.require(:entity).permit(
        :full_name, :nationality, :id_type, :id_number, :gender,
        :date_of_birth, :place_of_birth, :address, :issuance_country, 
        :issuance_location, :issuance_date,
        :expiry_date, :residence_status, :role_id,
        contacts_attributes: [:id, :contact_type, :value, :_destroy]
      )
    end
end
