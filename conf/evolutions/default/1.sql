# --- !Ups

CREATE TABLE Traffic (
  "LINE" VARCHAR(255) PRIMARY KEY,
  "TRANSPORT" VARCHAR(255),
  "SLUG" VARCHAR(255),
  "TITLE" VARCHAR(255),
  "MESSAGE" VARCHAR(255),
);

CREATE TABLE TRAFFIC_SUBSCRIPTION (
  "LINE" VARCHAR(255),
  "USERID" VARCHAR(255),

  PRIMARY KEY ("LINE", "USERID")
)

# --- !Downs
drop table Traffic;
drop table TRAFFIC_SUBSCRIPTION;