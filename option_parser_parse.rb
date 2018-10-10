require 'optparse'
require_relative 'desc_supporter'

$options = {}

OptionParser.new do |opt|
  opt.version = ''
  opt.release = ''
  opt.program_name = ''
  # opt.banner = "Usage: #{File.expand_path(__FILE__)} [$options] (directory)"
  summary_width = 32
  opt.summary_width = summary_width
  summary_indent = 4
  opt.summary_indent = ' ' * summary_indent
  blank = summary_indent + summary_width
  # the summary under the lines, copy from `man wc`.
  # opt.on('-c',
  #        DescSupporter.gen_desc('The number of bytes in each input file is written to the standard output. This will cancel out any prior usage of the -m option.', blank)) do |v|
  #   $options[:c] = v
  # end
  # opt.on('-l',
  #        DescSupporter.gen_desc('The number of lines in each input file is written to the standard output.', blank)) do |v|
  #   $options[:l] = v
  # end
  # opt.on('-m',
  #         DescSupporter.gen_desc('The number of characters in each input file is written to the standard output. If the current locale does not support multibyte characters, this is equivalent to the -c option. This will cancel out any prior usage of the -c option.' , blank)) do |v|
  #   $options[:m] = v
  # end
  # opt.on('-w',
  #         DescSupporter.gen_desc('The number of words in each input file is written to the standard output.', blank)) do |v|
  #   $options[:w] = v
  # end

  opt.separator('')
  opt.on('-h', '--help', 'show help.') do
    puts opt.help
    exit
  end
  opt.on('-v', '--version', 'show version.') do
    puts opt.ver
    exit
  end
  opt.parse!(ARGV)
  $options[:directorypath] = []
  loop do
    break if ARGV.empty?

    $options[:directorypath] << ARGV.pop
  end
  $options[:directorypath].reverse!
rescue OptionParser::InvalidOption => e
  puts e.message
  return
end

# entry point

paths = $options[:directorypath]
$options.delete(:directorypath)

