require 'chefspec'
require 'chefspec/berkshelf'
require_relative 'support/matchers'

def subdirs_for(dir)
  Dir.entries(dir).select do |entry|
    (File.directory? File.join(dir, entry)) && !(entry == '.' || entry == '..')
  end
end

def inject_databags(server)
  data_bags_path = File.expand_path(File.join(File.dirname(__FILE__), '../test/integration/data_bags'))
  subdirs_for(data_bags_path).each do |databag|
    Dir["#{data_bags_path}/#{databag}/*.json"].each do |item_path|
      item = File.basename(item_path, File.extname(item_path))
      server.create_data_bag(databag, item => JSON.parse(File.read(item_path)))
    end
  end
end
