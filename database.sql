-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: std-mysql    Database: std_2360_exam
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('19ad1a1d919d');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_visits`
--

DROP TABLE IF EXISTS `book_visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_visits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_book_visits_book_id_books` (`book_id`),
  KEY `fk_book_visits_user_id_users` (`user_id`),
  CONSTRAINT `fk_book_visits_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `fk_book_visits_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_visits`
--

LOCK TABLES `book_visits` WRITE;
/*!40000 ALTER TABLE `book_visits` DISABLE KEYS */;
INSERT INTO `book_visits` VALUES (6,3,2,'2024-06-10 16:18:26'),(7,3,2,'2024-06-10 16:42:58');
/*!40000 ALTER TABLE `book_visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `short_desc` text NOT NULL,
  `year_release` year(4) NOT NULL,
  `publisher` varchar(256) NOT NULL,
  `author` varchar(256) NOT NULL,
  `pages_volume` int(11) NOT NULL,
  `image_id` varchar(256) NOT NULL,
  `rating_sum` int(11) NOT NULL,
  `rating_num` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_books_image_id_images` (`image_id`),
  CONSTRAINT `fk_books_image_id_images` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (2,'Гарри Потер','Га́рри Джеймс По́ттер (англ. Harry James Potter) — литературный персонаж, главный герой серии романов английской писательницы Джоан Роулинг.\r\nНа одиннадцатый день рождения Гарри узнаёт, что является волшебником, и ему уготовано место в школе волшебства «Хогвартс», в которой он будет практиковать магию под руководством директора Альбуса Дамблдора и других школьных профессоров. Также оказывается, что он уже является знаменитостью во всём магическом сообществе романа, и что его судьба связана с судьбой Волан-де-Морта, опасного тёмного мага, убившего среди прочих и его родителей — Лили и Джеймса Поттеров.',2008,'Scholastic',' Дж.К Роулинг',245,'90825d82-ebb3-4127-8c67-19a0c7ed8344',4,1),(3,'Зеленая миля','История повествуется от лица Пола Эджкомба — бывшего надзирателя федеральной тюрьмы «Холодная гора» в штате Луизиана, а в настоящее время обитателя дома престарелых «Джорджия Пайнс» под Атлантой (штат Джорджия). Пол пишет мемуары (которые он потом показывает своей подруге Элейн Коннелли) о событиях 64-летней давности.\n\n1932 год. Пол — старший надзиратель тюремного блока «Е», в котором содержатся приговорённые к смертной казни на электрическом стуле. В тюрьме этот блок, застеленный линолеумом цвета перезрелого лайма, называют «Зелёная миля» (по аналогии с «Последней милей», которую приговорённый проходит в последний раз).\n\nВ обязанности Пола входит проведение казней. Надзиратели Гарри Тервиллигер, Брутус «Зверюга» Хоуэлл и Дин Стэнтон, которые помогают ему в этом, выполняют свою работу, придерживаясь негласного правила «Зелёной мили»: «Наша работа — говорить, а не кричать».\n\nОсобняком в команде Пола стоит надзиратель Перси Уэтмор — молодой, трусливый и жестокий садист; он развлекается, издеваясь над заключёнными, и мечтает о том дне, когда лично проведёт казнь. Несмотря на всеобщее омерзение, которое он вызывает на «Зелёной миле», Перси чувствует себя в полной безопасности — он племянник жены губернатора штата.',2022,'ACT','Стивен Кинг',245,'439369f8-4005-4a3f-af84-abf991761396',5,1),(4,'До встечи с тобой','Лу Кларк знает, сколько шагов от автобусной остановки до ее дома. Она знает, что ей очень нравится работа в кафе и что, скорее всего, она не любит своего бойфренда Патрика. Но Лу не знает, что вот-вот потеряет свою работу и что в ближайшем будущем ей понадобятся все силы, чтобы преодолеть свалившиеся на нее проблемы.\n\nУилл Трейнор знает, что сбивший его мотоциклист отнял у него желание жить. И он точно знает, что надо сделать, чтобы положить конец всему этому. Но он не знает, что Лу скоро ворвется в его мир буйством красок. И они оба не знают, что навсегда изменят жизнь друг друга.\n\nВ первые месяцы после выхода в свет романа Джоджо Мойес «До встречи с тобой» было продано свыше полумиллиона экземпляров. Книга вошла в список бестселлеров «Нью-Йорк таймс», переведена на 31 язык. Права на ее экранизацию купила киностудия «Метро-Голдвин-Майер».',2013,'Иностранка','Джоджо Мойес',410,'626c79fb-4030-4de3-a877-dca7d0b1b7c9',0,0),(5,'Три мушкетёра','Герои блестящего романа Александра Дюма \"Три мушкетера\" (1844 г.) — верные друзья Атос, Портос, Арамис и д\'Артаньян — покоряют жизнелюбием, неистощимой энергией, душевным благородством, находчивостью и отвагой многие поколения читателей. Наряду с вымышленными героями в романе действуют подлинные исторические лица эпохи Людовика XIII. История д\'Артаньяна продолжается в двух других романах трилогии: \"Десять лет спустя\" и \"Двадцать лет спустя\". Большое количество иллюстраций — 250 гравюр французского художника XIX века Мориса Лелуара, переплет с тиснением золотой фольгой, продуманный формат и изящное оформление тома, входящего в собрание сочинений автора, поразят воображение даже самого искушенного ценителя книги, а качественный перевод позволит насладиться одним из лучших творений автора в полном объеме. Бесспорный шедевр мировой литературы в изящном полиграфическом исполнении станет роскошным и достойным подарком для вас и ваших близких.',1945,'нигма','Александр Дюма',260,'bc83d91c-d419-452a-97b0-1f3084fc1725',0,0),(6,' Остров Сокровищ','Знаменитый роман Роберта Льюиса Стивенсона в сопровождении подробного историко-бытового комментария, посвященного морскому делу в Англии XVIII века и «золотому веку» пиратства. Рисунки, гравюры, карты, страницы из книг того времени, интерактивные элементы помогают воссоздать живую атмосферу эпохи.\nВ Англии, близ Бристоля, в таверне «Адмирал Бенбоу», в комнате старого капитана, в матросском сундуке, в пакете из клеенки надежно спрятано то, с чего начинаются приключения, известные каждому мальчишке. В Англию XVIII века мы отправимся с этой книгой, чтобы тут же выйти в море и в долгом плавании к острову Сокровищ постичь все морские премудрости.\nЗдесь за текстом знакомого романа оживает эпоха, а в рассказах Капитана Флинта встает перед глазами грозная история пиратства. Здесь можно рассмотреть каждый уголок шхуны от салинга до кильсона, заглянуть в сундучок доктора Ливси, набрать команду корабля вместе со сквайром Трелони, научиться вести судовой журнал, прокладывать курс, считать пиастры и муадоры, стрелять из мушкета и пушки, узнать все о Желтом Джеке, о рифах и бакштагах, о Доке казней, об островах Драй-Тортугас и о разбойничьих гнездах в Испанском море.',2023,'Лабиринт','Роберт Стивенсон',270,'7f05a43a-f712-49b2-8b20-3593ad184652',0,0),(7,'Горе от ума','\"Горе от ума\" - шедевр русской литературы, произведение, раздерганное на цитаты и крылатые фразы чуть не от первого до последнего слова. \"Собрать бы книги все да сжечь\", \"карету мне, карету\", \"в деревню, к тетке, в глушь, в Саратов\", \"она к нему - а он ко мне\"… Мы используем фразы из \"Горя от ума\" настолько часто, что даже не осознаем, что это - цитаты. Не потому ли горькая, язвительная и блестящая комедия Грибоедова по-прежнему актуальна и по сей день не сходит с лучших театральных сцен нашей страны?',2022,'АСТ','Александр Грибоедов',256,'37ae80b7-1cbc-44ac-b4cf-c291f85bbb1c',0,0);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_genres`
--

DROP TABLE IF EXISTS `books_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_genres` (
  `book_id` int(11) DEFAULT NULL,
  `genre_id` int(11) DEFAULT NULL,
  KEY `fk_books_genres_book_id_books` (`book_id`),
  KEY `fk_books_genres_genre_id_genres` (`genre_id`),
  CONSTRAINT `fk_books_genres_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `fk_books_genres_genre_id_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_genres`
--

LOCK TABLES `books_genres` WRITE;
/*!40000 ALTER TABLE `books_genres` DISABLE KEYS */;
INSERT INTO `books_genres` VALUES (2,7),(3,4),(4,8),(5,3),(6,2),(7,3),(7,2);
/*!40000 ALTER TABLE `books_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_genres_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (4,'Драма'),(3,'Комедия'),(7,'Мистика'),(9,'Научная фантастика'),(2,'Приключения'),(8,'Романтика'),(10,'Триллер'),(6,'Ужасы'),(5,'Фэнтези'),(1,'Экшен');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` varchar(256) NOT NULL,
  `file_name` varchar(256) NOT NULL,
  `mime_type` varchar(256) NOT NULL,
  `md5_hash` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_images_md5_hash` (`md5_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES ('3116e09e-177d-43e2-b0d4-efd191db237a','3116e09e-177d-43e2-b0d4-efd191db237a.webp','image/webp','b35534ce473e738cd210d4eed63e410c'),('37ae80b7-1cbc-44ac-b4cf-c291f85bbb1c','37ae80b7-1cbc-44ac-b4cf-c291f85bbb1c.png','image/png','0a1ce0334f6c083b21b076e98c4d6779'),('439369f8-4005-4a3f-af84-abf991761396','439369f8-4005-4a3f-af84-abf991761396.jpg','image/jpeg','cab79a5a6e4597e0f3c4af58dff584b2'),('626c79fb-4030-4de3-a877-dca7d0b1b7c9','626c79fb-4030-4de3-a877-dca7d0b1b7c9.jpg','image/jpeg','10fdd6e9b47f525a5cf6605e2ddcc8e3'),('7f05a43a-f712-49b2-8b20-3593ad184652','7f05a43a-f712-49b2-8b20-3593ad184652.png','image/png','16effc9c97eb31572c42b9ae1d9b55f4'),('90825d82-ebb3-4127-8c67-19a0c7ed8344','90825d82-ebb3-4127-8c67-19a0c7ed8344.jfif','image/jpeg','627a9623f19d5acfdea7989f222518c6'),('b07c70f8-221a-4c63-9a28-a30f6148fa71','b07c70f8-221a-4c63-9a28-a30f6148fa71.jfif','image/jpeg','65083336b025c04e4a88385ceaac363f'),('bc83d91c-d419-452a-97b0-1f3084fc1725','bc83d91c-d419-452a-97b0-1f3084fc1725.jpg','image/jpeg','1074864dbd5261dccb05814d7606e1f5');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `last_book_visits`
--

DROP TABLE IF EXISTS `last_book_visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `last_book_visits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_last_book_visits_book_id_books` (`book_id`),
  KEY `fk_last_book_visits_user_id_users` (`user_id`),
  CONSTRAINT `fk_last_book_visits_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `fk_last_book_visits_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `last_book_visits`
--

LOCK TABLES `last_book_visits` WRITE;
/*!40000 ALTER TABLE `last_book_visits` DISABLE KEYS */;
INSERT INTO `last_book_visits` VALUES (2,3,2,'2024-06-10 16:42:58');
/*!40000 ALTER TABLE `last_book_visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_reviews_book_id_books` (`book_id`),
  KEY `fk_reviews_user_id_users` (`user_id`),
  CONSTRAINT `fk_reviews_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `fk_reviews_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (2,2,2,4,'нравится данная книга, советую','2024-06-10 16:48:13'),(3,3,3,5,'Классная книга','2024-06-12 15:50:18');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','суперпользователь, имеет полный доступ к системе, в том числе к созданию и удалению книг'),(2,'moderator','может редактировать данные книг и производить модерацию рецензий'),(3,'user','может оставлять рецензии');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(256) NOT NULL,
  `password_hash` varchar(256) NOT NULL,
  `last_name` varchar(256) NOT NULL,
  `first_name` varchar(256) NOT NULL,
  `middle_name` varchar(256) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_login` (`login`),
  KEY `fk_users_role_id_roles` (`role_id`),
  CONSTRAINT `fk_users_role_id_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user','1bfae3cd5d988f9cd078332c75fdfc96d2454133489d91435ecab4453973e16e','Иванов','Иван',NULL,3),(2,'Timur','scrypt:32768:8:1$vbNflDA7nd2L6Phl$4735dbcd46e2180900c2bfa74934e8c09223c7550b2e9171236f32faa1bf7b967ad35d86d228e125149769c4e0dab125b25073748a754cb37edc33341178727d','Барателия','Тимур',NULL,2),(3,'Tim','scrypt:32768:8:1$rIAejPmtyzdSH0QJ$8573046cf0247589142773dd418e1e676db0a273cb3291442b3c1eaec076f8183330bb8d19ee3feb04f8ccf4ec44307baba3ac216b6cc8b183db3cc7b1852040','Баратели','Тимур',NULL,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-12 19:56:01
