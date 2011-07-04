ActionController::Routing::Routes.draw do |map|
  map.resources :projects do |project|
    project.resource :project_email, :as => 'outbound_email',
      :only => [:update, :destroy]
  end
end
