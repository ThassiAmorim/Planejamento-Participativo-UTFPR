class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new edit update destroy ]


  # GET /activities or /activities.json
  def index
    @activities = Activity.all
  end



  # GET /activities/1 or /activities/1.json
  def show
  end

  def search
    @query = params[:query]
    @filter = params[:filter]

    # Lógica para buscar atividades com base nos parâmetros
    @activities = Activity.all

    if @query.present?
      @activities = @activities.where("name LIKE ?", "%#{@query}%")
    end

    if @filter.present? && @filter != "Todos"
      @activities = @activities.where(activity_type: @filter)
    end
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities or /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to activity_url(@activity), notice: "Atividade inserida com sucesso!" }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1 or /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to activity_url(@activity), notice: "Atividade atualizada com sucesso!" }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1 or /activities/1.json
  def destroy
    @activity.destroy!

    respond_to do |format|
      format.html { redirect_to activities_url, notice: "Activity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # # GET /dashboard
  def dashboard

    @activities = Activity.all
    # Calculando a contagem de atividades por tipo
    @activities_by_type = @activities.group(:activity_type).count

    # Calculando a média de progresso por tipo
    @progress_by_type = @activities.group(:activity_type).average(:progress)

     # Convertendo os dados para um formato adequado para o JavaScript
    @activities_data = @activities.group_by(&:activity_type).transform_values { |activities| activities.map { |activity| { name: activity.name, completion: activity.progress } } }.to_json

  end

  def relatorio
    @activities = Activity.all
    @activities_total      = @activities.count
    @activities_infra      = @activities.where(activity_type: "Infraestrutura").count
    @activities_graduacao  = @activities.where(activity_type: "Graduação").count
    @activities_pos        = @activities.where(activity_type: "Pesquisa e Pós-Graduação").count
    @activities_relacoes   = @activities.where(activity_type: "Relações Empresariais e Comunitárias").count
    @activities_gestao     = @activities.where(activity_type: "Gestão do Campus").count
    @activities_servidores = @activities.where(activity_type: "Servidores").count
    @activities_processos  = @activities.where(activity_type: "Processos").count
    @activities_comunidade = @activities.where(activity_type: "Comunidade Acadêmica").count
    @activities_rg         = @activities.where(activity_type: "Registro RG").count

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :activity_type, :progress, :activity_id, :description, :responsible)
    end
end
