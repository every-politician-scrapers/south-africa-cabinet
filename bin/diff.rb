#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/comparison'

SKIP = [ # Not listed on Ministers page
  ['---', 'Matamela Cyril Ramaphosa', 'President of South Africa'],
  ['---', 'David Dabede Mabuza', 'Deputy President of South Africa'],
  ['---', 'David Mabuza', 'Deputy President of South Africa']
].freeze

diff = EveryPoliticianScraper::NulllessComparison.new('data/wikidata.csv', 'data/official.csv').diff
                                         .reject { |row| SKIP.include? row }
puts diff.sort_by { |r| [r.first, r[1].to_s] }.reverse.map(&:to_csv)
