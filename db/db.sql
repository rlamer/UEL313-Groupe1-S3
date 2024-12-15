
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Création de l'utilisateur 'watson' avec le mot de passe 'watson'
CREATE USER IF NOT EXISTS 'watson'@'localhost' IDENTIFIED BY 'watson';

-- Attribution de tous les privilèges sur la base 'watson' à l'utilisateur 'watson'
INSERT INTO mysql.db (Host, Db, User, Select_priv, Insert_priv, Update_priv, Delete_priv, Create_priv, Drop_priv, Index_priv, Alter_priv)
VALUES ('localhost', 'watson', 'watson', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y')
ON DUPLICATE KEY UPDATE
Select_priv='Y', Insert_priv='Y', Update_priv='Y', Delete_priv='Y', Create_priv='Y', Drop_priv='Y', Index_priv='Y', Alter_priv='Y';

-- Application des changements de privilèges
FLUSH PRIVILEGES;


--
-- Base de données : `watson`
--
CREATE DATABASE IF NOT EXISTS `watson` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `watson`;

-- --------------------------------------------------------

--
-- Structure de la table `tl_liens`
--

CREATE TABLE `tl_liens` (
  `lien_id` int(11) NOT NULL,
  `lien_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lien_titre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lien_desc` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `tl_liens`
--

INSERT INTO `tl_liens` (`lien_id`, `lien_url`, `lien_titre`, `lien_desc`, `user_id`) VALUES
(1, 'https://cvtic.unilim.fr/', 'Campus Virtuel TIC', 'Site internet du CvTIC.', 1),
(2, 'https://duckduckgo.com/', 'Duck Duck Go', 'Le moteur de recherche qui ne trace pas ses utilisateurs.', 1),
(3, 'https://framasoft.org/', 'Framasoft', 'Un réseau dédié à la promotion du « libre » en général', 1),
(4, 'https://www.google.com/', 'Google', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(5, 'https://fontawesome.com/', 'font awesome', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(6, 'https://www.instagram.com/', 'Instagram', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(7, 'https://www.facebook.com/', 'Facebook', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(8, 'https://x.com/Accueil', 'X (Twitter)', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(9, 'https://www.linkedin.com/', 'Linkedin', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(10, 'https://fr.pinterest.com/', 'Pinterest', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(11, 'https://github.com/', 'Github', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(12, 'https://openclassrooms.com/fr/', 'OpenClassrooms', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(13, 'https://www.w3schools.com/', 'W3School', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(14, 'https://chatgpt.com/', 'ChatGPT', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(15, 'https://30dayjavascript.js.org/', '30 days Javascript', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4),
(16, 'https://codepen.io/', 'Code Pen', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 4);

-- --------------------------------------------------------

--
-- Structure de la table `tl_tags`
--

CREATE TABLE `tl_tags` (
  `tag_id` int(11) NOT NULL,
  `tag_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `tl_tags`
--

INSERT INTO `tl_tags` (`tag_id`, `tag_name`) VALUES
(1, 'fac'),
(2, 'vieprivee'),
(3, 'opensource'),
(4, 'apprendre'),
(5, 'reseaux');

-- --------------------------------------------------------

--
-- Structure de la table `tl_tags_liens`
--

CREATE TABLE `tl_tags_liens` (
  `tag_id` int(11) NOT NULL,
  `lien_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `tl_tags_liens`
--

INSERT INTO `tl_tags_liens` (`tag_id`, `lien_id`) VALUES
(1, 1),
(2, 2),
(3, 2),
(1, 5),
(1, 4),
(3, 3),
(5, 6),
(5, 7),
(5, 8),
(5, 9),
(5, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16);

-- --------------------------------------------------------

--
-- Structure de la table `tl_users`
--

CREATE TABLE `tl_users` (
  `usr_id` int(11) NOT NULL,
  `usr_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `usr_password` varchar(88) COLLATE utf8_unicode_ci NOT NULL,
  `usr_salt` varchar(23) COLLATE utf8_unicode_ci NOT NULL,
  `usr_role` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ROLE_ADMIN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `tl_users`
--

INSERT INTO `tl_users` (`usr_id`, `usr_name`, `usr_password`, `usr_salt`, `usr_role`) VALUES
(1, 'admin', 'LsJKppRTEPz4uKrkhScOE6HBSvHuaIcFbAX9FWC7h/f5HffX4TBcFt7p8M0hqvGzFXL+JV8TzEYePoimaosfMQ==', '>=28!7NLw!S37zLjs7Uu[nC', 'ROLE_ADMIN'),
(4, 'joana', 'Fi+4xHMpG9gPAbnaDpw5ruoWDHp3Ynhfn3N2o/A5HYid9SMQ2ifvzJ8tm4XwvyfZAjS+Mga3uDNO5kXmoocluw==', '18ebb3016066d88c52fba90', 'ROLE_ADMIN');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `tl_liens`
--
ALTER TABLE `tl_liens`
  ADD PRIMARY KEY (`lien_id`);

--
-- Index pour la table `tl_tags`
--
ALTER TABLE `tl_tags`
  ADD PRIMARY KEY (`tag_id`);

--
-- Index pour la table `tl_users`
--
ALTER TABLE `tl_users`
  ADD PRIMARY KEY (`usr_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `tl_liens`
--
ALTER TABLE `tl_liens`
  MODIFY `lien_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `tl_tags`
--
ALTER TABLE `tl_tags`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `tl_users`
--
ALTER TABLE `tl_users`
  MODIFY `usr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

