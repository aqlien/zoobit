require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

Rails::TestTask.new("test:presenters" => "test:prepare") do |t|
  t.pattern = "test/**/*_test.rb"
end

Rake::Task["test:run"].enhance ["test:presenters"]
