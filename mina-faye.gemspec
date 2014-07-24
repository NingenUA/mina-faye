# -*- encoding: utf-8 -*-

require "./lib/mina_faye/version.rb"

Gem::Specification.new do |s|
  s.name = "mina-faye"
  s.version = MinaFaye.version
  s.authors = ["Kostyantin Semchenko"]
  s.email = ["Ningen.UA@gmail.com"]
  s.homepage = "https://github.com/NingenUA/mina-faye"
  s.summary = "Tasks to deploy Faye with mina."
  s.description = "Adds tasks to aid in the deployment of Faye"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_runtime_dependency "mina"
end
