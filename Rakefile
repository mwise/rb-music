$:.push File.expand_path("../lib", __FILE__)
require "rb-music/version"

desc 'Build gem into the pkg directory'
task :build do
  FileUtils.rm_rf('pkg')
  Dir['*.gemspec'].each do |gemspec|
    system "gem build #{gemspec}"
  end
  FileUtils.mkdir_p('pkg')
  FileUtils.mv(Dir['*.gem'], 'pkg')
end

desc 'Tags version, pushes to remote, and pushes gem'
task :release => :build do
  sh 'git', 'tag', '-m', changelog, "v#{RBMusic::VERSION}"
  sh "git push origin master"
  sh "git push origin v#{RBMusic::VERSION}"
  sh "ls pkg/*.gem | xargs -n 1 gem push"
end

def changelog
  File.read('ChangeLog').split("\n\n\n", 2).first
end
