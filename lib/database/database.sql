 
 CREATE TABLE user(
     idUser INTEGER PRIMARY KEY,
     nameUser VARCHAR(30) NOT NULL,
     userUser VARCHAR(30) NOT NULL,
     typeUser INTEGER NOT NULL  
 );
 CREATE TABLE wordFavorites(
     wordSpanish VARCHAR(30) NOT NULL,
     wordChatino VARCHAR(30) NOT NULL,
     pathImage TEXT NOT NULL,
     pathSound TEXT NOT NULL
 );
 CREATE TABLE progress(
     idUser INTEGER NOT NULL,
     levelAdavance INTEGER NOT NULL,
     lessonAdavance INTEGER NOT NULL,
     
 );