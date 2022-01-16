#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  # decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'Chief justices of South Africa'
  end

  # TODO: make this easier to override
  def holder_entries
    noko.xpath("//h2[.//span[contains(.,'#{header_column}')]][1]//following-sibling::ol//li")
  end

  class Officeholder < OfficeholderBase
    def combo_date?
      true
    end

    def raw_combo_date
      noko.xpath('text()').text.tidy
    end

    def name_cell
      noko.css('a')
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
