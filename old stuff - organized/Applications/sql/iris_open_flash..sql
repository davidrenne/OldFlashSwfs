# phpMyAdmin MySQL-Dump
# version 2.2.0
# http://phpwizard.net/phpMyAdmin/
# http://phpmyadmin.sourceforge.net/ (download page)
#
# Serveur: localhost
# Généré le : February 26, 1990, 4:03 am
# Version du serveur: 3.23.27
# Version de PHP: 4.0.8-dev
# Base de données: `iris_open_flash`
# --------------------------------------------------------

#
# Structure de la table `iof_photos`
#

CREATE TABLE iof_photos (
  id_photo int(11) NOT NULL auto_increment,
  id_page varchar(20) NOT NULL default '0',
  nom_photo varchar(40) NOT NULL default '                                        ',
  x_photo float NOT NULL default '0',
  y_photo float NOT NULL default '0',
  height int(11) NOT NULL default '0',
  width int(11) NOT NULL default '0',
  KEY id_photo(id_photo)
) TYPE=MyISAM;

#
# Contenu de la table `iof_photos`
#

INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (18,'25dc80302a1e8','0000000000000.swf','30','50',40,50);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (17,'25dc80302a1e8','0000000000000.swf','-110','60',40,50);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (16,'25dc80302a1e8','25dc807bbd91b.swf','-210','-110',90,110);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (15,'25dc80302a1e8','25dc807560b27.swf','-80','-100',100,90);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (122,'25df19b777258','25e89bf0268d5.swf','-110','-70',70,240);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (121,'25df19b777258','25e87603d1437.swf','170','-70',100,110);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (114,'25bb244307a1d','25e89995ae7f8.swf','-340','20',260,720);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (113,'25bb244307a1d','25e89723ed592.swf','-340','-260',280,720);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (120,'25df19b777258','25e86c83dfbcb.swf','-280','-70',100,110);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (67,'25df19c988904','25e86dec36c0e.swf','-330','-50',110,130);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (68,'25df19c988904','25e86e45d3079.swf','190','-50',110,130);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (97,'25df1eea35fb6','25e8720e1772b.swf','-300','-200',90,50);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (96,'25df1eea35fb6','25e86e918781c.swf','250','-210',90,50);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (104,'25df704f9cf9c','25e872b3aa1be.swf','-90','-10',190,210);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (102,'25df19937abd1','25e86fcd28c82.swf','-90','110',50,60);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (101,'25df19937abd1','25e86fb17fdd4.swf','-80','-90',40,50);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (100,'25df19937abd1','25e86f75ae541.swf','240','-20',30,50);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (99,'25df19937abd1','25e86f2e3fccc.swf','-80','-210',30,40);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (98,'25df19937abd1','25e86efcf06c4.swf','250','-230',50,40);
INSERT INTO iof_photos (id_photo, id_page, nom_photo, x_photo, y_photo, height, width) VALUES (95,'25df1eea35fb6','25e87222650ff.swf','-340','-250',540,680);
# --------------------------------------------------------

#
# Structure de la table `iof_textes`
#

CREATE TABLE iof_textes (
  id_texte int(11) NOT NULL auto_increment,
  id_page varchar(20) NOT NULL default '0',
  contenu_texte text NOT NULL,
  x_texte float NOT NULL default '0',
  y_texte float NOT NULL default '0',
  height int(11) NOT NULL default '0',
  width int(11) NOT NULL default '0',
  KEY id_texte(id_texte)
) TYPE=MyISAM;

#
# Contenu de la table `iof_textes`
#

INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (9,'25dc80302a1e8','Tsdfdfsdfsdfsdf','-100','-180',1,4);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (8,'25dc80302a1e8','Type text here ...','110','-120',1,10);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (10,'25dc80302a1e8','sfdfdsdf.','140','-40',1,6);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (539,'25df1eea35fb6','Each module can be moved,redimensioned and deleted using the admininistration menu.','10','140',2,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (634,'25bb244307a1d','Be aware that there isn\'t any loading animation in this version so if it\'s not responding for a while it\'s normal, be patient','-180','-30',2,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (632,'25bb244307a1d','Welcome on Iris Open Flash.','-90','-210',1,9);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (633,'25bb244307a1d','IOF (Iris Open Flash) is a web content management system that is entirely made in flash and php. The purpose of this project is to provide the necessary tools to create easly dynamic flash sites. This project is open source, it means that you can use the source code for any purpose. Your only obligation is to share with everybody any improvement made to the source code by sending us back the modified files in order for us to post them on this site.','-180','-180',8,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (627,'25bb244307a1d','The "home" menu send you back to this page.','-310','60',1,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (628,'25bb244307a1d','You may test the features of this project trough the "DEMO" folder.','-310','230',2,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (629,'25bb244307a1d','Any question about the DEMO can be found in the "DEMO Help" menu.','10','230',2,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (630,'25bb244307a1d','All bugs are listed in the "Bug Report" menu.','10','160',1,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (631,'25bb244307a1d','Home','-20','-240',1,1);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (546,'25df19937abd1','The texte-module is a dynamic text. You can edit the text at any time through the administration menu of each texte-module. The text is saved in a mysql database for further use.','-320','170',5,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (556,'25df19937abd1','"reset": reset the current page settings.','10','210',1,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (548,'25df19937abd1','- dynamic photo-module.','10','-200',1,11);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (549,'25df19937abd1','- dynamic texte-module.','-320','140',1,11);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (550,'25df19937abd1','- navigation tools.','10','-10',1,11);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (551,'25df19937abd1','There are 5 tools that can be used to navigate trough each page of the site: "select", "hand", "zoom plus", "zoom minus" and "reset".','10','20',3,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (552,'25df19937abd1','"select": standard selection and action tool.','10','80',1,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (553,'25df19937abd1','"hand": move the current page like in acrobat.','10','110',1,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (554,'25df19937abd1','"zoom plus": zoom the current page forward.','10','140',1,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (555,'25df19937abd1','"zoom minus": zoom the current page backward.','10','170',2,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (443,'25df19c988904','To setup the mysql database you just have to connect to phpmyadmin, create a new database named "IOF" and execute the .sql file located in the /sql/ directory.','-180','-120',3,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (442,'25df19c988904','To setup the php connection to the database just edit the "mysql.inc" file in the /php/lib/ directory and change the name of the database, the name of the domain, the login and the password of the domain.','-180','-50',4,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (441,'25df19c988904','To setup the flash file just edit the "iris_open_flash.fla" file and change content of the variable "_root.UrlSite" located in the first frame of the main movie to your domain name.','-180','40',4,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (540,'25df1eea35fb6','Dont forget to often save your modifications using the "Save" button. For now there is no notification or confirmation of any kind in this site, be carefull.','-170','200',3,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (538,'25df1eea35fb6','To add a photo-module to a page just click on the "Add Photo" button and place your new photo-module on the page. To edit the text just type it into the text field.','10','60',4,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (440,'25df19c988904','If necessary set the CHMOD of the folders /data/ and /upload/ to 777.','-180','200',2,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (532,'25df1eea35fb6','DEMO Help','-40','-230',1,4);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (533,'25df1eea35fb6','The "DEMO" folder allow you to test the features of this project. To access these functionalities just log yourself with the login "admin" and the password "admin". After that you will be able to add as many folders and pages to the "DEMO" folder and manage each pages of this folder. To exit the administration mode just logout.','-170','-200',6,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (536,'25df1eea35fb6','To delete a folder or a page just select it and click the "Delete" button to validate.','-320','10',2,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (537,'25df1eea35fb6','To add a photo-module to a page just click on the "Add Photo" button and place your new photo-module on the page. To upload a jpg or swf to this module click on the photo, choose a file (swf must be not too complicated and without _root references in order to work), and then click the "Upload" button.','-320','60',7,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (535,'25df1eea35fb6','To add a page just select the folder where you want to add a new page, type a new name in the input text field and click the "Add Page" button to validate.','10','-80',4,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (534,'25df1eea35fb6','To add a folder just select the folder where you want to add a new folder, type a new name in the input text field and click the "Add Folder" button to validate.','-320','-80',4,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (625,'25bb244307a1d','To find help about installation just go to the "Installation" menu.','10','110',2,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (626,'25bb244307a1d','If you want to modify any file of this project, you will find some help about each important file in the "Source Description" menu.','-310','160',3,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (547,'25df19937abd1','- dynamic pages.','-320','-70',1,11);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (544,'25df19937abd1','Each page of the site can be edited. These pages are structured by modules. For now there are just two modules implemented : photo-module and text-module. A module is like a standard brick of a page construct. It\'s like a Lego brick. It is possible to add any quantity of photos or texts to a page trough the administration menu. The XY position, the height and the width of each module can be changed at any time.','-320','-40',8,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (545,'25df19937abd1','The photo-module is a dynamic photo or swf. You can upload at any time a new photo or swf through the administration menu of each photo-module. For now you can only upload any jpg and swf files. If necessary these files are automatically converted and stored on the server. After that the converted files are displayed back on the page.','10','-170',8,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (370,'25df1ec1643c9','IN CONSTRUCTION','-60','-10',1,7);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (371,'25df3e1cb0393','IN CONSTRUCTION','-50','',1,7);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (439,'25df19c988904','You may now launch IOF from your favorite browser.','-180','250',1,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (437,'25df19c988904','Installation','-40','-230',1,4);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (438,'25df19c988904','After having downloaded the zip file trough the "Download" menu, extract it to the folder where you maintain your php files.','-180','-190',3,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (624,'25bb244307a1d','To download the current version of IOF just go to the "Download" menu.','-310','110',2,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (623,'25bb244307a1d','All features of the project are listed in the "Features" menu.','10','60',2,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (444,'25df19c988904','The admin-superadmin password and login can be changed in the action of the "OK" button of the administration panel.','-180','130',3,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (541,'25df19937abd1','- dynamic navigation system. ','-320','-200',1,11);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (543,'25df19937abd1','The tree of the navigation system is created from an xml file. It is possible, trough the administration menu, to add any quantity of folders or pages and to delete these.','-320','-170',4,17);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (542,'25df19937abd1','Features','-40','-240',1,3);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (560,'25df704f9cf9c','this a demo page','-60','240',1,6);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (561,'25df704f9cf9c','this a demo page','-50','-240',1,6);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (562,'25df704f9cf9c','Tu use the functionalities of IOF just login with login \'admin\' and password \'admin\'. You may now add as many pages as you want with any number of photos and texts in these pages.Dont\' forget to save your work using the \'Save\' button before living the page.Logout to switch from \'edit mode\' to \'view mode\'','-170','-200',8,20);
INSERT INTO iof_textes (id_texte, id_page, contenu_texte, x_texte, y_texte, height, width) VALUES (636,'25df19b777258','Click here to download (394 Ko)','-80','10',1,10);

