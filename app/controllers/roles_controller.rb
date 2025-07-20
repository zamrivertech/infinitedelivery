class RolesController < ApplicationController
  before_action :set_role, only: %i[edit update destroy]

  def index
    @roles = Role.order(:name)
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to roles_path, notice: "Papel criado com sucesso!"
    else
      flash.now[:alert] = "Erro ao criar papel."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @role.update(role_params)
      redirect_to roles_path, notice: "Papel atualizado com sucesso!"
    else
      flash.now[:alert] = "Erro ao atualizar papel."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @role.destroy
    redirect_to roles_path, notice: "Papel removido com sucesso!"
  end

  private

    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name, :role_group, :description)
    end
end
