#!/usr/bin/ruby -KuU
# encoding: utf-8

require 'optparse'
require_relative 'lib_transcribe.rb'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ./ipa_transcriber.rb [options]"

  opts.on("-f", "--filename FILE", "Source file") { |v| options[:filename] = v }
  opts.on("-i", "--ipa-dict DICT", "IPA dictionary file") { |v| options[:dictfile] = v }
  opts.on("-w", "--wordlist LIST", "Optional custom word list") { |v| options[:wordlist] = v }

end.parse!

if !options[:filename]
  abort("  Please provide a source filename.")
end
if !options[:dictfile]
  abort("  Please provide an IPA dictionary file.")
end
if options[:wordlist]
  @wordlist = options[:wordlist]
  if !File.exist?(@wordlist)
    abort("  Specified wordlist file not found.")
  end
end

source_file = options[:filename]
dict_file = options[:dictfile]

if !File.exist?(source_file)
  abort("  Specified source file not found.")
end
if !File.exist?(dict_file)
  abort("  Specified IPA dictionary not found.")
end

puts transcribe_ipa(source_file,dict_file)
