require 'emeril/rake'
require 'foodcritic'
require 'rubocop/rake_task'

task default: [:foodcritic, :rubocop]

FoodCritic::Rake::LintTask.new
RuboCop::RakeTask.new
