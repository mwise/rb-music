guard "rspec", cmd: "rspec --color --tag focus", run_all: { cmd: "foo bard" } do
  watch("spec/spec_helper.rb")    { "spec" }
  watch(%r{^spec/.+_spec\.rb$}) { "spec" }
  watch(%r{^lib/(.+)\.rb$})       { "spec" }
  # watch(%r{^lib/(.+)\.rb$})       { |m| "spec/#{m[1]}_spec.rb" }
end
