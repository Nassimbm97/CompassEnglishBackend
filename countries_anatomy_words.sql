-- ================================================================
--  PALABRAS COUNTRIES + ANATOMY — CompassEnglish
--  Solo añade palabras y fill-gaps — no toca nada más
-- ================================================================

INSERT INTO `word` (`WordSpa`,`WordEng`,`Type`,`FeedbackHint`,`Level`,`IsFalseFriend`,`IsIrregular`,`WordSpaPlain`,`WordEngPlain`) VALUES
  ('frontera','border','Noun',NULL,'BEGINNER',0,0,'frontera','border'),
  ('embajada','embassy','Noun',NULL,'INTERMEDIATE',0,0,'embajada','embassy'),
  ('ciudadanía','citizenship','Noun',NULL,'ADVANCED',0,0,'ciudadanía','citizenship'),
  ('capital','capital','Noun','Capital in English also means money or main/chief','BEGINNER',1,0,'capital','capital'),
  ('moneda','currency','Noun',NULL,'INTERMEDIATE',0,0,'moneda','currency'),
  ('patrimonio','heritage','Noun',NULL,'ADVANCED',0,0,'patrimonio','heritage'),
  ('inmigrante','immigrant','Noun',NULL,'INTERMEDIATE',0,0,'inmigrante','immigrant'),
  ('tratado','treaty','Noun',NULL,'ADVANCED',0,0,'tratado','treaty'),
  ('gobierno','government','Noun',NULL,'BEGINNER',0,0,'gobierno','government'),
  ('refugiado','refugee','Noun',NULL,'INTERMEDIATE',0,0,'refugiado','refugee'),
  ('constitución','constitution','Noun',NULL,'ADVANCED',0,0,'constitución','constitution'),
  ('exportación','export','Noun',NULL,'INTERMEDIATE',0,0,'exportación','export'),
  ('soberanía','sovereignty','Noun',NULL,'ADVANCED',0,0,'soberanía','sovereignty'),
  ('idioma oficial','official language','Noun',NULL,'INTERMEDIATE',0,0,'idioma oficial','official language'),
  ('alianza','alliance','Noun',NULL,'ADVANCED',0,0,'alianza','alliance'),
  ('acuerdo','agreement','Noun',NULL,'BEGINNER',0,0,'acuerdo','agreement'),
  ('república','republic','Noun',NULL,'INTERMEDIATE',0,0,'república','republic'),
  ('sanción','sanction','Noun',NULL,'ADVANCED',0,0,'sanción','sanction'),
  ('minoría','minority','Noun',NULL,'INTERMEDIATE',0,0,'minoría','minority'),
  ('territorio','territory','Noun',NULL,'INTERMEDIATE',0,0,'territorio','territory'),
  ('tobillo','ankle','Noun',NULL,'BEGINNER',0,0,'tobillo','ankle'),
  ('muñeca','wrist','Noun','Do not confuse: muñeca = wrist AND doll','BEGINNER',1,0,'muñeca','wrist'),
  ('columna vertebral','spine','Noun',NULL,'INTERMEDIATE',0,0,'columna vertebral','spine'),
  ('pulmón','lung','Noun',NULL,'BEGINNER',0,0,'pulmón','lung'),
  ('tendón','tendon','Noun',NULL,'INTERMEDIATE',0,0,'tendón','tendon'),
  ('párpado','eyelid','Noun',NULL,'INTERMEDIATE',0,0,'párpado','eyelid'),
  ('codo','elbow','Noun',NULL,'BEGINNER',0,0,'codo','elbow'),
  ('diafragma','diaphragm','Noun',NULL,'ADVANCED',0,0,'diafragma','diaphragm'),
  ('nuca','nape','Noun',NULL,'ADVANCED',0,0,'nuca','nape'),
  ('cartílago','cartilage','Noun',NULL,'ADVANCED',0,0,'cartílago','cartilage'),
  ('clavícula','collarbone','Noun',NULL,'INTERMEDIATE',0,0,'clavícula','collarbone'),
  ('nervio','nerve','Noun',NULL,'INTERMEDIATE',0,0,'nervio','nerve'),
  ('arteria','artery','Noun',NULL,'INTERMEDIATE',0,0,'arteria','artery'),
  ('glándula','gland','Noun',NULL,'ADVANCED',0,0,'glándula','gland'),
  ('mandíbula','jaw','Noun',NULL,'INTERMEDIATE',0,0,'mandíbula','jaw'),
  ('músculo','muscle','Noun',NULL,'BEGINNER',0,0,'músculo','muscle'),
  ('médula ósea','bone marrow','Noun',NULL,'ADVANCED',0,0,'médula ósea','bone marrow'),
  ('córnea','cornea','Noun',NULL,'ADVANCED',0,0,'córnea','cornea'),
  ('pelvis','pelvis','Noun',NULL,'INTERMEDIATE',0,0,'pelvis','pelvis'),
  ('esófago','oesophagus','Noun',NULL,'ADVANCED',0,0,'esófago','oesophagus'),
  ('córtex','cortex','Noun',NULL,'ADVANCED',0,0,'córtex','cortex');

INSERT INTO `wordtheme` (`WordId`, `ThemeId`)
SELECT w.Id, 38 FROM `word` w WHERE w.WordSpa IN ('frontera','embajada','ciudadanía','capital','moneda','patrimonio','inmigrante','tratado','gobierno','refugiado','constitución','exportación','soberanía','idioma oficial','alianza','acuerdo','república','sanción','minoría','territorio')
UNION ALL
SELECT w.Id, 39 FROM `word` w WHERE w.WordSpa IN ('tobillo','muñeca','columna vertebral','pulmón','tendón','párpado','codo','diafragma','nuca','cartílago','clavícula','nervio','arteria','glándula','mandíbula','músculo','médula ósea','córnea','pelvis','esófago','córtex');

INSERT INTO `fillgapexercise` (`WordId`,`PhraseEng`,`PhraseSpa`,`Answer`,`AlternativeAnswers`,`Level`,`Category`)
SELECT sub.wid,sub.pe,sub.ps,sub.ans,sub.alts,sub.lvl,sub.cat FROM (
  SELECT (SELECT Id FROM `word` WHERE WordSpa='frontera' LIMIT 1) AS wid,'You need a valid passport to cross the international ___ between Spain and France.' AS pe,'Necesitas pasaporte para cruzar la frontera internacional entre España y Francia.' AS ps,'border' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='frontera' LIMIT 1) AS wid,'The two countries share a long mountain ___ that stretches for five hundred kilometres.' AS pe,'Los dos países comparten una larga frontera montañosa.' AS ps,'border' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='embajada' LIMIT 1) AS wid,'Contact your country\'s ___ immediately if you lose your passport abroad.' AS pe,'Contacta la embajada si pierdes el pasaporte en el extranjero.' AS ps,'embassy' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='embajada' LIMIT 1) AS wid,'The ___ issues visas and provides legal assistance to citizens in emergencies.' AS pe,'La embajada emite visados y asiste a ciudadanos en emergencias.' AS ps,'embassy' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='ciudadanía' LIMIT 1) AS wid,'She applied for Spanish ___ after living in Madrid for ten years.' AS pe,'Solicitó la ciudadanía española tras vivir en Madrid diez años.' AS ps,'citizenship' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='ciudadanía' LIMIT 1) AS wid,'Dual ___ is permitted in some countries but not in others.' AS pe,'La doble ciudadanía está permitida en algunos países pero no en otros.' AS ps,'citizenship' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='capital' LIMIT 1) AS wid,'Paris is the ___ of France and its most populated city.' AS pe,'París es la capital de Francia y su ciudad más poblada.' AS ps,'capital' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='capital' LIMIT 1) AS wid,'The ___ city usually hosts the main government buildings and parliament.' AS pe,'La capital alberga los principales edificios gubernamentales.' AS ps,'capital' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='moneda' LIMIT 1) AS wid,'The ___ of Japan is the yen, not the dollar.' AS pe,'La moneda de Japón es el yen, no el dólar.' AS ps,'currency' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='moneda' LIMIT 1) AS wid,'Always check the exchange rate before converting your ___ abroad.' AS pe,'Comprueba siempre el tipo de cambio antes de cambiar tu moneda en el extranjero.' AS ps,'currency' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='patrimonio' LIMIT 1) AS wid,'The old town centre was declared a UNESCO World ___ Site in 1987.' AS pe,'El casco antiguo fue declarado Patrimonio de la Humanidad por la UNESCO en 1987.' AS ps,'heritage' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='patrimonio' LIMIT 1) AS wid,'Cultural ___ includes traditions, language and historic buildings passed down through generations.' AS pe,'El patrimonio cultural incluye tradiciones, idioma y edificios históricos transmitidos a través de generaciones.' AS ps,'heritage' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='inmigrante' LIMIT 1) AS wid,'The country introduced a new policy to welcome skilled ___ workers from abroad.' AS pe,'El país introdujo una nueva política para acoger trabajadores inmigrantes cualificados del extranjero.' AS ps,'immigrant' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='inmigrante' LIMIT 1) AS wid,'Second-generation ___s often feel connected to two different cultures at the same time.' AS pe,'Los inmigrantes de segunda generación suelen sentirse conectados a dos culturas distintas al mismo tiempo.' AS ps,'immigrants' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='tratado' LIMIT 1) AS wid,'The two nations signed a peace ___ after years of armed conflict.' AS pe,'Las dos naciones firmaron un tratado de paz tras años de conflicto armado.' AS ps,'treaty' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='tratado' LIMIT 1) AS wid,'The trade ___ eliminated tariffs between the member states and boosted the economy.' AS pe,'El tratado comercial eliminó aranceles entre los estados miembros e impulsó la economía.' AS ps,'treaty' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='gobierno' LIMIT 1) AS wid,'The ___ announced a series of measures to tackle rising unemployment.' AS pe,'El gobierno anunció una serie de medidas para combatir el creciente desempleo.' AS ps,'government' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='gobierno' LIMIT 1) AS wid,'A democratic ___ is elected by the people through free and fair elections.' AS pe,'Un gobierno democrático es elegido por el pueblo mediante elecciones libres y justas.' AS ps,'government' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='refugiado' LIMIT 1) AS wid,'___ camps provide temporary shelter and food for people forced to flee their homes.' AS pe,'Los campos de refugiados ofrecen cobijo temporal y comida a personas obligadas a huir.' AS ps,'refugee' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='refugiado' LIMIT 1) AS wid,'The country granted asylum to thousands of ___s who had escaped the war.' AS pe,'El país concedió asilo a miles de refugiados que habían huido de la guerra.' AS ps,'refugees' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='constitución' LIMIT 1) AS wid,'The ___ guarantees freedom of speech and the right to a fair trial for all citizens.' AS pe,'La constitución garantiza la libertad de expresión y el derecho a un juicio justo.' AS ps,'constitution' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='constitución' LIMIT 1) AS wid,'Any change to the ___ requires approval by a two-thirds majority in parliament.' AS pe,'Cualquier cambio en la constitución requiere la aprobación de dos tercios del parlamento.' AS ps,'constitution' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='exportación' LIMIT 1) AS wid,'Oil is still the country\'s most important ___ product by value.' AS pe,'El petróleo sigue siendo el producto de exportación más importante del país por valor.' AS ps,'export' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='exportación' LIMIT 1) AS wid,'Germany is widely known for its high-quality car ___s across the world.' AS pe,'Alemania es ampliamente conocida por sus exportaciones de coches de alta calidad en todo el mundo.' AS ps,'exports' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='soberanía' LIMIT 1) AS wid,'The nation firmly defended its ___ against any form of foreign interference.' AS pe,'La nación defendió firmemente su soberanía contra cualquier forma de injerencia extranjera.' AS ps,'sovereignty' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='soberanía' LIMIT 1) AS wid,'National ___ means that a country has the right to govern its own affairs.' AS pe,'La soberanía nacional significa que un país tiene el derecho a gobernar sus propios asuntos.' AS ps,'sovereignty' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='idioma oficial' LIMIT 1) AS wid,'Canada has two ___ languages: English and French, used in all public services.' AS pe,'Canadá tiene dos idiomas oficiales: inglés y francés, usados en todos los servicios públicos.' AS ps,'official languages' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='idioma oficial' LIMIT 1) AS wid,'Switzerland recognises four ___ languages, which makes it quite unique in Europe.' AS pe,'Suiza reconoce cuatro idiomas oficiales, lo que la hace bastante única en Europa.' AS ps,'official languages' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='alianza' LIMIT 1) AS wid,'The military ___ was formed to protect all member states from external threats.' AS pe,'La alianza militar se formó para proteger a todos los estados miembros de amenazas externas.' AS ps,'alliance' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='alianza' LIMIT 1) AS wid,'A trade ___ between the two countries boosted exports and created thousands of jobs.' AS pe,'Una alianza comercial entre los dos países impulsó las exportaciones y creó miles de empleos.' AS ps,'alliance' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='acuerdo' LIMIT 1) AS wid,'Both sides finally reached an ___ after three weeks of difficult negotiations.' AS pe,'Ambas partes llegaron finalmente a un acuerdo tras tres semanas de difíciles negociaciones.' AS ps,'agreement' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='acuerdo' LIMIT 1) AS wid,'The climate ___ was signed by almost two hundred countries at the summit.' AS pe,'El acuerdo climático fue firmado por casi doscientos países en la cumbre.' AS ps,'agreement' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='república' LIMIT 1) AS wid,'France is a democratic ___ with an elected president who serves for five years.' AS pe,'Francia es una república democrática con un presidente elegido que sirve durante cinco años.' AS ps,'republic' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='república' LIMIT 1) AS wid,'A ___ differs from a monarchy in that it has no king or queen as head of state.' AS pe,'Una república se diferencia de una monarquía en que no tiene rey ni reina como jefe de Estado.' AS ps,'republic' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='sanción' LIMIT 1) AS wid,'Economic ___s were imposed on the country following violations of international law.' AS pe,'Se impusieron sanciones económicas al país tras violaciones del derecho internacional.' AS ps,'sanctions' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='sanción' LIMIT 1) AS wid,'International ___s can seriously damage a country\'s economy and isolate it diplomatically.' AS pe,'Las sanciones internacionales pueden dañar gravemente la economía de un país y aislarlo diplomáticamente.' AS ps,'sanctions' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='minoría' LIMIT 1) AS wid,'The new law was specifically designed to protect the rights of ethnic ___s.' AS pe,'La nueva ley fue diseñada específicamente para proteger los derechos de las minorías étnicas.' AS ps,'minorities' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='minoría' LIMIT 1) AS wid,'A linguistic ___ speaks a different language from the majority of the population.' AS pe,'Una minoría lingüística habla un idioma diferente al de la mayoría de la población.' AS ps,'minority' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='territorio' LIMIT 1) AS wid,'The disputed ___ has been a source of tension between the two countries for decades.' AS pe,'El territorio en disputa ha sido fuente de tensión entre los dos países durante décadas.' AS ps,'territory' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='territorio' LIMIT 1) AS wid,'Overseas ___ refers to land governed by a country located outside its main continent.' AS pe,'El territorio de ultramar hace referencia a tierras gobernadas por un país fuera de su continente principal.' AS ps,'territory' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='tobillo' LIMIT 1) AS wid,'She sprained her ___ badly while running on uneven ground and had to stop training.' AS pe,'Se torció gravemente el tobillo mientras corría en terreno irregular y tuvo que parar de entrenar.' AS ps,'ankle' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='tobillo' LIMIT 1) AS wid,'The ___ connects the lower leg to the foot and supports the body\'s weight.' AS pe,'El tobillo conecta la parte inferior de la pierna con el pie y soporta el peso del cuerpo.' AS ps,'ankle' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='muñeca' LIMIT 1) AS wid,'She wears a fitness tracker on her ___ to monitor her daily steps and heart rate.' AS pe,'Lleva una pulsera de actividad en la muñeca para monitorizar sus pasos diarios y frecuencia cardíaca.' AS ps,'wrist' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='muñeca' LIMIT 1) AS wid,'A broken ___ is one of the most common fractures seen in accident and emergency departments.' AS pe,'Una muñeca rota es una de las fracturas más comunes que se ven en urgencias.' AS ps,'wrist' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='columna vertebral' LIMIT 1) AS wid,'Poor posture at a desk can cause serious damage to your ___ over time.' AS pe,'Una mala postura en el escritorio puede causar daños graves en tu columna vertebral con el tiempo.' AS ps,'spine' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='columna vertebral' LIMIT 1) AS wid,'The ___ supports the upper body and protects the spinal cord from injury.' AS pe,'La columna vertebral soporta la parte superior del cuerpo y protege la médula espinal.' AS ps,'spine' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='pulmón' LIMIT 1) AS wid,'Smoking causes serious and irreversible damage to the ___s over time.' AS pe,'Fumar causa daños graves e irreversibles en los pulmones con el tiempo.' AS ps,'lungs' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='pulmón' LIMIT 1) AS wid,'Each ___ is divided into sections called lobes that exchange oxygen and carbon dioxide.' AS pe,'Cada pulmón está dividido en secciones llamadas lóbulos que intercambian oxígeno y dióxido de carbono.' AS ps,'lung' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='tendón' LIMIT 1) AS wid,'The Achilles ___ connects the calf muscle to the heel bone at the back of the foot.' AS pe,'El tendón de Aquiles conecta el músculo gemelar con el hueso del talón en la parte posterior del pie.' AS ps,'tendon' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='tendón' LIMIT 1) AS wid,'A ruptured ___ requires surgery and several months of physiotherapy to recover fully.' AS pe,'Un tendón roto requiere cirugía y varios meses de fisioterapia para recuperarse completamente.' AS ps,'tendon' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='párpado' LIMIT 1) AS wid,'A twitching ___ can be a sign of stress, fatigue or excessive caffeine intake.' AS pe,'Un párpado que parpadea puede ser señal de estrés, fatiga o consumo excesivo de cafeína.' AS ps,'eyelid' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='párpado' LIMIT 1) AS wid,'The ___ protects the eye from dust, bright light and physical contact.' AS pe,'El párpado protege el ojo del polvo, la luz intensa y el contacto físico.' AS ps,'eyelid' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='codo' LIMIT 1) AS wid,'He bumped his ___ hard against the corner of the table and it hurt a lot.' AS pe,'Se golpeó el codo con fuerza contra la esquina de la mesa y le dolió mucho.' AS ps,'elbow' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='codo' LIMIT 1) AS wid,'Tennis ___ is a painful condition caused by repetitive arm movements over time.' AS pe,'El codo de tenista es una dolorosa afección causada por movimientos repetitivos del brazo con el tiempo.' AS ps,'elbow' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='diafragma' LIMIT 1) AS wid,'The ___ is the main muscle responsible for breathing in and out.' AS pe,'El diafragma es el principal músculo responsable de respirar hacia dentro y hacia fuera.' AS ps,'diaphragm' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='diafragma' LIMIT 1) AS wid,'Hiccups occur when the ___ contracts involuntarily and causes a sudden intake of air.' AS pe,'El hipo ocurre cuando el diafragma se contrae de forma involuntaria y provoca una entrada de aire repentina.' AS ps,'diaphragm' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='nuca' LIMIT 1) AS wid,'She felt tension building in her ___ after spending six hours in front of the computer.' AS pe,'Sintió tensión acumulándose en la nuca tras pasar seis horas frente al ordenador.' AS ps,'nape' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='nuca' LIMIT 1) AS wid,'A gentle massage on the ___ can relieve tension headaches and neck stiffness.' AS pe,'Un masaje suave en la nuca puede aliviar las cefaleas tensionales y la rigidez cervical.' AS ps,'nape' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='cartílago' LIMIT 1) AS wid,'The ___ in his knee gradually wore down after years of long-distance running.' AS pe,'El cartílago de su rodilla se desgastó gradualmente tras años de carrera de larga distancia.' AS ps,'cartilage' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='cartílago' LIMIT 1) AS wid,'___ is a flexible tissue that cushions the joints and prevents bones from rubbing together.' AS pe,'El cartílago es un tejido flexible que amortigua las articulaciones y evita que los huesos rocen entre sí.' AS ps,'cartilage' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='clavícula' LIMIT 1) AS wid,'She fractured her ___ in a cycling accident and had to wear a sling for six weeks.' AS pe,'Se fracturó la clavícula en un accidente de bicicleta y tuvo que llevar un cabestrillo seis semanas.' AS ps,'collarbone' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='clavícula' LIMIT 1) AS wid,'The ___ connects the shoulder blade to the breastbone and is easy to break in a fall.' AS pe,'La clavícula conecta el omóplato con el esternón y es fácil de romper en una caída.' AS ps,'collarbone' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='nervio' LIMIT 1) AS wid,'The dentist injected local anaesthetic to numb the ___ before starting the procedure.' AS pe,'El dentista inyectó anestesia local para adormecer el nervio antes de empezar el procedimiento.' AS ps,'nerve' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='nervio' LIMIT 1) AS wid,'Damaged ___ fibres can cause tingling, numbness or sharp pain in the affected area.' AS pe,'Las fibras nerviosas dañadas pueden causar hormigueo, entumecimiento o dolor agudo en la zona afectada.' AS ps,'nerve' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='arteria' LIMIT 1) AS wid,'The main ___ carries oxygenated blood from the heart to the rest of the body.' AS pe,'La arteria principal lleva sangre oxigenada desde el corazón al resto del cuerpo.' AS ps,'artery' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='arteria' LIMIT 1) AS wid,'A blocked ___ can restrict blood flow to the heart and lead to a heart attack.' AS pe,'Una arteria bloqueada puede restringir el flujo sanguíneo al corazón y provocar un infarto.' AS ps,'artery' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='glándula' LIMIT 1) AS wid,'The thyroid ___ regulates the body\'s metabolism and energy levels throughout the day.' AS pe,'La glándula tiroidea regula el metabolismo del cuerpo y los niveles de energía a lo largo del día.' AS ps,'gland' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='glándula' LIMIT 1) AS wid,'Swollen ___s in the neck are often the first sign of an infection or immune response.' AS pe,'Las glándulas inflamadas en el cuello son a menudo la primera señal de una infección.' AS ps,'glands' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='mandíbula' LIMIT 1) AS wid,'He tends to clench his ___ tightly when he is under stress or working late at night.' AS pe,'Tiende a apretar la mandíbula con fuerza cuando está bajo estrés o trabajando hasta tarde.' AS ps,'jaw' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='mandíbula' LIMIT 1) AS wid,'A dislocated ___ is extremely painful and must be reset by a doctor as soon as possible.' AS pe,'Una mandíbula dislocada es extremadamente dolorosa y debe ser recolocada por un médico cuanto antes.' AS ps,'jaw' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='músculo' LIMIT 1) AS wid,'Regular strength training helps build and maintain healthy ___s throughout your life.' AS pe,'El entrenamiento de fuerza regular ayuda a desarrollar y mantener músculos sanos a lo largo de la vida.' AS ps,'muscles' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='músculo' LIMIT 1) AS wid,'A pulled ___ can take several weeks to heal properly with rest and physiotherapy.' AS pe,'Un tirón muscular puede tardar varias semanas en curarse correctamente con reposo y fisioterapia.' AS ps,'muscle' AS ans,NULL AS alts,'BEGINNER' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='médula ósea' LIMIT 1) AS wid,'___ produces both red and white blood cells inside the hollow part of bones.' AS pe,'La médula ósea produce glóbulos rojos y blancos dentro de la parte hueca de los huesos.' AS ps,'bone marrow' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='médula ósea' LIMIT 1) AS wid,'A ___ transplant can be used to treat certain types of leukaemia and other blood disorders.' AS pe,'Un trasplante de médula ósea puede usarse para tratar ciertos tipos de leucemia y otros trastornos sanguíneos.' AS ps,'bone marrow' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='córnea' LIMIT 1) AS wid,'Laser surgery can correct refractive defects in the ___ and reduce the need for glasses.' AS pe,'La cirugía láser puede corregir defectos refractivos en la córnea y reducir la necesidad de gafas.' AS ps,'cornea' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='córnea' LIMIT 1) AS wid,'A scratched ___ is extremely painful and must be treated promptly to avoid infection.' AS pe,'Una córnea arañada es extremadamente dolorosa y debe tratarse rápidamente para evitar infección.' AS ps,'cornea' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='pelvis' LIMIT 1) AS wid,'The ___ supports the spine and connects the lower limbs to the upper body.' AS pe,'La pelvis soporta la columna y conecta los miembros inferiores con la parte superior del cuerpo.' AS ps,'pelvis' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='pelvis' LIMIT 1) AS wid,'Fractures of the ___ are more common in elderly people who fall due to brittle bones.' AS pe,'Las fracturas de pelvis son más comunes en personas mayores que se caen por huesos frágiles.' AS ps,'pelvis' AS ans,NULL AS alts,'INTERMEDIATE' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='esófago' LIMIT 1) AS wid,'Food travels down the ___ from the mouth to the stomach in a few seconds.' AS pe,'Los alimentos bajan por el esófago desde la boca al estómago en pocos segundos.' AS ps,'oesophagus' AS ans,'esophagus' AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='esófago' LIMIT 1) AS wid,'Acid reflux occurs when stomach acid rises back up through the ___ causing a burning sensation.' AS pe,'El reflujo ácido ocurre cuando el ácido del estómago sube por el esófago causando ardor.' AS ps,'oesophagus' AS ans,'esophagus' AS alts,'ADVANCED' AS lvl,'Context' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='córtex' LIMIT 1) AS wid,'The cerebral ___ is the outer layer of the brain responsible for higher thinking and language.' AS pe,'El córtex cerebral es la capa exterior del cerebro responsable del pensamiento superior y el lenguaje.' AS ps,'cortex' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Vocabulary' AS cat
UNION ALL
  SELECT (SELECT Id FROM `word` WHERE WordSpa='córtex' LIMIT 1) AS wid,'Damage to the visual ___ can cause blindness even if the eyes themselves are undamaged.' AS pe,'El daño al córtex visual puede causar ceguera aunque los propios ojos estén intactos.' AS ps,'cortex' AS ans,NULL AS alts,'ADVANCED' AS lvl,'Context' AS cat
) sub;

-- 41 palabras: 20 Countries + 21 Anatomy
-- 82 fill-the-gaps