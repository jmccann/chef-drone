require 'emeril/rake'
require 'foodcritic'
require 'rubocop/rake_task'

task ci: [:foodcritic, :rubocop]
task default: :ci

FoodCritic::Rake::LintTask.new
Rubocop::RakeTask.new

unless ENV['CI']
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
  task(:default).enhance(['kitchen:all'])
end
