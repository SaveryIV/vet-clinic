/*Queries that provide answers to the questions from all projects.*/

SELECT name FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* day 2 queries on transactions */

BEGIN;

UPDATE animals SET species = 'unspecified';

ROLLBACK;

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'digimon' WHERE name IS NULL;

SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;
ROLLBACK;

BEGIN;

DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;

SELECT * FROM animals;

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT birth;

UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK;

BEGIN;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

/* day 2 questions activities */

SELECT count(name) FROM animals;

SELECT count(name) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth <= '2000-01-01' AND date_of_birth > '1989-12-31' GROUP BY species;

/* day 3 question activities */

SELECT name FROM animals A JOIN owners O ON O.id = A.owner_id WHERE owner_id = 4;

SELECT * FROM animals A JOIN species s ON s.id = A.species_id WHERE species_id = 1;

SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(*) FROM species LEFT JOIN animals ON species.id = animals.species_id GROUP BY species.name;

SELECT animals.name, owners.full_name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.id = 2 AND owners.id = 2;

SELECT animals.name, owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE escape_attempts = 0 AND owners.id = 5;

SELECT owners.full_name, COUNT(*) FROM owners LEFT JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY count DESC;

/* day 4 questions */

SELECT animals.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = 1 ORDER BY date_of_visit DESC;

SELECT COUNT(*) FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = 3;

SELECT vets.name, species.name AS specialized_in FROM vets LEFT JOIN specializations ON specializations.vet_id = vets.id LEFT JOIN  species ON specializations.species_id = species.id;


SELECT name FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = 3 AND date_of_visit BETWEEN '2020/04/01' AND '2020/08/30';


SELECT animals.name, COUNT(*) FROM animals JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY count DESC LIMIT 1;

SELECT animals.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = 2 GROUP BY animals.name, date_of_visit ORDER BY date_of_visit LIMIT 1;

SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, vets.name, vets.age, vets.date_of_graduation, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id ORDER BY date_of_visit DESC;

SELECT COUNT(*) FROM visits JOIN animals ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id JOIN specializations on specializations.vet_id = visits.vet_id WHERE animals.species_id != specializations.species_id;

SELECT species.name as species, COUNT(*) from visits JOIN vets ON vets.id = visits.vet_id JOIN animals ON animals.id = visits.animal_id JOIN species ON species.id = animals.species_id WHERE vets.id = 2 GROUP BY species.name;

/* week 2 - day 1 */

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;


EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';