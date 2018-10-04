# Accepts:
#   application (application name)
#   deploy (hash of deploy attributes)
#   env (hash of custom environment settings)
#
# Notifies a "restart Rails app <name> for custom env" resource.

define :custom_env_template do

  directory "/srv/www/#{params[:application]}/shared/config" do
    owner 'deploy'
    group 'www-data'
    recursive true
  end

  template "/srv/www/#{params[:application]}/shared/config/application.yml" do
    source "application.yml.erb"
    owner 'deploy'
    group 'www-data'
    mode "0774"
    variables :env => params[:env]
   # notifies :run, resources(:execute => "restart Rails app #{params[:application]} for custom env")

    # only_if do
    #   File.exists?("/srv/www/#{params[:application]}/shared/config")
    # end
  end

end
