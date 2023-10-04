CREATE TABLE patients (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name varchar(70),
	date_of_birth date
);

CREATE TABLE medical_histories (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	admitted_at timestamp NOT NULL,
	patient_id INT,
	status varchar(150)
);

CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    total_amount DECIMAL NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    payed_at TIMESTAMP NOT NULL,
    medical_history_id INT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE invoice_items (
	id serial PRIMARY KEY,
	unit_price DECIMAL,
	quantity INT,
	total_price DECIMAL,
	invoice_id INT,
	treatment_id INT
);

CREATE TABLE treatments (
	id serial PRIMARY KEY,
	type varchar(100),
	name varchar(65)
);

CREATE TABLE medical_histories_treatment (
	med_history_id INT,
	treatment_id INT
);

ALTER TABLE invoices
ADD CONSTRAINT med_history_fk FOREIGN KEY(medical_history_id)
REFERENCES medical_histories(id);

ALTER TABLE medical_histories
ADD CONSTRAINT patient_fk FOREIGN KEY(patient_id)
REFERENCES patients(id);

ALTER TABLE invoice_items
ADD CONSTRAINT invoice_fk FOREIGN KEY(invoice_id)
REFERENCES invoices(id);

ALTER TABLE invoice_items
ADD CONSTRAINT treatment_fk FOREIGN KEY(treatment_id)
REFERENCES treatments(id);

ALTER TABLE medical_histories_treatment
ADD CONSTRAINT med_history_id_fk FOREIGN KEY(med_history_id)
REFERENCES medical_histories(id);

ALTER TABLE medical_histories_treatment
ADD CONSTRAINT treatment_id_fk FOREIGN KEY(treatment_id)
REFERENCES treatments(id);

CREATE INDEX idx_treatment_id 
ON invoice_items(treatment_id);

CREATE INDEX idx_med_histories_id 
ON invoices(medical_history_id);

CREATE INDEX idx_invoice_id ON invoice_items(treatment_id);

CREATE INDEX idx_patient_id ON medical_histories(patient_id);

CREATE INDEX idx_med_treatment_id ON medical_histories_treatment(treatment_id);

CREATE INDEX idx_med_medical_id ON medical_histories_treatment(med_history_id);