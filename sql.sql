INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('zx3', 'ZX3 Maddesi', 1),
	('zx3checker', 'ZX3 Kontrol Aleti', 1),
	('zx3remover', 'ZX3 Çıkartma Aleti', 1)
;

CREATE TABLE IF NOT EXISTS `material_zx3` (
  `plate` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
