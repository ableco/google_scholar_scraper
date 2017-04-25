# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "google_scholar_scraper/version"

Gem::Specification.new do |spec|
  spec.name          = "google_scholar_scraper"
  spec.version       = GoogleScholarScraper::VERSION
  spec.authors       = ["Able Co."]
  spec.email         = ["engineering@able.co"]

  spec.summary       = "Google Scholar scraper, allow searches scholar articles by author ID."
  spec.description   = "Google Scholar scraper"
  spec.homepage      = "https://github.com/ableco/google-scholar-scraper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "useragents", "~> 0.1.4"
  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_dependency "rest-client", "~> 2.0.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop", "~> 0.48.1"
end
