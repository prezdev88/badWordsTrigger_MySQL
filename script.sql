CREATE DATABASE testTrigger; -- DROP DATABASE testTrigger;

USE testTrigger;

CREATE TABLE badWords(
	id INT AUTO_INCREMENT,
	name VARCHAR(100),
	PRIMARY KEY(id)
);

CREATE TABLE clients(
	id INT AUTO_INCREMENT,
	name VARCHAR(100),
	PRIMARY KEY(id)
);

INSERT INTO badWords VALUES
(NULL, 'tonto'),
(NULL, 'bobo');

SELECT * FROM badWords;
SELECT * FROM clients;

DELIMITER $$
CREATE TRIGGER reviewBadWords BEFORE INSERT ON clients
FOR EACH ROW BEGIN 
	DECLARE badWordsCount FLOAT;
	SET badWordsCount = (SELECT AVG(LOCATE(name, NEW.name)) FROM badWords);

	IF(badWordsCount > 0) THEN
		SET NEW.name = 'Nombre Banneado';
	END IF;
END$$
DELIMITER ;

DROP TRIGGER reviewBadWords;
