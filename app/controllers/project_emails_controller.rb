class ProjectEmailsController < ApplicationController
  unloadable
  
  before_filter :load_project, :authorize
  
  def update
    url = project_settings_tab_url

    email = (params[:project] || {})[:email]
    @project.email = email
    if @project.project_email.save
      flash[:notice] = l(:notice_successful_update)
    else
      flash[:error] = @project.project_email.errors.full_messages.join
      url[:email] = email
    end
    redirect_to url
  end
  
  def restore_default
    @project.project_email.destroy if @project.project_email
    @project.reload

    redirect_to project_settings_tab_url, :notice => l(:notice_email_restored)
  end
  
  private
  
  def load_project
    @project = Project.find(params[:id])
  end

  def project_settings_tab_url
    { :controller => 'projects', :action => 'settings',
      :id => @project, :tab => 'outbound_email' }
  end
end
