task :overapp_dep do
  branch = `git branch`.split("\n").find { |x| x =~ /^\*/ }.split(" ").last.strip
  raise "bad branch" unless branch.present?
  ec "bundle update overapp npm_overapp"
  ec "git add Gemfile.lock"
  ec "git commit -m 'overapp dep'"
  ec "git push origin #{branch}:#{branch}"
end