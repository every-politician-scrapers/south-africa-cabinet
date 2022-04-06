#!/bin/bash

bundle exec ruby bin/scraper/premiers-wikipedia.rb > data/premiers-wikipedia.csv
# TODO: bring WD fetch in-place
bundle exec ruby bin/diff-premiers.rb > data/diff-premiers.csv
