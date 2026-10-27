CREATE DATABASE Bank_Management_System;
USE Bank_Management_System;
SELECT * FROM customer_table;

SELECT
COUNT(*) AS Total_Customer
FROM customer_table;

SELECT
	(SELECT COUNT(*) FROM customer_table)
	AS Total_Customer,
    
	(SELECT COUNT(*) FROM customer_table
	WHERE customer_status="Active")
	AS Total_Active_Customer,
    
	(SELECT COUNT(*) FROM account_table
	WHERE account_status="Active")
	AS Total_Active_Account,
    
		(SELECT SUM(balance)
		FROM account_table)
		AS Total_Balance,
        
			(SELECT SUM(Amount)
			FROM transaction_table
			WHERE status="successful")
			AS Successful_Transaction;
            

