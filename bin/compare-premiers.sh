#!/bin/bash

bundle exec ruby bin/scraper/premiers-wikipedia.rb | ifne tee data/premiers-wikipedia.csv
# TODO: bring WD fetch in-place
bundle exec ruby bin/diff-premiers.rb | ifne tee data/diff-premiers.csv
