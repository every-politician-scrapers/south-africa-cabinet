#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      Name.new(full: tds.last.text.tidy, prefixes: %w[Dr Ms Mrs Mr]).short
    end

    def position
      return "Minister in the #{ministry}" if ministry.start_with?('Presidency')

      "Minister of #{ministry}"
    end

    private

    def tds
      noko.css('td')
    end

    def ministry
      tds.first.text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.page-content table').xpath('.//tr[td]')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
