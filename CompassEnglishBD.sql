-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: compassenglishbd
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `custom_card`
--

DROP TABLE IF EXISTS `custom_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `level` enum('BEGINNER','INTERMEDIATE','ADVANCED') DEFAULT NULL,
  `word_eng` varchar(255) NOT NULL,
  `word_spa` varchar(255) NOT NULL,
  `theme_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKa4l0ygsb1xtp5p8tkh3d5i0gw` (`theme_id`),
  KEY `FKit20nl3jcmf6j0k73eq53v0un` (`user_id`),
  CONSTRAINT `FKa4l0ygsb1xtp5p8tkh3d5i0gw` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`Id`),
  CONSTRAINT `FKit20nl3jcmf6j0k73eq53v0un` FOREIGN KEY (`user_id`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_card`
--

LOCK TABLES `custom_card` WRITE;
/*!40000 ALTER TABLE `custom_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customcard`
--

DROP TABLE IF EXISTS `customcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customcard` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `WordSpa` varchar(100) NOT NULL,
  `WordEng` varchar(100) NOT NULL,
  `ThemeId` int(11) DEFAULT NULL,
  `Level` enum('BEGINNER','INTERMEDIATE','ADVANCED') NOT NULL DEFAULT 'BEGINNER',
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `Notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `UserId` (`UserId`),
  KEY `ThemeId` (`ThemeId`),
  CONSTRAINT `customcard_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `customcard_ibfk_2` FOREIGN KEY (`ThemeId`) REFERENCES `theme` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customcard`
--

LOCK TABLES `customcard` WRITE;
/*!40000 ALTER TABLE `customcard` DISABLE KEYS */;
INSERT INTO `customcard` VALUES (2,22,'España','Spain',NULL,'INTERMEDIATE','2026-05-03 16:09:46','Yo'),(3,22,'botella','bottle',NULL,'INTERMEDIATE','2026-05-03 16:15:02','awita pa beber'),(4,22,'tarta','cake',34,'BEGINNER','2026-05-03 16:31:00','Rico'),(6,22,'mesa','table',NULL,'BEGINNER','2026-05-03 16:34:10','Para sentarse'),(7,22,'comida','food',NULL,'BEGINNER','2026-05-04 00:03:35','Ta rica'),(8,24,'magia','magic',NULL,'BEGINNER','2026-05-06 04:56:11','La magia e una cosa'),(9,22,'clase','class',NULL,'INTERMEDIATE','2026-05-08 04:34:43','hola');
/*!40000 ALTER TABLE `customcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fill_gap_exercise`
--

DROP TABLE IF EXISTS `fill_gap_exercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fill_gap_exercise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer` varchar(255) NOT NULL,
  `category` enum('Vocabulary','Grammar','Context') DEFAULT NULL,
  `level` enum('BEGINNER','INTERMEDIATE','ADVANCED') DEFAULT NULL,
  `phrase_eng` varchar(400) NOT NULL,
  `phrase_spa` varchar(400) DEFAULT NULL,
  `word_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK40u9wj7namcr8oed6o9j35iu9` (`word_id`),
  CONSTRAINT `FK40u9wj7namcr8oed6o9j35iu9` FOREIGN KEY (`word_id`) REFERENCES `word` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fill_gap_exercise`
--

LOCK TABLES `fill_gap_exercise` WRITE;
/*!40000 ALTER TABLE `fill_gap_exercise` DISABLE KEYS */;
/*!40000 ALTER TABLE `fill_gap_exercise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fillgapexercise`
--

DROP TABLE IF EXISTS `fillgapexercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fillgapexercise` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `WordId` int(11) NOT NULL,
  `PhraseEng` varchar(400) NOT NULL,
  `PhraseSpa` varchar(400) DEFAULT NULL,
  `Answer` varchar(100) NOT NULL,
  `Level` enum('BEGINNER','INTERMEDIATE','ADVANCED') NOT NULL DEFAULT 'BEGINNER',
  `Category` enum('Vocabulary','Grammar','Context') NOT NULL DEFAULT 'Vocabulary',
  `AlternativeAnswers` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `idx_fillgap_word` (`WordId`),
  KEY `idx_fillgap_level` (`Level`),
  CONSTRAINT `fillgapexercise_ibfk_1` FOREIGN KEY (`WordId`) REFERENCES `word` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fillgapexercise`
--

LOCK TABLES `fillgapexercise` WRITE;
/*!40000 ALTER TABLE `fillgapexercise` DISABLE KEYS */;
INSERT INTO `fillgapexercise` VALUES (7,15,'The ___ is barking at the door.','El ___ está ladrando en la puerta.','dog','BEGINNER','Vocabulary',NULL),(8,16,'My ___ sleeps all day on the sofa.','Mi ___ duerme todo el día en el sofá.','cat','BEGINNER','Vocabulary',NULL),(9,25,'She eats an ___ every morning.','Ella come una ___ cada mañana.','apple','BEGINNER','Vocabulary',NULL),(10,20,'The traffic light is ___.','El semáforo es ___.','red','BEGINNER','Vocabulary',NULL),(11,30,'I like to ___ in the park every morning.','Me gusta ___ en el parque cada mañana.','run','INTERMEDIATE','Vocabulary',NULL),(12,35,'___ it was cold, she went for a run.','___ hacía frío, salió a correr.','Although','INTERMEDIATE','Grammar',NULL),(13,36,'The film was long. ___, it was very interesting.','La película era larga. ___, era muy interesante.','However','INTERMEDIATE','Grammar',NULL),(14,37,'It was raining, ___ we stayed at home.','Llovía, ___ nos quedamos en casa.','therefore','INTERMEDIATE','Grammar',NULL),(15,38,'___ I was cooking, she was reading.','___ yo cocinaba, ella leía.','While','INTERMEDIATE','Grammar',NULL),(16,39,'The hotel was cheap. ___, the location was perfect.','El hotel era barato. ___, la ubicación era perfecta.','Furthermore','INTERMEDIATE','Grammar',NULL),(17,40,'___ it is difficult, I will try.','___ sea difícil, lo intentaré.','Even if','INTERMEDIATE','Grammar',NULL),(18,41,'He looks young. ___, he is 40 years old.','Parece joven. ___, tiene 40 años.','In fact','INTERMEDIATE','Grammar',NULL),(19,42,'I don’t like tea. ___, I prefer coffee.','No me gusta el té. ___, prefiero el café.','Instead','INTERMEDIATE','Grammar',NULL),(20,43,'It was late, ___ we left.','Era tarde, ___ nos fuimos.','that is why','INTERMEDIATE','Grammar',NULL),(21,44,'___ the rain, we went out.','___ la lluvia, salimos.','Despite','INTERMEDIATE','Grammar',NULL),(22,45,'He didn’t study. ___, he failed the exam.','No estudió. ___, suspendió el examen.','Consequently','INTERMEDIATE','Grammar',NULL),(23,46,'She is bilingual, ___ she speaks two languages.','Es bilingüe, ___ habla dos idiomas.','that is','INTERMEDIATE','Grammar',NULL),(24,47,'The job is hard. ___, it pays well.','El trabajo es duro. ___, paga bien.','On the other hand','INTERMEDIATE','Grammar',NULL),(25,48,'___ we tried.','___ lo intentamos.','At least','INTERMEDIATE','Grammar',NULL),(26,49,'It was raining. ___, we went out.','Llovía. ___, salimos.','Anyway','INTERMEDIATE','Grammar',NULL),(27,50,'I like to ___ before going to bed.','Me gusta ___ antes de dormir.','read','BEGINNER','Vocabulary',NULL),(28,51,'She can ___ very well.','Ella sabe ___ muy bien.','draw','BEGINNER','Vocabulary',NULL),(29,52,'They ___ in the choir every Sunday.','Ellos ___ en el coro cada domingo.','sing','BEGINNER','Vocabulary',NULL),(30,53,'We ___ at parties.','Nosotros ___ en las fiestas.','dance','BEGINNER','Vocabulary',NULL),(31,54,'Children ___ in the park.','Los niños ___ en el parque.','play','BEGINNER','Vocabulary',NULL),(32,55,'I ___ in my notebook every day.','Yo ___ en mi cuaderno cada día.','write','BEGINNER','Vocabulary',NULL),(33,30,'He ___ every morning.','Él ___ cada mañana.','run','BEGINNER','Vocabulary',NULL),(34,57,'We ___ in the sea during summer.','Nosotros ___ en el mar en verano.','swim','BEGINNER','Vocabulary',NULL),(35,58,'They ___ to different countries.','Ellos ___ a diferentes países.','travel','BEGINNER','Vocabulary',NULL),(36,59,'She ___ English at school.','Ella ___ inglés en la escuela.','study','BEGINNER','Vocabulary',NULL),(37,60,'The ___ works in a hospital.','El ___ trabaja en un hospital.','doctor','BEGINNER','Vocabulary',NULL),(38,61,'The ___ explains the lesson.','El ___ explica la lección.','teacher','BEGINNER','Vocabulary',NULL),(39,62,'The ___ designs bridges.','El ___ diseña puentes.','engineer','INTERMEDIATE','Vocabulary',NULL),(43,66,'The ___ cooks in a restaurant.','El ___ cocina en un restaurante.','chef','BEGINNER','Vocabulary',NULL),(46,69,'The ___ protects people.','El ___ protege a la gente.','police officer','BEGINNER','Vocabulary',NULL),(47,70,'It will ___ tomorrow.','Va a ___ mañana.','rain','BEGINNER','Vocabulary',NULL),(48,71,'It is ___ today.','Hoy está ___.','sunny','BEGINNER','Vocabulary',NULL),(52,75,'It can ___ in winter.','Puede ___ en invierno.','snow','BEGINNER','Vocabulary',NULL),(53,76,'The ___ is intense in summer.','El ___ es intenso en verano.','heat','BEGINNER','Vocabulary',NULL),(54,77,'It is very ___.','Hace mucho ___.','cold','BEGINNER','Vocabulary',NULL),(55,78,'The ___ is changing.','El ___ está cambiando.','weather','BEGINNER','Vocabulary',NULL),(57,202,'The ___ blew the whistle and stopped the match.','El árbitro pitó y paró el partido.','referee','BEGINNER','Vocabulary',NULL),(58,202,'All players must follow the ___ \'s decisions.','Todos los jugadores deben seguir las decisiones del árbitro.','referee','BEGINNER','Context',NULL),(59,203,'The final score was 1-1, so the match ended in a ___.','El marcador final fue 1-1, así que el partido acabó en empate.','draw','BEGINNER','Vocabulary',NULL),(60,203,'A ___ means both teams share the same number of points.','Un empate significa que ambos equipos comparten los mismos puntos.','draw','BEGINNER','Context',NULL),(61,204,'He suffered a knee ___ and missed three weeks of training.','Sufrió una lesión en la rodilla y se perdió tres semanas.','injury','BEGINNER','Vocabulary',NULL),(62,204,'The player left the field after the ___  was confirmed by doctors.','El jugador abandonó el campo tras confirmar la lesión los médicos.','injury','BEGINNER','Context',NULL),(63,205,'The ___ gave the team instructions at half-time.','El entrenador dio instrucciones al equipo en el descanso.','coach','BEGINNER','Vocabulary',NULL),(64,205,'A good ___ motivates players even after a heavy defeat.','Un buen entrenador motiva a los jugadores incluso tras una gran derrota.','coach','BEGINNER','Context',NULL),(65,206,'The ___ dived to the right and saved the penalty.','El portero se lanzó a la derecha y paró el penalti.','goalkeeper','BEGINNER','Vocabulary',NULL),(66,206,'A ___ who commands the area gives confidence to the whole defence.','Un portero que manda en el área da confianza a toda la defensa.','goalkeeper','BEGINNER','Context',NULL),(67,207,'Thousands of ___s packed the stadium for the final.','Miles de aficionados llenaron el estadio para la final.','fans','BEGINNER','Vocabulary',NULL),(68,207,'A loyal ___ supports the team regardless of the result.','Un aficionado fiel apoya al equipo independientemente del resultado.','fan','BEGINNER','Context',NULL),(69,208,'She ran the 400 metres in a new ___ of 51 seconds.','Corrió los 400 metros en una nueva marca personal de 51 segundos.','personal best','BEGINNER','Vocabulary',NULL),(70,208,'Every athlete tries to beat their ___ each season.','Todo atleta intenta superar su marca personal cada temporada.','personal best','BEGINNER','Context',NULL),(71,209,'Sixteen clubs competed in the national ___ last spring.','Dieciséis clubes compitieron en el torneo nacional la pasada primavera.','tournament','INTERMEDIATE','Vocabulary',NULL),(72,209,'The ___ was decided on penalties after extra time.','El torneo se decidió en los penaltis después de la prórroga.','tournament','INTERMEDIATE','Context',NULL),(73,210,'They need one more win to ___ for the semi-finals.','Necesitan una victoria más para clasificarse para las semifinales.','qualify','INTERMEDIATE','Vocabulary',NULL),(74,210,'Only the top two teams in each group will ___.','Solo los dos primeros de cada grupo se clasificarán.','qualify','INTERMEDIATE','Context',NULL),(75,211,'The linesman flagged because the striker was clearly ___.','El linier levantó la bandera porque el delantero estaba claramente en fuera de juego.','offside','INTERMEDIATE','Vocabulary',NULL),(76,211,'The ___ rule requires the attacker to be behind the last defender when the ball is played.','La regla del fuera de juego exige que el atacante esté detrás del último defensor cuando se juega el balón.','offside','INTERMEDIATE','Context',NULL),(77,212,'He launched a final ___ in the last 100 metres and won the race.','Lanzó un esprint final en los últimos 100 metros y ganó la carrera.','sprint','BEGINNER','Vocabulary',NULL),(78,212,'Cyclists save their energy for a decisive ___ at the finish line.','Los ciclistas guardan energía para un esprint decisivo en la meta.','sprint','BEGINNER','Context',NULL),(79,213,'She climbed onto the ___ to collect her gold medal.','Subió al podio para recoger su medalla de oro.','podium','INTERMEDIATE','Vocabulary',NULL),(80,213,'Standing on the Olympic ___ is the dream of every athlete.','Subir al podio olímpico es el sueño de todo atleta.','podium','INTERMEDIATE','Context',NULL),(81,214,'His powerful ___ hit the crossbar and stayed out.','Su potente remate golpeó el larguero y no entró.','shot on goal','ADVANCED','Vocabulary',NULL),(82,214,'The goalkeeper had no chance with that precise ___ into the top corner.','El portero no tuvo opción ante ese remate preciso a la escuadra.','shot on goal','ADVANCED','Context',NULL),(83,215,'He helped his injured opponent off the field, showing excellent ___.','Ayudó al rival lesionado a salir del campo, mostrando una excelente deportividad.','sportsmanship','ADVANCED','Vocabulary',NULL),(84,215,'True ___ means accepting defeat with dignity.','La verdadera deportividad significa aceptar la derrota con dignidad.','sportsmanship','ADVANCED','Context',NULL),(85,216,'The manager named a twenty-three-player ___ for the World Cup.','El seleccionador nombró una convocatoria de veintitrés jugadores para el Mundial.','squad','ADVANCED','Vocabulary',NULL),(86,216,'Two veterans were dropped from the ___ due to poor form.','Dos veteranos fueron descartados de la convocatoria por su mal rendimiento.','squad','ADVANCED','Context',NULL),(87,217,'The ___ raised his flag to signal a foul near the touchline.','El árbitro de línea levantó la bandera para señalar una falta cerca de la banda.','linesman','INTERMEDIATE','Vocabulary',NULL),(88,217,'The ___ and the main referee discussed the incident before making a decision.','El árbitro de línea y el árbitro principal discutieron el incidente antes de tomar una decisión.','linesman','INTERMEDIATE','Context',NULL),(89,218,'The Kenyan runner broke the marathon ___ by twelve seconds.','El corredor keniano batió el récord mundial de maratón por doce segundos.','world record','BEGINNER','Vocabulary',NULL),(90,218,'Setting a ___ requires years of hard training and perfect conditions.','Establecer un récord mundial requiere años de duro entrenamiento y condiciones perfectas.','world record','BEGINNER','Context',NULL),(91,219,'Her outstanding ___ includes four Grand Slam titles.','Su sobresaliente palmarés incluye cuatro títulos de Grand Slam.','track record','ADVANCED','Vocabulary',NULL),(92,219,'Clubs always study a coach\'s ___ before offering him a contract.','Los clubes siempre estudian el palmarés de un entrenador antes de ofrecerle un contrato.','track record','ADVANCED','Context',NULL),(93,220,'He ___ his ankle in the final training session before the match.','Se lesionó el tobillo en el último entrenamiento antes del partido.','got injured','INTERMEDIATE','Vocabulary',NULL),(94,220,'Several key players ___ during the pre-season tour.','Varios jugadores clave se lesionaron durante la gira de pretemporada.','got injured','INTERMEDIATE','Context',NULL),(95,221,'The Jamaican ___ won the 100 metres in under ten seconds.','El velocista jamaicano ganó los 100 metros en menos de diez segundos.','sprinter','INTERMEDIATE','Vocabulary',NULL),(96,221,'A ___ needs explosive power in the first thirty metres of the race.','Un velocista necesita potencia explosiva en los primeros treinta metros de la carrera.','sprinter','INTERMEDIATE','Context',NULL),(97,222,'He curled the ___ over the wall and into the top corner.','Enroscó el tiro libre por encima de la barrera y a la escuadra.','free kick','BEGINNER','Vocabulary',NULL),(98,222,'A direct ___ awarded inside the penalty area can lead to a goal.','Un tiro libre directo concedido dentro del área puede suponer un gol.','free kick','BEGINNER','Context',NULL),(99,223,'The sprinter received a ___ for a false start.','El velocista recibió una descalificación por una salida falsa.','disqualification','ADVANCED','Vocabulary',NULL),(100,223,'Doping leads to immediate ___ and can end a career.','El dopaje conlleva la descalificación inmediata y puede acabar con una carrera.','disqualification','ADVANCED','Context',NULL),(101,224,'The ___ s cheered loudly when the home side scored.','Los aficionados locales animaron fuerte cuando el equipo local marcó.','home fans','INTERMEDIATE','Vocabulary',NULL),(102,224,'Playing in front of ___ s gives a team a psychological advantage.','Jugar ante aficionados locales da a un equipo una ventaja psicológica.','home fans','INTERMEDIATE','Context',NULL),(103,225,'The match remained level after ninety minutes and went to ___.','El partido seguía igualado tras noventa minutos y se fue a la prórroga.','extra time','INTERMEDIATE','Vocabulary',NULL),(104,225,'During ___ both teams were exhausted but unwilling to concede.','Durante la prórroga ambos equipos estaban agotados pero no querían encajar.','extra time','INTERMEDIATE','Context',NULL),(105,226,'The ___ did not reflect how closely the teams had competed.','El tanteo no reflejó lo igualado que había sido el partido.','scoreline','ADVANCED','Vocabulary',NULL),(106,226,'Despite the heavy ___ the losing team refused to give up.','A pesar del tanteo abultado, el equipo perdedor se negó a rendirse.','scoreline','ADVANCED','Context',NULL),(107,227,'The champion landed a ___ in the fifth round to end the fight.','El campeón asestó el golpe definitivo en el quinto asalto para acabar el combate.','knockout blow','ADVANCED','Vocabulary',NULL),(108,227,'That ___ sent the challenger crashing to the canvas.','Ese golpe definitivo mandó al aspirante al suelo.','knockout blow','ADVANCED','Context',NULL),(109,228,'The referee asked the players to stop kicking the ___ out of play.','El árbitro pidió a los jugadores que dejaran de sacar el balón fuera.','ball','BEGINNER','Vocabulary',NULL),(110,228,'He controlled the ___ with his chest before shooting.','Controló el balón con el pecho antes de disparar.','ball','BEGINNER','Context',NULL),(111,229,'The striker sent the ball into the back of the ___.','El delantero mandó el balón al fondo de la portería.','goal','BEGINNER','Vocabulary',NULL),(112,229,'The goalkeeper stood firm and defended his ___ for ninety minutes.','El portero se mantuvo firme y defendió su portería durante noventa minutos.','goal','BEGINNER','Context',NULL),(113,230,'The home team suffered a 5-0 ___ in front of their own supporters.','El equipo local sufrió una paliza de 5-0 ante sus propios aficionados.','thrashing','INTERMEDIATE','Vocabulary',NULL),(114,230,'That ___ prompted the club to sack the manager immediately.','Esa paliza llevó al club a despedir al entrenador de inmediato.','thrashing','INTERMEDIATE','Context',NULL),(115,231,'Only eight teams remained after the first ___.','Solo ocho equipos quedaban tras la primera ronda eliminatoria.','knockout round','ADVANCED','Vocabulary',NULL),(116,231,'Every match in a ___ is winner-takes-all.','Cada partido en una ronda eliminatoria lo es todo para el ganador.','knockout round','ADVANCED','Context',NULL),(117,232,'Please put the milk back in the ___ before it turns sour.','Por favor, mete la leche en la nevera antes de que se agríe.','fridge','BEGINNER','Vocabulary',NULL),(118,232,'Always keep seafood in the ___ to prevent bacteria from growing.','Guarda siempre el marisco en la nevera para evitar que crezcan bacterias.','fridge','BEGINNER','Context',NULL),(119,233,'She followed her grandmother\'s ___ to bake the perfect apple pie.','Siguió la receta de su abuela para hornear el pastel de manzana perfecto.','recipe','BEGINNER','Vocabulary',NULL),(120,233,'This ___ serves four people and takes only thirty minutes to prepare.','Esta receta es para cuatro personas y tarda solo treinta minutos en prepararse.','recipe','BEGINNER','Context',NULL),(121,234,'You need to ___ the pasta for ten minutes before draining it.','Hay que hervir la pasta diez minutos antes de escurrirla.','boil','BEGINNER','Vocabulary',NULL),(122,234,'___ the eggs for six minutes if you prefer a soft yolk.','Hierve los huevos seis minutos si prefieres la yema blanda.','boil','BEGINNER','Context','boiled'),(123,235,'I would like the salmon ___, please, not fried.','Me gustaría el salmón a la plancha, por favor, no frito.','grilled','BEGINNER','Vocabulary',NULL),(124,235,'___ chicken retains more protein than deep-fried chicken.','El pollo a la plancha conserva más proteínas que el pollo frito.','grilled','BEGINNER','Context',NULL),(125,236,'The coastal restaurant is famous for its fresh ___ platter.','El restaurante costero es famoso por su tabla de mariscos frescos.','seafood','BEGINNER','Vocabulary',NULL),(126,236,'People with shellfish allergies must avoid all ___ dishes.','Las personas alérgicas deben evitar todos los platos de mariscos.','seafood','BEGINNER','Context',NULL),(127,237,'She loves to ___ sourdough bread every Sunday morning.','Le encanta hornear pan de masa madre cada domingo por la mañana.','bake','BEGINNER','Vocabulary',NULL),(128,237,'___ the cake at 180 degrees for forty minutes until golden.','Hornea el bizcocho a 180 grados durante cuarenta minutos hasta que esté dorado.','bake','BEGINNER','Context','baked'),(129,238,'Try not to ___ between meals if you want to lose weight.','Intenta no picar entre horas si quieres adelgazar.','snack','BEGINNER','Vocabulary',NULL),(130,238,'She prefers to ___ on nuts and fruit rather than crisps.','Prefiere picar frutos secos y fruta en lugar de patatas fritas.','snack','BEGINNER','Context',NULL),(131,239,'We ordered soup as a ___ before the main course arrived.','Pedimos sopa como entrante antes de que llegara el plato principal.','starter','BEGINNER','Vocabulary','appetizer'),(132,239,'The ___ was so delicious that we almost forgot to save room for the main.','El entrante fue tan delicioso que casi olvidamos guardar hueco para el principal.','starter','BEGINNER','Context','appetizer'),(133,240,'Add more ___ to taste before you serve the stew.','Añade más condimento al gusto antes de servir el estofado.','seasoning','INTERMEDIATE','Vocabulary',NULL),(134,240,'The chef prepared a secret ___ blend that gave the dish its unique flavour.','El chef preparó una mezcla secreta de condimentos que le daba al plato su sabor único.','seasoning','INTERMEDIATE','Context',NULL),(135,241,'The label must list every ___ present in the product by law.','La ley exige que la etiqueta liste cada alérgeno presente en el producto.','allergen','ADVANCED','Vocabulary',NULL),(136,241,'Peanuts are a common ___ that can cause life-threatening reactions.','Los cacahuetes son un alérgeno común que puede causar reacciones potencialmente mortales.','allergen','ADVANCED','Context',NULL),(137,242,'We had yesterday\'s dinner ___ for lunch to avoid wasting food.','Comimos las sobras de la cena del día anterior para no desperdiciar comida.','leftovers','INTERMEDIATE','Vocabulary',NULL),(138,242,'___ can be stored safely in an airtight container in the fridge for three days.','Las sobras se pueden guardar en un recipiente hermético en la nevera durante tres días.','leftovers','INTERMEDIATE','Context',NULL),(139,243,'Leave the avocado at room temperature to ___ for two days.','Deja el aguacate a temperatura ambiente para que madure durante dos días.','ripen','INTERMEDIATE','Vocabulary','ripened'),(140,243,'Bananas ___ faster when kept next to other fruit in the fruit bowl.','Los plátanos maduran más rápido si se guardan junto a otras frutas.','ripen','INTERMEDIATE','Context','ripened'),(141,244,'She had a sudden ___ for chocolate ice cream at midnight.','Le entró un antojo repentino de helado de chocolate a medianoche.','craving','INTERMEDIATE','Vocabulary',NULL),(142,244,'Pregnancy can cause unusual food ___s that are hard to explain.','El embarazo puede causar antojos de comida poco habituales que son difíciles de explicar.','cravings','INTERMEDIATE','Context',NULL),(143,245,'Do you have any ___ bread on the menu for coeliacs?','¿Tienen pan sin gluten en el menú para celíacos?','gluten-free','INTERMEDIATE','Vocabulary',NULL),(144,245,'More supermarkets now stock a full range of ___ products.','Más supermercados ofrecen ahora una gama completa de productos sin gluten.','gluten-free','INTERMEDIATE','Context',NULL),(145,246,'Always check the ___ before buying dairy products at the supermarket.','Comprueba siempre la fecha de caducidad antes de comprar lácteos en el supermercado.','expiry date','INTERMEDIATE','Vocabulary',NULL),(146,246,'Never consume food past its ___ as it can make you ill.','Nunca consumas alimentos pasada su fecha de caducidad ya que pueden hacerte enfermar.','expiry date','INTERMEDIATE','Context',NULL),(147,247,'___ is estimated to cost the UK economy twelve billion pounds every year.','Se estima que el desperdicio alimentario le cuesta a la economía del Reino Unido doce mil millones de libras al año.','food waste','ADVANCED','Vocabulary',NULL),(148,247,'Meal planning is one of the most effective ways to reduce ___.','La planificación de menús es una de las formas más eficaces de reducir el desperdicio alimentario.','food waste','ADVANCED','Context',NULL),(149,248,'___ is the natural process that turns grape juice into wine.','La fermentación es el proceso natural que convierte el zumo de uva en vino.','fermentation','ADVANCED','Vocabulary',NULL),(150,248,'Yogurt is produced through the ___ of milk by beneficial bacteria.','El yogur se produce mediante la fermentación de la leche por bacterias beneficiosas.','fermentation','ADVANCED','Context',NULL),(151,249,'Pour the golden ___ over the warm pancakes before serving.','Vierte el almíbar dorado sobre los crepes calientes antes de servir.','syrup','INTERMEDIATE','Vocabulary',NULL),(152,249,'The cocktail recipe calls for a measure of sugar ___.','La receta del cóctel requiere una medida de almíbar de azúcar.','syrup','INTERMEDIATE','Context',NULL),(153,250,'The hotel\'s ___ breakfast includes eggs, toast and fresh fruit.','El desayuno buffet libre del hotel incluye huevos, tostadas y fruta fresca.','all-you-can-eat','INTERMEDIATE','Vocabulary',NULL),(154,250,'Children under five eat for free at our ___ restaurant.','Los niños menores de cinco años comen gratis en nuestro restaurante buffet libre.','all-you-can-eat','INTERMEDIATE','Context',NULL),(155,251,'Be careful, the curry is very ___ and may cause discomfort.','Ten cuidado, el curry es muy picante y puede causar malestar.','spicy','BEGINNER','Vocabulary',NULL),(156,251,'She prefers mild sauces because she cannot tolerate ___ food.','Prefiere las salsas suaves porque no tolera la comida picante.','spicy','BEGINNER','Context',NULL),(157,252,'The chef sliced the ___ fish thinly to make sashimi.','El chef cortó el pescado crudo en finas lonchas para hacer sashimi.','raw','BEGINNER','Vocabulary',NULL),(158,252,'Eating ___ chicken is dangerous and can cause food poisoning.','Comer pollo crudo es peligroso y puede causar intoxicación alimentaria.','raw','BEGINNER','Context',NULL),(159,253,'A ___ can reduce the cooking time of legumes by half.','Una olla a presión puede reducir el tiempo de cocción de las legumbres a la mitad.','pressure cooker','INTERMEDIATE','Vocabulary',NULL),(160,253,'She cooked the lamb shanks in a ___ for just forty minutes.','Cocinó el jarrete de cordero en una olla a presión durante solo cuarenta minutos.','pressure cooker','INTERMEDIATE','Context',NULL),(161,254,'Leave the chicken in the ___ overnight to absorb all the flavours.','Deja el pollo en la marinada toda la noche para que absorba todos los sabores.','marinade','INTERMEDIATE','Vocabulary',NULL),(162,254,'A good ___ usually contains an acid, an oil and aromatic herbs.','Una buena marinada suele contener un ácido, un aceite y hierbas aromáticas.','marinade','INTERMEDIATE','Context',NULL),(163,255,'Strawberries are only available during their natural ___.','Las fresas solo están disponibles durante su temporada natural.','season','BEGINNER','Vocabulary',NULL),(164,255,'Eating fruit in ___ is cheaper and far more flavourful.','Comer fruta de temporada es más barato y tiene mucho más sabor.','season','BEGINNER','Context',NULL),(165,256,'She simmered the chicken bones for hours to make a rich ___.','Coció los huesos de pollo durante horas para hacer un caldo rico.','broth','INTERMEDIATE','Vocabulary',NULL),(166,256,'A bowl of hot ___ is perfect for soothing a sore throat.','Un tazón de caldo caliente es perfecto para aliviar el dolor de garganta.','broth','INTERMEDIATE','Context',NULL),(167,257,'Please set the ___ on the table before the guests arrive.','Por favor, pon los cubiertos en la mesa antes de que lleguen los invitados.','cutlery','INTERMEDIATE','Vocabulary',NULL),(168,257,'The restaurant uses silver ___ for formal occasions.','El restaurante usa cubiertos de plata en las ocasiones formales.','cutlery','INTERMEDIATE','Context',NULL),(169,258,'The steak came with a ___ of roasted potatoes and green beans.','El filete venía con una guarnición de patatas asadas y judías verdes.','side dish','INTERMEDIATE','Vocabulary',NULL),(170,258,'She asked for salad as a ___ instead of chips.','Pidió ensalada como guarnición en lugar de patatas fritas.','side dish','INTERMEDIATE','Context',NULL),(171,259,'The restaurant received a devastating review from a well-known ___.','El restaurante recibió una crítica devastadora de un conocido paladeador.','food critic','ADVANCED','Vocabulary',NULL),(172,259,'A ___ evaluates the taste, presentation and service of every dish.','Un crítico gastronómico evalúa el sabor, la presentación y el servicio de cada plato.','food critic','ADVANCED','Context',NULL),(173,260,'___ is described as the fifth basic taste, distinct from sweet, sour, salty and bitter.','El umami se describe como el quinto sabor básico, distinto del dulce, ácido, salado y amargo.','umami','ADVANCED','Vocabulary',NULL),(174,260,'Mushrooms, aged cheese and soy sauce are all rich sources of ___.','Las setas, el queso curado y la salsa de soja son fuentes ricas en umami.','umami','ADVANCED','Context',NULL),(175,261,'The dessert was so ___ that I could only eat two bites.','El postre era tan empalagoso que solo pude comer dos bocados.','sickly sweet','ADVANCED','Vocabulary',NULL),(176,261,'Some energy drinks have a ___ flavour that puts many people off.','Algunas bebidas energéticas tienen un sabor empalagoso que echa para atrás a mucha gente.','sickly sweet','ADVANCED','Context',NULL),(177,262,'A violent ___ hit the coast and uprooted dozens of trees.','Una violenta tormenta azotó la costa y arrancó decenas de árboles.','storm','BEGINNER','Vocabulary',NULL),(178,262,'The ___ brought heavy rain and strong winds that lasted all night.','La tormenta trajo lluvia intensa y fuertes vientos que duraron toda la noche.','storm','BEGINNER','Context',NULL),(179,263,'It is only a light ___ so you probably don\'t need an umbrella.','Es solo una llovizna ligera así que probablemente no necesitas paraguas.','drizzle','INTERMEDIATE','Vocabulary',NULL),(180,263,'A thin ___ covered the city all morning, making the streets slippery.','Una fina llovizna cubrió la ciudad toda la mañana, poniendo las calles resbaladizas.','drizzle','INTERMEDIATE','Context',NULL),(181,264,'A cool ___ from the sea made the hot afternoon pleasant.','Una fresca brisa del mar hizo agradable la calurosa tarde.','breeze','BEGINNER','Vocabulary',NULL),(182,264,'The yacht sailed smoothly thanks to a steady ___ from the west.','El yate navegó suavemente gracias a una constante brisa del oeste.','breeze','BEGINNER','Context',NULL),(183,265,'The sudden ___ dented several cars parked in the open.','El granizo repentino abolló varios coches aparcados al aire libre.','hail','INTERMEDIATE','Vocabulary',NULL),(184,265,'Golf-ball-sized ___ is extremely rare but causes devastating damage.','El granizo del tamaño de una pelota de golf es muy raro pero causa daños devastadores.','hail','INTERMEDIATE','Context',NULL),(185,266,'Dense ___ reduced visibility to less than fifty metres on the motorway.','La densa niebla redujo la visibilidad a menos de cincuenta metros en la autopista.','fog','BEGINNER','Vocabulary',NULL),(186,266,'Flights were delayed for hours because of thick ___ at the airport.','Los vuelos se retrasaron durante horas por la espesa niebla en el aeropuerto.','fog','BEGINNER','Context',NULL),(187,267,'The region has been suffering a severe ___ for the past two summers.','La región lleva sufriendo una sequía severa durante los dos últimos veranos.','drought','INTERMEDIATE','Vocabulary',NULL),(188,267,'Water restrictions are enforced automatically whenever a ___ is declared.','Las restricciones de agua se aplican automáticamente cuando se declara una sequía.','drought','INTERMEDIATE','Context',NULL),(189,268,'A deadly ___ swept across southern Europe in early August.','Una ola de calor mortal azotó el sur de Europa a principios de agosto.','heat wave','INTERMEDIATE','Vocabulary',NULL),(190,268,'During the ___ authorities urged elderly people to stay indoors.','Durante la ola de calor las autoridades instaron a los mayores a quedarse en casa.','heat wave','INTERMEDIATE','Context',NULL),(191,269,'The weather ___ predicts heavy snow for the mountain areas tomorrow.','El pronóstico meteorológico predice nieve intensa para las zonas de montaña mañana.','forecast','BEGINNER','Vocabulary',NULL),(192,269,'Check the ___ before you plan any outdoor activities this weekend.','Consulta el pronóstico antes de planificar actividades al aire libre este fin de semana.','forecast','BEGINNER','Context',NULL),(193,270,'A bolt of ___ struck the old oak tree and split it in two.','Un rayo cayó en el viejo roble y lo partió en dos.','lightning','BEGINNER','Vocabulary',NULL),(194,270,'Never shelter under a tree during a ___ storm as it is extremely dangerous.','Nunca te refugies bajo un árbol durante una tormenta eléctrica ya que es extremadamente peligroso.','lightning','BEGINNER','Context',NULL),(195,271,'The sky was completely ___ all morning, making the light perfect for photography.','El cielo estuvo completamente nublado toda la mañana, haciendo la luz perfecta para fotografiar.','overcast','INTERMEDIATE','Vocabulary',NULL),(196,271,'An ___ day is ideal for hiking because you avoid direct sunlight.','Un día nublado es ideal para caminar porque evitas la luz solar directa.','overcast','INTERMEDIATE','Context',NULL),(197,272,'The ___ closed all mountain passes for forty-eight hours.','La ventisca cerró todos los puertos de montaña durante cuarenta y ocho horas.','blizzard','ADVANCED','Vocabulary',NULL),(198,272,'Drivers were stranded on the motorway when the ___ struck without warning.','Los conductores quedaron atrapados en la autopista cuando llegó la ventisca sin previo aviso.','blizzard','ADVANCED','Context',NULL),(199,273,'We were soaked to the skin after being caught in a sudden ___.','Quedamos empapados tras ser sorprendidos por un aguacero repentino.','downpour','ADVANCED','Vocabulary',NULL),(200,273,'A brief but intense ___ flooded the low-lying streets of the city.','Un breve pero intenso aguacero inundó las calles bajas de la ciudad.','downpour','ADVANCED','Context',NULL),(201,274,'The overnight ___ killed the tomato plants that were left outside.','La helada nocturna mató las plantas de tomate que se dejaron fuera.','frost','INTERMEDIATE','Vocabulary',NULL),(202,274,'Farmers covered their crops with plastic sheeting before the expected ___.','Los agricultores cubrieron sus cultivos con plástico antes de la helada prevista.','frost','INTERMEDIATE','Context',NULL),(203,275,'High ___ makes hot temperatures feel far more uncomfortable than they actually are.','La alta humedad hace que las temperaturas cálidas resulten mucho más incómodas de lo que realmente son.','humidity','INTERMEDIATE','Vocabulary',NULL),(204,275,'Air conditioning reduces indoor ___ significantly during summer.','El aire acondicionado reduce notablemente la humedad interior durante el verano.','humidity','INTERMEDIATE','Context',NULL),(205,276,'The ___ August weather made it impossible to sleep without a fan.','El bochornoso tiempo de agosto hacía imposible dormir sin un ventilador.','muggy','ADVANCED','Vocabulary',NULL),(206,276,'Tropical coastal regions are often ___ because of the combination of heat and moisture.','Las regiones costeras tropicales son a menudo bochornosas por la combinación de calor y humedad.','muggy','ADVANCED','Context',NULL),(207,277,'The ___ made landfall on the eastern coast with winds of two hundred kilometres per hour.','El tifón tocó tierra en la costa oriental con vientos de doscientos kilómetros por hora.','typhoon','ADVANCED','Vocabulary',NULL),(208,277,'A ___ in the Pacific Ocean is the same phenomenon as a hurricane in the Atlantic.','Un tifón en el Océano Pacífico es el mismo fenómeno que un huracán en el Atlántico.','typhoon','ADVANCED','Context',NULL),(209,278,'___ is causing more frequent and intense extreme weather events around the world.','El cambio climático está provocando fenómenos meteorológicos extremos más frecuentes e intensos en todo el mundo.','climate change','ADVANCED','Vocabulary',NULL),(210,278,'Scientists agree that human activity is the main driver of ___.','Los científicos coinciden en que la actividad humana es el principal motor del cambio climático.','climate change','ADVANCED','Context',NULL),(211,279,'A beautiful ___ appeared in the sky immediately after the storm passed.','Un hermoso arco iris apareció en el cielo justo después de que pasara la tormenta.','rainbow','BEGINNER','Vocabulary',NULL),(212,279,'You can only see a ___ when sunlight shines through rain droplets.','Solo puedes ver un arco iris cuando la luz solar brilla a través de las gotas de lluvia.','rainbow','BEGINNER','Context',NULL),(213,280,'The ___ dropped to minus fifteen degrees in the mountains overnight.','La temperatura bajó a quince grados bajo cero en las montañas durante la noche.','temperature','BEGINNER','Vocabulary',NULL),(214,280,'Body ___ rises during a fever as the immune system fights infection.','La temperatura corporal sube durante la fiebre mientras el sistema inmune combate la infección.','temperature','BEGINNER','Context',NULL),(215,281,'We enjoyed a ___ every day during our week in the Canary Islands.','Disfrutamos de un cielo despejado cada día durante nuestra semana en las Islas Canarias.','clear sky','BEGINNER','Vocabulary',NULL),(216,281,'A ___ at night is perfect for stargazing with a telescope.','Un cielo despejado de noche es perfecto para observar estrellas con un telescopio.','clear sky','BEGINNER','Context',NULL),(217,282,'The unexpected ___ destroyed a large part of this year\'s grape harvest.','La inesperada granizada destruyó gran parte de la cosecha de uva de este año.','hailstorm','ADVANCED','Vocabulary',NULL),(218,282,'The ___ lasted only ten minutes but left the streets covered in ice.','La granizada duró solo diez minutos pero dejó las calles cubiertas de hielo.','hailstorm','ADVANCED','Context',NULL),(219,283,'Low ___ usually signals the arrival of bad weather within twenty-four hours.','La baja presión atmosférica suele indicar la llegada de mal tiempo en veinticuatro horas.','atmospheric pressure','ADVANCED','Vocabulary',NULL),(220,283,'Pilots must constantly monitor ___ to ensure safe flight conditions.','Los pilotos deben monitorear constantemente la presión atmosférica para garantizar condiciones de vuelo seguras.','atmospheric pressure','ADVANCED','Context',NULL),(221,284,'She grabbed her ___ before leaving the house because rain was forecast.','Cogió su chubasquero antes de salir de casa porque se preveía lluvia.','raincoat','BEGINNER','Vocabulary',NULL),(222,284,'Always pack a ___ when visiting the north of England in autumn.','Lleva siempre un chubasquero cuando visites el norte de Inglaterra en otoño.','raincoat','BEGINNER','Context',NULL),(223,285,'A thin ___ covered the valley early in the morning before the sun rose.','Una fina neblina cubría el valle por la mañana temprano antes de que saliera el sol.','mist','INTERMEDIATE','Vocabulary',NULL),(224,285,'The hilltop was hidden in ___ and we could barely see the path ahead.','La cima de la colina estaba envuelta en neblina y apenas podíamos ver el camino.','mist','INTERMEDIATE','Context',NULL),(225,286,'The sailing race was cancelled because of a fierce ___ in the bay.','La regata se canceló por un viento huracanado en la bahía.','gale','ADVANCED','Vocabulary',NULL),(226,286,'A ___ warning was issued for the entire northern coastline.','Se emitió un aviso de viento huracanado para toda la costa norte.','gale','ADVANCED','Context',NULL),(227,287,'___ made the road markings invisible and caused several accidents.','La niebla baja hizo invisibles las marcas viales y causó varios accidentes.','low-lying fog','ADVANCED','Vocabulary',NULL),(228,287,'Airports often close when ___ reduces visibility below minimum limits.','Los aeropuertos suelen cerrar cuando la niebla baja reduce la visibilidad por debajo de los límites mínimos.','low-lying fog','ADVANCED','Context',NULL),(229,288,'Each ___ has a unique hexagonal structure that is never repeated.','Cada copo de nieve tiene una estructura hexagonal única que nunca se repite.','snowflake','BEGINNER','Vocabulary',NULL),(230,288,'The first ___ of the season fell on the mountain summit overnight.','El primer copo de nieve de la temporada cayó en la cima de la montaña durante la noche.','snowflake','BEGINNER','Context',NULL),(231,289,'Ten centimetres of ___ fell overnight, disrupting the morning commute.','Cayeron diez centímetros de nieve durante la noche, alterando los desplazamientos matutinos.','snow','BEGINNER','Vocabulary',NULL),(232,289,'Children were thrilled when they woke up to find ___ covering the garden.','Los niños se emocionaron cuando se despertaron y encontraron la nieve cubriendo el jardín.','snow','BEGINNER','Context',NULL),(233,290,'A strong ___ blew down the fence at the back of our garden.','Un fuerte viento derribó la valla en la parte trasera de nuestro jardín.','wind','BEGINNER','Vocabulary',NULL),(234,290,'The ___ turbines on the hillside generate electricity for the whole village.','Los aerogeneradores de la ladera generan electricidad para todo el pueblo.','wind','BEGINNER','Context',NULL),(235,291,'___ caused by industrial pollution has damaged forests across northern Europe.','La lluvia ácida causada por la contaminación industrial ha dañado bosques en toda Europa del norte.','acid rain','ADVANCED','Vocabulary',NULL),(236,291,'___ occurs when sulphur dioxide and nitrogen oxides react with water vapour in the atmosphere.','La lluvia ácida se produce cuando el dióxido de azufre y los óxidos de nitrógeno reaccionan con el vapor de agua.','acid rain','ADVANCED','Context',NULL),(237,292,'A ___ struck the church tower and damaged the old bell.','Un rayo cayó en la torre de la iglesia y dañó la antigua campana.','thunderbolt','INTERMEDIATE','Vocabulary',NULL),(238,292,'The hikers took shelter in a cave when a ___ hit a nearby tree.','Los senderistas se refugiaron en una cueva cuando un rayo cayó en un árbol cercano.','thunderbolt','INTERMEDIATE','Context',NULL),(239,293,'We called a ___ to fix the burst pipe under the kitchen sink.','Llamamos a un fontanero para arreglar la tubería reventada bajo el fregadero.','plumber','BEGINNER','Vocabulary',NULL),(240,293,'A ___ must be available for emergency call-outs at any time of day.','Un fontanero debe estar disponible para urgencias a cualquier hora del día.','plumber','BEGINNER','Context',NULL),(241,294,'The company hired a new ___ to manage its quarterly tax returns.','La empresa contrató a un nuevo contable para gestionar sus declaraciones trimestrales.','accountant','INTERMEDIATE','Vocabulary',NULL),(242,294,'A chartered ___ must complete years of professional exams before qualifying.','Un contable titulado debe superar años de exámenes profesionales antes de obtener la titulación.','accountant','INTERMEDIATE','Context',NULL),(243,295,'The ___ took my blood pressure and temperature before the doctor arrived.','La enfermera tomó mi tensión arterial y temperatura antes de que llegara el médico.','nurse','BEGINNER','Vocabulary',NULL),(244,295,'An intensive care ___ can be responsible for up to four critically ill patients at once.','Una enfermera de cuidados intensivos puede ser responsable de hasta cuatro pacientes críticos a la vez.','nurse','BEGINNER','Context',NULL),(245,296,'The ___ designed a stunning glass building for the city centre.','El arquitecto diseñó un impresionante edificio de cristal para el centro de la ciudad.','architect','INTERMEDIATE','Vocabulary',NULL),(246,296,'An ___ must balance aesthetic vision with strict safety regulations.','Un arquitecto debe equilibrar la visión estética con la normativa de seguridad estricta.','architect','INTERMEDIATE','Context',NULL),(247,297,'The ___ interviewed the minister live on television about the new policy.','El periodista entrevistó al ministro en directo por televisión sobre la nueva política.','journalist','INTERMEDIATE','Vocabulary',NULL),(248,297,'A war ___ risks their life every day to report from conflict zones.','Un periodista de guerra arriesga su vida cada día para informar desde zonas de conflicto.','journalist','INTERMEDIATE','Context',NULL),(249,298,'The ___ rewired the entire house in just three working days.','El electricista rewired la casa entera en solo tres días laborables.','electrician','INTERMEDIATE','Vocabulary',NULL),(250,298,'You must hire a certified ___ for any major electrical installation work.','Debes contratar a un electricista certificado para cualquier instalación eléctrica importante.','electrician','INTERMEDIATE','Context',NULL),(251,299,'She works as a ___ for an international law firm, specialising in contracts.','Trabaja como traductora en un bufete internacional, especializada en contratos.','translator','INTERMEDIATE','Vocabulary',NULL),(252,299,'A literary ___ must capture not just the meaning but also the style of the original work.','Un traductor literario debe capturar no solo el significado sino también el estilo de la obra original.','translator','INTERMEDIATE','Context',NULL),(253,300,'We took our dog to the ___ for its annual booster vaccination.','Llevamos a nuestro perro al veterinario para su vacuna de refuerzo anual.','vet','BEGINNER','Vocabulary',NULL),(254,300,'The ___ performed a minor operation on the cat under general anaesthetic.','El veterinario realizó una pequeña operación al gato bajo anestesia general.','vet','BEGINNER','Context',NULL),(255,301,'The ___ performed a complex heart bypass operation lasting seven hours.','El cirujano realizó una compleja operación de bypass cardíaco que duró siete horas.','surgeon','INTERMEDIATE','Vocabulary',NULL),(256,301,'A ___ needs years of specialist training and exceptionally steady hands.','Un cirujano necesita años de formación especializada y unas manos extraordinariamente firmes.','surgeon','INTERMEDIATE','Context',NULL),(257,302,'She sees a ___ every fortnight to manage her anxiety disorder.','Ve a un psicólogo cada dos semanas para gestionar su trastorno de ansiedad.','psychologist','INTERMEDIATE','Vocabulary',NULL),(258,302,'A sports ___ helps athletes cope with pressure and recover from setbacks.','Un psicólogo deportivo ayuda a los atletas a manejar la presión y recuperarse de los reveses.','psychologist','INTERMEDIATE','Context',NULL),(259,303,'The ___ announced that we would be landing in Madrid in twenty minutes.','El piloto anunció que aterrizaríamos en Madrid en veinte minutos.','pilot','BEGINNER','Vocabulary',NULL),(260,303,'A commercial ___ must log thousands of flying hours before captaining a passenger flight.','Un piloto comercial debe registrar miles de horas de vuelo antes de capitanear un vuelo de pasajeros.','pilot','BEGINNER','Context',NULL),(261,304,'The ___ published her groundbreaking findings in a peer-reviewed journal.','La investigadora publicó sus revolucionarios hallazgos en una revista científica revisada por expertos.','researcher','INTERMEDIATE','Vocabulary',NULL),(262,304,'A medical ___ can spend years testing a single drug before it reaches patients.','Un investigador médico puede pasar años probando un solo fármaco antes de que llegue a los pacientes.','researcher','INTERMEDIATE','Context',NULL),(263,305,'The ___ rescued an elderly woman from the second floor of the burning building.','El bombero rescató a una anciana del segundo piso del edificio en llamas.','firefighter','BEGINNER','Vocabulary',NULL),(264,305,'A ___ must stay physically fit and mentally calm under extreme pressure.','Un bombero debe mantenerse en buena forma física y mentalmente tranquilo bajo presión extrema.','firefighter','BEGINNER','Context',NULL),(265,306,'The ___ created a striking new logo for the company in just two days.','El diseñador gráfico creó un llamativo nuevo logotipo para la empresa en solo dos días.','graphic designer','INTERMEDIATE','Vocabulary',NULL),(266,306,'A ___ must balance creativity with the technical specifications of the client.','Un diseñador gráfico debe equilibrar la creatividad con las especificaciones técnicas del cliente.','graphic designer','INTERMEDIATE','Context',NULL),(267,307,'She hired a ___ to represent her in the divorce proceedings.','Contrató a un abogado para que la representara en el proceso de divorcio.','lawyer','BEGINNER','Vocabulary','solicitor|attorney'),(268,307,'The ___ advised her client not to say anything without legal representation present.','El abogado aconsejó a su cliente no decir nada sin representación legal presente.','lawyer','BEGINNER','Context','solicitor|attorney'),(269,308,'The ___ recommended a full-bodied Rioja to accompany the lamb dish.','El sommelier recomendó un Rioja con cuerpo para acompañar el plato de cordero.','sommelier','ADVANCED','Vocabulary',NULL),(270,308,'A ___ requires an exceptional palate and an encyclopaedic knowledge of wines.','Un sommelier requiere un paladar excepcional y un conocimiento enciclopédico de los vinos.','sommelier','ADVANCED','Context',NULL),(271,309,'The external ___ reviewed all company accounts and found several irregularities.','El auditor externo revisó todas las cuentas de la empresa y encontró varias irregularidades.','auditor','ADVANCED','Vocabulary',NULL),(272,309,'An ___ must remain completely independent to provide an objective financial opinion.','Un auditor debe permanecer completamente independiente para proporcionar una opinión financiera objetiva.','auditor','ADVANCED','Context',NULL),(273,310,'Her ___ recommended breathing exercises and mindfulness to reduce daily stress.','Su terapeuta recomendó ejercicios de respiración y mindfulness para reducir el estrés diario.','therapist','INTERMEDIATE','Vocabulary',NULL),(274,310,'A speech ___ works with patients who have difficulties communicating clearly.','Un logopeda trabaja con pacientes que tienen dificultades para comunicarse con claridad.','therapist','INTERMEDIATE','Context',NULL),(275,311,'An ___ uses statistical models to calculate financial risk for insurance companies.','Un actuario utiliza modelos estadísticos para calcular el riesgo financiero de las aseguradoras.','actuary','ADVANCED','Vocabulary',NULL),(276,311,'Without an ___ \'s analysis, insurance companies could not price their products accurately.','Sin el análisis de un actuario, las aseguradoras no podrían fijar sus productos con precisión.','actuary','ADVANCED','Context',NULL),(277,312,'A property ___ assessed the house before the bank agreed to the mortgage.','Un tasador valoró la casa antes de que el banco aprobara la hipoteca.','appraiser','ADVANCED','Vocabulary',NULL),(278,312,'The insurance company sent its own ___ to evaluate the damage after the flood.','La aseguradora envió a su propio tasador para evaluar los daños tras la inundación.','appraiser','ADVANCED','Context',NULL),(279,313,'The ___ coordinated the delivery of supplies across four countries simultaneously.','El responsable de logística coordinó la entrega de suministros en cuatro países simultáneamente.','logistics manager','ADVANCED','Vocabulary',NULL),(280,313,'A skilled ___ anticipates supply chain disruptions before they occur.','Un hábil responsable de logística anticipa las interrupciones de la cadena de suministro antes de que ocurran.','logistics manager','ADVANCED','Context',NULL),(281,314,'The ___ visited the family twice a week to monitor the children\'s wellbeing.','La asistente social visitaba a la familia dos veces por semana para supervisar el bienestar de los niños.','social worker','INTERMEDIATE','Vocabulary',NULL),(282,314,'A ___ must handle difficult and emotionally challenging situations every day.','Un asistente social debe afrontar situaciones difíciles y emocionalmente exigentes cada día.','social worker','INTERMEDIATE','Context',NULL),(283,315,'The ___ explained the correct dosage for each of the three medicines.','El farmacéutico explicó la dosis correcta para cada uno de los tres medicamentos.','pharmacist','INTERMEDIATE','Vocabulary',NULL),(284,315,'A hospital ___ works closely with doctors to prevent dangerous drug interactions.','Un farmacéutico hospitalario trabaja estrechamente con los médicos para prevenir interacciones farmacológicas peligrosas.','pharmacist','INTERMEDIATE','Context',NULL),(285,316,'The ___ gathered enough evidence to charge the suspect with fraud.','El detective reunió suficientes pruebas para acusar al sospechoso de fraude.','detective','INTERMEDIATE','Vocabulary',NULL),(286,316,'A private ___ is hired by individuals to investigate personal matters discreetly.','Un detective privado es contratado por particulares para investigar asuntos personales de forma discreta.','detective','INTERMEDIATE','Context',NULL),(287,317,'The ___ studied the rock formations to determine when the volcanic eruption occurred.','El geólogo estudió las formaciones rocosas para determinar cuándo ocurrió la erupción volcánica.','geologist','ADVANCED','Vocabulary',NULL),(288,317,'Oil companies employ ___s to identify underground reserves before drilling.','Las compañías petrolíferas contratan geólogos para identificar reservas subterráneas antes de perforar.','geologists','ADVANCED','Context',NULL),(289,318,'The ___ prepared the samples for analysis under the microscope.','El técnico de laboratorio preparó las muestras para su análisis bajo el microscopio.','lab technician','INTERMEDIATE','Vocabulary',NULL),(290,318,'A ___ must follow strict protocols to prevent contamination of test results.','Un técnico de laboratorio debe seguir protocolos estrictos para evitar la contaminación de los resultados.','lab technician','INTERMEDIATE','Context',NULL),(291,319,'The new ___ announced a major restructuring plan at the annual general meeting.','El nuevo director ejecutivo anunció un importante plan de reestructuración en la junta general anual.','CEO','ADVANCED','Vocabulary',NULL),(292,319,'The ___ is ultimately responsible for the strategic direction of the entire company.','El director ejecutivo es el máximo responsable de la dirección estratégica de toda la empresa.','CEO','ADVANCED','Context',NULL),(293,320,'Her ___ managed her diary and filtered all incoming calls and emails.','Su asistente personal gestionaba su agenda y filtraba todas las llamadas y correos entrantes.','personal assistant','INTERMEDIATE','Vocabulary','PA'),(294,320,'A good ___ anticipates the needs of their employer before being asked.','Un buen asistente personal anticipa las necesidades de su jefe antes de que se las pidan.','personal assistant','INTERMEDIATE','Context','PA'),(295,321,'The ___ led the group through the old city and explained the history of each monument.','El guía turístico condujo al grupo por el casco antiguo y explicó la historia de cada monumento.','tour guide','BEGINNER','Vocabulary',NULL),(296,321,'A good ___ must speak at least two foreign languages fluently.','Un buen guía turístico debe hablar al menos dos idiomas extranjeros con fluidez.','tour guide','BEGINNER','Context',NULL),(297,322,'The ___ dived into the sea and rescued the swimmer who had got into difficulty.','El socorrista se lanzó al mar y rescató al nadador que había tenido problemas.','lifeguard','BEGINNER','Vocabulary',NULL),(298,322,'Every public swimming pool must have a qualified ___ on duty at all times.','Toda piscina pública debe tener un socorrista cualificado de guardia en todo momento.','lifeguard','BEGINNER','Context',NULL),(299,323,'The head ___ created a seasonal menu using only locally sourced ingredients.','El jefe de cocina creó un menú de temporada usando solo ingredientes locales.','chef','BEGINNER','Vocabulary',NULL),(300,323,'A Michelin-starred ___ must maintain exceptional standards every single service.','Un chef con estrella Michelin debe mantener estándares excepcionales en cada servicio.','chef','BEGINNER','Context',NULL);
/*!40000 ALTER TABLE `fillgapexercise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reading_question`
--

DROP TABLE IF EXISTS `reading_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reading_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `correct_answer` varchar(255) NOT NULL,
  `optionb` varchar(255) DEFAULT NULL,
  `optionc` varchar(255) DEFAULT NULL,
  `optiond` varchar(255) DEFAULT NULL,
  `question_text` varchar(255) NOT NULL,
  `question_type` varchar(255) DEFAULT NULL,
  `reading_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK98tw96vbv6bpnvdiwrdks4d68` (`reading_id`),
  CONSTRAINT `FK98tw96vbv6bpnvdiwrdks4d68` FOREIGN KEY (`reading_id`) REFERENCES `reading_text` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reading_question`
--

LOCK TABLES `reading_question` WRITE;
/*!40000 ALTER TABLE `reading_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `reading_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reading_text`
--

DROP TABLE IF EXISTS `reading_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reading_text` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `level` enum('BEGINNER','INTERMEDIATE','ADVANCED') DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `theme_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbwyccl7troa8l17ffenejplb8` (`theme_id`),
  CONSTRAINT `FKbwyccl7troa8l17ffenejplb8` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reading_text`
--

LOCK TABLES `reading_text` WRITE;
/*!40000 ALTER TABLE `reading_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `reading_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `readingquestion`
--

DROP TABLE IF EXISTS `readingquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `readingquestion` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ReadingId` int(11) NOT NULL,
  `QuestionText` varchar(300) NOT NULL,
  `CorrectAnswer` varchar(200) NOT NULL,
  `OptionB` varchar(200) DEFAULT NULL,
  `OptionC` varchar(200) DEFAULT NULL,
  `OptionD` varchar(200) DEFAULT NULL,
  `QuestionType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ReadingId` (`ReadingId`),
  CONSTRAINT `readingquestion_ibfk_1` FOREIGN KEY (`ReadingId`) REFERENCES `readingtext` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `readingquestion`
--

LOCK TABLES `readingquestion` WRITE;
/*!40000 ALTER TABLE `readingquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `readingquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `readingtext`
--

DROP TABLE IF EXISTS `readingtext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `readingtext` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(200) NOT NULL,
  `Content` text NOT NULL,
  `Level` enum('BEGINNER','INTERMEDIATE','ADVANCED') NOT NULL DEFAULT 'BEGINNER',
  `ThemeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ThemeId` (`ThemeId`),
  KEY `idx_reading_level` (`Level`),
  CONSTRAINT `readingtext_ibfk_1` FOREIGN KEY (`ThemeId`) REFERENCES `theme` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `readingtext`
--

LOCK TABLES `readingtext` WRITE;
/*!40000 ALTER TABLE `readingtext` DISABLE KEYS */;
/*!40000 ALTER TABLE `readingtext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_log`
--

DROP TABLE IF EXISTS `session_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `correct` bit(1) NOT NULL,
  `error_type` enum('VOCABULARY','GRAMMAR','FALSE_FRIEND','OVERGENERALIZATION','CONTEXT') DEFAULT NULL,
  `exercise_type` enum('TRANSLATE','MULTIPLE_CHOICE','FILL_GAP','READING') NOT NULL,
  `response_ms` int(11) DEFAULT NULL,
  `session_date` date NOT NULL,
  `user_answer` varchar(255) DEFAULT NULL,
  `fill_gap_id` int(11) DEFAULT NULL,
  `reading_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `word_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3mq0iuorqd0fgcryg3jr3ksf7` (`fill_gap_id`),
  KEY `FK9gstn8tvd82dyi8fyonkv2bsm` (`reading_id`),
  KEY `FKg3ek1tuk5bepu875cw73einx7` (`user_id`),
  KEY `FKt74m8wrsqt9gl17w4basqccwc` (`word_id`),
  CONSTRAINT `FK3mq0iuorqd0fgcryg3jr3ksf7` FOREIGN KEY (`fill_gap_id`) REFERENCES `fill_gap_exercise` (`id`),
  CONSTRAINT `FK9gstn8tvd82dyi8fyonkv2bsm` FOREIGN KEY (`reading_id`) REFERENCES `reading_text` (`id`),
  CONSTRAINT `FKg3ek1tuk5bepu875cw73einx7` FOREIGN KEY (`user_id`) REFERENCES `user` (`Id`),
  CONSTRAINT `FKt74m8wrsqt9gl17w4basqccwc` FOREIGN KEY (`word_id`) REFERENCES `word` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_log`
--

LOCK TABLES `session_log` WRITE;
/*!40000 ALTER TABLE `session_log` DISABLE KEYS */;
INSERT INTO `session_log` VALUES (1,_binary '\0','VOCABULARY','MULTIPLE_CHOICE',2905,'2026-05-01','',NULL,NULL,22,18),(2,_binary '\0','VOCABULARY','MULTIPLE_CHOICE',2182,'2026-05-01','',NULL,NULL,22,26);
/*!40000 ALTER TABLE `session_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessionlog`
--

DROP TABLE IF EXISTS `sessionlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessionlog` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `WordId` int(11) DEFAULT NULL,
  `FillGapId` int(11) DEFAULT NULL,
  `ReadingId` int(11) DEFAULT NULL,
  `ExerciseType` enum('TRANSLATE','MULTIPLE_CHOICE','FILL_GAP','READING') NOT NULL,
  `Correct` tinyint(1) NOT NULL,
  `ResponseMs` int(11) DEFAULT NULL,
  `ErrorType` enum('VOCABULARY','GRAMMAR','FALSE_FRIEND','OVERGENERALIZATION','CONTEXT') DEFAULT NULL,
  `UserAnswer` varchar(200) DEFAULT NULL,
  `SessionDate` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`Id`),
  KEY `WordId` (`WordId`),
  KEY `FillGapId` (`FillGapId`),
  KEY `ReadingId` (`ReadingId`),
  KEY `idx_log_user_date` (`UserId`,`SessionDate`),
  KEY `idx_log_error` (`ErrorType`),
  CONSTRAINT `sessionlog_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `sessionlog_ibfk_2` FOREIGN KEY (`WordId`) REFERENCES `word` (`Id`) ON DELETE SET NULL,
  CONSTRAINT `sessionlog_ibfk_3` FOREIGN KEY (`FillGapId`) REFERENCES `fillgapexercise` (`Id`) ON DELETE SET NULL,
  CONSTRAINT `sessionlog_ibfk_4` FOREIGN KEY (`ReadingId`) REFERENCES `readingtext` (`Id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=430 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessionlog`
--

LOCK TABLES `sessionlog` WRITE;
/*!40000 ALTER TABLE `sessionlog` DISABLE KEYS */;
INSERT INTO `sessionlog` VALUES (1,22,27,NULL,NULL,'FILL_GAP',1,6700,NULL,'water','2026-05-01'),(2,22,20,NULL,NULL,'TRANSLATE',0,5512,'GRAMMAR','blue','2026-05-01'),(3,22,23,NULL,NULL,'TRANSLATE',1,5364,NULL,'black','2026-05-01'),(4,22,28,NULL,NULL,'MULTIPLE_CHOICE',1,2385,NULL,'milk','2026-05-01'),(5,22,18,NULL,NULL,'MULTIPLE_CHOICE',1,3466,NULL,'fish','2026-05-01'),(6,22,25,NULL,NULL,'FILL_GAP',1,10117,NULL,'apple','2026-05-01'),(7,22,17,NULL,NULL,'FILL_GAP',1,4788,NULL,'bird','2026-05-01'),(8,22,19,NULL,NULL,'TRANSLATE',1,3838,NULL,'horse','2026-05-01'),(9,22,23,NULL,NULL,'MULTIPLE_CHOICE',1,2931,NULL,'black','2026-05-01'),(10,22,15,NULL,NULL,'TRANSLATE',1,4955,NULL,'dog','2026-05-01'),(11,22,24,NULL,NULL,'FILL_GAP',1,5777,NULL,'white','2026-05-01'),(12,22,29,NULL,NULL,'MULTIPLE_CHOICE',1,2224,NULL,'egg','2026-05-01'),(13,22,26,NULL,NULL,'FILL_GAP',1,8024,NULL,'bread','2026-05-01'),(14,22,28,NULL,NULL,'TRANSLATE',1,18363,NULL,'milk','2026-05-01'),(15,22,22,NULL,NULL,'FILL_GAP',1,25136,NULL,'green','2026-05-01'),(16,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,2175,NULL,'water','2026-05-01'),(17,22,17,NULL,NULL,'FILL_GAP',1,5290,NULL,'bird','2026-05-02'),(18,22,21,NULL,NULL,'TRANSLATE',1,4647,NULL,'blue','2026-05-02'),(19,22,24,NULL,NULL,'TRANSLATE',1,8282,NULL,'white','2026-05-02'),(20,22,17,NULL,NULL,'FILL_GAP',1,4522,NULL,'bird','2026-05-02'),(21,22,18,NULL,NULL,'FILL_GAP',1,3878,NULL,'fish','2026-05-02'),(22,22,24,NULL,NULL,'MULTIPLE_CHOICE',1,1630,NULL,'white','2026-05-02'),(23,22,22,NULL,NULL,'TRANSLATE',1,4276,NULL,'green','2026-05-02'),(24,22,26,NULL,NULL,'FILL_GAP',1,3485,NULL,'bread','2026-05-02'),(25,22,16,NULL,NULL,'MULTIPLE_CHOICE',0,3150,'GRAMMAR','horse','2026-05-02'),(26,22,16,NULL,NULL,'MULTIPLE_CHOICE',0,4292,'GRAMMAR','horse','2026-05-02'),(27,22,23,NULL,NULL,'MULTIPLE_CHOICE',1,1784,NULL,'black','2026-05-02'),(28,22,29,NULL,NULL,'MULTIPLE_CHOICE',1,1931,NULL,'egg','2026-05-02'),(29,22,25,NULL,NULL,'TRANSLATE',1,4669,NULL,'apple','2026-05-02'),(30,22,28,NULL,NULL,'MULTIPLE_CHOICE',1,1767,NULL,'milk','2026-05-02'),(31,22,17,NULL,NULL,'MULTIPLE_CHOICE',1,1706,NULL,'bird','2026-05-02'),(32,22,19,NULL,NULL,'FILL_GAP',1,3703,NULL,'horse','2026-05-02'),(33,22,20,NULL,NULL,'FILL_GAP',1,2834,NULL,'red','2026-05-02'),(34,22,15,NULL,NULL,'MULTIPLE_CHOICE',1,2316,NULL,'dog','2026-05-02'),(35,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,2043,NULL,'water','2026-05-02'),(36,22,21,NULL,NULL,'MULTIPLE_CHOICE',1,1484,NULL,'blue','2026-05-02'),(37,22,15,NULL,NULL,'MULTIPLE_CHOICE',1,1858,NULL,'dog','2026-05-02'),(38,22,28,NULL,NULL,'TRANSLATE',1,3277,NULL,'milk','2026-05-02'),(39,22,23,NULL,NULL,'TRANSLATE',1,3307,NULL,'black','2026-05-02'),(40,22,26,NULL,NULL,'TRANSLATE',1,2787,NULL,'bread','2026-05-02'),(41,22,22,NULL,NULL,'MULTIPLE_CHOICE',1,2706,NULL,'green','2026-05-02'),(42,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,1151,NULL,'water','2026-05-02'),(43,22,18,NULL,NULL,'TRANSLATE',1,2529,NULL,'fish','2026-05-02'),(44,22,29,NULL,NULL,'TRANSLATE',1,4174,NULL,'egg','2026-05-02'),(45,22,20,NULL,NULL,'TRANSLATE',0,2508,'VOCABULARY','blue','2026-05-02'),(46,22,20,NULL,NULL,'TRANSLATE',0,5021,'VOCABULARY','blue','2026-05-02'),(47,22,16,NULL,NULL,'MULTIPLE_CHOICE',0,1679,'VOCABULARY','milk','2026-05-02'),(48,22,15,NULL,NULL,'FILL_GAP',1,6471,NULL,'dog','2026-05-02'),(49,22,23,NULL,NULL,'MULTIPLE_CHOICE',1,2065,NULL,'black','2026-05-02'),(50,22,21,NULL,NULL,'TRANSLATE',1,2585,NULL,'blue','2026-05-02'),(51,22,17,NULL,NULL,'MULTIPLE_CHOICE',1,1265,NULL,'bird','2026-05-02'),(52,22,28,NULL,NULL,'TRANSLATE',1,2577,NULL,'milk','2026-05-02'),(53,22,24,NULL,NULL,'MULTIPLE_CHOICE',1,1148,NULL,'white','2026-05-02'),(54,22,19,NULL,NULL,'TRANSLATE',1,2667,NULL,'horse','2026-05-02'),(55,22,25,NULL,NULL,'TRANSLATE',1,3415,NULL,'aPple','2026-05-02'),(56,22,22,NULL,NULL,'TRANSLATE',1,4027,NULL,'green','2026-05-02'),(57,22,16,NULL,NULL,'TRANSLATE',1,3365,NULL,'cat','2026-05-03'),(58,22,18,NULL,NULL,'TRANSLATE',1,3500,NULL,'fish','2026-05-03'),(59,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,1208,NULL,'water','2026-05-03'),(60,22,29,NULL,NULL,'MULTIPLE_CHOICE',1,1852,NULL,'egg','2026-05-03'),(61,22,25,NULL,NULL,'FILL_GAP',0,15268,'VOCABULARY','orange','2026-05-03'),(62,22,25,NULL,NULL,'FILL_GAP',0,13866,'VOCABULARY','orange','2026-05-03'),(63,22,19,NULL,NULL,'MULTIPLE_CHOICE',0,1756,'VOCABULARY','blue','2026-05-03'),(64,22,20,NULL,NULL,'FILL_GAP',1,3629,NULL,'red','2026-05-03'),(65,22,21,NULL,NULL,'MULTIPLE_CHOICE',1,1712,NULL,'blue','2026-05-03'),(66,22,17,NULL,NULL,'TRANSLATE',1,3320,NULL,'bird','2026-05-03'),(67,22,26,NULL,NULL,'MULTIPLE_CHOICE',1,1589,NULL,'bread','2026-05-03'),(68,22,15,NULL,NULL,'MULTIPLE_CHOICE',1,14882,NULL,'dog','2026-05-03'),(69,22,22,NULL,NULL,'MULTIPLE_CHOICE',1,1587,NULL,'green','2026-05-03'),(70,22,26,NULL,NULL,'TRANSLATE',1,3874,NULL,'bread','2026-05-03'),(71,22,29,NULL,NULL,'MULTIPLE_CHOICE',1,1468,NULL,'egg','2026-05-03'),(72,22,15,NULL,NULL,'MULTIPLE_CHOICE',1,2594,NULL,'dog','2026-05-03'),(73,22,20,NULL,NULL,'MULTIPLE_CHOICE',1,1444,NULL,'red','2026-05-03'),(74,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,1631,NULL,'water','2026-05-03'),(75,22,23,NULL,NULL,'MULTIPLE_CHOICE',1,2818,NULL,'black','2026-05-03'),(76,22,17,NULL,NULL,'MULTIPLE_CHOICE',1,1167,NULL,'bird','2026-05-03'),(77,22,16,NULL,NULL,'TRANSLATE',1,2961,NULL,'cat','2026-05-03'),(78,22,25,NULL,NULL,'MULTIPLE_CHOICE',1,2905,NULL,'apple','2026-05-03'),(79,22,18,NULL,NULL,'TRANSLATE',1,3296,NULL,'fish','2026-05-03'),(80,22,21,NULL,NULL,'TRANSLATE',0,10291,'VOCABULARY','cerulean','2026-05-03'),(81,22,20,NULL,NULL,'MULTIPLE_CHOICE',1,1573,NULL,'red','2026-05-03'),(82,22,29,NULL,NULL,'TRANSLATE',1,4484,NULL,'egg','2026-05-03'),(83,22,16,NULL,NULL,'MULTIPLE_CHOICE',1,1285,NULL,'cat','2026-05-03'),(84,22,17,NULL,NULL,'TRANSLATE',1,4440,NULL,'bird','2026-05-03'),(85,22,18,NULL,NULL,'TRANSLATE',1,2967,NULL,'fish','2026-05-03'),(86,22,28,NULL,NULL,'MULTIPLE_CHOICE',1,1384,NULL,'milk','2026-05-03'),(87,22,19,NULL,NULL,'MULTIPLE_CHOICE',1,1241,NULL,'horse','2026-05-03'),(88,22,25,NULL,NULL,'MULTIPLE_CHOICE',1,1249,NULL,'apple','2026-05-03'),(89,22,27,NULL,NULL,'TRANSLATE',0,7138,'VOCABULARY','watr','2026-05-03'),(90,22,24,NULL,NULL,'TRANSLATE',0,56796,'VOCABULARY','pale','2026-05-03'),(91,22,22,NULL,NULL,'TRANSLATE',0,21756,'VOCABULARY','verdant','2026-05-03'),(92,22,15,NULL,NULL,'TRANSLATE',0,12855,'VOCABULARY','hound','2026-05-03'),(93,22,26,NULL,NULL,'TRANSLATE',1,2948,NULL,'bread','2026-05-03'),(94,22,23,NULL,NULL,'TRANSLATE',0,4848,'VOCABULARY','bleak','2026-05-03'),(95,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,2594,NULL,'water','2026-05-03'),(96,22,19,NULL,NULL,'MULTIPLE_CHOICE',1,1303,NULL,'horse','2026-05-03'),(97,22,18,NULL,NULL,'TRANSLATE',1,3539,NULL,'fish','2026-05-03'),(98,22,25,NULL,NULL,'MULTIPLE_CHOICE',1,4160,NULL,'apple','2026-05-03'),(99,22,22,NULL,NULL,'MULTIPLE_CHOICE',1,1807,NULL,'green','2026-05-03'),(100,22,16,NULL,NULL,'MULTIPLE_CHOICE',1,1586,NULL,'cat','2026-05-03'),(101,22,19,NULL,NULL,'MULTIPLE_CHOICE',1,1916,NULL,'horse','2026-05-03'),(102,22,25,NULL,NULL,'TRANSLATE',1,5975,NULL,'apple','2026-05-03'),(103,22,23,NULL,NULL,'MULTIPLE_CHOICE',1,1420,NULL,'black','2026-05-03'),(104,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,1037,NULL,'water','2026-05-03'),(105,22,21,NULL,NULL,'MULTIPLE_CHOICE',1,1178,NULL,'blue','2026-05-03'),(106,22,29,NULL,NULL,'TRANSLATE',1,2529,NULL,'egg','2026-05-03'),(107,22,26,NULL,NULL,'TRANSLATE',1,3079,NULL,'bread','2026-05-03'),(108,22,18,NULL,NULL,'MULTIPLE_CHOICE',1,1388,NULL,'fish','2026-05-03'),(109,22,15,NULL,NULL,'TRANSLATE',1,1999,NULL,'dog','2026-05-03'),(110,22,22,NULL,NULL,'TRANSLATE',1,3408,NULL,'green','2026-05-03'),(111,22,21,NULL,NULL,'MULTIPLE_CHOICE',1,2390,NULL,'blue','2026-05-03'),(112,22,27,NULL,NULL,'TRANSLATE',0,2705,'VOCABULARY','watee','2026-05-03'),(113,22,20,NULL,NULL,'TRANSLATE',1,2367,NULL,'red','2026-05-03'),(114,22,19,NULL,NULL,'MULTIPLE_CHOICE',1,1280,NULL,'horse','2026-05-03'),(115,22,22,NULL,NULL,'TRANSLATE',1,3407,NULL,'green','2026-05-03'),(116,22,16,NULL,NULL,'FILL_GAP',1,3436,NULL,'cat','2026-05-03'),(117,22,21,NULL,NULL,'MULTIPLE_CHOICE',1,1387,NULL,'blue','2026-05-03'),(118,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,927,NULL,'water','2026-05-03'),(119,22,17,NULL,NULL,'MULTIPLE_CHOICE',1,1503,NULL,'bird','2026-05-03'),(120,22,24,NULL,NULL,'MULTIPLE_CHOICE',1,1200,NULL,'white','2026-05-03'),(121,22,23,NULL,NULL,'MULTIPLE_CHOICE',1,1710,NULL,'black','2026-05-03'),(122,22,18,NULL,NULL,'MULTIPLE_CHOICE',1,1107,NULL,'fish','2026-05-03'),(123,22,15,NULL,NULL,'FILL_GAP',1,1580,NULL,'dog','2026-05-03'),(124,22,29,NULL,NULL,'MULTIPLE_CHOICE',1,1518,NULL,'egg','2026-05-03'),(125,22,25,NULL,NULL,'TRANSLATE',1,2362,NULL,'apple','2026-05-03'),(126,22,26,NULL,NULL,'MULTIPLE_CHOICE',1,1335,NULL,'bread','2026-05-03'),(127,22,77,NULL,NULL,'FILL_GAP',1,2705,NULL,'cold','2026-05-03'),(128,22,50,NULL,NULL,'MULTIPLE_CHOICE',1,1471,NULL,'read','2026-05-03'),(129,22,78,NULL,NULL,'TRANSLATE',1,4838,NULL,'climate','2026-05-03'),(130,22,61,NULL,NULL,'TRANSLATE',0,132754,'VOCABULARY','professor','2026-05-03'),(131,22,56,NULL,NULL,'TRANSLATE',0,30946,'VOCABULARY','dash','2026-05-03'),(132,22,17,NULL,NULL,'MULTIPLE_CHOICE',1,1468,NULL,'bird','2026-05-03'),(133,22,26,NULL,NULL,'MULTIPLE_CHOICE',1,1538,NULL,'bread','2026-05-03'),(134,22,58,NULL,NULL,'MULTIPLE_CHOICE',1,2458,NULL,'travel','2026-05-03'),(135,22,57,NULL,NULL,'FILL_GAP',1,3967,NULL,'swim','2026-05-03'),(136,22,55,NULL,NULL,'FILL_GAP',1,7100,NULL,'write','2026-05-03'),(137,22,15,NULL,NULL,'TRANSLATE',1,3887,NULL,'dog','2026-05-03'),(138,22,25,NULL,NULL,'MULTIPLE_CHOICE',1,2203,NULL,'apple','2026-05-03'),(139,22,20,NULL,NULL,'TRANSLATE',1,6859,NULL,'red','2026-05-03'),(140,22,59,NULL,NULL,'TRANSLATE',0,80624,'VOCABULARY','probing','2026-05-03'),(141,22,16,NULL,NULL,'FILL_GAP',1,2622,NULL,'cat','2026-05-03'),(142,22,71,NULL,NULL,'FILL_GAP',0,4118,'VOCABULARY','cold','2026-05-03'),(143,22,51,NULL,NULL,'FILL_GAP',1,5190,NULL,'draw','2026-05-03'),(144,22,22,NULL,NULL,'MULTIPLE_CHOICE',1,1645,NULL,'green','2026-05-03'),(145,22,19,NULL,NULL,'TRANSLATE',1,3579,NULL,'horse','2026-05-03'),(146,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,1862,NULL,'water','2026-05-03'),(147,22,53,NULL,NULL,'TRANSLATE',0,14417,'VOCABULARY','prance','2026-05-03'),(148,22,60,NULL,NULL,'FILL_GAP',1,4277,NULL,'doctor','2026-05-03'),(149,22,NULL,NULL,NULL,'TRANSLATE',0,8261,'VOCABULARY','firefightee','2026-05-03'),(150,22,21,NULL,NULL,'TRANSLATE',1,2414,NULL,'blue','2026-05-03'),(151,22,54,NULL,NULL,'MULTIPLE_CHOICE',1,3146,NULL,'play','2026-05-03'),(152,22,24,NULL,NULL,'MULTIPLE_CHOICE',1,4322,NULL,'white','2026-05-03'),(153,22,NULL,NULL,NULL,'TRANSLATE',1,2352,NULL,'wind','2026-05-03'),(154,22,52,NULL,NULL,'TRANSLATE',1,2325,NULL,'sing','2026-05-03'),(155,22,23,NULL,NULL,'MULTIPLE_CHOICE',1,2802,NULL,'black','2026-05-03'),(156,22,NULL,NULL,NULL,'FILL_GAP',1,3388,NULL,'nurse','2026-05-03'),(157,22,75,NULL,NULL,'FILL_GAP',1,3141,NULL,'snow','2026-05-03'),(158,22,70,NULL,NULL,'MULTIPLE_CHOICE',1,5651,NULL,'rain','2026-05-03'),(159,22,18,NULL,NULL,'MULTIPLE_CHOICE',1,1221,NULL,'fish','2026-05-03'),(160,22,28,NULL,NULL,'MULTIPLE_CHOICE',1,1061,NULL,'milk','2026-05-03'),(161,22,29,NULL,NULL,'TRANSLATE',1,3770,NULL,'egg','2026-05-03'),(162,22,76,NULL,NULL,'FILL_GAP',1,4222,NULL,'heat','2026-05-03'),(163,22,66,NULL,NULL,'TRANSLATE',1,30309,NULL,'cook','2026-05-03'),(164,22,NULL,NULL,NULL,'FILL_GAP',1,30208,NULL,'cloudy','2026-05-03'),(165,22,69,NULL,NULL,'FILL_GAP',0,5238,'VOCABULARY','firefighter','2026-05-03'),(166,22,76,NULL,NULL,'MULTIPLE_CHOICE',1,1854,NULL,'heat','2026-05-03'),(167,22,23,NULL,NULL,'MULTIPLE_CHOICE',1,1108,NULL,'black','2026-05-03'),(168,22,70,NULL,NULL,'MULTIPLE_CHOICE',1,1400,NULL,'rain','2026-05-03'),(169,22,50,NULL,NULL,'MULTIPLE_CHOICE',1,1436,NULL,'read','2026-05-03'),(170,22,29,NULL,NULL,'MULTIPLE_CHOICE',1,934,NULL,'egg','2026-05-03'),(171,22,22,NULL,NULL,'MULTIPLE_CHOICE',1,1667,NULL,'green','2026-05-03'),(172,22,15,NULL,NULL,'MULTIPLE_CHOICE',1,991,NULL,'dog','2026-05-03'),(173,22,28,NULL,NULL,'MULTIPLE_CHOICE',1,1920,NULL,'milk','2026-05-03'),(174,22,77,NULL,NULL,'MULTIPLE_CHOICE',1,1311,NULL,'cold','2026-05-03'),(175,22,18,NULL,NULL,'MULTIPLE_CHOICE',1,1031,NULL,'fish','2026-05-03'),(176,22,56,NULL,NULL,'MULTIPLE_CHOICE',1,965,NULL,'run','2026-05-03'),(177,22,16,NULL,NULL,'MULTIPLE_CHOICE',1,1026,NULL,'cat','2026-05-03'),(178,22,71,NULL,NULL,'MULTIPLE_CHOICE',1,1228,NULL,'sunny','2026-05-03'),(179,22,69,NULL,NULL,'MULTIPLE_CHOICE',1,1553,NULL,'police officer','2026-05-03'),(180,22,69,NULL,NULL,'MULTIPLE_CHOICE',1,1734,NULL,'police officer','2026-05-03'),(181,22,NULL,NULL,NULL,'MULTIPLE_CHOICE',1,1645,NULL,'cloudy','2026-05-03'),(182,22,NULL,NULL,NULL,'MULTIPLE_CHOICE',0,7577,'VOCABULARY','police officer','2026-05-03'),(183,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,2674,NULL,'water','2026-05-03'),(184,22,NULL,NULL,NULL,'MULTIPLE_CHOICE',1,1166,NULL,'wind','2026-05-03'),(185,22,19,NULL,NULL,'MULTIPLE_CHOICE',1,1934,NULL,'horse','2026-05-03'),(186,22,75,NULL,NULL,'MULTIPLE_CHOICE',1,1933,NULL,'snow','2026-05-03'),(187,22,25,NULL,NULL,'TRANSLATE',1,2721,NULL,'apple','2026-05-03'),(188,22,50,NULL,NULL,'MULTIPLE_CHOICE',1,3584,NULL,'read','2026-05-03'),(189,22,28,NULL,NULL,'MULTIPLE_CHOICE',1,1215,NULL,'milk','2026-05-03'),(190,22,NULL,NULL,NULL,'MULTIPLE_CHOICE',1,1520,NULL,'nurse','2026-05-03'),(191,22,77,NULL,NULL,'FILL_GAP',1,3196,NULL,'cold','2026-05-03'),(192,22,50,NULL,NULL,'FILL_GAP',1,4367,NULL,'read','2026-05-03'),(193,22,75,NULL,NULL,'FILL_GAP',1,3737,NULL,'snow','2026-05-03'),(194,22,76,NULL,NULL,'FILL_GAP',1,3480,NULL,'heat','2026-05-03'),(195,22,25,NULL,NULL,'FILL_GAP',1,8820,NULL,'apple','2026-05-03'),(196,22,69,NULL,NULL,'FILL_GAP',1,17126,NULL,'police officer','2026-05-03'),(197,22,51,NULL,NULL,'FILL_GAP',0,1946,'VOCABULARY','read','2026-05-03'),(198,22,51,NULL,NULL,'FILL_GAP',0,2469,'VOCABULARY','read','2026-05-03'),(199,22,50,NULL,NULL,'FILL_GAP',1,3540,NULL,'read','2026-05-03'),(200,22,59,NULL,NULL,'FILL_GAP',1,5129,NULL,'study','2026-05-03'),(201,22,53,NULL,NULL,'FILL_GAP',1,2297,NULL,'dance','2026-05-03'),(202,22,76,NULL,NULL,'FILL_GAP',1,1657,NULL,'heat','2026-05-03'),(203,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,1849,NULL,'water','2026-05-03'),(204,22,24,NULL,NULL,'MULTIPLE_CHOICE',1,1415,NULL,'white','2026-05-03'),(205,22,NULL,NULL,NULL,'FILL_GAP',1,4617,NULL,'nurse','2026-05-03'),(206,22,23,NULL,NULL,'MULTIPLE_CHOICE',1,1093,NULL,'black','2026-05-03'),(207,22,NULL,NULL,NULL,'MULTIPLE_CHOICE',1,1492,NULL,'firefighter','2026-05-03'),(208,22,55,NULL,NULL,'MULTIPLE_CHOICE',1,1548,NULL,'write','2026-05-03'),(209,22,76,NULL,NULL,'MULTIPLE_CHOICE',1,1577,NULL,'heat','2026-05-03'),(210,22,60,NULL,NULL,'MULTIPLE_CHOICE',0,4029,'VOCABULARY','dance','2026-05-03'),(211,22,60,NULL,NULL,'MULTIPLE_CHOICE',0,2473,'VOCABULARY','dance','2026-05-03'),(212,22,54,NULL,NULL,'MULTIPLE_CHOICE',0,1990,'VOCABULARY','green','2026-05-03'),(213,22,50,NULL,NULL,'MULTIPLE_CHOICE',1,1858,NULL,'read','2026-05-03'),(214,22,17,NULL,NULL,'MULTIPLE_CHOICE',1,1192,NULL,'bird','2026-05-03'),(215,22,57,NULL,NULL,'MULTIPLE_CHOICE',1,2370,NULL,'swim','2026-05-03'),(216,22,51,NULL,NULL,'MULTIPLE_CHOICE',1,2738,NULL,'draw','2026-05-03'),(217,22,53,NULL,NULL,'MULTIPLE_CHOICE',1,1583,NULL,'dance','2026-05-03'),(218,22,15,NULL,NULL,'MULTIPLE_CHOICE',1,2614,NULL,'dog','2026-05-03'),(219,22,70,NULL,NULL,'MULTIPLE_CHOICE',1,1215,NULL,'rain','2026-05-03'),(220,22,NULL,NULL,NULL,'MULTIPLE_CHOICE',0,1631,'VOCABULARY','weather','2026-05-03'),(221,22,26,NULL,NULL,'MULTIPLE_CHOICE',0,1514,'VOCABULARY','water','2026-05-03'),(222,22,59,NULL,NULL,'MULTIPLE_CHOICE',1,2035,NULL,'study','2026-05-03'),(223,22,58,NULL,NULL,'MULTIPLE_CHOICE',1,1140,NULL,'travel','2026-05-03'),(224,22,71,NULL,NULL,'MULTIPLE_CHOICE',1,1431,NULL,'sunny','2026-05-03'),(225,22,NULL,NULL,NULL,'MULTIPLE_CHOICE',1,1369,NULL,'nurse','2026-05-03'),(226,22,21,NULL,NULL,'MULTIPLE_CHOICE',1,1301,NULL,'blue','2026-05-03'),(227,22,21,NULL,NULL,'MULTIPLE_CHOICE',1,1485,NULL,'blue','2026-05-03'),(228,22,16,NULL,NULL,'MULTIPLE_CHOICE',1,1511,NULL,'cat','2026-05-03'),(229,22,56,NULL,NULL,'MULTIPLE_CHOICE',0,1046,'VOCABULARY','sunny','2026-05-03'),(230,22,57,NULL,NULL,'TRANSLATE',1,5893,NULL,'swim','2026-05-03'),(231,22,29,NULL,NULL,'MULTIPLE_CHOICE',1,1410,NULL,'egg','2026-05-03'),(232,22,52,NULL,NULL,'MULTIPLE_CHOICE',1,1412,NULL,'sing','2026-05-03'),(233,22,20,NULL,NULL,'MULTIPLE_CHOICE',1,1301,NULL,'red','2026-05-03'),(234,22,15,NULL,NULL,'TRANSLATE',1,2698,NULL,'dog','2026-05-03'),(235,22,19,NULL,NULL,'MULTIPLE_CHOICE',1,1356,NULL,'horse','2026-05-03'),(236,22,25,NULL,NULL,'MULTIPLE_CHOICE',1,1339,NULL,'apple','2026-05-03'),(237,22,60,NULL,NULL,'MULTIPLE_CHOICE',1,1076,NULL,'doctor','2026-05-03'),(238,22,75,NULL,NULL,'MULTIPLE_CHOICE',1,1110,NULL,'snow','2026-05-03'),(239,22,NULL,NULL,NULL,'TRANSLATE',1,2772,NULL,'nurse','2026-05-03'),(240,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,1313,NULL,'water','2026-05-03'),(241,22,71,NULL,NULL,'TRANSLATE',1,2770,NULL,'sunny','2026-05-03'),(242,22,66,NULL,NULL,'MULTIPLE_CHOICE',1,1868,NULL,'chef','2026-05-03'),(243,22,17,NULL,NULL,'TRANSLATE',1,3357,NULL,'bird','2026-05-03'),(244,22,NULL,NULL,NULL,'MULTIPLE_CHOICE',0,2495,'VOCABULARY','horse','2026-05-03'),(245,22,NULL,NULL,NULL,'MULTIPLE_CHOICE',0,2875,'VOCABULARY','horse','2026-05-03'),(246,22,55,NULL,NULL,'TRANSLATE',1,4945,NULL,'write','2026-05-03'),(247,22,77,NULL,NULL,'MULTIPLE_CHOICE',1,1179,NULL,'cold','2026-05-03'),(248,22,NULL,NULL,NULL,'MULTIPLE_CHOICE',1,1314,NULL,'cloudy','2026-05-03'),(249,22,26,NULL,NULL,'MULTIPLE_CHOICE',1,1153,NULL,'bread','2026-05-03'),(250,22,21,NULL,NULL,'MULTIPLE_CHOICE',1,1128,NULL,'blue','2026-05-03'),(251,22,25,NULL,NULL,'FILL_GAP',1,2903,NULL,'apple','2026-05-03'),(252,22,61,NULL,NULL,'FILL_GAP',1,1945,NULL,'teacher','2026-05-03'),(253,22,23,NULL,NULL,'MULTIPLE_CHOICE',1,1579,NULL,'black','2026-05-03'),(254,22,22,NULL,NULL,'MULTIPLE_CHOICE',1,1073,NULL,'green','2026-05-03'),(255,22,76,NULL,NULL,'FILL_GAP',1,1788,NULL,'heat','2026-05-03'),(256,22,56,NULL,NULL,'MULTIPLE_CHOICE',1,1466,NULL,'run','2026-05-03'),(257,22,71,NULL,NULL,'FILL_GAP',1,2143,NULL,'sunny','2026-05-03'),(258,22,55,NULL,NULL,'FILL_GAP',1,2496,NULL,'write','2026-05-03'),(259,22,75,NULL,NULL,'FILL_GAP',1,2263,NULL,'snow','2026-05-03'),(260,22,50,NULL,NULL,'FILL_GAP',1,8700,NULL,'read','2026-05-03'),(261,22,52,NULL,NULL,'FILL_GAP',0,3674,'VOCABULARY','water','2026-05-03'),(262,22,52,NULL,NULL,'FILL_GAP',0,1846,'VOCABULARY','water','2026-05-03'),(263,22,55,NULL,NULL,'FILL_GAP',1,2305,NULL,'write','2026-05-03'),(264,22,NULL,NULL,NULL,'FILL_GAP',1,3971,NULL,'architect','2026-05-03'),(265,22,25,NULL,NULL,'FILL_GAP',1,2172,NULL,'apple','2026-05-03'),(266,22,15,NULL,NULL,'FILL_GAP',1,1924,NULL,'dog','2026-05-03'),(267,22,61,NULL,NULL,'FILL_GAP',1,1365,NULL,'teacher','2026-05-03'),(268,22,57,NULL,NULL,'FILL_GAP',1,2014,NULL,'swim','2026-05-04'),(269,22,16,NULL,NULL,'FILL_GAP',1,2293,NULL,'cat','2026-05-04'),(270,22,77,NULL,NULL,'MULTIPLE_CHOICE',1,2057,NULL,'cold','2026-05-04'),(271,22,71,NULL,NULL,'MULTIPLE_CHOICE',1,1280,NULL,'sunny','2026-05-04'),(272,22,57,NULL,NULL,'MULTIPLE_CHOICE',1,1971,NULL,'swim','2026-05-04'),(273,22,66,NULL,NULL,'MULTIPLE_CHOICE',1,1283,NULL,'chef','2026-05-04'),(274,22,59,NULL,NULL,'MULTIPLE_CHOICE',0,1376,'VOCABULARY','cold','2026-05-04'),(275,22,27,NULL,NULL,'MULTIPLE_CHOICE',1,1178,NULL,'water','2026-05-04'),(276,22,51,NULL,NULL,'MULTIPLE_CHOICE',1,1431,NULL,'draw','2026-05-04'),(277,22,21,NULL,NULL,'MULTIPLE_CHOICE',1,1099,NULL,'blue','2026-05-04'),(278,24,52,NULL,NULL,'MULTIPLE_CHOICE',1,1633,NULL,'sing','2026-05-06'),(279,24,NULL,NULL,NULL,'MULTIPLE_CHOICE',1,2083,NULL,'nurse','2026-05-06'),(280,24,61,NULL,NULL,'MULTIPLE_CHOICE',1,1886,NULL,'teacher','2026-05-06'),(281,24,61,NULL,NULL,'MULTIPLE_CHOICE',1,2308,NULL,'teacher','2026-05-06'),(282,24,22,NULL,NULL,'MULTIPLE_CHOICE',1,1311,NULL,'green','2026-05-06'),(283,24,75,NULL,NULL,'MULTIPLE_CHOICE',1,1838,NULL,'snow','2026-05-06'),(284,24,50,NULL,NULL,'MULTIPLE_CHOICE',1,1317,NULL,'read','2026-05-06'),(285,24,70,NULL,NULL,'MULTIPLE_CHOICE',1,1541,NULL,'rain','2026-05-06'),(286,24,16,NULL,NULL,'MULTIPLE_CHOICE',0,1947,'VOCABULARY','rain','2026-05-06'),(287,24,23,NULL,NULL,'MULTIPLE_CHOICE',1,1505,NULL,'black','2026-05-06'),(288,24,51,NULL,NULL,'MULTIPLE_CHOICE',1,1669,NULL,'draw','2026-05-06'),(289,24,51,NULL,NULL,'MULTIPLE_CHOICE',1,1809,NULL,'draw','2026-05-06'),(290,24,66,NULL,NULL,'MULTIPLE_CHOICE',1,1087,NULL,'chef','2026-05-06'),(291,24,NULL,NULL,NULL,'MULTIPLE_CHOICE',1,1350,NULL,'wind','2026-05-06'),(292,24,NULL,NULL,NULL,'MULTIPLE_CHOICE',1,1528,NULL,'wind','2026-05-06'),(293,24,56,NULL,NULL,'MULTIPLE_CHOICE',1,984,NULL,'run','2026-05-06'),(294,24,NULL,NULL,NULL,'MULTIPLE_CHOICE',1,3477,NULL,'cloudy','2026-05-06'),(295,24,22,NULL,NULL,'TRANSLATE',1,2642,NULL,'green','2026-05-06'),(296,24,15,NULL,NULL,'MULTIPLE_CHOICE',1,1502,NULL,'dog','2026-05-06'),(297,24,15,NULL,NULL,'MULTIPLE_CHOICE',1,1240,NULL,'dog','2026-05-06'),(298,24,50,NULL,NULL,'TRANSLATE',1,3255,NULL,'read','2026-05-06'),(299,24,58,NULL,NULL,'MULTIPLE_CHOICE',1,2614,NULL,'travel','2026-05-06'),(300,24,58,NULL,NULL,'MULTIPLE_CHOICE',1,2965,NULL,'travel','2026-05-06'),(301,24,25,NULL,NULL,'MULTIPLE_CHOICE',1,1004,NULL,'apple','2026-05-06'),(302,24,23,NULL,NULL,'TRANSLATE',1,2779,NULL,'black','2026-05-06'),(303,24,51,NULL,NULL,'FILL_GAP',1,2694,NULL,'draw','2026-05-06'),(304,24,NULL,NULL,NULL,'MULTIPLE_CHOICE',1,2638,NULL,'firefighter','2026-05-06'),(305,24,27,NULL,NULL,'MULTIPLE_CHOICE',1,4174,NULL,'water','2026-05-06'),(306,24,19,NULL,NULL,'MULTIPLE_CHOICE',1,1523,NULL,'horse','2026-05-06'),(307,24,75,NULL,NULL,'TRANSLATE',1,2358,NULL,'snow','2026-05-06'),(308,24,66,NULL,NULL,'TRANSLATE',1,2643,NULL,'cook','2026-05-06'),(309,24,54,NULL,NULL,'MULTIPLE_CHOICE',1,1591,NULL,'play','2026-05-06'),(310,24,55,NULL,NULL,'MULTIPLE_CHOICE',1,9989,NULL,'write','2026-05-06'),(311,24,55,NULL,NULL,'MULTIPLE_CHOICE',0,7652,'VOCABULARY','white','2026-05-06'),(312,24,55,NULL,NULL,'MULTIPLE_CHOICE',0,4412,'VOCABULARY','white','2026-05-06'),(313,24,55,NULL,NULL,'MULTIPLE_CHOICE',0,8732,'VOCABULARY','water','2026-05-06'),(314,24,55,NULL,NULL,'MULTIPLE_CHOICE',0,3066,'VOCABULARY','white','2026-05-06'),(315,24,26,NULL,NULL,'MULTIPLE_CHOICE',1,1793,NULL,'bread','2026-05-06'),(316,24,29,NULL,NULL,'MULTIPLE_CHOICE',0,1370,'VOCABULARY','fish','2026-05-06'),(317,24,69,NULL,NULL,'MULTIPLE_CHOICE',1,1356,NULL,'police officer','2026-05-06'),(318,24,16,NULL,NULL,'MULTIPLE_CHOICE',1,1289,NULL,'cat','2026-05-06'),(319,22,78,NULL,NULL,'FILL_GAP',1,4069,NULL,'weather','2026-05-07'),(320,22,20,NULL,NULL,'FILL_GAP',1,3366,NULL,'red','2026-05-07'),(321,22,77,NULL,NULL,'FILL_GAP',1,2417,NULL,'cold','2026-05-07'),(322,22,57,NULL,NULL,'FILL_GAP',1,7301,NULL,'swim','2026-05-07'),(323,22,15,NULL,NULL,'FILL_GAP',1,1633,NULL,'dog','2026-05-07'),(324,22,NULL,NULL,NULL,'FILL_GAP',1,6147,NULL,'cloudy','2026-05-07'),(325,22,76,NULL,NULL,'FILL_GAP',1,2848,NULL,'heat','2026-05-07'),(326,22,55,NULL,NULL,'FILL_GAP',1,3421,NULL,'write','2026-05-07'),(327,22,61,NULL,NULL,'FILL_GAP',1,2978,NULL,'teacher','2026-05-07'),(328,22,50,NULL,NULL,'FILL_GAP',0,3102,'VOCABULARY','write','2026-05-07'),(329,22,50,NULL,NULL,'FILL_GAP',0,4418,'VOCABULARY','write','2026-05-07'),(330,22,52,NULL,NULL,'FILL_GAP',1,6325,NULL,'sing','2026-05-08'),(331,22,50,NULL,NULL,'FILL_GAP',0,3398,'VOCABULARY','plumber','2026-05-08'),(332,22,323,NULL,NULL,'FILL_GAP',1,5508,NULL,'chef','2026-05-08'),(333,22,264,NULL,NULL,'FILL_GAP',1,6087,NULL,'breeze','2026-05-08'),(334,22,321,NULL,NULL,'FILL_GAP',1,5180,NULL,'tour guide','2026-05-08'),(335,22,19,NULL,NULL,'TRANSLATE',1,3599,NULL,'horse','2026-05-09'),(336,22,17,NULL,NULL,'TRANSLATE',1,4267,NULL,'bird','2026-05-09'),(337,22,280,NULL,NULL,'FILL_GAP',1,4533,NULL,'temperature','2026-05-09'),(338,22,55,NULL,NULL,'FILL_GAP',1,2173,NULL,'write','2026-05-09'),(339,22,206,NULL,NULL,'FILL_GAP',1,5586,NULL,'goalkeeper','2026-05-09'),(340,22,20,NULL,NULL,'FILL_GAP',1,2893,NULL,'red','2026-05-09'),(341,30,252,NULL,NULL,'MULTIPLE_CHOICE',1,1342,NULL,'raw','2026-05-09'),(342,30,18,NULL,NULL,'MULTIPLE_CHOICE',1,1908,NULL,'fish','2026-05-09'),(343,30,77,NULL,NULL,'MULTIPLE_CHOICE',1,1776,NULL,'cold','2026-05-09'),(344,30,232,NULL,NULL,'MULTIPLE_CHOICE',1,2015,NULL,'fridge','2026-05-09'),(345,30,70,NULL,NULL,'MULTIPLE_CHOICE',1,1175,NULL,'rain','2026-05-09'),(346,30,284,NULL,NULL,'MULTIPLE_CHOICE',1,6394,NULL,'raincoat','2026-05-09'),(347,30,289,NULL,NULL,'MULTIPLE_CHOICE',1,1183,NULL,'snow','2026-05-09'),(348,30,206,NULL,NULL,'MULTIPLE_CHOICE',1,2933,NULL,'goalkeeper','2026-05-09'),(349,30,279,NULL,NULL,'MULTIPLE_CHOICE',1,1463,NULL,'rainbow','2026-05-09'),(350,30,75,NULL,NULL,'MULTIPLE_CHOICE',1,1326,NULL,'snow','2026-05-09'),(351,30,305,NULL,NULL,'MULTIPLE_CHOICE',0,1466,'VOCABULARY','blue','2026-05-09'),(352,30,305,NULL,NULL,'MULTIPLE_CHOICE',0,3334,'VOCABULARY','blue','2026-05-09'),(353,30,207,NULL,NULL,'FILL_GAP',0,1469,'VOCABULARY','forecast','2026-05-09'),(354,30,252,NULL,NULL,'FILL_GAP',0,984,'VOCABULARY','egg','2026-05-09'),(355,30,235,NULL,NULL,'FILL_GAP',0,1182,'VOCABULARY','nurse','2026-05-09'),(356,30,57,NULL,NULL,'MULTIPLE_CHOICE',1,3414,NULL,'swim','2026-05-09'),(357,30,281,NULL,NULL,'MULTIPLE_CHOICE',0,1389,'VOCABULARY','coach','2026-05-09'),(358,30,281,NULL,NULL,'MULTIPLE_CHOICE',0,1874,'VOCABULARY','coach','2026-05-09'),(359,30,280,NULL,NULL,'MULTIPLE_CHOICE',1,1665,NULL,'temperature','2026-05-09'),(360,30,233,NULL,NULL,'MULTIPLE_CHOICE',0,1883,'VOCABULARY','temperature','2026-05-09'),(361,30,70,NULL,NULL,'TRANSLATE',0,8524,'VOCABULARY','drizzle','2026-05-09'),(362,30,28,NULL,NULL,'MULTIPLE_CHOICE',1,3878,NULL,'milk','2026-05-09'),(363,30,58,NULL,NULL,'MULTIPLE_CHOICE',1,1649,NULL,'travel','2026-05-09'),(364,30,29,NULL,NULL,'MULTIPLE_CHOICE',1,1180,NULL,'egg','2026-05-09'),(365,30,238,NULL,NULL,'MULTIPLE_CHOICE',0,2767,'VOCABULARY','green','2026-05-09'),(366,30,208,NULL,NULL,'MULTIPLE_CHOICE',1,1287,NULL,'personal best','2026-05-09'),(367,30,69,NULL,NULL,'MULTIPLE_CHOICE',1,3204,NULL,'police officer','2026-05-09'),(368,30,60,NULL,NULL,'MULTIPLE_CHOICE',0,925,'VOCABULARY','injury','2026-05-09'),(369,30,60,NULL,NULL,'MULTIPLE_CHOICE',0,1112,'VOCABULARY','injury','2026-05-09'),(370,30,60,NULL,NULL,'MULTIPLE_CHOICE',0,1314,'VOCABULARY','injury','2026-05-09'),(371,30,300,NULL,NULL,'MULTIPLE_CHOICE',0,1169,'VOCABULARY','to boil','2026-05-09'),(372,30,300,NULL,NULL,'MULTIPLE_CHOICE',0,1399,'VOCABULARY','to boil','2026-05-09'),(373,30,290,NULL,NULL,'MULTIPLE_CHOICE',0,1143,'VOCABULARY','starter','2026-05-09'),(374,30,321,NULL,NULL,'MULTIPLE_CHOICE',0,571,'VOCABULARY','temperature','2026-05-09'),(375,30,204,NULL,NULL,'MULTIPLE_CHOICE',0,2450,'VOCABULARY','pilot','2026-05-09'),(376,30,204,NULL,NULL,'MULTIPLE_CHOICE',0,2633,'VOCABULARY','pilot','2026-05-09'),(377,30,16,NULL,NULL,'MULTIPLE_CHOICE',1,1126,NULL,'cat','2026-05-09'),(378,30,20,NULL,NULL,'MULTIPLE_CHOICE',1,1312,NULL,'red','2026-05-09'),(379,30,23,NULL,NULL,'MULTIPLE_CHOICE',1,1523,NULL,'black','2026-05-09'),(380,30,24,NULL,NULL,'MULTIPLE_CHOICE',1,1449,NULL,'white','2026-05-09'),(381,30,295,NULL,NULL,'MULTIPLE_CHOICE',1,2076,NULL,'nurse','2026-05-09'),(382,30,233,NULL,NULL,'MULTIPLE_CHOICE',1,1572,NULL,'recipe','2026-05-09'),(383,30,55,NULL,NULL,'MULTIPLE_CHOICE',1,1545,NULL,'write','2026-05-09'),(384,30,269,NULL,NULL,'MULTIPLE_CHOICE',1,2084,NULL,'forecast','2026-05-09'),(385,30,303,NULL,NULL,'MULTIPLE_CHOICE',1,1496,NULL,'pilot','2026-05-09'),(386,30,207,NULL,NULL,'MULTIPLE_CHOICE',1,1181,NULL,'fan','2026-05-09'),(387,30,52,NULL,NULL,'MULTIPLE_CHOICE',1,973,NULL,'sing','2026-05-09'),(388,30,251,NULL,NULL,'MULTIPLE_CHOICE',1,1183,NULL,'spicy','2026-05-09'),(389,30,300,NULL,NULL,'MULTIPLE_CHOICE',1,2420,NULL,'vet','2026-05-09'),(390,30,270,NULL,NULL,'MULTIPLE_CHOICE',1,1784,NULL,'lightning','2026-05-09'),(391,30,15,NULL,NULL,'MULTIPLE_CHOICE',1,1323,NULL,'dog','2026-05-09'),(392,30,252,NULL,NULL,'MULTIPLE_CHOICE',1,1224,NULL,'raw','2026-05-09'),(393,30,58,NULL,NULL,'TRANSLATE',1,6421,NULL,'travel','2026-05-09'),(394,30,212,NULL,NULL,'MULTIPLE_CHOICE',1,1760,NULL,'sprint','2026-05-09'),(395,30,229,NULL,NULL,'MULTIPLE_CHOICE',1,1547,NULL,'goal','2026-05-09'),(396,30,229,NULL,NULL,'MULTIPLE_CHOICE',1,1970,NULL,'goal','2026-05-09'),(397,30,22,NULL,NULL,'MULTIPLE_CHOICE',1,1145,NULL,'green','2026-05-09'),(398,30,206,NULL,NULL,'TRANSLATE',1,11778,NULL,'goalkeeper','2026-05-09'),(399,30,208,NULL,NULL,'TRANSLATE',1,8013,NULL,'personal best','2026-05-09'),(400,30,54,NULL,NULL,'MULTIPLE_CHOICE',1,1638,NULL,'play','2026-05-09'),(401,30,234,NULL,NULL,'MULTIPLE_CHOICE',1,1873,NULL,'to boil','2026-05-09'),(402,30,28,NULL,NULL,'TRANSLATE',1,4260,NULL,'milk','2026-05-09'),(403,30,29,NULL,NULL,'TRANSLATE',1,2464,NULL,'egg','2026-05-09'),(404,30,252,NULL,NULL,'FILL_GAP',1,3780,NULL,'raw','2026-05-09'),(405,30,26,NULL,NULL,'MULTIPLE_CHOICE',1,1732,NULL,'bread','2026-05-09'),(406,30,233,NULL,NULL,'FILL_GAP',1,16488,NULL,'recipe','2026-05-09'),(407,30,232,NULL,NULL,'TRANSLATE',0,13623,'VOCABULARY','refrigerator','2026-05-09'),(408,30,255,NULL,NULL,'MULTIPLE_CHOICE',1,4010,NULL,'season','2026-05-09'),(409,30,238,NULL,NULL,'MULTIPLE_CHOICE',1,5449,NULL,'to snack','2026-05-09'),(410,30,235,NULL,NULL,'MULTIPLE_CHOICE',1,1729,NULL,'grilled','2026-05-09'),(411,30,27,NULL,NULL,'MULTIPLE_CHOICE',1,3132,NULL,'water','2026-05-09'),(412,30,251,NULL,NULL,'TRANSLATE',1,5573,NULL,'hot','2026-05-09'),(413,30,239,NULL,NULL,'MULTIPLE_CHOICE',1,6598,NULL,'starter','2026-05-09'),(414,30,25,NULL,NULL,'MULTIPLE_CHOICE',1,3867,NULL,'apple','2026-05-09'),(415,30,237,NULL,NULL,'MULTIPLE_CHOICE',1,2048,NULL,'to bake','2026-05-09'),(416,30,236,NULL,NULL,'MULTIPLE_CHOICE',1,1343,NULL,'seafood','2026-05-09'),(417,30,236,NULL,NULL,'MULTIPLE_CHOICE',1,1717,NULL,'seafood','2026-05-09'),(418,30,53,NULL,NULL,'FILL_GAP',1,1966,NULL,'dance','2026-05-09'),(419,30,54,NULL,NULL,'FILL_GAP',1,3114,NULL,'play','2026-05-09'),(420,30,51,NULL,NULL,'FILL_GAP',0,2178,'VOCABULARY','black','2026-05-09'),(421,30,55,NULL,NULL,'FILL_GAP',1,2122,NULL,'write','2026-05-09'),(422,30,57,NULL,NULL,'FILL_GAP',1,3422,NULL,'swim','2026-05-09'),(423,30,52,NULL,NULL,'FILL_GAP',0,3540,'VOCABULARY','draw','2026-05-09'),(424,30,50,NULL,NULL,'FILL_GAP',1,8837,NULL,'read','2026-05-09'),(425,30,50,NULL,NULL,'FILL_GAP',1,9310,NULL,'read','2026-05-09'),(426,30,59,NULL,NULL,'FILL_GAP',1,4071,NULL,'study','2026-05-09'),(427,30,58,NULL,NULL,'FILL_GAP',1,5467,NULL,'travel','2026-05-09'),(428,22,239,NULL,NULL,'FILL_GAP',0,3793,'VOCABULARY','fish','2026-05-10'),(429,22,255,NULL,NULL,'FILL_GAP',1,3537,NULL,'season','2026-05-10');
/*!40000 ALTER TABLE `sessionlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `Plan` enum('FREE','PREMIUM') NOT NULL DEFAULT 'FREE',
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `Status` enum('ACTIVE','EXPIRED','CANCELLED') NOT NULL DEFAULT 'ACTIVE',
  `end_date` date NOT NULL,
  `start_date` date NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserId` (`UserId`),
  UNIQUE KEY `UK_tq3cq3gmsss8jjyb2l5sb1o6k` (`user_id`),
  CONSTRAINT `FK8l1goo02px4ye49xd7wgogxg6` FOREIGN KEY (`user_id`) REFERENCES `user` (`Id`),
  CONSTRAINT `subscription_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theme`
--

DROP TABLE IF EXISTS `theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theme` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` enum('Sports','Food','Countries','Anatomy','Weather','Hobbies','Jobs','Others') NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theme`
--

LOCK TABLES `theme` WRITE;
/*!40000 ALTER TABLE `theme` DISABLE KEYS */;
INSERT INTO `theme` VALUES (35,''),(33,'Sports'),(34,'Food'),(38,'Countries'),(39,'Anatomy'),(37,'Weather'),(40,'Hobbies'),(41,'Jobs'),(42,'Others');
/*!40000 ALTER TABLE `theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Points` int(11) NOT NULL DEFAULT 0,
  `Premium` tinyint(1) NOT NULL DEFAULT 0,
  `LearningMode` enum('FREE','EVALUATION') NOT NULL DEFAULT 'FREE',
  `LevelEstimated` enum('BEGINNER','INTERMEDIATE','ADVANCED') NOT NULL DEFAULT 'BEGINNER',
  `Role` enum('USER','ADMIN') NOT NULL DEFAULT 'USER',
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime(6) DEFAULT NULL,
  `learning_mode` enum('FREE','EVALUATION') DEFAULT NULL,
  `level_estimated` enum('BEGINNER','INTERMEDIATE','ADVANCED') DEFAULT NULL,
  `AvatarUrl` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (21,'test','123456','test@test.com',0,0,'FREE','BEGINNER','USER','2026-05-01 06:51:54',NULL,NULL,NULL,NULL),(22,'nass','$2a$10$KTK9IGXMJv.fEPheUy62EufzEneRNpg1clG.mPmNhD8zI6ZZvBjvu','12@',2779,0,'EVALUATION','BEGINNER','USER','2026-05-01 06:53:31','2026-05-01 05:53:30.000000','FREE','BEGINNER',NULL),(23,'MrRaulity','$2a$10$ZKvNyRp8.UUb4X.6Wb..x.v/eChM6vLN1Eo8yWom96aDIpTO.wjj.','e@hotmail',0,0,'EVALUATION','BEGINNER','USER','2026-05-06 04:52:34',NULL,NULL,NULL,NULL),(24,'MRRaulity3','$2a$10$FI3CyqWhbNyf/eCtr7AU4efH7wSRXZfVPJoeN.WRrmcd9bzt0EXx.','e@hotmail.com',500,0,'EVALUATION','BEGINNER','USER','2026-05-06 04:55:20',NULL,NULL,NULL,NULL),(25,'ana_garcia','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LPVkgN.kHW2','ana@demo.com',2340,0,'EVALUATION','ADVANCED','USER','2026-03-22 09:49:42',NULL,NULL,NULL,NULL),(26,'carlos_mb','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LPVkgN.kHW2','carlos@demo.com',1580,0,'EVALUATION','INTERMEDIATE','USER','2026-04-06 09:49:42',NULL,NULL,NULL,NULL),(27,'sofia_r','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LPVkgN.kHW2','sofia@demo.com',870,0,'FREE','BEGINNER','USER','2026-04-21 09:49:42',NULL,NULL,NULL,NULL),(28,'david_lp','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LPVkgN.kHW2','david@demo.com',430,0,'EVALUATION','BEGINNER','USER','2026-04-26 09:49:42',NULL,NULL,NULL,NULL),(29,'prof_martinez','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LPVkgN.kHW2','prof@demo.com',3100,1,'EVALUATION','ADVANCED','ADMIN','2026-03-07 09:49:42',NULL,NULL,NULL,NULL),(30,'pruebita','$2a$10$0s51s7wBKhMvJocH73vRd.lTF22FezLkjmy2U6tpeFD5jRFSkh5lq','pruebita@hotmail',790,0,'EVALUATION','BEGINNER','USER','2026-05-09 22:11:32',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_progress`
--

DROP TABLE IF EXISTS `user_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_progress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avg_response_ms` int(11) DEFAULT NULL,
  `correct_attempts` int(11) DEFAULT NULL,
  `last_updated` date DEFAULT NULL,
  `production_attempts` int(11) DEFAULT NULL,
  `recognition_attempts` int(11) DEFAULT NULL,
  `total_attempts` int(11) DEFAULT NULL,
  `trend` enum('IMPROVING','STABLE','DECLINING') DEFAULT NULL,
  `theme_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK8pixfl6b3mcqgyt5fc4uyxn6y` (`user_id`,`theme_id`),
  KEY `FK8stxihrx54a3wjuaf1fdgp0i7` (`theme_id`),
  CONSTRAINT `FK8stxihrx54a3wjuaf1fdgp0i7` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`Id`),
  CONSTRAINT `FKdpcn9k9uoj0uh6eenim54gvng` FOREIGN KEY (`user_id`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_progress`
--

LOCK TABLES `user_progress` WRITE;
/*!40000 ALTER TABLE `user_progress` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_word`
--

DROP TABLE IF EXISTS `user_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_word` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `difficulty` double DEFAULT NULL,
  `due_date` datetime(6) DEFAULT NULL,
  `lapses` int(11) DEFAULT NULL,
  `reps` int(11) DEFAULT NULL,
  `stability` double DEFAULT NULL,
  `state` enum('NEW','LEARNING','REVIEW','RELEARNING') DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `word_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK74smtwu5psis7pvjl1dnqmts2` (`user_id`,`word_id`),
  KEY `FKjqlk39web147dg7bn1efkbddk` (`word_id`),
  CONSTRAINT `FK70vcixbxt7t2lhgcng6ukg74x` FOREIGN KEY (`user_id`) REFERENCES `user` (`Id`),
  CONSTRAINT `FKjqlk39web147dg7bn1efkbddk` FOREIGN KEY (`word_id`) REFERENCES `word` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_word`
--

LOCK TABLES `user_word` WRITE;
/*!40000 ALTER TABLE `user_word` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usercustomword`
--

DROP TABLE IF EXISTS `usercustomword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usercustomword` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Difficulty` double DEFAULT NULL,
  `DueDate` datetime(6) DEFAULT NULL,
  `Lapses` int(11) DEFAULT NULL,
  `LastReview` datetime(6) DEFAULT NULL,
  `Reps` int(11) DEFAULT NULL,
  `Stability` double DEFAULT NULL,
  `State` enum('NEW','LEARNING','REVIEW','RELEARNING') DEFAULT NULL,
  `CustomCardId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UKc8o6m1nxec7om6jpbagj9k55x` (`UserId`,`CustomCardId`),
  KEY `FKbqe7y28brje947vjild3e0bwg` (`CustomCardId`),
  CONSTRAINT `FK17t5g8dxvgwcspfxe2byjor8j` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`),
  CONSTRAINT `FKbqe7y28brje947vjild3e0bwg` FOREIGN KEY (`CustomCardId`) REFERENCES `customcard` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usercustomword`
--

LOCK TABLES `usercustomword` WRITE;
/*!40000 ALTER TABLE `usercustomword` DISABLE KEYS */;
INSERT INTO `usercustomword` VALUES (1,4.199408114429,'2026-10-07 15:51:58.000000',1,'2026-05-09 15:51:58.000000',4,151.2324730415495,'REVIEW',2,22),(2,1,'2026-05-24 15:52:00.000000',0,'2026-05-09 15:52:00.000000',4,15.4722,'REVIEW',3,22),(3,2.619400792085935,'2026-05-12 15:51:54.000000',0,'2026-05-09 15:51:54.000000',4,3.1262,'REVIEW',9,22),(4,5.626497622085934,'2028-05-26 15:51:52.000000',1,'2026-05-09 15:51:52.000000',3,748.4802857761699,'REVIEW',7,22),(5,2.619400792085935,'2026-05-12 15:52:03.000000',0,'2026-05-09 15:52:03.000000',4,3.1262,'REVIEW',6,22),(6,1.8246988654320733,'2026-05-12 15:51:56.000000',0,'2026-05-09 15:51:56.000000',5,3.1262,'REVIEW',4,22);
/*!40000 ALTER TABLE `usercustomword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userprogress`
--

DROP TABLE IF EXISTS `userprogress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userprogress` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `ThemeId` int(11) NOT NULL,
  `TotalAttempts` int(11) NOT NULL DEFAULT 0,
  `CorrectAttempts` int(11) NOT NULL DEFAULT 0,
  `AvgResponseMs` int(11) NOT NULL DEFAULT 0,
  `Trend` enum('IMPROVING','STABLE','DECLINING') NOT NULL DEFAULT 'STABLE',
  `LastUpdated` date DEFAULT NULL,
  `ProductionAttempts` int(11) DEFAULT NULL,
  `RecognitionAttempts` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `uq_user_theme` (`UserId`,`ThemeId`),
  UNIQUE KEY `UK8vc1arnw16fspxviks6nyt6ph` (`UserId`,`ThemeId`),
  KEY `ThemeId` (`ThemeId`),
  KEY `idx_progress_user` (`UserId`),
  CONSTRAINT `userprogress_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `userprogress_ibfk_2` FOREIGN KEY (`ThemeId`) REFERENCES `theme` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userprogress`
--

LOCK TABLES `userprogress` WRITE;
/*!40000 ALTER TABLE `userprogress` DISABLE KEYS */;
INSERT INTO `userprogress` VALUES (1,22,42,6,6,3933,'STABLE','2026-05-09',6,0),(2,30,33,49,34,3365,'STABLE','2026-05-09',13,36),(3,30,34,103,80,3532,'STABLE','2026-05-09',28,75),(4,30,37,63,43,2444,'STABLE','2026-05-09',5,58),(5,30,40,36,34,3729,'DECLINING','2026-05-09',14,22),(6,30,41,57,17,1707,'STABLE','2026-05-09',0,57),(7,30,42,32,32,1398,'STABLE','2026-05-09',0,32);
/*!40000 ALTER TABLE `userprogress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userword`
--

DROP TABLE IF EXISTS `userword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userword` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `WordId` int(11) NOT NULL,
  `Stability` double NOT NULL DEFAULT 0,
  `Difficulty` double NOT NULL DEFAULT 0,
  `Lapses` int(11) NOT NULL DEFAULT 0,
  `Reps` int(11) NOT NULL DEFAULT 0,
  `DueDate` datetime NOT NULL DEFAULT current_timestamp(),
  `State` enum('NEW','LEARNING','REVIEW','RELEARNING') NOT NULL DEFAULT 'NEW',
  `LastReview` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `uq_user_word` (`UserId`,`WordId`),
  UNIQUE KEY `UKjf4o5svym52hxmiq09ineeaex` (`UserId`,`WordId`),
  KEY `WordId` (`WordId`),
  KEY `idx_userword_due` (`UserId`,`DueDate`),
  KEY `idx_userword_state` (`UserId`,`State`),
  CONSTRAINT `userword_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `userword_ibfk_2` FOREIGN KEY (`WordId`) REFERENCES `word` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userword`
--

LOCK TABLES `userword` WRITE;
/*!40000 ALTER TABLE `userword` DISABLE KEYS */;
INSERT INTO `userword` VALUES (1,22,55,46.35691815071363,1.4148121731805823,0,6,'2026-06-24 15:53:08','REVIEW','2026-05-09 15:53:08.000000'),(2,22,76,54.318845045981654,1.664407170647841,0,3,'2026-06-30 08:22:06','REVIEW','2026-05-07 08:22:06.000000'),(3,22,60,748.4802857761699,6.1451,1,1,'2028-05-20 22:15:39','REVIEW','2026-05-03 22:15:39.000000'),(5,22,54,0.4072,7.2102,1,0,'2026-05-03 22:24:01','RELEARNING','2026-05-03 22:14:01.000000'),(6,22,50,2.1008067974650095,9.015003749438684,2,2,'2026-05-08 04:45:21','RELEARNING','2026-05-08 04:35:21.000000'),(7,22,17,30.42889683141493,3.731872780647841,0,3,'2026-06-08 15:45:43','REVIEW','2026-05-09 15:45:43.000000'),(8,22,57,33.048730357055454,2.1838607939438766,0,5,'2026-06-09 08:21:54','REVIEW','2026-05-07 08:21:54.000000'),(9,22,51,24.5664237050021,2.449077027571821,0,2,'2026-05-29 00:01:40','REVIEW','2026-05-04 00:01:40.000000'),(10,22,53,15.4722,3.28285649513529,0,1,'2026-05-18 22:14:16','LEARNING','2026-05-03 22:14:16.000000'),(11,22,15,57.08353176657343,1,0,4,'2026-07-03 08:21:56','REVIEW','2026-05-07 08:21:56.000000'),(12,22,70,15.4722,3.28285649513529,0,1,'2026-05-18 22:14:21','LEARNING','2026-05-03 22:14:21.000000'),(14,22,26,748.4802857761699,6.1451,1,1,'2028-05-20 22:16:11','REVIEW','2026-05-03 22:16:11.000000'),(15,22,59,2.0442132691576593,5.644377027571822,1,1,'2026-05-04 00:10:18','RELEARNING','2026-05-04 00:00:18.000000'),(16,22,58,15.4722,3.28285649513529,0,1,'2026-05-18 22:14:29','LEARNING','2026-05-03 22:14:29.000000'),(17,22,71,26.107570865023284,1,0,4,'2026-05-30 00:00:10','REVIEW','2026-05-04 00:00:10.000000'),(19,22,21,26.107570865023284,1,0,4,'2026-05-30 00:01:41','REVIEW','2026-05-04 00:01:41.000000'),(20,22,16,24.5664237050021,2.449077027571821,0,2,'2026-05-28 23:57:08','REVIEW','2026-05-03 23:57:08.000000'),(21,22,56,748.4802857761699,6.1451,1,1,'2028-05-20 22:16:42','REVIEW','2026-05-03 22:16:42.000000'),(22,22,29,15.4722,3.28285649513529,0,1,'2026-05-18 22:15:27','LEARNING','2026-05-03 22:15:27.000000'),(23,22,52,151.2324730415495,5.736604000647842,1,2,'2026-10-06 04:35:16','REVIEW','2026-05-08 04:35:16.000000'),(24,22,20,42.237854528799325,2.666772780647841,0,3,'2026-06-20 15:53:43','REVIEW','2026-05-09 15:53:43.000000'),(25,22,19,30.87688147477328,3.5141770275718214,0,2,'2026-06-09 15:45:38','REVIEW','2026-05-09 15:45:38.000000'),(26,22,25,15.4722,1.664407170647841,0,3,'2026-05-18 22:43:05','REVIEW','2026-05-03 22:43:05.000000'),(27,22,75,15.4722,2.449077027571821,0,2,'2026-05-18 22:16:52','REVIEW','2026-05-03 22:16:52.000000'),(28,22,27,24.5664237050021,2.449077027571821,0,2,'2026-05-29 00:01:35','REVIEW','2026-05-04 00:01:35.000000'),(29,22,66,24.5664237050021,2.449077027571821,0,2,'2026-05-29 00:00:15','REVIEW','2026-05-04 00:00:15.000000'),(30,22,77,52.11745102332308,1.664407170647841,0,3,'2026-06-28 08:21:46','REVIEW','2026-05-07 08:21:46.000000'),(32,22,61,54.318845045981654,1.664407170647841,0,3,'2026-06-30 08:22:14','REVIEW','2026-05-07 08:22:14.000000'),(33,22,23,15.4722,3.28285649513529,0,1,'2026-05-18 22:16:35','LEARNING','2026-05-03 22:16:35.000000'),(34,22,22,15.4722,3.28285649513529,0,1,'2026-05-18 22:16:38','LEARNING','2026-05-03 22:16:38.000000'),(36,24,52,15.4722,3.28285649513529,0,1,'2026-05-21 04:56:26','LEARNING','2026-05-06 04:56:26.000000'),(38,24,61,15.4722,2.449077027571821,0,2,'2026-05-21 04:56:33','REVIEW','2026-05-06 04:56:33.000000'),(39,24,22,15.4722,2.449077027571821,0,2,'2026-05-21 04:57:07','REVIEW','2026-05-06 04:57:07.000000'),(40,24,75,15.4722,2.449077027571821,0,2,'2026-05-21 04:57:52','REVIEW','2026-05-06 04:57:52.000000'),(41,24,50,15.4722,3.5141770275718214,0,2,'2026-05-21 04:57:19','REVIEW','2026-05-06 04:57:19.000000'),(42,24,70,15.4722,3.28285649513529,0,1,'2026-05-21 04:56:41','LEARNING','2026-05-06 04:56:41.000000'),(43,24,16,748.4802857761699,6.1451,1,1,'2028-05-23 04:58:20','REVIEW','2026-05-06 04:58:20.000000'),(44,24,23,15.4722,2.449077027571821,0,2,'2026-05-21 04:57:28','REVIEW','2026-05-06 04:57:28.000000'),(45,24,51,15.4722,1.664407170647841,0,3,'2026-05-21 04:57:32','REVIEW','2026-05-06 04:57:32.000000'),(46,24,66,15.4722,2.449077027571821,0,2,'2026-05-21 04:57:56','REVIEW','2026-05-06 04:57:56.000000'),(48,24,56,15.4722,3.28285649513529,0,1,'2026-05-21 04:56:52','LEARNING','2026-05-06 04:56:52.000000'),(50,24,15,15.4722,3.28285649513529,0,1,'2026-05-21 04:57:09','LEARNING','2026-05-06 04:57:09.000000'),(52,24,58,15.4722,2.449077027571821,0,2,'2026-05-21 04:57:23','REVIEW','2026-05-06 04:57:23.000000'),(53,24,25,15.4722,3.28285649513529,0,1,'2026-05-21 04:57:25','LEARNING','2026-05-06 04:57:25.000000'),(55,24,27,3.1262,5.314577829570867,0,1,'2026-05-09 04:57:40','LEARNING','2026-05-06 04:57:40.000000'),(56,24,19,15.4722,3.28285649513529,0,1,'2026-05-21 04:57:42','LEARNING','2026-05-06 04:57:42.000000'),(57,24,54,15.4722,3.28285649513529,0,1,'2026-05-21 04:57:58','LEARNING','2026-05-06 04:57:58.000000'),(58,24,55,0.38850435615044815,8.680074572406678,1,1,'2026-05-06 05:08:10','RELEARNING','2026-05-06 04:58:10.000000'),(59,24,26,15.4722,3.28285649513529,0,1,'2026-05-21 04:58:12','LEARNING','2026-05-06 04:58:12.000000'),(60,24,29,0.4072,7.2102,1,0,'2026-05-06 05:08:15','RELEARNING','2026-05-06 04:58:15.000000'),(61,24,69,15.4722,3.28285649513529,0,1,'2026-05-21 04:58:18','LEARNING','2026-05-06 04:58:18.000000'),(63,25,15,45.2,3.1,0,12,'2026-06-15 13:09:26','REVIEW','2026-05-01 13:09:26.000000'),(64,25,16,38.7,3.8,1,10,'2026-06-10 13:09:26','REVIEW','2026-05-03 13:09:26.000000'),(65,25,17,62.1,2.4,0,9,'2026-06-29 13:09:26','REVIEW','2026-04-28 13:09:26.000000'),(66,25,18,71.5,2.1,0,11,'2026-07-06 13:09:26','REVIEW','2026-04-26 13:09:26.000000'),(67,25,19,29.3,4.2,2,8,'2026-06-02 13:09:26','REVIEW','2026-05-04 13:09:26.000000'),(68,25,20,3.1,5.8,1,2,'2026-05-07 13:09:26','RELEARNING','2026-05-05 13:09:26.000000'),(69,25,21,52,2.9,0,10,'2026-06-20 13:09:26','REVIEW','2026-04-29 13:09:26.000000'),(70,25,22,18.4,4.6,3,6,'2026-05-23 13:09:26','REVIEW','2026-05-05 13:09:26.000000'),(71,25,23,0,0,0,0,'2026-05-06 13:09:26','NEW',NULL),(72,25,24,0,0,0,0,'2026-05-06 13:09:26','NEW',NULL),(73,25,25,35,3.5,0,9,'2026-05-05 13:09:26','REVIEW','2026-03-31 13:09:26.000000'),(74,25,26,42,3.2,0,10,'2026-05-03 13:09:26','REVIEW','2026-03-24 13:09:26.000000'),(78,26,15,12.4,5.1,1,4,'2026-05-15 13:09:26','REVIEW','2026-05-03 13:09:26.000000'),(79,26,16,8.7,5.9,2,3,'2026-05-12 13:09:26','REVIEW','2026-05-04 13:09:26.000000'),(80,26,17,3.1,6.2,0,2,'2026-05-09 13:09:26','LEARNING','2026-05-05 13:09:26.000000'),(81,26,18,1.8,6.8,0,1,'2026-05-08 13:09:26','LEARNING','2026-05-06 13:09:26.000000'),(82,26,19,18.2,4.3,1,6,'2026-05-19 13:09:26','REVIEW','2026-05-01 13:09:26.000000'),(83,26,20,0,0,0,0,'2026-05-06 13:09:26','NEW',NULL),(84,26,21,0,0,0,0,'2026-05-06 13:09:26','NEW',NULL),(85,26,22,2.4,5.5,1,1,'2026-05-06 13:09:26','RELEARNING','2026-05-05 13:09:26.000000'),(86,26,23,22.1,3.9,0,7,'2026-05-04 13:09:26','REVIEW','2026-04-13 13:09:26.000000'),(93,27,15,1.1,7.2,0,1,'2026-05-07 13:09:26','LEARNING','2026-05-05 13:09:26.000000'),(94,27,16,0,0,0,0,'2026-05-06 13:09:26','NEW',NULL),(95,27,17,0,0,0,0,'2026-05-06 13:09:26','NEW',NULL),(96,27,18,1.8,6.5,1,1,'2026-05-07 13:09:26','RELEARNING','2026-05-06 13:09:26.000000'),(97,27,19,0,0,0,0,'2026-05-06 13:09:26','NEW',NULL),(100,28,15,1.2,8.1,4,2,'2026-05-06 13:09:26','RELEARNING','2026-05-05 13:09:26.000000'),(101,28,16,0.8,8.9,3,1,'2026-05-07 13:09:26','RELEARNING','2026-05-06 13:09:26.000000'),(102,28,17,2.1,7.5,2,2,'2026-05-07 13:09:26','LEARNING','2026-05-04 13:09:26.000000'),(103,28,18,0,0,0,0,'2026-05-06 13:09:26','NEW',NULL),(104,28,19,3.4,6.8,2,3,'2026-05-07 13:09:26','REVIEW','2026-05-03 13:09:26.000000'),(107,29,15,95.3,2.1,0,18,'2026-07-20 13:09:26','REVIEW','2026-04-16 13:09:26.000000'),(108,29,16,88.1,2.3,0,16,'2026-07-18 13:09:26','REVIEW','2026-04-21 13:09:26.000000'),(109,29,17,112.4,1.8,0,20,'2026-07-27 13:09:26','REVIEW','2026-04-06 13:09:26.000000'),(110,29,18,73.2,2.6,1,14,'2026-07-08 13:09:26','REVIEW','2026-04-26 13:09:26.000000'),(111,29,19,67.9,2.8,0,13,'2026-06-30 13:09:26','REVIEW','2026-04-24 13:09:26.000000'),(114,22,78,3.1262,5.314577829570867,0,1,'2026-05-10 08:21:37','LEARNING','2026-05-07 08:21:37.000000'),(115,22,323,3.1262,5.314577829570867,0,1,'2026-05-11 04:35:28','LEARNING','2026-05-08 04:35:28.000000'),(116,22,264,3.1262,5.314577829570867,0,1,'2026-05-11 04:35:35','LEARNING','2026-05-08 04:35:35.000000'),(117,22,321,3.1262,5.314577829570867,0,1,'2026-05-11 04:35:42','LEARNING','2026-05-08 04:35:42.000000'),(118,22,280,3.1262,5.314577829570867,0,1,'2026-05-12 15:53:05','LEARNING','2026-05-09 15:53:05.000000'),(119,22,206,3.1262,5.314577829570867,0,1,'2026-05-12 15:53:38','LEARNING','2026-05-09 15:53:38.000000'),(120,30,252,748.4802857761699,4.821033195009684,1,3,'2028-05-26 22:28:00','REVIEW','2026-05-09 22:28:00.000000'),(121,30,18,15.4722,3.28285649513529,0,1,'2026-05-24 22:12:17','LEARNING','2026-05-09 22:12:17.000000'),(122,30,77,15.4722,3.28285649513529,0,1,'2026-05-24 22:12:20','LEARNING','2026-05-09 22:12:20.000000'),(123,30,232,2.0097270871201327,5.644377027571822,1,1,'2026-05-09 22:38:36','RELEARNING','2026-05-09 22:28:36.000000'),(124,30,70,2.0097270871201327,5.644377027571822,1,1,'2026-05-09 22:32:42','RELEARNING','2026-05-09 22:22:42.000000'),(125,30,284,3.1262,5.314577829570867,0,1,'2026-05-12 22:12:31','LEARNING','2026-05-09 22:12:31.000000'),(126,30,289,15.4722,3.28285649513529,0,1,'2026-05-24 22:12:53','LEARNING','2026-05-09 22:12:53.000000'),(127,30,206,15.4722,4.5792770275718215,0,2,'2026-05-24 22:24:24','REVIEW','2026-05-09 22:24:24.000000'),(128,30,279,15.4722,3.28285649513529,0,1,'2026-05-24 22:12:59','LEARNING','2026-05-09 22:12:59.000000'),(129,30,75,15.4722,3.28285649513529,0,1,'2026-05-24 22:13:01','LEARNING','2026-05-09 22:13:01.000000'),(130,30,305,0.4072,7.2102,1,0,'2026-05-09 22:23:14','RELEARNING','2026-05-09 22:13:14.000000'),(132,30,207,748.4802857761699,6.1451,1,1,'2028-05-26 22:23:46','REVIEW','2026-05-09 22:23:46.000000'),(133,30,235,748.4802857761699,6.1451,1,1,'2028-05-26 22:28:49','REVIEW','2026-05-09 22:28:49.000000'),(134,30,57,3.1262,5.426229975409143,0,2,'2026-05-12 22:29:54','REVIEW','2026-05-09 22:29:54.000000'),(135,30,281,0.4072,9.3404,2,0,'2026-05-09 22:32:27','RELEARNING','2026-05-09 22:22:27.000000'),(136,30,280,15.4722,3.28285649513529,0,1,'2026-05-24 22:22:29','LEARNING','2026-05-09 22:22:29.000000'),(137,30,233,748.4802857761699,7.2729343900000005,1,2,'2028-05-26 22:28:20','REVIEW','2026-05-09 22:28:20.000000'),(138,30,28,3.1262,5.426229975409143,0,2,'2026-05-12 22:27:52','REVIEW','2026-05-09 22:27:52.000000'),(139,30,58,15.4722,3.731872780647841,0,3,'2026-05-24 22:30:21','REVIEW','2026-05-09 22:30:21.000000'),(140,30,29,15.4722,2.449077027571821,0,2,'2026-05-24 22:27:55','REVIEW','2026-05-09 22:27:55.000000'),(141,30,238,151.2324730415495,7.2102,1,1,'2026-10-07 22:28:47','REVIEW','2026-05-09 22:28:47.000000'),(142,30,208,15.4722,4.5792770275718215,0,2,'2026-05-24 22:24:33','REVIEW','2026-05-09 22:24:33.000000'),(143,30,69,3.1262,5.314577829570867,0,1,'2026-05-12 22:23:00','LEARNING','2026-05-09 22:23:00.000000'),(144,30,60,0.4072,10,3,0,'2026-05-09 22:33:02','RELEARNING','2026-05-09 22:23:02.000000'),(145,30,300,5205.884322142705,8.149831220000001,2,1,'2040-08-09 22:23:52','REVIEW','2026-05-09 22:23:52.000000'),(146,30,290,0.4072,7.2102,1,0,'2026-05-09 22:33:06','RELEARNING','2026-05-09 22:23:06.000000'),(147,30,321,0.4072,7.2102,1,0,'2026-05-09 22:33:07','RELEARNING','2026-05-09 22:23:07.000000'),(148,30,204,0.4072,9.3404,2,0,'2026-05-09 22:33:11','RELEARNING','2026-05-09 22:23:11.000000'),(149,30,16,15.4722,3.28285649513529,0,1,'2026-05-24 22:23:13','LEARNING','2026-05-09 22:23:13.000000'),(150,30,20,15.4722,3.28285649513529,0,1,'2026-05-24 22:23:14','LEARNING','2026-05-09 22:23:14.000000'),(151,30,23,15.4722,3.28285649513529,0,1,'2026-05-24 22:23:16','LEARNING','2026-05-09 22:23:16.000000'),(152,30,24,15.4722,3.28285649513529,0,1,'2026-05-24 22:23:34','LEARNING','2026-05-09 22:23:34.000000'),(153,30,295,15.4722,3.28285649513529,0,1,'2026-05-24 22:23:36','LEARNING','2026-05-09 22:23:36.000000'),(154,30,55,15.4722,2.449077027571821,0,2,'2026-05-24 22:29:50','REVIEW','2026-05-09 22:29:50.000000'),(155,30,269,15.4722,3.28285649513529,0,1,'2026-05-24 22:23:43','LEARNING','2026-05-09 22:23:43.000000'),(156,30,303,15.4722,3.28285649513529,0,1,'2026-05-24 22:23:45','LEARNING','2026-05-09 22:23:45.000000'),(157,30,52,2.0097270871201327,5.644377027571822,1,1,'2026-05-09 22:39:59','RELEARNING','2026-05-09 22:29:59.000000'),(158,30,251,15.4722,3.5141770275718214,0,2,'2026-05-24 22:29:00','REVIEW','2026-05-09 22:29:00.000000'),(159,30,270,15.4722,3.28285649513529,0,1,'2026-05-24 22:23:54','LEARNING','2026-05-09 22:23:54.000000'),(160,30,15,15.4722,3.28285649513529,0,1,'2026-05-24 22:23:56','LEARNING','2026-05-09 22:23:56.000000'),(161,30,212,15.4722,3.28285649513529,0,1,'2026-05-24 22:24:07','LEARNING','2026-05-09 22:24:07.000000'),(162,30,229,15.4722,2.449077027571821,0,2,'2026-05-24 22:24:10','REVIEW','2026-05-09 22:24:10.000000'),(163,30,22,15.4722,3.28285649513529,0,1,'2026-05-24 22:24:11','LEARNING','2026-05-09 22:24:11.000000'),(164,30,54,15.4722,3.5141770275718214,0,2,'2026-05-24 22:29:44','REVIEW','2026-05-09 22:29:44.000000'),(165,30,234,15.4722,3.28285649513529,0,1,'2026-05-24 22:27:47','LEARNING','2026-05-09 22:27:47.000000'),(166,30,26,15.4722,3.28285649513529,0,1,'2026-05-24 22:28:03','LEARNING','2026-05-09 22:28:03.000000'),(167,30,255,3.1262,5.314577829570867,0,1,'2026-05-12 22:28:41','LEARNING','2026-05-09 22:28:41.000000'),(168,30,27,3.1262,5.314577829570867,0,1,'2026-05-12 22:28:53','LEARNING','2026-05-09 22:28:53.000000'),(169,30,239,3.1262,5.314577829570867,0,1,'2026-05-12 22:29:11','LEARNING','2026-05-09 22:29:11.000000'),(170,30,25,3.1262,5.314577829570867,0,1,'2026-05-12 22:29:16','LEARNING','2026-05-09 22:29:16.000000'),(171,30,237,15.4722,3.28285649513529,0,1,'2026-05-24 22:29:19','LEARNING','2026-05-09 22:29:19.000000'),(172,30,236,15.4722,2.449077027571821,0,2,'2026-05-24 22:29:21','REVIEW','2026-05-09 22:29:21.000000'),(173,30,53,15.4722,3.28285649513529,0,1,'2026-05-24 22:29:40','LEARNING','2026-05-09 22:29:40.000000'),(174,30,51,0.4072,7.2102,1,0,'2026-05-09 22:39:47','RELEARNING','2026-05-09 22:29:47.000000'),(175,30,50,1.1829,7.614974572406678,0,2,'2026-05-10 22:30:10','REVIEW','2026-05-09 22:30:10.000000'),(176,30,59,3.1262,5.314577829570867,0,1,'2026-05-12 22:30:15','LEARNING','2026-05-09 22:30:15.000000'),(177,22,239,0.4072,7.2102,1,0,'2026-05-10 19:14:08','RELEARNING','2026-05-10 19:04:08.000000'),(178,22,255,3.1262,5.314577829570867,0,1,'2026-05-13 19:04:14','LEARNING','2026-05-10 19:04:14.000000');
/*!40000 ALTER TABLE `userword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_due_words`
--

DROP TABLE IF EXISTS `v_due_words`;
/*!50001 DROP VIEW IF EXISTS `v_due_words`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_due_words` AS SELECT 
 1 AS `UserId`,
 1 AS `WordSpa`,
 1 AS `WordEng`,
 1 AS `Level`,
 1 AS `State`,
 1 AS `DueDate`,
 1 AS `Stability`,
 1 AS `Lapses`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_ranking`
--

DROP TABLE IF EXISTS `v_ranking`;
/*!50001 DROP VIEW IF EXISTS `v_ranking`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_ranking` AS SELECT 
 1 AS `Id`,
 1 AS `Username`,
 1 AS `Points`,
 1 AS `LevelEstimated`,
 1 AS `Premium`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_user_progress`
--

DROP TABLE IF EXISTS `v_user_progress`;
/*!50001 DROP VIEW IF EXISTS `v_user_progress`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_user_progress` AS SELECT 
 1 AS `UserId`,
 1 AS `Username`,
 1 AS `Theme`,
 1 AS `TotalAttempts`,
 1 AS `CorrectAttempts`,
 1 AS `AccuracyPct`,
 1 AS `Trend`,
 1 AS `LastUpdated`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `word`
--

DROP TABLE IF EXISTS `word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `WordSpa` varchar(100) NOT NULL,
  `WordEng` varchar(100) NOT NULL,
  `Type` enum('Noun','Verb','Adjective','Adverb','Determiner','Preposition') DEFAULT NULL,
  `Image` varchar(200) DEFAULT NULL,
  `Level` enum('BEGINNER','INTERMEDIATE','ADVANCED') NOT NULL DEFAULT 'BEGINNER',
  `IsFalseFriend` tinyint(1) NOT NULL DEFAULT 0,
  `IsIrregular` tinyint(1) NOT NULL DEFAULT 0,
  `FeedbackHint` varchar(300) DEFAULT NULL,
  `feedback_hint` varchar(255) DEFAULT NULL,
  `is_false_friend` bit(1) DEFAULT NULL,
  `is_irregular` bit(1) DEFAULT NULL,
  `word_eng` varchar(255) NOT NULL,
  `word_spa` varchar(255) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `idx_word_level` (`Level`),
  KEY `idx_word_false` (`IsFalseFriend`),
  KEY `idx_word_spa` (`WordSpa`),
  KEY `idx_word_eng` (`WordEng`)
) ENGINE=InnoDB AUTO_INCREMENT=324 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word`
--

LOCK TABLES `word` WRITE;
/*!40000 ALTER TABLE `word` DISABLE KEYS */;
INSERT INTO `word` VALUES (15,'perro','dog','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'dog','perro'),(16,'gato','cat','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'cat','gato'),(17,'pájaro','bird','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'bird','pájaro'),(18,'pez','fish','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'fish','pez'),(19,'caballo','horse','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'horse','caballo'),(20,'rojo','red','Adjective',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'red','rojo'),(21,'azul','blue','Adjective',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'blue','azul'),(22,'verde','green','Adjective',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'green','verde'),(23,'negro','black','Adjective',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'black','negro'),(24,'blanco','white','Adjective',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'white','blanco'),(25,'manzana','apple','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'apple','manzana'),(26,'pan','bread','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'bread','pan'),(27,'agua','water','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'water','agua'),(28,'leche','milk','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'milk','leche'),(29,'huevo','egg','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'egg','huevo'),(30,'correr','run','Verb',NULL,'INTERMEDIATE',0,1,NULL,NULL,NULL,NULL,'run','correr'),(31,'comer','eat','Verb',NULL,'INTERMEDIATE',0,1,NULL,NULL,NULL,NULL,'eat','comer'),(32,'beber','drink','Verb',NULL,'INTERMEDIATE',0,1,NULL,NULL,NULL,NULL,'drink','beber'),(33,'dormir','sleep','Verb',NULL,'INTERMEDIATE',0,1,NULL,NULL,NULL,NULL,'sleep','dormir'),(34,'hablar','speak','Verb',NULL,'INTERMEDIATE',0,1,NULL,NULL,NULL,NULL,'speak','hablar'),(35,'aunque','although','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(36,'sin embargo','however','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(37,'por lo tanto','therefore','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(38,'mientras','while','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(39,'además','furthermore','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(40,'aunque sea','even if','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(41,'de hecho','in fact','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(42,'en cambio','instead','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(43,'por eso','that is why','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(44,'a pesar de','despite','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(45,'en consecuencia','consequently','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(46,'es decir','that is','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(47,'por otro lado','on the other hand','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(48,'al menos','at least','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(49,'de todas formas','anyway','Adverb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(50,'leer','read','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(51,'dibujar','draw','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(52,'cantar','sing','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(53,'bailar','dance','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(54,'jugar','play','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(55,'escribir','write','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(56,'correr','run','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(57,'nadar','swim','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(58,'viajar','travel','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(59,'estudiar','study','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(60,'doctor','doctor','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(61,'profesor','teacher','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(62,'ingeniero','engineer','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(66,'cocinero','chef','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(69,'policía','police officer','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(70,'lluvia','rain','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(71,'soleado','sunny','Adjective',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(75,'nevar','snow','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(76,'calor','heat','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(77,'frío','cold','Adjective',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(78,'clima','weather','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(202,'árbitro','referee','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(203,'empate','draw','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(204,'lesión','injury','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(205,'entrenador','coach','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(206,'portero','goalkeeper','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(207,'aficionado','fan','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(208,'marca personal','personal best','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(209,'torneo','tournament','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(210,'clasificarse','to qualify','Verb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(211,'fuera de juego','offside','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(212,'esprint','sprint','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(213,'podio','podium','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(214,'remate','shot on goal','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(215,'deportividad','sportsmanship','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(216,'convocatoria','squad','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(217,'árbitro de línea','linesman','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(218,'récord mundial','world record','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(219,'palmarés','track record','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(220,'lesionarse','to get injured','Verb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(221,'velocista','sprinter','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(222,'tiro libre','free kick','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(223,'descalificación','disqualification','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(224,'aficionado local','home fan','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(225,'prórroga','extra time','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(226,'tanteo','scoreline','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(227,'golpe de estado','knockout blow','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(228,'balón','ball','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(229,'portería','goal','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(230,'paliza','thrashing','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(231,'ronda eliminatoria','knockout round','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(232,'nevera','fridge','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(233,'receta','recipe','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(234,'hervir','to boil','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(235,'a la plancha','grilled','Adjective',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(236,'mariscos','seafood','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(237,'hornear','to bake','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(238,'picar','to snack','Verb',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(239,'entrante','starter','Noun',NULL,'BEGINNER',0,0,'In the US they say \'appetizer\'',NULL,NULL,NULL,'',''),(240,'condimento','seasoning','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(241,'alérgeno','allergen','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(242,'sobras','leftovers','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(243,'madurar','to ripen','Verb',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(244,'antojo','craving','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(245,'sin gluten','gluten-free','Adjective',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(246,'fecha de caducidad','expiry date','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(247,'desperdicio alimentario','food waste','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(248,'fermentación','fermentation','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(249,'almíbar','syrup','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(250,'buffet libre','all-you-can-eat','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(251,'picante','spicy','Adjective',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(252,'crudo','raw','Adjective',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(253,'olla a presión','pressure cooker','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(254,'marinada','marinade','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(255,'temporada','season','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(256,'caldo','broth','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(257,'cubiertos','cutlery','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(258,'guarnición','side dish','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(259,'paladeador','food critic','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(260,'umami','umami','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(261,'empalagoso','sickly sweet','Adjective',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(262,'tormenta','storm','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(263,'llovizna','drizzle','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(264,'brisa','breeze','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(265,'granizo','hail','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(266,'niebla','fog','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(267,'sequía','drought','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(268,'ola de calor','heat wave','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(269,'pronóstico','forecast','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(270,'relámpago','lightning','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(271,'nublado','overcast','Adjective',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(272,'ventisca','blizzard','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(273,'aguacero','downpour','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(274,'helada','frost','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(275,'humedad','humidity','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(276,'bochornoso','muggy','Adjective',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(277,'tifón','typhoon','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(278,'cambio climático','climate change','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(279,'arco iris','rainbow','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(280,'temperatura','temperature','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(281,'cielo despejado','clear sky','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(282,'granizada','hailstorm','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(283,'presión atmosférica','atmospheric pressure','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(284,'chubasquero','raincoat','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(285,'neblina','mist','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(286,'viento huracanado','gale','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(287,'niebla baja','low-lying fog','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(288,'copo de nieve','snowflake','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(289,'nieve','snow','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(290,'viento','wind','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(291,'lluvia ácida','acid rain','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(292,'rayo','thunderbolt','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(293,'fontanero','plumber','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(294,'contable','accountant','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(295,'enfermero','nurse','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(296,'arquitecto','architect','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(297,'periodista','journalist','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(298,'electricista','electrician','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(299,'traductor','translator','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(300,'veterinario','vet','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(301,'cirujano','surgeon','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(302,'psicólogo','psychologist','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(303,'piloto','pilot','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(304,'investigador','researcher','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(305,'bombero','firefighter','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(306,'diseñador gráfico','graphic designer','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(307,'abogado','lawyer','Noun',NULL,'BEGINNER',1,0,'Lawyer (general)/solicitor (UK)/barrister (UK)/attorney (US)',NULL,NULL,NULL,'',''),(308,'sommelier','sommelier','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(309,'auditor','auditor','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(310,'terapeuta','therapist','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(311,'actuario','actuary','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(312,'tasador','appraiser','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(313,'logístico','logistics manager','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(314,'asistente social','social worker','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(315,'farmacéutico','pharmacist','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(316,'detective','detective','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(317,'geólogo','geologist','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(318,'técnico de laboratorio','lab technician','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(319,'director ejecutivo','CEO','Noun',NULL,'ADVANCED',0,0,NULL,NULL,NULL,NULL,'',''),(320,'asistente personal','personal assistant','Noun',NULL,'INTERMEDIATE',0,0,NULL,NULL,NULL,NULL,'',''),(321,'guía turístico','tour guide','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(322,'socorrista','lifeguard','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'',''),(323,'chef','chef','Noun',NULL,'BEGINNER',0,0,NULL,NULL,NULL,NULL,'','');
/*!40000 ALTER TABLE `word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word_copy`
--

DROP TABLE IF EXISTS `word_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(6) DEFAULT NULL,
  `word_eng` varchar(255) NOT NULL,
  `word_spa` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word_copy`
--

LOCK TABLES `word_copy` WRITE;
/*!40000 ALTER TABLE `word_copy` DISABLE KEYS */;
/*!40000 ALTER TABLE `word_copy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word_theme`
--

DROP TABLE IF EXISTS `word_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word_theme` (
  `word_id` int(11) NOT NULL,
  `theme_id` int(11) NOT NULL,
  PRIMARY KEY (`word_id`,`theme_id`),
  KEY `FKk3c5l9af02obe6t5p3crqqah9` (`theme_id`),
  CONSTRAINT `FK6jnn532dg75cxaos188ieuwki` FOREIGN KEY (`word_id`) REFERENCES `word` (`Id`),
  CONSTRAINT `FKk3c5l9af02obe6t5p3crqqah9` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word_theme`
--

LOCK TABLES `word_theme` WRITE;
/*!40000 ALTER TABLE `word_theme` DISABLE KEYS */;
/*!40000 ALTER TABLE `word_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wordcopy`
--

DROP TABLE IF EXISTS `wordcopy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wordcopy` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `WordSpa` varchar(100) NOT NULL,
  `WordEng` varchar(100) NOT NULL,
  `CreationDate` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`Id`),
  UNIQUE KEY `WordSpa` (`WordSpa`,`WordEng`),
  KEY `idx_cache_spa` (`WordSpa`),
  KEY `idx_cache_eng` (`WordEng`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wordcopy`
--

LOCK TABLES `wordcopy` WRITE;
/*!40000 ALTER TABLE `wordcopy` DISABLE KEYS */;
INSERT INTO `wordcopy` VALUES (1,'perro','dog','2026-05-01 06:51:54'),(2,'gato','cat','2026-05-01 06:51:54'),(3,'pájaro','bird','2026-05-01 06:51:54'),(4,'pez','fish','2026-05-01 06:51:54'),(5,'caballo','horse','2026-05-01 06:51:54'),(6,'rojo','red','2026-05-01 06:51:54'),(7,'azul','blue','2026-05-01 06:51:54'),(8,'verde','green','2026-05-01 06:51:54'),(9,'negro','black','2026-05-01 06:51:54'),(10,'blanco','white','2026-05-01 06:51:54'),(11,'manzana','apple','2026-05-01 06:51:54'),(12,'pan','bread','2026-05-01 06:51:54'),(13,'agua','water','2026-05-01 06:51:54'),(14,'leche','milk','2026-05-01 06:51:54'),(15,'huevo','egg','2026-05-01 06:51:54'),(16,'correr','run','2026-05-01 06:51:54'),(17,'comer','eat','2026-05-01 06:51:54'),(18,'beber','drink','2026-05-01 06:51:54'),(19,'dormir','sleep','2026-05-01 06:51:54'),(20,'hablar','speak','2026-05-01 06:51:54'),(21,'clima','climate','2026-05-03 08:12:14'),(22,'clima','ambiente : atmosphere','2026-05-03 08:12:14'),(23,'clima','ambience','2026-05-03 08:12:14'),(24,'cocinero','cook','2026-05-03 08:19:32'),(25,'cocinero','chef','2026-05-03 08:19:32'),(26,'picante','hot','2026-05-09 22:29:00'),(27,'picante','spicy','2026-05-09 22:29:00'),(28,'picante','sharp','2026-05-09 22:29:00'),(29,'picante','cutting','2026-05-09 22:29:00'),(30,'picante','racy','2026-05-09 22:29:00'),(31,'picante','risqué','2026-05-09 22:29:00'),(32,'picante','spiciness','2026-05-09 22:29:00'),(33,'picante','hot spices plural','2026-05-09 22:29:00'),(34,'picante','hot sauce','2026-05-09 22:29:00'),(35,'picante','radish','2026-05-09 22:29:00'),(36,'picante','horseradish','2026-05-09 22:29:00');
/*!40000 ALTER TABLE `wordcopy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wordtheme`
--

DROP TABLE IF EXISTS `wordtheme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wordtheme` (
  `WordId` int(11) NOT NULL,
  `ThemeId` int(11) NOT NULL,
  PRIMARY KEY (`WordId`,`ThemeId`),
  KEY `idx_wt_word` (`WordId`),
  KEY `idx_wt_theme` (`ThemeId`),
  CONSTRAINT `wordtheme_ibfk_1` FOREIGN KEY (`WordId`) REFERENCES `word` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `wordtheme_ibfk_2` FOREIGN KEY (`ThemeId`) REFERENCES `theme` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wordtheme`
--

LOCK TABLES `wordtheme` WRITE;
/*!40000 ALTER TABLE `wordtheme` DISABLE KEYS */;
INSERT INTO `wordtheme` VALUES (15,42),(16,42),(17,42),(18,42),(19,42),(20,42),(21,42),(22,42),(23,42),(24,42),(25,34),(26,34),(27,34),(28,34),(29,34),(35,42),(36,42),(37,42),(38,42),(39,42),(40,42),(41,42),(42,42),(43,42),(44,42),(45,42),(46,42),(47,42),(48,42),(49,42),(50,40),(51,40),(52,40),(53,40),(54,40),(55,40),(56,40),(57,40),(58,40),(59,40),(60,41),(61,41),(62,41),(66,41),(69,41),(70,37),(71,37),(75,37),(76,37),(77,37),(78,37),(202,33),(203,33),(204,33),(205,33),(206,33),(207,33),(208,33),(209,33),(210,33),(211,33),(212,33),(213,33),(214,33),(215,33),(216,33),(217,33),(218,33),(219,33),(220,33),(221,33),(222,33),(223,33),(224,33),(225,33),(226,33),(227,33),(228,33),(229,33),(230,33),(231,33),(232,34),(233,34),(234,34),(235,34),(236,34),(237,34),(238,34),(239,34),(240,34),(241,34),(242,34),(243,34),(244,34),(245,34),(246,34),(247,34),(248,34),(249,34),(250,34),(251,34),(252,34),(253,34),(254,34),(255,34),(256,34),(257,34),(258,34),(259,34),(260,34),(261,34),(262,37),(263,37),(264,37),(265,37),(266,37),(267,37),(268,37),(269,37),(270,37),(271,37),(272,37),(273,37),(274,37),(275,37),(276,37),(277,37),(278,37),(279,37),(280,37),(281,37),(282,37),(283,37),(284,37),(285,37),(286,37),(287,37),(288,37),(289,37),(290,37),(291,37),(292,37),(293,41),(294,41),(295,41),(296,41),(297,41),(298,41),(299,41),(300,41),(301,41),(302,41),(303,41),(304,41),(305,41),(306,41),(307,41),(308,41),(309,41),(310,41),(311,41),(312,41),(313,41),(314,41),(315,41),(316,41),(317,41),(318,41),(319,41),(320,41),(321,41),(322,41),(323,41);
/*!40000 ALTER TABLE `wordtheme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'compassenglishbd'
--

--
-- Final view structure for view `v_due_words`
--

/*!50001 DROP VIEW IF EXISTS `v_due_words`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_due_words` AS select `uw`.`UserId` AS `UserId`,`w`.`WordSpa` AS `WordSpa`,`w`.`WordEng` AS `WordEng`,`w`.`Level` AS `Level`,`uw`.`State` AS `State`,`uw`.`DueDate` AS `DueDate`,`uw`.`Stability` AS `Stability`,`uw`.`Lapses` AS `Lapses` from (`userword` `uw` join `word` `w` on(`uw`.`WordId` = `w`.`Id`)) where `uw`.`DueDate` <= current_timestamp() */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_ranking`
--

/*!50001 DROP VIEW IF EXISTS `v_ranking`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_ranking` AS select `user`.`Id` AS `Id`,`user`.`Username` AS `Username`,`user`.`Points` AS `Points`,`user`.`LevelEstimated` AS `LevelEstimated`,`user`.`Premium` AS `Premium` from `user` order by `user`.`Points` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user_progress`
--

/*!50001 DROP VIEW IF EXISTS `v_user_progress`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_progress` AS select `up`.`UserId` AS `UserId`,`u`.`Username` AS `Username`,`t`.`Name` AS `Theme`,`up`.`TotalAttempts` AS `TotalAttempts`,`up`.`CorrectAttempts` AS `CorrectAttempts`,round(`up`.`CorrectAttempts` * 100.0 / nullif(`up`.`TotalAttempts`,0),1) AS `AccuracyPct`,`up`.`Trend` AS `Trend`,`up`.`LastUpdated` AS `LastUpdated` from ((`userprogress` `up` join `user` `u` on(`up`.`UserId` = `u`.`Id`)) join `theme` `t` on(`up`.`ThemeId` = `t`.`Id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-11  7:23:35
