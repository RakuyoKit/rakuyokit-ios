namespace :lib do
  include Tools

  task :release do
    print "Please enter version: "
    version = STDIN.gets.chomp
    puts "Start publishing a new version: #{version}"

    main_branch = "main"
    release_branch = "release/#{version}"

    sh "git checkout -b #{release_branch} #{main_branch}"

    git_message = "release: version #{version}"
    sh "git add . && git commit -m '#{git_message}' --no-verify --allow-empty"

    git_merge(release_branch, main_branch, "Merge branch '#{release_branch}'")

    sh "git tag #{version}"
    git_push(version)

    sh "git branch -d #{release_branch}"
  end

  def git_merge(from_branch, to_branch, merge_message)
    sh "git checkout #{to_branch}"
    sh "git merge --no-ff -m '#{merge_message}' #{from_branch} --no-verify"
    git_push(to_branch, "--no-verify")
  end

  def git_push(branch, options = "")
    sh "git push origin #{branch} #{options}"
  end
end
