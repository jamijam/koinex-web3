Gem::Specification.new do |s|
  s.name        = 'koinex_web3'
  s.version     = '0.0.0'
  s.date        = '2017-07-01'
  s.summary     = "Koinex Ruby wrapper on geth rpc calls"
  s.description = s.summary
  s.authors     = ["Rakesh Yadav"]
  s.email       = 'rakesh@koinex.in'
  s.files       = ["lib/web3.rb", "lib/generated_web3_methods.rb"]

  s.add_runtime_dependency "httparty", '~> 0.14'
  s.add_runtime_dependency "json", '~> 2'
end
