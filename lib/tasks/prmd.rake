require 'prmd/rake_tasks/combine'
require 'prmd/rake_tasks/verify'
require 'prmd/rake_tasks/doc'

namespace :schema do
  Prmd::RakeTasks::Combine.new do |t|
    t.options[:meta] = 'config/schema/meta.json'    # use meta.yml if you prefer YAML format
    t.paths << 'config/schema/schemata/'
    t.output_file = 'config/schema/api.json'
  end

  Prmd::RakeTasks::Verify.new do |t|
    t.files << 'config/schema/api.json'
  end

  Prmd::RakeTasks::Doc.new do |t|
    t.files = { 'config/schema/api.json' => 'config/schema/api.md' }
  end
end

task schema: ['schema:combine', 'schema:verify', 'schema:doc']
