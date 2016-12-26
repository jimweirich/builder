require './lib/builder/version'
require 'rake/file_list'

PKG_VERSION = Builder::VERSION

PKG_FILES = Rake::FileList[
  '[A-Z]*',
  'doc/**/*',
  'lib/**/*.rb',
  'test/**/*.rb',
  'rakelib/**/*'
]
PKG_FILES.exclude('test/test_cssbuilder.rb')
PKG_FILES.exclude('lib/builder/css.rb')
PKG_FILES.exclude('TAGS')

Gem::Specification.new do |s|

  #### Basic information.

  s.name = 'builder'
  s.version = PKG_VERSION
  s.summary = "Builders for MarkUp."
  s.description = %{\
Builder provides a number of builder objects that make creating structured data
simple to do.  Currently the following builder objects are supported:

* XML Markup
* XML Events
}

  s.files = PKG_FILES.to_a
  s.require_path = 'lib'

  s.test_files = PKG_FILES.select { |fn| fn =~ /^test\/test/ }

  s.has_rdoc = true
  # s.extra_rdoc_files = rd.rdoc_files.reject { |fn| fn =~ /\.rb$/ }.to_a
  s.rdoc_options <<
    '--title' <<  'Builder -- Easy XML Building' <<
    '--main' << 'README.rdoc' <<
    '--line-numbers'

  s.author = "Jim Weirich"
  s.email = "jim.weirich@gmail.com"
  s.homepage = "http://onestepback.org"
  s.license = 'MIT'
end
