# splitter
Solving the single most annoying problem in my life right now: **Splitting PDF documents with facing pages.**

### Run from the command line:

```bash
splitter <input_file> <output_file>
```

NOTE: Currently, this needs to be run in the folder containing the input file.

### Within Ruby:

```ruby
require 'splitter'

# ...

Splitter.new('input_path', 'output_path').split
```

# Getting started

This gem has NOT been published to rubygems yet so you will need to build it yourself:

```bash
gem build splitter.gemspec
gem install splitter-0.0.0.gem
```