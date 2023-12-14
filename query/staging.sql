-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 04, 2023 lúc 04:29 AM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `staging`
--

DELIMITER $$
--
-- Thủ tục
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `load_to_datawarehouse` ()   BEGIN

    CREATE TEMPORARY TABLE fact_temp (province_temp INT, date_temp INT);

    INSERT INTO fact_temp
    SELECT DISTINCT _province, _date_lottery FROM staging.staging;

	UPDATE datawarehouse.factlottery AS facts
     JOIN fact_temp AS dtemp ON facts.province_id = dtemp.province_temp
    SET facts.expiration_date = current_timestamp() , facts.update_date = current_timestamp();
		
		INSERT INTO datawarehouse.factlottery (province_id, date_lottery_id, prize_id, result, area_id)
		SELECT stage._province, stage._date_lottery, stage._prize, stage.result, stage._area
		FROM staging.staging stage;

    -- Xóa bảng tạm thời
    DROP TEMPORARY TABLE fact_temp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transform_area` ()   BEGIN
    DROP TABLE IF EXISTS area_temp;
    CREATE TEMPORARY TABLE area_temp (area VARCHAR(255));

    INSERT INTO area_temp
    SELECT DISTINCT area FROM staging.staging;

		INSERT INTO datawarehouse.dimarea (area)
		SELECT area FROM area_temp
		WHERE NOT EXISTS (
				SELECT 1
				FROM datawarehouse.dimarea
				WHERE datawarehouse.dimarea.area = area_temp.area
);
	ALTER TABLE staging.staging ADD COLUMN if not exists _area INT;

	UPDATE staging.staging AS staging
    JOIN datawarehouse.dimarea AS dim ON staging.area = dim.area
    SET staging._area = dim.id;

    DROP TEMPORARY TABLE area_temp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transform_data` ()   BEGIN
    	call staging.transform_prize();
		call staging.transform_province();
        call staging.transform_area();
		call staging.transform_date();

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transform_date` ()   BEGIN

    DROP TABLE IF EXISTS date_temp;
    CREATE TEMPORARY TABLE date_temp (date_lottery DATE);

    INSERT INTO date_temp
    SELECT DISTINCT STR_TO_DATE(date_lottery, '%d-%m-%Y') as date_lo FROM staging.staging;

		INSERT INTO datawarehouse.dimdate (full_date, day, month, year, quarter_of_year)
		SELECT date_lottery, DAY(date_lottery), MONTH(date_lottery), YEAR(date_lottery), QUARTER(date_lottery) FROM date_temp
		WHERE NOT EXISTS (
				SELECT 1
				FROM datawarehouse.dimdate
				WHERE datawarehouse.dimdate.full_date = date_temp.date_lottery
		);
	ALTER TABLE staging.staging ADD COLUMN if not exists _date_lottery INT;

	UPDATE staging.staging AS staging
    JOIN datawarehouse.dimdate AS dim ON STR_TO_DATE(staging.date_lottery, '%d-%m-%Y') = dim.full_date
    SET staging._date_lottery = dim.id;

    DROP TEMPORARY TABLE date_temp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transform_prize` ()   BEGIN
	DROP TABLE IF EXISTS `prize_tempate`;
    CREATE TEMPORARY TABLE prize_tempate (prize VARCHAR(255)) ;

    INSERT INTO prize_tempate
    SELECT DISTINCT name_prize FROM staging.staging;

		INSERT INTO datawarehouse.dimprize (name_prize)
		SELECT prize FROM prize_tempate
		WHERE NOT EXISTS (
				SELECT 1
				FROM datawarehouse.dimprize
				WHERE datawarehouse.dimprize.name_prize = prize_tempate.prize
);
	ALTER TABLE staging.staging ADD COLUMN if not exists _prize INT;
    UPDATE staging.staging AS staging
    JOIN datawarehouse.dimprize AS dim ON staging.name_prize = dim.name_prize
    SET staging._prize = dim.id;

    DROP TEMPORARY TABLE prize_tempate;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transform_province` ()   BEGIN
    DROP TABLE IF EXISTS province_temp;
    CREATE TEMPORARY TABLE province_temp (province VARCHAR(255));

    INSERT INTO province_temp
    SELECT DISTINCT province FROM staging.staging;

		INSERT INTO datawarehouse.dimprovince (province)
		SELECT province FROM province_temp
		WHERE NOT EXISTS (
				SELECT 1
				FROM datawarehouse.dimprovince
				WHERE datawarehouse.dimprovince.province = province_temp.province
);
	ALTER TABLE staging.staging ADD COLUMN if not exists _province INT;

	UPDATE staging.staging AS staging
    JOIN datawarehouse.dimprovince AS dim ON staging.province = dim.province
    SET staging._province = dim.id;

    DROP TEMPORARY TABLE province_temp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `truncate_staging_table` ()   BEGIN
    TRUNCATE table staging.staging;
    CREATE TABLE IF NOT EXISTS staging (
  id int(11) NOT NULL,
  province varchar(255) NOT NULL,
  area varchar(255) NOT NULL,
  date_lottery varchar(255) NOT NULL,
  name_prize varchar(255) NOT NULL,
  result varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `staging`
--

CREATE TABLE `staging` (
  `id` int(11) NOT NULL,
  `province` varchar(255) NOT NULL,
  `area` varchar(255) NOT NULL,
  `date_lottery` varchar(255) NOT NULL,
  `name_prize` varchar(255) NOT NULL,
  `result` varchar(10) NOT NULL,
  `_prize` int(11) DEFAULT NULL,
  `_province` int(11) DEFAULT NULL,
  `_area` int(11) DEFAULT NULL,
  `_date_lottery` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `staging`
--
ALTER TABLE `staging`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `staging`
--
ALTER TABLE `staging`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=256;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
