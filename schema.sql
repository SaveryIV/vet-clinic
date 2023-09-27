/* Database schema to keep the structure of entire database. */

CREATE table animals(
	id int GENERATED ALWAYS as IDENTITY,
	name varchar(40) NOT NULL,
	date_of_birth date NOT NULL,
	escape_attempts int NOT NULL,
	neutered boolean NOT NULL,
	weight_kg decimal(5,2) NOT NULL,
	primary key(id)
);