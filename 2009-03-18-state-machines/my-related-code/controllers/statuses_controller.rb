class StatusesController < ApplicationController

  before_filter :require_user
  before_filter :current_user_must_be_admin!
    
  def update
    raise('STATUS: requires a thing to stat!') unless (params[:klass] && params[:status])
    
    @thing = params[:klass].classify.constantize.find(params[:id])
    
    if @thing.available_statuses.include? params[:status].to_sym
      @thing.current_user = current_user
      eval "@thing.#{params[:status]}!"
    end
      
    flash[:notice] = "#{@thing.class} was successfully #{@thing.status}."
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

end
