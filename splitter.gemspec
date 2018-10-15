Gem::Specification.new do |s|
  s.name = 'splitter'
  s.version = '0.0.0'
  s.date = '2018-10-14'
  s.summary = 'Solving the most annoying problem in my life'
  s.authors = ['Jonah Roth']
  s.files = Dir['lib/**/*.rb']
  s.executables = ['splitter']
  s.require_paths = %w[lib]
  s.add_runtime_dependency 'hexapdf', ['= 0.7.0']
end
