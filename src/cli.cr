require "./franklin"
require "option_parser"

config_path = Franklin::Config::DEFAULT_FILE_LOCATION
filter_type = nil

parser = OptionParser.parse { |parser|
  parser.banner = "Usage: frankling [options] search_term1 search_term2..."

  parser.on("-h", "--help", "Prints this help") do
    puts parser
    puts "Franklin v#{Franklin::VERSION}"
    exit
  end

  parser.on("--config-path=CONFIG", "Path to configuration file. Defaults to ~/.franklin") do |path|
    config_path = path
  end

  parser.on "-tTYPE", "--type=TYPE", "Filter results by type (eBook, Audiobook, etc). Will override config" do |type|
    filter_type = type
  end
}

begin
  Franklin.run(search_terms: ARGV.join(" "), config_path: config_path, filter: filter_type)
rescue ex : ArgumentError
  STDERR.puts <<-ERROR
  Oops! #{ex.message}
  #{parser}
  Franklin v#{Franklin::VERSION}
  ERROR
rescue File::Error
  STDERR.puts <<-ERROR
  Oops! It looks like you have not configured franklin
  Please add a configuration file in $HOME/.franklin that looks like this:
  ---
  libraries:
    - name: San Francisco Public Library
      url: https://sfpl.overdrive.com
    - name: San Diego County Library
      url: https://sdcl.overdrive.com
  default_type: eBook # Optional, leave empty to search for all types
  ERROR
end
