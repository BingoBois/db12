# Db 12
Made by: Viktor Kim Christiansen, William Pfaffe, Christopher Rosendorf, Christian Engelberth Olsen

## Links
http://localhost:7474/browser/
https://github.com/datsoftlyngby/soft2019spring-databases/blob/master/lecture_notes/12-IntroToNeo4j.ipynb
https://github.com/datsoftlyngby/soft2019spring-databases/blob/master/assignments/assignment12.md


## Exc1 & Getting Started
1. Run `buildContainer.sh`, to get the right Data into the container image
2. Run `runContainer.sh`
3. Visit http://localhost:7474/browser/ & Login with `mingade` credentials
4. Insert the following query at the top (this makes 1000 tweet objects) `queries/1.neo4j`
```
LOAD CSV WITH HEADERS FROM "file:///some2016UKgeotweets.csv" AS row 
    FIELDTERMINATOR ";"


CREATE (a:Tweet { 
  userName: row.`User Name`,
  place: row.`Place (as appears on Bio)`,
  latitude: row.`Latitude`,
  longitude: row.`Longitude`,
  tweetContent: row.`Tweet content`,
  nickName: row.`Nickname`
  })
  return a
  LIMIT 5000;
```

## Exc 2 Relations
1. Fill in `queries/2.neo4j`
```
match (t:Tweet)
WITH extract( m in 
                filter(m in split(t.tweetContent," ") where m starts with "@" and size(m) > 1) 
                | right(m,size(m)-1))
                AS mentions, t.userName AS tmpUsername
CREATE (a:Tweeters { 
tweeterName: tmpUsername,
mentions: mentions
})
return a;
```


REST DOES NOT WORK
2. Create the relations

We tried and couldn't make it work. Seems like either the mention isn't actually in the data itself, or we tried manually searching for examples but couldn't find it.
```
MATCH (a:Tweeters)
UNWIND a.mentions as m
MATCH (b:Tweeters)
WHERE b.tweeterName = m
CREATE (a)-[:Tweeted]->(b);

```


So yea we got stuck for hours and couldn't find a solution tried multiple things, (Tweeters to tweeters, and tweeters to tweet) but still stuck. Had a rough time adapting to the query language.

## Bonus
1. 1full.json: 1 line from the csv file
2. 1min.json: cut down row from csv file.

## Delete everything query
```
MATCH (n)
DETACH DELETE n
```
