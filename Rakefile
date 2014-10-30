require "bundler/gem_tasks"

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r vibe.rb"
end

require 'rake/testtask'
Rake::TestTask.new do |test|
  test.libs << 'lib' << 'test'
  test.ruby_opts << "-rubygems"
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task default: :test
