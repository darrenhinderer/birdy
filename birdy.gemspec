Gem::Specification.new do |s|
  s.name = "birdy"
  s.version = "1.0.0"
  s.summary = "Twitter integration with Linux desktop notifications"
  s.authors = "Darren Hinderer"
  s.email = "darren.hinderer@gmail.com"
  s.rubyforge_project = "birdy"
  s.has_rdoc = false
  s.files = ["MIT-LICENSE", "bin/birdy", "lib/birdy.rb", 
             "lib/birdy/authentication.rb", "lib/birdy/base.rb", 
             "lib/birdy/config.rb", "lib/birdy/linux_notifier.rb", 
             "lib/birdy/image_download.rb"]
  s.executables = ['birdy']
  s.require_paths = ['lib']

  s.add_runtime_dependency(%q<twitter4r>, [">= 0.3.0"])
  s.add_runtime_dependency(%q<rbus>, [">= 0.2.0"])
  s.add_runtime_dependency(%q<highline>, [">= 1.5.0"])
end
