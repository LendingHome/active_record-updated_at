Gem::Specification.new do |s|
  s.author                = "LendingHome"
  s.email                 = "github@lendinghome.com"
  s.extra_rdoc_files      = %w(LICENSE)
  s.files                 = `git ls-files`.split("\n")
  s.homepage              = "https://github.com/lendinghome/active_record-updated_at"
  s.license               = "MIT"
  s.name                  = "active_record-updated_at"
  s.rdoc_options          = %w(--charset=UTF-8 --inline-source --line-numbers --main README.md)
  s.require_paths         = %w(lib)
  s.required_ruby_version = ">= 3.0.0"
  s.summary               = "Touch `updated_at` by default with calls to `update_column(s)` and `update_all`"
  s.test_files            = `git ls-files -- spec/*`.split("\n")
  s.version               = "1.0.0"

  s.add_dependency "activerecord", "~> 6.1"
end
