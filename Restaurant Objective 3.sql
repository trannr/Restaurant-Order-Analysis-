-- 1. Combine the menu_items and order_details tables into a single table.
SELECT *
FROM order_details od
LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id; 
		-- When joining tables, you should list the transactional table first then add on lookup info table
		-- LEFT JOIN was used because wanted to keep all rows in order_details table and to just add on item_id table (if there were any item_id from od that's not in mi, it would show up as null. 
        -- INNER JOIN would show only data that is in both tables, no NULLS
        
-- 2. What were the least and most ordered items? What categories were they in?
SELECT item_name, category, COUNT(order_details_id) AS num_purchases
FROM order_details od
LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases DESC; 
		-- Least order is chicken taco, most order is hamburger. So this could mean take chicken tacos off the menu
        -- Least order category is Mexican and most order was American

-- 3. What were the top 5 orders that spent the most money?
SELECT od.order_id, SUM(price) AS total_spent
FROM order_details od
LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY od.order_id
ORDER BY total_spent DESC 
LIMIT 5; 
		-- Top 5 orders that spent the most money was 440, 2075, 1957, 330, 2675
        
-- 4. View the details of the highest spend order. What insights can you gather from the results?
SELECT category, COUNT(item_id) AS num_item
FROM order_details od
LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
WHERE order_id = '440'
GROUP BY category
;
		-- We can see that they ordered Italian the most 8, compared to 2

-- 5. View the details of the top 5 highest spend orders. What insights can you gather from the results?
SELECT order_id, category, COUNT(item_id) AS num_item
FROM order_details od
LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category
;
		-- This shows that Italian was still ordered the most by the highest spenders so we should keep this item on the menu.




