const fs = require('fs');
let rawmeta = fs.readFileSync('meta.json');
let meta = JSON.parse(rawmeta);

module.exports = function () {
  return `SELECT DISTINCT ?province ?provinceLabel ?position ?positionLabel ?person ?personLabel ?start 
         (STRAFTER(STR(?held), '/statement/') AS ?psid)
  WHERE {
    ?province wdt:P31 wd:Q191093 ; wdt:P1313 ?position .
    MINUS { ?province wdt:P576 [] }
    OPTIONAL {
      ?person wdt:P31 wd:Q5 ; p:P39 ?held .
      ?held ps:P39 ?position ; pq:P580 ?start .
      FILTER NOT EXISTS { ?held pq:P582 ?end }
    }
    SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
  }
  # ${new Date().toISOString()}
  ORDER BY ?provinceLabel ?start`
}
