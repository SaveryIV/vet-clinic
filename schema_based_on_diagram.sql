CREATE TABLE patients (
	id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name varchar(70),
	date_of_birth date
);

CREATE TABLE medical_histories (
	id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	admitted_at timestamp,
	patient_id int,
	status varchar(60)
);

CREATE TABLE invoices (
	id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	total_amount decimal,
	generated_at timestamp,
	payed_at timestamp,
	medical_history_id int
);

CREATE TABLE invoice_items (
	id serial PRIMARY KEY,
	unit_price decimal,
	quantity int,
	total_price decimal,
	invoice_id int,
	treatment_id int
);

CREATE TABLE treatments (
	id serial PRIMARY KEY,
	type varchar(50),
	name
);

CREATE TABLE medical_histories_treatment (
	id serial PRIMARY KEY,
	med_history_id int,
	treatment_id int
);

ALTER TABLE invoices
ADD CONSTRAINT med_history_fk FOREIGN KEY(medical_history_id)
REFERENCES medical_histories(id)

ALTER TABLE medical_histories
ADD CONSTRAINT patient_fk FOREIGN KEY(patient_id)
REFERENCES patients(id)

ALTER TABLE invoice_items
ADD CONSTRAINT invoice_fk FOREIGN KEY(invoice_id)
REFERENCES invoices(id)

ALTER TABLE invoice_items
ADD CONSTRAINT treatment_fk FOREIGN KEY(treatment_id)
REFERENCES treatments(id)

ALTER TABLE medical_histories_treatment
ADD CONSTRAINT med_history_fk FOREIGN KEY(med_history_id)
REFERENCES medical_histories(id)

ALTER TABLE medical_histories_treatment
ADD CONSTRAINT treatment_id_fk FOREIGN KEY(treatment_id)
REFERENCES treatments(id)