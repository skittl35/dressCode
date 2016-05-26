/* ========================================================================================================
Script intended for use in SQL Server 2016 !!
I wrote this in such a way that it can be modified on the fly while developing your database and adjusting
its structure as needed - tables will be dropped and recreated each time the script is run, but tables, 
views, initial data (etc) will not be lost
======================================================================================================== */

-- Drop tables as needed
DROP TABLE IF EXISTS tlkp_dressType
DROP TABLE IF EXISTS tbl_dress

-- Create tables
CREATE TABLE tlkp_dressType(
	dressType_id int IDENTITY(1,1),
	dressType varchar(100),
	active_flag bit,

	CONSTRAINT pk_dressType_id PRIMARY KEY (dressType_id)
)

CREATE TABLE tbl_dress(
	dress_id int IDENTITY(1,1),
	dressType_id int NOT NULL,
	dressName varchar(100),
	numLikes int DEFAULT 0,
	numDislikes int DEFAULT 0,
	popularityIndex as (numLikes-numDislikes),
	active_flag bit NOT NULL,

	CONSTRAINT pk_dress_id PRIMARY KEY (dress_id),
	CONSTRAINT fk_dressType_id FOREIGN KEY (dressType_id) REFERENCES tlkp_dressType(dressType_id)
)

-- With tables now created, insert some data to test with
INSERT INTO tlkp_dressType(dressType, active_flag)
	VALUES ('Prom Dresses', '1')
INSERT INTO tlkp_dressType(dressType, active_flag)
	VALUES ('Sleek Dresses', '1')
INSERT INTO tlkp_dressType(dressType, active_flag)
	VALUES ('Prom Under $200', '1')
INSERT INTO tlkp_dressType(dressType, active_flag)
	VALUES ('Plus Prom Dresses', '1')
INSERT INTO tlkp_dressType(dressType, active_flag)
	VALUES ('Grad Dresses', '1')

INSERT INTO tbl_dress(dressType_id, dressName, active_flag)
	VALUES (1, 'Side Cut Out Dress', '1')
INSERT INTO tbl_dress(dressType_id, dressName, active_flag)
	VALUES (1, 'V-Neck Open Back Dress', '1')
INSERT INTO tbl_dress(dressType_id, dressName, active_flag)
	VALUES (2, 'B/W Mermaid Dress', '1')
INSERT INTO tbl_dress(dressType_id, dressName, active_flag)
	VALUES (2, 'Red Sleeveless Lace Dress', '1')
INSERT INTO tbl_dress(dressType_id, dressName, active_flag)
	VALUES (3, 'Open Back Long Dress', '1')
INSERT INTO tbl_dress(dressType_id, dressName, active_flag)
	VALUES (3, 'Two Piece Floor Length Dress', '1')
INSERT INTO tbl_dress(dressType_id, dressName, active_flag)
	VALUES (4, 'Sleeveless Floor Length Dress', '1')
INSERT INTO tbl_dress(dressType_id, dressName, active_flag)
	VALUES (4, 'Lace Strapless Dress', '1')
INSERT INTO tbl_dress(dressType_id, dressName, active_flag)
	VALUES (5, 'Casual Summer Dress', '1')
INSERT INTO tbl_dress(dressType_id, dressName, active_flag)
	VALUES (5, 'Flare Open Back Sleeveless Dress', '1')