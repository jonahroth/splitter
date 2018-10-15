# Splits a PDF of scanned facing pages into individual pages

require 'hexapdf'
require 'fileutils'
require 'pathname'

class Splitter
  def initialize(source_file, dest_file)
    @dir = Dir.pwd
    @dest_file = dest_file
    @source = HexaPDF::Document.new(io: File.new("#{@dir}/#{source_file}"))
    @copy = HexaPDF::Document.new(io: File.new("#{@dir}/#{source_file}"))
    @dest = HexaPDF::Document.new
  end

  def split
    import_pages(@source, @copy, @dest)
    alt_split_pages(@dest)
    @dest.write("#{@dir}/#{@dest_file}")
  end

  private

  def length
    @source.pages.length
  end

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
      page[:MediaBox] = new_box
    end
  end

end
