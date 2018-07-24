# --- !Ups

CREATE TABLE TRAFFIC (
  "LINE" VARCHAR(255) PRIMARY KEY,
  "TRANSPORT" VARCHAR(255),
  "SLUG" VARCHAR(255),
  "TITLE" VARCHAR(255),
  "MESSAGE" VARCHAR(255),
);

CREATE TABLE TRAFFIC_SUBSCRIPTION (
  "LINE" VARCHAR(255),
  "TRANSPORT" VARCHAR(255),
  "USERID" VARCHAR(255),

  PRIMARY KEY ("LINE", "USERID", "TRANSPORT")
);

CREATE TABLE ALERT (
  "ID" INTEGER PRIMARY KEY AUTO_INCREMENT,
  "USERID" VARCHAR(255),
  "TRAINTYPE" VARCHAR(255),
  "TRAINCODE" VARCHAR(255),
  "STATION" VARCHAR(255),
  "HOUR" INTEGER,
  "MINUTES" INTEGER,

  CONSTRAINT UNIQ_ALERT_VALUES UNIQUE ("USERID", "TRAINTYPE", "TRAINCODE", "STATION", "HOUR", "MINUTES"),
  CONSTRAINT CHECK_HOUR CHECK("HOUR" > 0 AND "HOUR" < 24),
  CONSTRAINT CHECK_MINUTES CHECK("MINUTES" > 0 AND "MINUTES" < 60)
);

CREATE TABLE DAYALERT (
  "ID" INTEGER PRIMARY KEY AUTO_INCREMENT,
  "ALERTID" INTEGER,
  "day" INTEGER,

  CONSTRAINT UNIQ_DAY_VALUES UNIQUE ("ALERTID", "day")
);

CREATE TABLE ALERTFORM (
  "ID" VARCHAR(255),
  "USERID" VARCHAR(255),
  "TRANSPORTTYPE" VARCHAR(255),
  "TRANSPORTCODE" VARCHAR(255),
  "TRANSPORTSTATION" VARCHAR(255),
  "TYPEOFALERT" VARCHAR(255),
  "DAY" INTEGER,
  "MONTH" INTEGER,
  "YEAR" INTEGER,
  "HOUR" INTEGER,
  "MINUTES" INTEGER,

  PRIMARY KEY("ID", "USERID"),
  CONSTRAINT CHECK_HOUR_FORM CHECK("HOUR" >= 0 AND "HOUR" < 24),
  CONSTRAINT CHECK_MINUTES_FORM CHECK("MINUTES" >= 0 AND "MINUTES" < 60)
);

CREATE TABLE ALERTDAYFORM(
  "ID" VARCHAR(255),
  "DAY" INTEGER,

  PRIMARY KEY("ID", "DAY")
);

ALTER TABLE DAYALERT ADD CONSTRAINT FK_DayAlert FOREIGN KEY (ALERTID) REFERENCES ALERT(ID);

# --- !Downs
drop table TRAFFIC;
drop table TRAFFIC_SUBSCRIPTION;
alter DAYALERT drop constraint FK_DayAlert;
drop table ALERT;
drop table DAYALERT;
drop table ALERTFORM;