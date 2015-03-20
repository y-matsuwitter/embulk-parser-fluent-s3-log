
Gem::Specification.new do |spec|
  spec.name          = "embulk-parser-fluent-s3-log"
  spec.version       = "0.0.1"
  spec.authors       = ["y-matsuwitter"]
  spec.summary       = "Fluent S3 Log parser plugin for Embulk"
  spec.description   = "Parses Fluent S3 Log files read by other file input plugins."
  spec.email         = ["info@yuki-matsumoto.com"]
  spec.licenses      = ["MIT"]
  spec.homepage      = "https://github.com/y-matsuwitter/embulk-parser-fluent-s3-log"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', ['~> 1.0']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
