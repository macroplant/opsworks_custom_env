# Set up app's custom configuration in the environment.
# See https://forums.aws.amazon.com/thread.jspa?threadID=118107

node[:deploy].each do |application, deploy|
  # rails apps only
  # next unless deploy[:application_type].eql?('rails')
  # and only if custom_env JSON is present
  # next unless node[:custom_env] && node[:custom_env][application]
  app = search("aws_opsworks_app").first
  custom_env_template do
    application application
    deploy deploy
    env node[:custom_env][application].to_h.merge(app['environment'].to_h)
  end
end
