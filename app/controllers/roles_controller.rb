class RolesController < ApplicationController
  before_action :set_role, only: %i[edit update destroy show]

  def index
    @roles = Role.order(:name)

      @entities_role_table_config = {
      collection: @roles,
      columns: [
        { label: "Nome", value: ->(e) { e.name } },
        { label: "Grupo", value: ->(e) { e.role_group } },
        { label: "Descrição", value: ->(e) { e.description} },
        { label: "", value: ->(e) {
            ActionController::Base.helpers.link_to(
              "Visualizar",
              "/entities_roles/#{e.id}",
              class: "btn btn-sm btn-outline-info ps-2 pe-2 pt-1 pb-1 me-0"
            ).html_safe
          }, class: "text-center"
        }

      ]
}
  end

  def new
    @role = Role.new
  end

  def show
  end  

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to entities_roles_path, notice: "Papel criado com sucesso!"
    else
      flash.now[:alert] = "Erro ao criar papel."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @role.update(role_params)
      redirect_to entities_roles_path, notice: "Papel atualizado com sucesso!"
    else
      flash.now[:alert] = "Erro ao atualizar papel."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @role.destroy
    redirect_to entities_roles_path, notice: "Papel removido com sucesso!"
  end

  private

    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name, :role_group, :description)
    end
end
