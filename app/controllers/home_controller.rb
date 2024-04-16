class HomeController < ApplicationController
  def index
    @activities = Activity.all
    @activities_total =  @activities.count
    @activities_infra = @activities.where(activity_type: "Infraestrutura").count
    @activities_graduacao = @activities.where(activity_type: "Graduação").count
    @activities_pos = @activities.where(activity_type: "Pós-Graduação").count
    @activities_ext = @activities.where(activity_type: "Extensão").count
  end
end
