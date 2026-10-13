   -- Join every house sale to the details of the house sold
   SELECT s.id AS sale_id,
          s.date,
          s.price,
          d.*
   FROM eda.king_county_house_sales AS s
   LEFT JOIN eda.king_county_house_details AS d
          ON s.house_id = d.id;