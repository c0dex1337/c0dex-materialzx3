INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('sportmode', 'Spor Modu', 1),
	('sportmoderemover', 'Spor Mod Çıkartıcı', 1)
;

CREATE TABLE IF NOT EXISTS `spor_mode` (
  `plate` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
