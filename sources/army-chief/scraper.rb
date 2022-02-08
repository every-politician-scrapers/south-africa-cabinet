#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'Portrait'
  end

  def table_number
    4
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[no img name start end].freeze
    end

    def name_cell
      super.css('b')
    end

    def raw_end
      super.gsub('†', '').tidy
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
