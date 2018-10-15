# Splits a PDF of scanned facing pages into individual pages

require 'hexapdf'
require 'fileutils'
require 'pathname'

SOURCE_FILE = ARGV[0]
DEST_FILE = ARGV[1]
DIRNAME = File.dirname(__FILE__)
binding.irb

source_file = File.new("#{DIRNAME}/#{SOURCE_FILE}")
SOURCE = HexaPDF::Document.new(io: source_file)
COPY = HexaPDF::Document.new(io: source_file)
DEST = HexaPDF::Document.new

LENGTH = SOURCE.pages.length

def import_pages(source, copy, dest)
  source.pages.each_with_index do |page, index|
    dest.pages << dest.import(page)
    dest.pages << dest.import(copy.pages[index])
  end
end

def alt_split_pages(document)
  document.pages.each_with_index do |page, index|
    box = page.box.value
    width = box[2]

    new_box = box.dup
    if index.odd?
      new_box[0] = width / 2
    else
      new_box[2] = width / 2
    end
    print "#{box} => \t\t #{new_box}\n"
    page[:MediaBox] = new_box
  end
end

import_pages(SOURCE, COPY, DEST)
alt_split_pages(DEST)
DEST.write("#{DIRNAME}/#{DEST_FILE}")
