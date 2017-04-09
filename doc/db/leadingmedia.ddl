
CREATE TABLE city
(
	id                   INTEGER NOT NULL,
	zipcode              VARCHAR(20) NULL,
	name                 VARCHAR(255) NOT NULL,
	province_id          INTEGER NOT NULL
);



ALTER TABLE city
ADD PRIMARY KEY (id);



CREATE TABLE country
(
	id                   INTEGER NOT NULL,
	name                 VARCHAR(255) NOT NULL
);



ALTER TABLE country
ADD PRIMARY KEY (id);



CREATE TABLE dingdong_user
(
	id                   BIGINT NOT NULL,
	uid                  VARCHAR(36) NOT NULL,
	other                VARCHAR(255) NULL,
	user_id              BIGINT NOT NULL
);



ALTER TABLE dingdong_user
ADD PRIMARY KEY (id);



CREATE UNIQUE INDEX XAK1dingdong_user_uid ON dingdong_user
(
	uid
);



CREATE TABLE gender
(
	id                   VARCHAR(20) NOT NULL
);



ALTER TABLE gender
ADD PRIMARY KEY (id);



CREATE TABLE media
(
	id                   BIGINT NOT NULL,
	create_at            DATETIME NOT NULL,
	origin_id            VARCHAR(32) NOT NULL
);



ALTER TABLE media
ADD PRIMARY KEY (id);



CREATE TABLE media_origin
(
	id                   VARCHAR(32) NOT NULL
);



ALTER TABLE media_origin
ADD PRIMARY KEY (id);



CREATE TABLE media_x_tag
(
	id                   BIGINT NOT NULL,
	tag_id               BIGINT NOT NULL,
	media_id             BIGINT NOT NULL
);



ALTER TABLE media_x_tag
ADD PRIMARY KEY (id);



CREATE TABLE province
(
	id                   INTEGER NOT NULL,
	name                 VARCHAR(255) NOT NULL,
	country_id           INTEGER NOT NULL
);



ALTER TABLE province
ADD PRIMARY KEY (id);



CREATE TABLE tag
(
	id                   BIGINT NOT NULL,
	name                 VARCHAR(255) NOT NULL,
	create_at            DATETIME NOT NULL
);



ALTER TABLE tag
ADD PRIMARY KEY (id);



CREATE UNIQUE INDEX XAK1tag_name ON tag
(
	name
);



CREATE TABLE tag_blacklist
(
	tag_id               BIGINT NOT NULL,
	id                   BIGINT NOT NULL
);



ALTER TABLE tag_blacklist
ADD PRIMARY KEY (id);



CREATE TABLE tag_whitelist
(
	tag_id               BIGINT NOT NULL,
	id                   BIGINT NOT NULL
);



ALTER TABLE tag_whitelist
ADD PRIMARY KEY (id);



CREATE TABLE user
(
	id                   BIGINT NOT NULL,
	uid                  VARCHAR(36) NOT NULL,
	nick_name            VARCHAR(255) NOT NULL,
	image_url            VARCHAR(1024) NULL,
	phone                VARCHAR(32) NULL,
	create_at            DATETIME NOT NULL,
	name                 VARCHAR(255) NOT NULL,
	country_id           INTEGER NOT NULL,
	province_id          INTEGER NOT NULL,
	city_id              INTEGER NOT NULL,
	type_id              VARCHAR(32) NOT NULL,
	gender_id            VARCHAR(20) NOT NULL,
	status_id            VARCHAR(20) NOT NULL
);



ALTER TABLE user
ADD PRIMARY KEY (id);



CREATE UNIQUE INDEX XAK1user_uid ON user
(
	uid
);



CREATE UNIQUE INDEX XAK2user_name ON user
(
	name
);



CREATE TABLE user_status
(
	id                   VARCHAR(20) NOT NULL
);



ALTER TABLE user_status
ADD PRIMARY KEY (id);



CREATE TABLE user_type
(
	id                   VARCHAR(32) NOT NULL
);



ALTER TABLE user_type
ADD PRIMARY KEY (id);



CREATE TABLE user_x_tag
(
	id                   BIGINT NOT NULL,
	user_id              BIGINT NOT NULL,
	tag_id               BIGINT NOT NULL,
	status               SMALLINT NULL
);



ALTER TABLE user_x_tag
ADD PRIMARY KEY (id);



CREATE TABLE weibo
(
	id                   BIGINT NOT NULL,
	text                 VARCHAR(1024) NOT NULL,
	comments_count       INTEGER NOT NULL,
	reposts_count        INTEGER NOT NULL,
	attitudes_count      INTEGER NOT NULL,
	reporter_id          BIGINT NOT NULL,
	media_id             BIGINT NOT NULL,
	uid                  BIGINT NOT NULL
);



ALTER TABLE weibo
ADD PRIMARY KEY (id);



CREATE UNIQUE INDEX XAK1weibo_uid ON weibo
(
	uid
);



CREATE TABLE weibo_rank
(
	id                   INTEGER NOT NULL,
	value                FLOAT NOT NULL,
	description          VARCHAR(32) NULL
);



ALTER TABLE weibo_rank
ADD PRIMARY KEY (id);



CREATE TABLE weibo_reporter
(
	followers_count      INTEGER NOT NULL,
	friends_count        INTEGER NOT NULL,
	statuses_count       INTEGER NOT NULL,
	favourites_count     INTEGER NOT NULL,
	nick_name            VARCHAR(255) NOT NULL,
	name                 VARCHAR(255) NOT NULL,
	id                   BIGINT NOT NULL,
	create_at            DATETIME NOT NULL,
	rank_id              INTEGER NOT NULL,
	uid                  BIGINT NOT NULL
);



ALTER TABLE weibo_reporter
ADD PRIMARY KEY (id);



CREATE UNIQUE INDEX XAK1weibo_reporter_uid ON weibo_reporter
(
	uid
);



CREATE UNIQUE INDEX XAK2weibo_reporter_name ON weibo_reporter
(
	name
);



CREATE TABLE weibo_user
(
	id                   BIGINT NOT NULL,
	uid                  BIGINT NOT NULL,
	name                 VARCHAR(255) NOT NULL,
	nick_name            VARCHAR(255) NOT NULL,
	user_id              BIGINT NOT NULL
);



ALTER TABLE weibo_user
ADD PRIMARY KEY (id);



CREATE UNIQUE INDEX XAK1weibo_user_uid ON weibo_user
(
	uid
);



CREATE UNIQUE INDEX XAK2weibo_user_name ON weibo_user
(
	name
);



ALTER TABLE city
ADD FOREIGN KEY R_12 (province_id) REFERENCES province (id);



ALTER TABLE dingdong_user
ADD FOREIGN KEY R_8 (user_id) REFERENCES user (id);



ALTER TABLE media
ADD FOREIGN KEY R_19 (origin_id) REFERENCES media_origin (id);



ALTER TABLE media_x_tag
ADD FOREIGN KEY R_26 (tag_id) REFERENCES tag (id);



ALTER TABLE media_x_tag
ADD FOREIGN KEY R_27 (media_id) REFERENCES media (id);



ALTER TABLE province
ADD FOREIGN KEY R_11 (country_id) REFERENCES country (id);



ALTER TABLE tag_blacklist
ADD FOREIGN KEY R_22 (tag_id) REFERENCES tag (id);



ALTER TABLE tag_whitelist
ADD FOREIGN KEY R_23 (tag_id) REFERENCES tag (id);



ALTER TABLE user
ADD FOREIGN KEY R_14 (country_id) REFERENCES country (id);



ALTER TABLE user
ADD FOREIGN KEY R_15 (province_id) REFERENCES province (id);



ALTER TABLE user
ADD FOREIGN KEY R_16 (city_id) REFERENCES city (id);



ALTER TABLE user
ADD FOREIGN KEY R_18 (type_id) REFERENCES user_type (id);



ALTER TABLE user
ADD FOREIGN KEY R_28 (gender_id) REFERENCES gender (id);



ALTER TABLE user
ADD FOREIGN KEY R_29 (status_id) REFERENCES user_status (id);



ALTER TABLE user_x_tag
ADD FOREIGN KEY R_24 (user_id) REFERENCES user (id);



ALTER TABLE user_x_tag
ADD FOREIGN KEY R_25 (tag_id) REFERENCES tag (id);



ALTER TABLE weibo
ADD FOREIGN KEY R_17 (reporter_id) REFERENCES weibo_reporter (id);



ALTER TABLE weibo
ADD FOREIGN KEY R_21 (media_id) REFERENCES media (id);



ALTER TABLE weibo_reporter
ADD FOREIGN KEY R_20 (rank_id) REFERENCES weibo_rank (id);



ALTER TABLE weibo_user
ADD FOREIGN KEY R_9 (user_id) REFERENCES user (id);


