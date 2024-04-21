FORMAT_COMMAND = 'swift package --allow-writing-to-package-directory format'

namespace :swift do
  desc 'Run Format'
  task :format do
    sh FORMAT_COMMAND
  end

  desc 'Run Lint'
  task :lint do
    sh FORMAT_COMMAND + ' --lint'
  end
end
