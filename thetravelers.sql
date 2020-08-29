-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 29, 2020 at 12:46 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.2.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `thetravelers`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `sno` int(11) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `website` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`sno`, `slug`, `name`, `email`, `website`, `message`, `date`) VALUES
(1, 'Hazratganj-the-iconic-place', 'Jack Sparrow', 'jack45@mycompanymail.com', '', 'This is testing comment.', '2020-08-28 00:00:00'),
(2, 'Hazratganj-the-iconic-place', 'ANUJ KUMAR SINGH', 'anuj.evil13@gmail.com', '', 'hi now i am messaging from the client side lets check it out weather it works or not.', '2020-08-28 21:37:35'),
(3, 'Hazratganj-the-iconic-place', 'saumya', 'saumya@gmail.com', '', 'previously we got an error', '2020-08-28 21:44:48'),
(4, 'Hazratganj-the-iconic-place', 'saumya', 'saumya@gmail.com', '', 'resolved the error Nice of you', '2020-08-28 21:45:14');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `subject` text NOT NULL,
  `message` text NOT NULL,
  `time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `subject`, `message`, `time`) VALUES
(1, 'Admin', 'admin@mail.com', 'Testing purpose', 'I am assigning the first contact form to set the value of primary key.', '2020-08-28 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `place` text NOT NULL,
  `title` varchar(100) NOT NULL,
  `img_file` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL,
  `slug` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `place`, `title`, `img_file`, `content`, `date`, `slug`) VALUES
(1, 'Hazratganj', 'Hazratganj The Iconic Place', 'bg_1.jpg', 'In 1827, the then Nawab Nasir-ud-Din Haidar Shah laid the foundation of the Ganj market by introducing the China Bazaar and Kaptaan Bazaar which sold goods stuff from China, Japan and Belgium. The famous Taar Wali Kothi, Dargah of 12 Imam\'s at Khas Mukaam, Choti Chattar Manzil, Saawan-Bhadoh Mahal (the present location of zoo), the stunning Baradari, which was earlier situated between Kaiserbagh, Darulshafa, and Lalbagh also emerged during his regime.\r\n\r\nIn 1842, the name of the area was changed to Hazratganj after Nawab Amjad Ali Shah, who was popularly known by his alias \'Hazrat\'.', '2020-08-28 00:00:00', 'Hazratganj-the-iconic-place'),
(2, 'Janeshwar Mishra Park', 'The Asia\'s 10 largest park', 'bg_1.jpg', 'Lucknow Development Authority (LDA) has developed eco-friendly Janeshwar Mishra Park (JMP) in the heart of the city. It has been conceptualised and designed as a multi-functional environmental and recreational green which will not just provide sustainable habitat for various species of birds but also double up as a major entertainment and recreation centre for all sections of the society. It will enhance and improve the ecological balance and help restore sensitive habitat for numerous species of birds, small animals, fishes, amphibians and even insects. The design direction for the park is centered on the strategy for sustainable development that aims to promote harmony among human beings and between humanity and nature. The pursuit of sustainable development requires a social system that provides for solutions for the tensions arising from disharmonious development', '2020-08-28 21:34:27', 'janeshwar-mishra-park'),
(3, 'Kukrail', 'The Kukrail Forest', 'bg_1.jpg', 'Kukrail Reserve Forest is located in Indranagar adjacent to Mayur Residency Extension on picnic spot road.\r\n\r\nIn Uttar Pradesh, crocodiles are found in the Ramganga, Suheli, Girwa and Chambal rivers. The female crocodile lays eggs in April by digging holes on the river banks. The young crocodiles hatch in a period of 60 to 80 days. The idea of setting up a breeding center for the endangered crocodile species came after a study by the International Union for Conservation of Nature and Natural Resources, UNO in 1975 which estimated that there were only 300 crocodile left in the open rivers of Uttar Pradesh.\r\n\r\nThe centre at Kukrail came up in the year 1978, which was funded by the Uttar Pradesh forest department in collaboration Ministry of Environment and Forests India. This effort marked the beginning of state government\'s efforts towards conservation of crocodiles at a time when only 300 of them were left.', '2020-08-28 21:36:13', 'the-kukrail-forest');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
