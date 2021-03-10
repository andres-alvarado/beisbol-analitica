USE baseball;

DROP TABLE majorLeagues;

CREATE TABLE majorLeagues (
  majorLeagueId INTEGER,
  majorLeague VARCHAR(20)
) ENGINE = INNODB;

ALTER TABLE majorLeagues ADD PRIMARY KEY(majorLeagueId);
