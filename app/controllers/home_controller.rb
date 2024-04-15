class HomeController < ApplicationController
  def index
    @activities = Activity.all
    @activities_total =  @activities.count
    @activities_mestrados = @activities.where(activity_type: "Mestrado").count
    @activities_ic = @activities.where(activity_type: "Pós-Graduação").count
    @activities_pos = @activities.where(activity_type: "Iniciação científica").count
    @activities_ext = @activities.where(activity_type: "Extensão").count
  end
end
