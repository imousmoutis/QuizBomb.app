CREATE DATABASE  IF NOT EXISTS `quizbomb` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
USE `quizbomb`;
--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `fullName` varchar(45),
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 

--
-- Table structure for table `professor`
--

CREATE TABLE IF NOT EXISTS `professor` (
  `id` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `controller`
--

CREATE TABLE IF NOT EXISTS `controller` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `sclass`
--

CREATE TABLE IF NOT EXISTS `sclass` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(45) NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `sclass_id` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_student_sclass_id` FOREIGN KEY (`sclass_id`) REFERENCES `sclass` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `course`
--

CREATE TABLE IF NOT EXISTS `course` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `psc` (Professor-SClass-Course)
--

CREATE TABLE IF NOT EXISTS `psc` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `professor_id` bigint(10) unsigned NOT NULL,
  `sclass_id` bigint(10) unsigned NOT NULL,
  `course_id` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_psc_sclass_id` FOREIGN KEY (`sclass_id`) REFERENCES `sclass` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_psc_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_psc_professor_id` FOREIGN KEY (`professor_id`) REFERENCES `professor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `question`
--

CREATE TABLE IF NOT EXISTS `question` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `isapproved` tinyint(1) DEFAULT 0 NOT NULL,
  `course_id` bigint(10) unsigned NOT NULL,
  `sclass_id` bigint(10) unsigned NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_question_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_question_sclass_id` FOREIGN KEY (`sclass_id`) REFERENCES `sclass` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `answer`
--

CREATE TABLE IF NOT EXISTS `answer` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `correct` tinyint(1) NOT NULL,
  `question_id` bigint(10) unsigned NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_answer_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `quiz`
--

CREATE TABLE IF NOT EXISTS `quiz` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint(10) unsigned NOT NULL,
  `sclass_id` bigint(10) unsigned NOT NULL,
  `title` VARCHAR(150) NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_quiz_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_quiz_sclass_id` FOREIGN KEY (`sclass_id`) REFERENCES `sclass` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `quiz_question`
--

CREATE TABLE IF NOT EXISTS `quiz_question` (
  `quiz_id` bigint(10) unsigned NOT NULL,
  `question_id` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`quiz_id`,`question_id`),
  CONSTRAINT `fk_quiz_question_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_quiz_question_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `score`
--

CREATE TABLE IF NOT EXISTS `score` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quiz_id` bigint(10) unsigned NOT NULL,
  `student_id` bigint(10) unsigned NOT NULL,
  `successrate` float NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_score_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_score_student_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Eleytherios Mavrothalassitis', 'lefmav', 'lefmav@proodos.gr', 'lefmav1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Efthimis Tsolas', 'tsolas', 'tsolas@proodos.gr', 'tsolas1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Allahu Akbaridis', 'akbar', 'akbar@proodos.gr', 'boom1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Maria Zizi', 'zizi', 'zizi@proodos.gr', 'zizi1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Pier Patrick Nikolaou', 'pierp', 'pierp@proodos.gr', 'pierp1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Tasoulis Livas', 'livas', 'livas@proodos.gr', 'livas1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Giasemakis Giasemis', 'geiasou', 'geiasou@proodos.gr', 'makis1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Maria Arni', 'arnaki', 'arnaki@proodos.gr', 'arni1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Ioannis Kolyvas', 'jkol', 'jkol@proodos.gr', 'jkol86');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Kostas Tsekmes', 'tsakmaki', 'tsakmaki@proodos.gr', 'vromtsek1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Andronikos Arabatzis', 'aravas', 'aravas@proodos.gr', 'aravas1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Dimitrios Darras', 'ddaras', 'ddaras@proodos.gr', 'ddaras1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Alexandra Paraskelidou', 'alexpa', 'alexpa@proodos.gr', 'alexpa1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Kostas Pelonis', 'peloni', 'peloni@proodos.gr', 'peloni1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Ioanna Tsinikou', 'tsinikou', 'tsinikou@proodos.gr', 'boom1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Dimitris Stathis', 'dstathis', 'dstathis@proodos.gr', 'dstathis1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Marianthi Papanota', 'mpapa', 'mpapa@proodos.gr', 'mpapa1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Efthimis Larentzakis', 'larry', 'larry@proodos.gr', 'larry1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Marios Matalon', 'matalon', 'matalon@proodos.gr', 'matalon1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Nikodimos Aristoklis', 'nikari', 'nikari@proodos.gr', 'nikari1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Avgerinos Iasonidou', 'avge', 'avge@proodos.gr', 'avge1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Maria Perrone', 'perrone', 'perrone@proodos.gr', 'perrone1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Asimina Rapti', 'rapti', 'rapti@proodos.gr', 'rapti1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Mimis Androulakis', 'mimis', 'mimis@proodos.gr', 'mimis1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Nikos Alefantos', 'alefas', 'alefas@proodos.gr', 'alefas1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Maria Kalpaki', 'kalpa', 'kalpa@proodos.gr', 'kalpa1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Sakis Rouvas', 'sakiii', 'sakiii@proodos.gr', 'sakiii1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Dimitris Kosmas', 'kosmas', 'kosmas@proodos.gr', 'kosmas1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Nikos Kasimatis', 'kasi', 'kasi@proodos.gr', 'kasi1');
INSERT INTO `quizbomb`.`user` (`fullName`, `username`, `email`, `password`) VALUES ('Giannis Karamouzis', 'jmouz', 'jmouz@proodos.gr', 'jmouz1');



INSERT INTO `quizbomb`.`professor` (`id`) VALUES ('1');
INSERT INTO `quizbomb`.`professor` (`id`) VALUES ('2');
INSERT INTO `quizbomb`.`professor` (`id`) VALUES ('10');
INSERT INTO `quizbomb`.`professor` (`id`) VALUES ('3');
INSERT INTO `quizbomb`.`professor` (`id`) VALUES ('6');


INSERT INTO `quizbomb`.`sclass` (`value`) VALUES ('A');
INSERT INTO `quizbomb`.`sclass` (`value`) VALUES ('B');
INSERT INTO `quizbomb`.`sclass` (`value`) VALUES ('C');

INSERT INTO `quizbomb`.`controller` (`id`) VALUES ('9');

INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('11', '1');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('13', '3');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('14', '2');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('15', '2');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('16', '1');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('17', '3');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('18', '3');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('19', '3');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('20', '1');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('21', '2');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('22', '1');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('23', '2');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('24', '2');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('25', '3');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('26', '1');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('27', '2');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('28', '3');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('29', '3');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('30', '1');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('4', '1');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('5', '2');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('7', '3');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('8', '1');
INSERT INTO `quizbomb`.`student` (`id`, `sclass_id`) VALUES ('12', '3');


INSERT INTO `quizbomb`.`course` (`name`) VALUES (N'Μαθηματικά');
INSERT INTO `quizbomb`.`course` (`name`) VALUES (N'Φυσική');
INSERT INTO `quizbomb`.`course` (`name`) VALUES (N'Χημεία');
INSERT INTO `quizbomb`.`course` (`name`) VALUES (N'Ιστορία');
INSERT INTO `quizbomb`.`course` (`name`) VALUES (N'Πληροφορική');
INSERT INTO `quizbomb`.`course` (`name`) VALUES (N'Βιολογία');

INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('1', '1', '1');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('1', '2', '1');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('1', '3', '1');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('2', '1', '2');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('2', '2', '2');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('2', '3', '2');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('3', '1', '3');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('3', '2', '3');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('3', '3', '3');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('10', '1', '4');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('10', '2', '4');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('10', '3', '4');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('6', '1', '5');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('6', '2', '5');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('6', '3', '5');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('10', '1', '6');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('10', '2', '6');
INSERT INTO `quizbomb`.`psc` (`professor_id`, `sclass_id`, `course_id`) VALUES ('10', '3', '6');



INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Είμαστε ακίνητοι και κρατάμε με το χέρι μας μια μπάλα ποδοσφαίρου. Η μπάλα έχει βάρος 8 Ν και βρίσκεται 1,5 m απο το έδαφος. Το έργο της δύναμης του χεριού μας για χρονικό διάστημα 10 s είναι:', '1', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Μεταφέρουμε ένα σώμα απο το σημείο Α στο σημείο Β. Το έργο του βάρους του σώματος:', '1', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποια απο τις παρακάτω προτάσεις είναι σωστή;', '1', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ένα ποδήλατο έχει μάζα m και κινείται με ταχύτητα υ1 . Ένα «παπάκι» έχει μάζα 4m και κινείται με ταχύτητα υ2 . Ποια από τις παρακάτω σχέσεις είναι η σωστή, αν και τα δυο κινητά έχουν την ίδια κινητική ενέργεια;', '1', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Δυο σώματα πού έχουν ίσες μάζες βρίσκονται στο ίδιο ύψος από την επιφάνεια της θάλασσας. Το ένα σώμα βρίσκεται στον Ισημερινό και το άλλο στο Βόρειο Πόλο. Μεγαλύτερη δυναμική ενέργεια έχει:', '1', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Μια μπάλα αφήνεται να πέσει απο το μπαλκόνι ενός σπιτιού. Αν οι αντιστάσεις που δέχεται η μπάλα απο τον αέρα είναι μηδαμινές τότε κατα την πτώση της:', '1', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Τι απέγινε η δυναμική ενέργεια ενός ανελκυστήρα που κατέβηκε από τον πρώτο όροφο στο ισόγειο;', '1', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ένα βέλος εκτοξεύεται από το έδαφος με τη βοήθεια ενός τόξου και αφού ανέβει μέχρι ένα ορισμένο ύψος, στη συνέχεια προσπίπτει ξανά στο έδαφος. Η διαδικασία από τη στιγμή που αρχίζουμε να τεντώνουμε τη χορδή μπορεί να περιγραφεί με την ακόλουθη σειρά ενεργειακών μετασχηματισμών:', '1', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποια απο τις παρακάτω προτάσεις είναι σωστή;', '1', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Όταν διπλασιάζεται η ταχύτητα ενός σώματος, η κινητική του ενέργεια:', '1', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποια απο τις παρακάτω προτάσεις είναι σωστή;', '1', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ένας πύραυλος που κινείται με ορισμένη ταχύτητα στο διάστημα, ενεργοποιεί τις μηχανές του και διπλασιάζει την ταχύτητά του, ενώ ταυτόχρονα αποβάλλει την άδεια δεξαμενή καυσίμων μειώνοντας τη μάζα του στη μισή. Η κινητική του ενέργεια:', '1', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποια απο τις παρακάτω προτάσεις είναι σωστή;', '1', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Μια πέτρα κινείται στον αέρα υπο την επίδραση μόνο του βάρους της και έχει μηχανική ενέργεια 20 J. Τότε:', '1', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Οι παρακάτω προτάσεις αφορούν τη χημική ενέργεια. Ποια απο αυτές είναι σωστή;', '1', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ένα σώμα μάζας m αφήνεται ελεύθερο απο ύψος h. Κατα την κάθοδό του η δυναμική του ενέργεια:', '1', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποια απο τις παρακάτω προτάσεις είναι σωστή;', '1', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ένας μαθητής σπρώχνει σε οριζόντιο δάπεδο ένα θρανίο με τέτοιο τρόπο ώστε η ταχύτητα του θρανίου ν’ αυξάνεται. Η χημική ενέργεια που καταναλώνει ο μαθητής μετατρέπεται:', '1', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Πετάμε ένα σώμα κατακόρυφα προς τα πάνω. Καθώς το σώμα ανεβαίνει:', '1', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Θεμελιώδεις μορφές ενέργειας στο μικρόκοσμο είναι:', '1', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ένα σώμα αφήνεται από ύψος 2 m να πέσει στο έδαφος. Μετά την αναπήδηση ανεβαίνει σε μικρότερο ύψος από το αρχικό. Τι από τα παρακάτω ισχύει;', '1', '2', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποια απο τις παρακάτω προτάσεις είναι σωστή;', '1', '2', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποια απο τις παρακάτω προτάσεις είναι σωστή;', '1', '2', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Η μηχανή Α παράγει έργο 400J σε 1min ενώ η μηχανή Β παράγει έργο 8.000J σε 2min.Ποια απο τις παρακάτω προτάσεις είναι σωστή;', '1', '2', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ένα κινούμενο σώμα έχει σταθερή μάζα m. Η κινητική του ενέργεια είναι:', '1', '2', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Το έργο μιας δύναμης:', '1', '2', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Η μονάδα ισχύος στο Διεθνές Σύστημα Μονάδων είναι:', '1', '2', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποια απο τις παρακάτω προτάσεις είναι σωστή για ένα σώμα που εκτελεί ελεύθερη πτώση;', '1', '2', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Το έργο της δύναμης βαρύτητας κατα την κάθοδο ενός αλεξιπτωτιστή με σταθερή ταχύτητα είναι:', '1', '2', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Όταν το μέτρο της ταχύτητας ενός σώματος αυξάνεται από υ σε 2υ τότε η κινητική του ενέργεια αυξάνεται κατά 3 Joule. Όταν το μέτρο της ταχύτητας αυξάνεται από 2υ σε 3υ τότε η κινητική ενέργεια αυξάνεται κατά:', '1', '2', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Όταν σε ένα σώμα που κινείται πάνω σε λείο οριζόντιο επίπεδο, ασκείται µια µόνο δύναμη F η οποία παράγει αρνητικό έργο, τότε:', '0', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποια απο τις παρακάτω προτάσεις ειναι σωστή;', '0', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Η μονάδα του έργου στο Διεθνές Σύστημα Μονάδων είναι:', '0', '2', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Μια οριζόντια σταθερή δύναμη ασκείται σε ένα σώμα που μετατοπίζεται στην ίδια κατεύθυνση με τη δύναμη. Επομένως το έργο της δύναμης είναι:', '0', '2', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ένας εργάτης σπρώχνει ένα κιβώτιο πάνω σ’ ένα κεκλιμένο επίπεδο με φορά προς τα πάνω, έτσι ώστε η ταχύτητα του κιβωτίου ν’ αυξάνεται. Η χημική ενέργεια που καταναλώνει ο εργάτης μετατρέπεται:', '0', '2', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Μια σφαίρα κινείται κατά μήκος μιας σχεδόν κυκλικής κατακόρυφης σιδηροτροχιάς χωρίς τριβές εκκινώντας από το ανώτερο σημείο της τροχιάς. Η κινητική της ενέργεια, η δυναμική της ενέργεια σε σχέση με το έδαφος και η μηχανική της ενέργεια:', '0', '2', '3');


INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (' 60 J', '0', '1');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('0 J', '1', '1');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (' 8 J', '0', '1');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('12 J', '0', '1');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Είναι ανάλογο της απόστασης των δύο σημείων', '0', '2');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Αν το σημείο Β είναι ψηλότερα απο το σημείο Α τότε το έργο του βάρους είναι θετικό', '0', '2');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Είναι ανάλογο της υψομετρικής διαφοράς των δύο σημείων', '1', '2');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Εξαρτάται απο τη διαδρομή που θα ακολουθήσουμε απο το σημείο Α μέχρι το σημείο Β', '0', '2');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η ενέργεια είναι θεμελιώδες μέγεθος', '0', '3');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Το έργο είναι διανυσματικό μέγεθος', '0', '3');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Το έργο και η ενέργεια είναιι μονόμετρα και παράγωγα μεγέθη', '1', '3');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Το έργο είναι θεμελιώδες μέγεθος', '0', '3');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'υ2 =2. υ1', '0', '4');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'υ2 =4. υ1', '0', '4');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'υ1 =2. υ2', '1', '4');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'υ1 =4. υ2', '0', '4');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Tο σώμα που βρίσκεται στον Iσημερινό', '1', '5');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Tίποτα από τα παραπάνω', '0', '5');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Tο σώμα που βρίσκεται στο Βόρειο Πόλο', '0', '5');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Kαι τα δυο σώματα έχουν την ίδια δυναμική ενέργεια', '0', '5');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η κινητική της ενέργεια αυξάνεται και η βαρυτική δυναμική της ενέργεια μειώνεται', '1', '6');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η μηχανική της ενέργεια μειώνεται και η κινητική της ενέργεια αυξάνεται', '0', '6');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η μηχανική της ενέργεια μειώνεται και η βαρυτική δυναμική της ενέργεια επίσης μειώνεται', '0', '6');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η μηχανική ενέργεια αυξάνεται', '0', '6');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μετατράπηκε σε θερμική', '1', '7');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Παρέμεινε μέσα στον ανελκυστήρα', '0', '7');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μετατράπηκε σε κινητική', '0', '7');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Εξαφανίσθηκε', '0', '7');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Τίποτε από τα υπόλοιπα δεν συμβαίνει', '0', '8');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ελαστική δυναμική ενέργεια-βαρυτική δυναμική ενέργεια-κινητική ενέργεια', '0', '8');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Έργο-δυναμική ενέργεια λόγω παραμόρφωσης-κινητική ενέργεια-βαρυτική δυναμική ενέργεια-κινητική ενέργεια', '1', '8');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Έργο-κινητική ενέργεια-ελαστική δυναμική ενέργεια-κινητική ενέργεια', '0', '8');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η βιομάζα ειναι πηγή ενέργειας που ειναι ανεξάρτητη απο τη φωτοσύνθεση', '0', '9');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Τα ορυκτά καύσιμα και ανεξάντλητη πηγή ενέργειας', '0', '9');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Τα θαλάσια κύματα οφείλονται στους σεισμούς', '0', '9');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Ο Ήλιος θεωρείται σταθερή και ανεξάντλητη πηγή ενέργειας', '1', '9');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Τετραπλασιάζεται', '1', '10');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Τριαπλασιάζεται', '0', '10');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Δεν αλλάζει', '0', '10');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Διπλασιάζεται', '0', '10');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η κινητική και τη δυναμική ενέργεια έχουν διαφορετική μονάδα μέτρησης', '0', '11');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μηχανική ενέργεια ονομάζεται το άθροισμα της κινητικής και της δυναμικής ενέργειας ενός σώματος', '1', '11');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Στη μηχανική ενέργεια ενός σώματος συμπεριλαμβάνεται και η θερμική ενέργεια που περικλείει', '0', '11');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μηχανική ενέργεια είναι η ενέργεια που έχουν μόνο οι μηχανές', '0', '11');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Διπλασιάζεται', '1', '12');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Τετραπλασιάζεται', '0', '12');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Δε μεταβάλλεται', '0', '12');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Τίποτε από τα υπόλοιπα δεν συμβαίνει', '0', '12');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η βαρυτική δυναμική ενέργεια που έχει ένα σώμα ειναι ανεξάρτητη απο τη μάζα του', '0', '13');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η δυναμική ενέργεια που έχει ένα σώμα μπορεί να μετασχηματιστεί σε άλλου είδους ενέργεια', '1', '13');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μόνάδα μέτρησης της δυναμικής ενέργειας ειναι το Watt', '0', '13');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Κάθε σώμα που έχει υποστεί ελαστική παραμόρφωση έχει δυναμική ενέργεια που δεν εξαρτάται απο το μέγεθος αυτής της παραμόρφωσης', '0', '13');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Όταν η βαρυτική δυναμική ενέργεια της πέτρας ειναι ίση με την κινητική της τότε η μηχανική ενέργεια της πέτρας είναι 10 J.', '0', '14');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Τη στιγμή που η βαρυτική δυναμική ενέργεια της πέτρας ειναι 12 J, η κινητική ενέργεια της πέτρας ειναι 8 J', '1', '14');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Όταν η βαρυτική δυναμική ενέργεια της πέτρας ειναι ίση με την κινητική της τότε η μηχανική ενέργεια της πέτρας είναι 40 J.', '0', '14');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Τη στιγμή που η βαρυτική δυναμική ενέργεια της πέτρας ειναι 5 J, η κινητική ενέργεια της πέτρας ειναι 25J', '0', '14');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η χημική ενέργεια είναι μια μορφή δυναμικής ενέργειας', '1', '15');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η χημική ενέργεια λέγεται έτσι γιατί τη συναντάμε πιο συχνά στο μάθημα της Χημείας', '0', '15');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η χημική ενέργεια είναι μια μορφή κινητικής ενέργειας', '0', '15');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Όλα τα παραπάνω', '0', '15');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Αυξάνεται', '0', '16');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μειώνεται', '1', '16');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Εξαρτάται από τη μάζα του σώματος', '0', '16');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Παραμένει σταθερή', '0', '16');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Τα πυρηνικά καύσιμα αποτελούν ανεξαντλητη πηγή ενέργειας', '0', '17');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Όταν ένα αυτοκίνητο φρενάρει και σταματήσει η αρχική του ενέργεια εξαφανίζεται', '0', '17');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ο ανεμιστήρας μετατρέπει την κινητική ενέργεια σε ηλεκτρική', '0', '17');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Οι ανεμογεννήτριες χρησιμοποιούνται για τη μετατροπή της αιολικής ενέργειας σε ηλεκτρική', '1', '17');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Σε κινητική και δυναμική ενέργεια του θρανίου', '0', '18');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Σε κινητική ενέργεια του θρανίου', '0', '18');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Σε κινητική ενέργεια του θρανίου αλλά και σε θερμική ενέργεια', '1', '18');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Σε θερμική ενέργεια', '0', '18');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η δυναμική του ένέργεια ελαττώνεται', '0', '19');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η μηχανική του ενέργεια ελαττώνεται', '0', '19');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η μηχανική του ενέργεια αυξάνεται', '0', '19');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η κινητική του ενέργεια ελαττώνεται', '1', '19');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η πυρηνική και η θερμική ενέργεια', '0', '20');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η χημική και η δυναμική ενέργεια', '0', '20');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η δυναμική και η κινητική ενέργεια', '1', '20');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η πυρηνική και η κινητική ενέργεια', '0', '20');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η δυναμική ενέργεια του σώματος είναι σταθερή', '0', '21');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η μηχανική ενέργεια του σώματος είναι σταθερή', '0', '21');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η κινητική ενέργεια του σώματος είναι σταθερή', '0', '21');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Κάποια ποσότητα μηχανικής ενέργειας μετατράπηκε σε θερμική ενέργεια', '1', '21');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Την απόδοση μιας μηχανής τη μετράμε σε J', '0', '22');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η ισχύς εκφράζει το ρυθμό μεταβολής της ταχύτητας ενός σώματος', '0', '22');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η ισχύς ειναι παράγωγο μέγεθος', '1', '22');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η ισχύς ειναι διανυσματικό μέγεθος', '0', '22');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η ηλεκτρική ενέργεια ειναι μια απο τις θεμελιώδεις ενέργειες στη φύση', '0', '23');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Καθώς κινείται ένα αυτοκίνητο συμβαίνει μετατροπή κινητικής ενέργειας σε χημική', '0', '23');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η κινητική και η δυναμική ενέργεια αποτελούν τις θεμελιώδεις ενέργειες στη φύση', '1', '23');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η πυρηνική ενέργεια ειναι μορφή ηλεκτρικής ενέργειας', '0', '23');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Pα>Pβ', '0', '24');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Pα<Pβ', '0', '24');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Pα=Pβ', '1', '24');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Κανένα από τα παραπάνω', '0', '24');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ανάλογη προς το τετράγωνο της μάζας του', '0', '25');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ανάλογη προς την μεταβολή της ταχύτητάς του', '0', '25');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ανάλογη προς το τετράγωνο της ταχύτητάς του', '1', '25');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Ανάλογη προς την ταχύτητά του', '0', '25');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Είναι πάντα θετικό', '0', '26');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Είναι μηδέν μόνο όταν το σώμα δεν μετατοπίζεται', '0', '26');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Είναι ανεξάρτητο από τη μετατόπιση του σώματος', '0', '26');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Eίναι μονόμετρο μέγεθος', '1', '26');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1 W', '1', '27');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1 J', '0', '27');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1 N/s', '0', '27');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1 N', '0', '27');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Όταν το σώμα φτάνει στο έδαφος (και πριν ακουμπήσει), δεν έχει κινητική ενέργεια', '0', '28');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Στην αρχή της κίνησής του το σώμα δεν έχει δυναμική ενέργεια', '0', '28');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η μηχανική ενέργεια του σώματος δεν παραμένει σταθερή', '0', '28');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η μηχανική ενέργεια του σώματος είναι σταθερή σε όλη τη διάρκεια της κίνησής του', '1', '28');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Θετικό', '1', '29');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Αρνητικό', '0', '29');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μηδέν', '0', '29');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Θετικό ή αρνητικό ανάλογα με τη θετική φορά που πήραμε στον κατακόρυφο άξονα', '0', '29');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('3 Joule', '0', '30');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1,5 Joule', '0', '30');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('5 Joule', '1', '30');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1 Joule', '0', '30');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Το σώμα δίνει ενέργεια στο περιβάλλον, µέσω του έργου της δύναμης F', '1', '31');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Στο σώμα προσφέρεται ενέργεια µέσω του έργου της δύναμης F', '0', '31');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η δύναμη F είναι κάθετη στην ταχύτητα του σώματος', '0', '31');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η δύναμη F είναι ομόρροπη της ταχύτητας του σώματος', '0', '31');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μια καλή μηχανή συνήθως έχει απόδοση γύρω στο 3 (ή στο 300%)', '0', '32');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η ισχύς εκφράζει το πηλίκο της προσφερόμενης προς την ωφέλιμη ενέργεια', '0', '32');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Ισχύ έχουν μόνο τα αυτοκίνητα', '0', '32');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'  Μονάδα ισχύος είναι το Watt', '1', '32');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1 J', '1', '33');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1 kg', '0', '33');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1N/m', '0', '33');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (' 1 N', '0', '33');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ανάλογο του τετραγώνου της μετατόπισης του σώματος', '0', '34');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Αντιστρόφως ανάλογο της μετατόπισης του σώματος', '0', '34');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ανεξάρτητο απο τη μετατόπιση του σώματος', '0', '34');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ανάλογο της μετατόπισης του σώματος', '1', '34');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Σε δυναμική και κινητική ενέργεια του κιβωτίου και σε θερμική ενέργεια', '1', '35');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Σε κινητική ενέργεια του κιβωτίου και σε θερμική ενέργεια', '0', '35');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Σε δυναμική ενέργεια του κιβωτίου και σε θερμική ενέργεια', '0', '35');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Σε κινητική και δυναμική ενέργεια του κιβωτίου', '0', '35');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Aυξάνεται, αυξάνεται, αυξάνεται', '0', '36');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Mειώνεται, μειώνεται, μειώνεται', '0', '36');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Aυξάνεται, μειώνεται, παραμένει η ίδια', '1', '36');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Aυξάνεται, μειώνεται, μειώνεται', '0', '36');


INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ένα διάλυμα χαρακτηρίζεται όξινο  όταν:', '1', '3', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Το γινόμενο [H3O+][OH-] έχει τιμή 10-14 στους 25οC:', '1', '3', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Το καθαρό νερό στους 40οC έχει pH:', '1', '3', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Κατά τη διάλυση ΗΝΟ3 σε νερό η τιμή του γινομένου [H3O+][OH-]', '1', '3', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Σε ένα υδατικό διάλυμα ΗClΟ4 0,1Μ η [H3O+] που προκύπτει από τον αυτοϊοντισμό του νερού είναι:', '1', '3', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Διάλυμα ΗCl 0,01M αραιώνεται με νερό σε σταθερή θερμοκρασία 25oC. Το αραιωμένο διάλυμα μπορεί να έχει pH:', '1', '3', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Μεταξύ δύο υδατικών διαλυμάτων της ίδιας θερμοκρασίας περισσότερο όξινο είναι αυτό:', '1', '3', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ανάμεσα στο pH και pOH ισχύει η σχέση:', '1', '3', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Στους 25oC διάλυμα NaOH συγκέντρωσης 10-8 Μ έχει pH:', '1', '3', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Σε υδατικό διάλυμα ΚΟΗ με pH = 10 προσθέτουμε διάλυμα ΚΟΗ με pH = 13. Το διάλυμα που προκύπτει μπορεί να έχει pH:', '1', '3', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Σε ένα υδατικό διάλυμα HCl με συγκέντρωση 10-8Μ στους 25oC ισχύει:', '0', '3', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποια από τις παρακάτω τιμές pH είναι πιθανή για υδατικό Διάλυμα ασθενούς μονοπρωτικού οξέος ΗΑ 0,1 Μ ;', '0', '3', '1');

INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH < 7', '0', '37');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH > pOH', '0', '37');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('[H3O+] > [OH-]', '1', '37');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH > 1/2 Kw', '0', '37');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μόνο στο καθαρό νερό', '0', '38');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μόνο σε διαλύματα οξέων', '0', '38');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μόνο στα υδατικά διαλύματα ηλεκτρολυτών', '0', '38');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Σε κάθε υδατικό διάλυμα', '1', '38');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('7', '0', '39');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('7.5', '0', '39');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('6.5', '1', '39');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('10^-14', '0', '39');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Αυξάνεται', '0', '40');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ελαττώνεται', '0', '40');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Παραμένει σταθερή', '1', '40');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Δεν μπορούμε να γνωρίζουμε', '0', '40');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1/2Kw', '0', '41');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('0.1M', '0', '41');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('10^-13M', '1', '41');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('0M', '0', '41');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('4', '1', '42');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('7', '0', '42');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('8', '0', '42');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1', '0', '42');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'που έχει μεγαλύτερη τιμή pH', '0', '43');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'που έχει μεγαλύτερη τιμή pOH', '1', '43');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'που περιέχει ισχυρό οξύ', '0', '43');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'που έχει περισσότερα ιόντα Η3Ο+', '0', '43');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH + pOH = 14', '0', '44');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH + pOH = 10^-14', '0', '44');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH + pOH = pKw', '1', '44');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH + pOH = Kw', '0', '44');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('8', '0', '45');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('6', '0', '45');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('4', '0', '45');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('7.02', '1', '45');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('9.6', '0', '46');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('10.5', '1', '46');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('10', '0', '46');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('13.5', '0', '46');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('[Cl-] > [H3O+]', '0', '47');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH = 7,02', '0', '47');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH = 8', '0', '47');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('[H3O+] > [OH-]', '1', '47');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('3', '1', '48');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1', '0', '48');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('0.1', '0', '48');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('7', '0', '48');

INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Βασικό είναι το υδατικό διάλυμα της ένωσης:', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Ποιο από τα παρακάτω ζεύγη ενώσεων όταν διαλυθεί σε νερό δίνει ρυθμιστικό διάλυμα:', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Ποιο από τα παρακάτω ζεύγη αποτελεί συζυγές ζεύγος οξέος-βάσης;', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N' Ποιο από τα παρακάτω διαλύματα οξέων που έχουν την ίδια συγκέντρωση και', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Η σταθερά ιοντισμού (γινόμενο ιόντων του νερού) Κw μεταβάλλεται, αν:', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Το υδατικό διάλυμα που παρουσιάζει τη μεγαλύτερη τιμή pH, είναι :', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Με προσθήκη νερού δεν μεταβάλλεται το pH υδατικού διαλύματος:', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Ρυθμιστικό διάλυμα μπορεί να προκύψει από τη διάλυση σε νερό, του ζεύγους των', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Ποια από τις παρακάτω προτάσεις ισχύει όταν υδατικό διάλυμα ΝΗ3 αραιώνεται με', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Σε αραιό υδατικό διάλυμα ΝΗ3 όγκου V1 με βαθμό ιοντισμού α1 (α1<0,1) προσθέτουμε', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Σύμφωνα με τη θεωρία Brönsted – Lowry σε υδατικό διάλυμα δρα ως οξύ το ιόν:', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Ένα υδατικό διάλυμα ΗCℓ με pH = 3 αραιώνεται με νερό. Το νέο διάλυμα μπορεί να έχει:', '3', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Ποιo από τα παρακάτω αποτελεί συζυγές ζεύγος οξέος–βάσης, κατά Brönsted– Lowry; ', '3', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Το συζυγές οξύ της βάσης', '3', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Το pH διαλύματος ασθενούς οξέος ΗΑ 0,01 Μ είναι:', '3', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Συζυγές ζεύγος οξέος – βάσης κατά Brönsted-Lowry είναι ', '3', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Ποιο από τα παρακάτω ζεύγη αποτελεί συζυγές ζεύγος οξέος – βάσης κατά Brönsted -', '3', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Σε υδατικό διάλυμα ασθενούς οξέος ΗΑ προσθέτουμε αέριο ΗCℓ, χωρίς να μεταβληθεί ο', '3', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Κατά την ογκομέτρηση διαλύματος ΗCℓ με πρότυπο διάλυμα ΝaΟΗ στο ισοδύναμο', '3', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Όταν μικρή ποσότητα ισχυρού οξέος (π.χ. ΗCl) προστεθεί σε υδατικό διάλυμα ασθενούς', '3', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Ποια από τις παρακάτω χημικές ουσίες θα προκαλέσει αύξηση του βαθμού ιοντισμού του', '3', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Ένας πρωτολυτικός δείκτης εμφανίζει κίτρινο και μπλε χρώμα σε δύο υδατικά διαλύματα,', '3', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Yδατικό διάλυμα ΝaOH όγκου V1 με pH = 12 αραιώνεται με νερό ίδιας θερμοκρασίας μέχρι', '3', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Από τα παρακάτω υδατικά διαλύματα είναι ρυθμιστικό διάλυμα το:', '3', '3');

INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('KCℓ', '0', '49');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('CH3COOK', '1', '49');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('NH4NO3', '0', '49');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('CH3C ≡CH', '0', '49');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HCℓ − NaCℓ', '0', '50');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HCOOH − HCOONa', '1', '50');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HCℓ − NH4Cℓ', '0', '50');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('NaOH − CH3COONa', '0', '50');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('ΗCl - Cl-', '1', '51');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('Νa-NaOH', '0', '51');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('H3O+- OH-', '0', '51');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('CH3COOH - H2O', '0', '51');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HCOOH με Ka = 2 ⋅ 10-4', '0', '52');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('CH3COOH με Ka = 2 ⋅ 10-5', '0', '52');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('. CℓCH2COOH με Ka = 1,5 ⋅ 10-3', '0', '52');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('Cℓ2CHCOOH με Ka = 5 ⋅ 10-2 ', '1', '52');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'στο νερό διαλυθεί οξύ', '0', '53');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'στο νερό διαλυθεί βάση', '0', '53');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'στο νερό διαλυθεί άλας', '0', '53');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μεταβληθεί η θερμοκρασία του νερού', '1', '53');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('NaF', '1', '54');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('NH4Cl', '0', '54');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HCOOH', '0', '54');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('KCl', '0', '54');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('CH3COOH', '0', '55');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (' NH4Cl', '0', '55');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('NaCl', '1', '55');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('CH3COONa', '0', '55');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('CH3COOH και HCℓ', '0', '56');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('NaOH και NaCℓ', '0', '56');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (' CH3COOH και CH3COONa', '1', '56');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (' HCℓ και NH4Cℓ', '0', '56');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η τιμή της σταθεράς Kb μειώνεται', '0', '57');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ο βαθμός ιοντισμού της ΝΗ3 αυξάνεται', '1', '57');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Το pH του διαλύματος αυξάνεται', '0', '57');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η συγκέντρωση του διαλύματος της ΝΗ3 αυξάνεται', '0', '57');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α2 = 2α1', '1', '58');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α2 = 4α1', '0', '58');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α2 = α1', '0', '58');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α2 =1/2 α1', '0', '58');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('SO4 2-', '0', '59');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('NH4+', '1', '59');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('Νa+', '0', '59');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('ΗCOO–', '0', '59');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH =2', '0', '60');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH =3', '0', '60');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH =4', '1', '60');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH =12', '0', '60');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HCN/CN-', '1', '61');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('H3O+/OH-', '0', '61');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('H2CO3/CO3 2-', '0', '61');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('NH4+/NH2-', '0', '61');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('CO3 2-', '0', '62');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HCO2-', '0', '62');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('H2CO3', '1', '62');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('CO2', '0', '62');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('2', '0', '63');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μεγαλύτερο του 2', '1', '63');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μικρότερο του 2', '0', '63');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('0', '0', '63');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('H3O+-OH-', '0', '64');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('NH4+ NH3', '1', '64');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HCl NaOH', '0', '64');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HNO3 NO2', '0', '64');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('H3O+ OH-', '0', '65');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('H2S S2-', '0', '65');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HS- S2-', '1', '65');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HCl H30+', '0', '65');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH', '0', '66');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('KaHa', '0', '66');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('aHa', '0', '66');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('[H3O+]', '1', '66');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH=13', '0', '67');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH=6', '0', '67');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH=7', '1', '67');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('pH=2', '0', '67');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'αυξάνεται', '0', '68');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μειώνεται', '1', '68');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'παραμένει σταθερός', '0', '68');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'τείνει στη μονάδα', '0', '68');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Καθαρό CH3COOH', '0', '69');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Στερεό CH3COOΝa, χωρίς μεταβολή του όγκου του διαλύματος', '0', '69');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Νερό', '1', '69');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Αέριο HCl, χωρίς μεταβολή του όγκου του διαλύματος', '0', '69');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μπλε', '0', '70');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'κίτρινο', '1', '70');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ενδιάμεσο (πράσινο)', '0', '70');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' δεν μπορεί να γίνει πρόβλεψη', '0', '70');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('10', '0', '71');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('11', '1', '71');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('13', '0', '71');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('14', '0', '71');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('H2SO4 0.1M - NaSO4 0.1M', '0', '72');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HCl 0.1M NH4Cl 0.1M', '0', '72');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('HCOOH 0.1M HCOONa 0.1M', '1', '72');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('NaOH 0.1M H3COONa 0.1M', '0', '72');


INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Η εξίσωση αχ = 0 είναι ταυτότητα ....', '1', '1');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Η εξίσωση 4χ - 2 = 6 είναι ισοδύναμη με την εξίσωση ....', '1', '1');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Αν το 2 είναι λύση της εξίσωσης 3χ - 1 + α = 0, τότε η τιμή του α είναι:', '1', '1');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Η εξίσωση (α-1)(α+2)χ = α(α+2) είναι αόριστη όταν:', '1', '1');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Η εξίσωση α(α-3)χ = (α-3)(α+2) είναι αδύνατη όταν:', '1', '1');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Η εξίσωση (α-1)χ = (α-1)(α+1) έχει μοναδική λύση όταν:', '1', '1');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Οι λύσεις της εξίσωσης (χ+3)(χ-2) = 0 είναι:', '1', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Η εξίσωση (x-5)^2+(x-2)^=0', '1', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Αν ισχύει 2 < χ < 4 τότε:', '1', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Αν την ανισότητα -4 > -8 τη διαιρέσουμε με -8, θα προκύψει η ανισότητα:', '1', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Αν α > β, τότε ισχύει:', '1', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Αν α : β >0, με β διαφορετικό του 0, τότε ισχύει:', '1', '2');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Αν αχ > β με α < 0, τότε:', '1', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Αν αχ < β με α > 0, τότε:', '1', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Η ανίσωση 0χ < -2 έχει:', '1', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'H ανίσωση 0χ>=0 έχει:', '1', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Η εξίσωση (χ-3)(χ-5)^2<0 αληθεύει για:', '1', '3');
INSERT INTO `quizbomb`.`question` (`content`, `course_id`, `sclass_id`) VALUES (N'Οι ανισώσεις -2 < χ < 6 και 2 < χ < 8 συναληθεύουν για:', '1', '3');

INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'για κάθε τιμή του α.', '0', '73');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'για α = 0', '1', '73');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'για α = 1.', '0', '73');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'για α διαφορετικό από το 0.', '0', '73');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' 2χ - 1 = 5.', '0', '74');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'5χ + 4 = 14.', '1', '74');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'χ - 1 = 6.', '0', '74');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'3χ - 5 = 4.', '0', '74');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('5', '0', '75');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('-5', '1', '75');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('-2', '0', '75');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('0', '0', '75');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α = 1.', '0', '76');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α = 2.', '0', '76');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α = 0.', '0', '76');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α = -2', '1', '76');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' α = 0.', '1', '77');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' α = 3.', '0', '77');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' α = 2.', '0', '77');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' α = -3', '0', '77');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' α = 1.', '0', '78');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α διαφορετικό του -1.', '0', '78');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α διαφορετικό του 1.', '1', '78');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α διαφορετικό του 0.', '0', '78');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' χ=3 ή χ=2.', '0', '79');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'χ=-3 ή χ=2.', '1', '79');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'χ=-3 ή χ=-2.', '0', '79');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'χ=3 ή χ=-2.', '0', '79');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'έχει λύση τη χ=5.', '0', '80');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' έχει λύση τη χ=2', '0', '80');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' είναι αδύνατη.', '1', '80');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'είναι αόριστη.', '0', '80');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'-2 < -χ < -4', '0', '81');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' 4 < 2χ < 8', '1', '81');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'-1 > χ-1 > -3', '0', '81');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'χ>=2', '0', '81');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1/2 < 1', '1', '82');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('1/2 > 1', '0', '82');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('-1/2 > 1', '0', '82');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('-1/2 > -1', '0', '82');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' β - α >0', '0', '83');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α+β > 0', '0', '83');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' α - β > 0', '1', '83');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'β > α', '0', '83');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'αβ < 0.', '0', '84');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'αβ > 0.', '1', '84');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'α > 0.', '0', '84');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'β > 0.', '0', '84');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' χ < β/α', '1', '85');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' χ > βα', '0', '85');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' χ < βα', '0', '85');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'χ > β/α', '0', '85');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' χ > β/α', '0', '86');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' χ < β/α', '1', '86');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' χ > β-α', '0', '86');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' χ > αβ', '0', '86');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'καμία λύση.', '1', '87');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' άπειρες λύσεις.', '0', '87');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' μία λύση.', '0', '87');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'δύο λύσεις.', '0', '87');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'άπειρες λύσεις.', '1', '88');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'καμία λύση.', '0', '88');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' μία λύση.', '0', '88');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'διπλή λύση.', '0', '88');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'χ < 3', '1', '89');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'3 < χ < 5', '0', '89');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'χ < 5', '0', '89');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' χ > 3', '0', '89');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' -2 < χ < 8', '0', '90');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'2 < χ < 6', '1', '90');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' -2 < χ < 2', '0', '90');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'0 < χ < 5', '0', '90');


INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Οι ιοί είναι:', '1', '6', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Οι ιντερφερόνες παράγονται από ορισμένα κύτταρα που έχουν μολυνθεί από:', '1', '6', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Το AIDS οφείλεται σε:', '1', '6', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Όλοι οι ιοί είναι:', '1', '6', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ο ιός που προκαλεί το AIDS μεταδίδεται κυρίως με', '1', '6', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Αλλεργία είναι η αντίδραση του ανοσοποιητικού συστήματος:', '0', '6', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Τα βακτήρια διαθέτουν:', '1', '6', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ασθένεια βακτηριακής αιτιολογίας είναι:', '1', '6', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Η αδυναμία επαναφοράς της διαταραγμένης ομοιόστασης στα φυσιολογικά επίπεδα μπορεί σταδιακά να οδηγήσει σε:', '1', '6', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Μεταξύ των παραγόντων στους οποίους στηρίζεται η μη ειδική άμυνα του ανθρώπινου οργανισμού είναι:', '1', '6', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Οι ιοί αποτελούνται από:', '1', '6', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Το τρυπανόσωμα προκαλεί:', '0', '6', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Παθητική ανοσία επιτυγχάνεται με χορήγηση:', '1', '6', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Τα βακτήρια διαθέτουν:', '1', '6', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Οι οροί που χρησιμοποιούνται για την παθητική ανοσοποίηση, περιέχουν:', '1', '6', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Τα ενδοσπόρια σχηματίζονται από:', '1', '6', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποιο από τα παρακάτω όργανα χαρακτηρίζεται πρωτογενές λεμφοειδές όργανο;', '1', '6', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Μεγάλες ποσότητες ανοσοσφαιρινών εκκρίνονται από:', '0', '6', '3');
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='47';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='48';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='49';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='50';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='51';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='52';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='53';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='54';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='55';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='56';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='57';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='58';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='59';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='60';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='61';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='62';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='63';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='64';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='65';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='66';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='67';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='68';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='69';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='70';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='71';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='72';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='73';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='74';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='75';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='76';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='77';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='78';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='79';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='80';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='81';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='82';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='83';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='84';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='85';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='86';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='87';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='88';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='89';
UPDATE `quizbomb`.`question` SET `isapproved`='1' WHERE `id`='90';


INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'παράσιτα', '1', '91');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ξενιστές', '0', '91');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'αποικοδομητές', '0', '91');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'παραγωγοί', '0', '91');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'βακτήριο', '0', '92');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'πρωτόζωο', '0', '92');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ιό', '1', '92');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μύκητα', '0', '92');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'βακτήριο', '0', '93');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ιό', '1', '93');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' μύκητα', '0', '93');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'πρωτόζωο', '0', '93');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μικρά κύτταρα', '0', '94');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'υποχρεωτικά ενδοκυτταρικά παράσιτα', '1', '94');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μη παθογόνοι για τον άνθρωπο', '0', '94');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' φορείς DNA', '0', '94');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'το σάλιο και τον ιδρώτα', '0', '95');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'τη χειραψία και το φιλί', '0', '95');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'το αίμα και τη σεξουαλική επαφή', '1', '95');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'το νερό και την τροφή', '0', '95');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'σε αβλαβείς για τον οργανισμό παράγοντες', '1', '96');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'σε παθογόνους μικροοργανισμούς', '0', '96');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'σε αλλαγές της θερμοκρασίας', '0', '96');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'στη θέα επικίνδυνων ζώων', '0', '96');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μιτοχόνδρια', '0', '97');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ριβοσώματα', '1', '97');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'χλωροπλάστες', '0', '97');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' πυρήνα', '0', '97');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'το κοινό κρυολόγημα', '0', '98');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'η ηπατίτιδα', '0', '98');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'η πολιομυελίτιδα', '0', '98');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'η γονόρροια', '1', '98');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' συναισθηματική φόρτιση', '0', '99');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' υψηλή αρτηριακή πίεση', '0', '99');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' αύξηση της συγκέντρωσης της γλυκόζης στο αίμα', '0', '99');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'θάνατο', '1', '99');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'τα Β λεμφοκύτταρα', '0', '100');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' οι βλεννογόνοι', '1', '100');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'τα Τ λεμφοκύτταρα', '0', '100');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'τα αντισώματα', '0', '100');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'DNA και πολυσακχαρίτες', '0', '101');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'νουκλεϊκό οξύ και πρωτεΐνες', '1', '101');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'RNA και πρωτεΐνες', '0', '101');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' νουκλεϊκό οξύ και κάποια επιπλέον γονίδια', '0', '101');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'δυσεντερία', '0', '102');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ελονοσία', '0', '102');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ασθένεια του ύπνου', '1', '102');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'χολέρα', '0', '102');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ορού αντισωμάτων', '1', '103');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'εμβολίου', '0', '103');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'αντιβιοτικού', '0', '103');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ιντερφερόνης', '0', '103');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ενδοπλασματικό δίκτυο', '0', '104');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'κυτταρικό τοίχωμα', '1', '104');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'διακριτό πυρήνα', '0', '104');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μιτοχόνδρια', '0', '104');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'έτοιμα τα αντιγόνα της συγκεκριμένης ασθένειας', '0', '105');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'λεμφοκύτταρα που αντιμετωπίζουν την προσβολή', '0', '105');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'έτοιμα αντισώματα', '1', '105');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μακροφάγα ικανά να καταστρέψουν τον παθογόνο παράγοντα', '0', '105');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'φυτά', '0', '106');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'DNA ιούς', '0', '106');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'βακτήρια', '1', '106');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'RNA ιούς', '0', '106');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'σπλήνας', '0', '107');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'αμυγδαλές', '0', '107');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'θύμος αδένας', '1', '107');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'γαστρεντερικός σωλήνας', '0', '107');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'φυσικά κύτταρα φονιάδες', '0', '108');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μακροφάγα', '0', '108');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'πλασματοκύτταρα', '1', '108');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'βοηθητικά Τ λεμφοκύτταρα', '0', '108');


INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Όταν εργαζόμαστε στον υπολογιστή πρέπει:', '1', '5', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Η σωστή θέση της οθόνης του υπολογιστή είναι:', '1', '5', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Η εργονομία εξετάζει:', '1', '5', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Το μέγεθος της οθόνης καθορίζεται από:', '1', '5', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Η λειτουργία του τραντζίστορ είναι όμοια με αυτήν:', '1', '5', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ο πρώτος ηλεκτρονικός υπολογιστής ήταν:', '1', '5', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Το σύνολο των προγραμμάτων που χρησιμοποιεί ο υπολογιστής ονομάζεται:', '1', '5', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ολα τα μηχανικά μέρη του υπολογιστή ονομάζονται:', '1', '5', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Αγοράσατε ένα Η/Υ μαζί με τις παρακάτω εφαρμογές. Ποιά πρέπει να εγκατασταθεί πρώτη;', '1', '5', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Με μιά γλώσσα προγραμματισμού μπορούμε:', '1', '5', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποιο από τα παρακάτω δεν είναι λειτουργικό σύστημα:', '1', '5', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ο μεταφραστής :', '1', '5', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Οι εντολές εκκίνησης και αυτοελέγχου του Η/Υ βρίσκονται:', '1', '5', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Μπορούμε να γράψουμε Ελληνικά χρησιμοποιώντας ', '1', '5', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Μπορούμε να διαγράψουμε χαρακτήρες με το πλήκτρο:', '1', '5', '3');


INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'να μη μας ενδιαφέρει ο χρόνος που τον χρησιμοποιούμε.', '0', '109');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' να τελειώνουμε γρήγορα την εργασία μας και μετά να κλείνουμε τον υπολογιστή.', '0', '109');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'να διαρκούν τα διαλείμματα περισσότερο από το συνολικό χρόνο χρήσης του.', '0', '109');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'να κάνουμε τακτικά διαλείμματα ανά 50 λεπτά.', '1', '109');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μπροστά μας, με το ανώτερο σημείο της στην ίδια ευθεία με τα μάτια μας', '1', '110');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'σε οποιαδήποτε θέση', '0', '110');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'αριστερά μας', '0', '110');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'σε επίπεδο ψηλότερα από το κεφάλι μας και να στηρίζεται σε βάση στον τοίχο.', '0', '110');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'με ποιο τρόπο μπορεί ο άνθρωπος να είναι σε αρμονία με το περιβάλλον του και τα αντικείμενα που χρησιμοποιεί.', '1', '111');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'με ποιο τρόπο μπορεί ο άνθρωπος να συνεργάζεται αρμονικά με τους γύρω του.', '0', '111');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'με ποιο τρόπο μπορούμε να ολοκληρώνουμε πιο γρήγορα τις εργασίες μας.', '0', '111');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'με ποιο τρόπο τηρούνται οι νόμοι στην εργασία.', '0', '111');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'από το πλάτος της.', '0', '112');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'από το ύψος της.', '0', '112');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'την περίμετρό της.', '0', '112');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'από το μήκος της διαγωνίου της.', '1', '112');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'του ραδιοφώνου', '1', '113');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'του διακόπτη', '0', '113');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'του τηλεφώνου', '0', '113');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'κανένα από τα παραπάνω', '0', '113');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η μηχανή του Μπάμπατζ', '0', '114');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'το PC', '0', '114');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ο Eniac', '1', '114');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'κανένα από τα παραπάνω', '0', '114');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'λογισμικό', '1', '115');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'λειτουργικό σύστημα', '0', '115');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'εφαρμογή ', '0', '115');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'υλικό', '0', '115');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'λογισμικό', '0', '116');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'υλικό', '1', '116');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'λειτουργικό σύστημα ', '0', '116');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'εφαρμογή', '0', '116');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'επεξεργασία κειμένου', '0', '117');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'λειτουργικό σύστημα', '1', '117');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'παιχνίδι FIFA', '0', '117');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ζωγραφική', '0', '117');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'να ταξινομήσουμε τα προγράμματα του υπολογιστή', '0', '118');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'να γράψουμε ένα κείμενο', '0', '118');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'να δημιουργήσουμε ένα δικό μας πρόγραμμα', '1', '118');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'κανένα από τα παραπάνω', '0', '118');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'επεξεργασία κειμένου', '1', '119');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'windows 2000', '0', '119');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Linux', '0', '119');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'κανένα από τα παραπάνω', '0', '119');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μεταφράζει ένα κείμενο του Η/Υ σε άλλη γλώσσα', '1', '120');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μετατρέπει τα προγράμματα σε γλώσσα του υπολογιστή', '0', '120');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'μεταφράζει τα προγράμματα σε γλώσσα υψηλού επιπέδου', '0', '120');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'όλα τα παραπάνω ', '0', '120');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'στη μνήμη RAM', '0', '121');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'στο ROM BIOS', '1', '121');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'στο σκληρό δίσκο', '0', '121');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'αλλού', '0', '121');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'το πλήκτρο enter', '0', '122');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'τη διάταξη πληκτρολογίου', '0', '122');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'τα πλήκτρα ειδικών λειτουργιών', '0', '122');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'τα πλήκτρα shift+alt', '1', '122');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('end', '0', '123');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('ctrl', '0', '123');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('enter', '0', '123');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES ('delete', '1', '123');


INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ιστορικό γεγονός σημαίνει:', '1', '4', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Σκοπός της ιστορίας είναι:', '1', '4', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Οι πηγές της ιστορίας είναι:', '1', '4', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Άμεσες πηγές της ιστορίας είναι:', '1', '4', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Έμμεσες πηγές της ιστορίας είναι:', '1', '4', '1');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Σκοπός της ιστορίας φυσικής αγωγής και αθλητισμού είναι:', '1', '4', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Σκοπός της αγωγής στην κλασική εποχή ήταν:', '1', '4', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Τα μέσα της φυσικής αγωγής είναι:', '1', '4', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποιο από τα παρακάτω δεν είναι τρόπος μετακίνησης του ανθρώπινου οργανισμού:', '1', '4', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποιο από τα παρακάτω δεν είναι τρόπος υπερνίκησης του βάρους των αντικειμένων:', '1', '4', '2');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Παράδοση είναι:', '1', '4', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποιο από τα παρακάτω δεν ανήκει στους κινδύνους της φυσικής αγωγής και του αθλητισμού:', '1', '4', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ποιο από τα παρακάτω χαρακτηριστικά δεν ανήκει στην παιδιά: ', '1', '4', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Ο αγώνας απαιτεί:  ', '1', '4', '3');
INSERT INTO `quizbomb`.`question` (`content`, `isapproved`, `course_id`, `sclass_id`) VALUES (N'Η παιδιά εύκολα μεταβάλλεται σε αγώνα, αρκεί:  ', '1', '4', '3');


INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Κάθε δραστηριότητα σε ορισμένο τόπο και χρόνο.', '0', '124');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Κάθε δραστηριότητα που έχει επιπτώσεις θετικές ή αρνητικές στη ζωή και εξέλιξη μιας κοινωνίας.', '0', '124');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'ιξη μιας κοινωνίας.', '1', '124');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Κανένα από τα παραπάνω.', '0', '124');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η γνώση του παρελθόντος. ', '0', '125');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η γνώση του παρόντος.  ', '0', '125');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η ανασύνδεση του παρόντος με το παρελθόν για άντληση πορισμάτων.', '1', '125');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Κανένα από τα παραπάνω.', '0', '125');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Τα γραπτά μνημεία και η προφορική παράδοση.', '0', '126');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Τα αρχαιολογικά και μνημεία τέχνης.', '0', '126');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Το οπτικοακουστικό υλικό.', '0', '126');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Όλα τα παραπάνω.', '1', '126');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Αυθεντικές μαρτυρίες.', '1', '127');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Έργα λογοτεχνίας.', '0', '127');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ιστοριογραφίες.', '0', '127');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Απομνημονεύματα.', '0', '127');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Νομίσματα.', '0', '128');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Νομοθεσίες και έγγραφα.', '0', '128');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Αρχαιολογικά μνημεία.', '0', '128');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Έργα λογοτεχνίας.', '1', '128');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η περιγραφή των αγωνισμάτων και γυμναστικών δραστηριοτήτων των λαών. ', '0', '129');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Δημιουργία κοινωνικών ατόμων.', '0', '129');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ανάπτυξη του πολιτισμού.', '0', '129');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Όλα τα παραπάνω είναι σωστά.', '1', '129');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Να δημιουργήσει τον άνδρα υπέροχο «στα λόγια και στις πράξεις». ', '0', '130');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Να επιτευχθεί «ο καλός καγαθός πολίτης».', '1', '130');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Να καλλιεργηθεί ο «θρησκευτικός τύπος».', '0', '130');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Όλα τα παραπάνω δεν είναι σωστά.', '0', '130');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η κίνηση και ο χορός.', '0', '131');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η παιδιά και ο αγώνας.', '0', '131');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Το τραγούδι και η μουσική.', '0', '131');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μόνο τα α και το β είναι σωστά.', '1', '131');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η βάδιση.', '0', '132');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Ο δρόμος.', '0', '132');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η ώθηση.', '1', '132');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Το άλμα.', '0', '132');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η αναρρίχηση.', '1', '133');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η έλξη.', '0', '133');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η πλήξη.', '0', '133');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η πίεση.', '0', '133');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Αλληγορική διήγηση από την οποία συνάγεται ηθικό συμπέρασμα.', '0', '134');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Διάφορα ιστορήματα που μεταδίδονται «διά στόματος» από γενιά σε γενιά.', '1', '134');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Φανταστική αφήγηση γεμάτη θαυμάσια γεγονότα.', '0', '134');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Κανένα από τα παραπάνω δεν είναι σωστό.', '0', '134');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Εμπορευματοποίηση ή πολιτικοποίηση. ', '0', '135');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Αναβολικά ή ντοπάρισμα.', '0', '135');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Φανατισμός ή χουλιγκανισμός.', '0', '135');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Πολιτισμική επικοινωνία ατόμων και λαών.', '1', '135');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η επιδίωξη επίδοσης ή ρεκόρ.', '1', '136');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N' Η ελεύθερη δράση.', '0', '136');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η έλλειψη εσωτερικού αναγκασμού.', '0', '136');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Η έλλειψη πίεσης.', '0', '136');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Συνεχή άσκηση.', '0', '137');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Απόλυτη πειθαρχία.', '0', '137');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Ελεύθερη δράση.', '0', '137');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Μόνο το α και β. ', '1', '137');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Να ενταθεί η προσπάθεια.', '0', '138');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Να παιχθεί από μικρές ηλικίες.', '0', '138');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Να επιδιωχθεί με πείσμα η νίκη.', '0', '138');
INSERT INTO `quizbomb`.`answer` (`content`, `correct`, `question_id`) VALUES (N'Το α και το γ.', '1', '138');




INSERT INTO `quizbomb`.`quiz` (`course_id`, `sclass_id`, `title`) VALUES ('2', '2', N'Φυσική - Τεστ ερωτήσεων πολλαπλής επιλογής -  Β΄ Γυμνασίου');
INSERT INTO `quizbomb`.`quiz` (`course_id`, `sclass_id`, `title`) VALUES ('3', '1', N'Χημεία - Τεστ ερωτήσεων πολλαπλής επιλογής -  Α΄ Γυμνασίου');
INSERT INTO `quizbomb`.`quiz` (`course_id`, `sclass_id`, `title`) VALUES ('2', '3', N'Φυσική - Τεστ ερωτήσεων πολλαπλής επιλογής -  Γ΄ Γυμνασίου');

INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('1', '12');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('1', '13');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('1', '14');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('1', '15');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('1', '16');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('1', '17');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('1', '18');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('1', '19');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('1', '20');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('1', '11');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('2', '37');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('2', '38');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('2', '39');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('2', '40');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('2', '41');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('2', '42');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('2', '43');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('2', '44');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('2', '45');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('2', '46');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('3', '21');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('3', '22');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('3', '23');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('3', '24');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('3', '25');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('3', '26');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('3', '27');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('3', '28');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('3', '29');
INSERT INTO `quizbomb`.`quiz_question` (`quiz_id`, `question_id`) VALUES ('3', '30');
