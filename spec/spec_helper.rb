require 'rspec-puppet'

RSpec.configure do |c|
  c.module_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
  c.manifest_dir = File.expand_path(File.join(__FILE__, '..', 'fixtures', 'manifests'))
end
