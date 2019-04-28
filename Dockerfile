# Own neo4j image because importing didn't work
FROM neo4j:latest

COPY import/some2016UKgeotweets.csv /var/lib/neo4j/import
CMD ["neo4j"]
