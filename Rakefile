require 'foodcritic'
require 'rubocop/rake_task'
require 'stove/rake_task'

task default: [:foodcritic, :rubocop]

FoodCritic::Rake::LintTask.new
RuboCop::RakeTask.new
Stove::RakeTask.new
