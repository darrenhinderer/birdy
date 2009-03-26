# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

begin
  require 'bones'
  Bones.setup
rescue LoadError
  begin
    load 'tasks/setup.rb'
  rescue LoadError
    raise RuntimeError, '### please install the "bones" gem ###'
  end
end

ensure_in_path 'lib'
require 'birdy'

PROJ.name = 'birdy'
PROJ.authors = 'Darren Hinderer'
PROJ.email = 'darren.hinderer@gmail.com'
PROJ.version = Birdy::VERSION
PROJ.rubyforge.name = 'hindenburg'
PROJ.summary = 'See new tweets using Gnome notifications'
PROJ.history_file = 'README.txt'
PROJ.ignore_file = '.gitignore'

depend_on "twitter4r"
depend_on "rbus"
depend_on "highline"
