-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le : ven. 13 déc. 2024 à 11:16
-- Version du serveur : 5.7.39
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `sport`
--

-- --------------------------------------------------------

--
-- Structure de la table `t_abonnement_abb`
--

CREATE TABLE `t_abonnement_abb` (
  `abb_id` int(11) NOT NULL,
  `abb_abonne_id` int(11) NOT NULL,
  `abb_cible_id` int(11) NOT NULL,
  `abb_date_creation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `t_abonnement_abb`
--

INSERT INTO `t_abonnement_abb` (`abb_id`, `abb_abonne_id`, `abb_cible_id`, `abb_date_creation`) VALUES
(7, 7, 9, '2024-12-13 12:04:43');

-- --------------------------------------------------------

--
-- Structure de la table `t_activite_att`
--

CREATE TABLE `t_activite_att` (
  `att_id` int(11) NOT NULL,
  `att_compte_id` int(11) NOT NULL,
  `att_nom` varchar(100) NOT NULL,
  `att_date` date NOT NULL,
  `att_calories` int(11) NOT NULL,
  `att_visibilite` char(1) NOT NULL,
  `att_duree` time NOT NULL,
  `att_distance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `t_activite_att`
--

INSERT INTO `t_activite_att` (`att_id`, `att_compte_id`, `att_nom`, `att_date`, `att_calories`, `att_visibilite`, `att_duree`, `att_distance`) VALUES
(8, 9, 'Course à pied', '2024-12-13', 300, 'N', '12:22:00', 22),
(9, 9, 'Marche', '2024-12-15', 50, 'V', '00:30:00', 5);

-- --------------------------------------------------------

--
-- Structure de la table `t_compte_cpt`
--

CREATE TABLE `t_compte_cpt` (
  `cpt_id` int(11) NOT NULL,
  `cpt_pseudo` varchar(80) NOT NULL,
  `cpt_login` varchar(45) NOT NULL,
  `cpt_mot_passe` varchar(255) NOT NULL,
  `cpt_etat` enum('A','D') NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `t_compte_cpt`
--

INSERT INTO `t_compte_cpt` (`cpt_id`, `cpt_pseudo`, `cpt_login`, `cpt_mot_passe`, `cpt_etat`) VALUES
(7, 'toto', 'to@gmail.com', '12345678', 'A'),
(9, 'CAROLE', 'ca@gmail.com', 'SAADSAAD', 'A');

-- --------------------------------------------------------

--
-- Structure de la table `t_invitation_inv`
--

CREATE TABLE `t_invitation_inv` (
  `inv_id` int(11) NOT NULL,
  `inviteur_id` int(11) NOT NULL,
  `invite_id` int(11) NOT NULL,
  `date_invitation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `t_invitation_inv`
--

INSERT INTO `t_invitation_inv` (`inv_id`, `inviteur_id`, `invite_id`, `date_invitation`) VALUES
(4, 9, 7, '2024-12-13 12:04:50');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `t_abonnement_abb`
--
ALTER TABLE `t_abonnement_abb`
  ADD PRIMARY KEY (`abb_id`),
  ADD UNIQUE KEY `unique_abonne_cible` (`abb_abonne_id`,`abb_cible_id`),
  ADD KEY `abb_cible_id` (`abb_cible_id`);

--
-- Index pour la table `t_activite_att`
--
ALTER TABLE `t_activite_att`
  ADD PRIMARY KEY (`att_id`),
  ADD KEY `att_compte_id` (`att_compte_id`);

--
-- Index pour la table `t_compte_cpt`
--
ALTER TABLE `t_compte_cpt`
  ADD PRIMARY KEY (`cpt_id`),
  ADD UNIQUE KEY `cpt_login_UNIQUE` (`cpt_login`);

--
-- Index pour la table `t_invitation_inv`
--
ALTER TABLE `t_invitation_inv`
  ADD PRIMARY KEY (`inv_id`),
  ADD UNIQUE KEY `relation_unique` (`inviteur_id`,`invite_id`),
  ADD KEY `invite_id` (`invite_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `t_abonnement_abb`
--
ALTER TABLE `t_abonnement_abb`
  MODIFY `abb_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `t_activite_att`
--
ALTER TABLE `t_activite_att`
  MODIFY `att_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `t_compte_cpt`
--
ALTER TABLE `t_compte_cpt`
  MODIFY `cpt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `t_invitation_inv`
--
ALTER TABLE `t_invitation_inv`
  MODIFY `inv_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `t_abonnement_abb`
--
ALTER TABLE `t_abonnement_abb`
  ADD CONSTRAINT `t_abonnement_abb_ibfk_1` FOREIGN KEY (`abb_abonne_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_abonnement_abb_ibfk_2` FOREIGN KEY (`abb_cible_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `t_activite_att`
--
ALTER TABLE `t_activite_att`
  ADD CONSTRAINT `t_activite_att_ibfk_1` FOREIGN KEY (`att_compte_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `t_invitation_inv`
--
ALTER TABLE `t_invitation_inv`
  ADD CONSTRAINT `t_invitation_inv_ibfk_1` FOREIGN KEY (`inviteur_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `t_invitation_inv_ibfk_2` FOREIGN KEY (`invite_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
