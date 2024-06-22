# frozen_string_literal: true

require 'wikipedia'
require 'optparse'

class Philosophy
  def initialize(page_name:, end_page: 'Philosophy')
    @current_page_name = page_name.downcase
    @end_page = end_page.downcase
    @count = 0
    @matched_pages = []
  end

  def count_jumps_to_philosophy
    puts "Jumping to: #{@current_page_name}"
    if @current_page_name.downcase == @end_page
      @count
    else
      @count += 1
      @current_page_name = fetch_wikipedia_raw_content
      count_jumps_to_philosophy
    end
  end

  def fetch_wikipedia_raw_content
    raw_content = make_wikipedia_request
    if raw_content.start_with?('#REDIRECT')
      redirect_page_name = raw_content.match(/\[\[(.*?)\]\]/)[1]
      @current_page_name = redirect_page_name.split('|').first.downcase
      raw_content = make_wikipedia_request
    end
    format_raw_data(raw_content)
  rescue StandardError => e
    "An error occurred: #{e.message}"
  end

  def format_raw_data(raw_content)
    matches = raw_content.strip.scan(/\[\[([^\[\]]*?)\]\]/).flatten
    @filtered_matches = matches.reject do |match|
      match.start_with?('File:', 'Category:', 'Help:', 'Wikipedia:', 'Template:', 'Portal:', 'Special:', 'Image:', '#', '/', 'User:', 'wikt:')
    end
    avoid_infinite_loops
  end

  def avoid_infinite_loops
    selected_match = nil
    @filtered_matches.each do |match|
      if @matched_pages.include?(match)
        puts "Infinite loop detected. Skipping page: #{match}"
        next
      end

      @matched_pages << match
      selected_match = match
      break
    end
    selected_match&.split('|')&.first
  end

  def make_wikipedia_request
    page = Wikipedia.find(@current_page_name)
    summary = page.content.split(/==[^=]/).first
    summary = summary.gsub!(/\{\{[^}]*\}\}/, '')
    summary = summary.gsub(/\n\n/, '').strip
    summary = summary.chomp('}}') if summary.end_with?('}}')
    summary = summary.gsub('>}}', '')
    summary.strip.split('}}').last
  end
end

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: main.rb [options]'

  opts.on('-pNAME', '--page_name=NAME', 'Page name to start from') do |name|
    options[:page_name] = name
  end
  opts.on('-eNAME', '--end_page=NAME', 'Page name to end on (Philosophy by default)') do |name|
    options[:end_page] = name || 'Philosophy'
  end
end.parse!

if options[:page_name]
  puts "Counting jumps to #{options[:end_page]}..."
  puts Philosophy.new(page_name: options[:page_name], end_page: options[:end_page]).count_jumps_to_philosophy
else
  puts 'Please arguments, run with -h for help.'
end
