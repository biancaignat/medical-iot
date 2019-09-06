INSERT INTO roles(name) VALUES('ROLE_USER');
INSERT INTO roles(name) VALUES('ROLE_DOCTOR');
INSERT INTO roles(name) VALUES('ROLE_ADMIN');


INSERT INTO users(id, unique_id, email, name, password, phone_number, username, role_id, age)
	VALUES (-1, '123', 'mail2@yahoo.com', 'Ionescu George', 'parola', '1234567890', 'patient', 1, 25);
INSERT INTO users(id, unique_id, email, name, password, phone_number, username, role_id, age)
	VALUES (-3, '134', 'mail1@yahoo.com', 'Doctorescu Ion', 'parola', '1234567890', 'doctor', 2, 26);
INSERT INTO users(id, unique_id, email, name, password, phone_number, username, role_id, age)
	VALUES (-2, '124', 'mail@yahoo.com', 'Georgescu Ion', 'parola', '1234567890', 'patient2', 1, 26);

--INSERT INTO investigations(id, name, patient_id) values (-2, 'ekg1', -1);
--INSERT INTO investigations(id, name, patient_id) values (-1, 'ekg2', -1);