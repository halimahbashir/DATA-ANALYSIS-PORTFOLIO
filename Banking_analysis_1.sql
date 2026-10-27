CREATE DATABASE bank_management_system;
USE bank_management_system;

#-----------------Executive KPI Dashboard------------------
SELECT
    (SELECT COUNT(*) FROM customer_table) AS total_customers,

    (SELECT COUNT(*)
     FROM customer_table
     WHERE customer_status = 'Active') AS active_customers,

    (SELECT COUNT(*)
     FROM account_table) AS total_accounts,

    (SELECT COUNT(*)
     FROM account_table
     WHERE account_status = 'Active') AS active_accounts,

    (SELECT SUM(balance)
     FROM account_table) AS total_deposits,

    (SELECT SUM(amount)
     FROM transaction_table
     WHERE status = 'Successful') AS successful_transaction_value,

    (SELECT COUNT(*) 
     FROM transaction_table
     WHERE status = 'Successful') AS successful_transactions,

    (SELECT SUM(principal_amount)
     FROM loan_table) AS total_loan_principal,

    (SELECT SUM(outstanding_balance)
     FROM loan_table
     WHERE loan_status IN ('Active','Defaulted')) AS outstanding_loans,

    (SELECT COUNT(*)
     FROM loan_table
     WHERE loan_status = 'Defaulted') AS defaulted_loans;

#-----------Customer acquisition analysis-----------------
SELECT
    YEAR(date_created) AS acquisition_year,
    COUNT(*) AS new_customers
FROM customer_table
GROUP BY YEAR(date_created)
ORDER BY acquisition_year;

#----------Monthly acquisition:------------
SELECT
    DATE_FORMAT(date_created, '%Y-%m') AS month,
    COUNT(*) AS new_customers
FROM customer_table
GROUP BY DATE_FORMAT(date_created, '%Y-%m')
ORDER BY month;

#-----------Customer demographic analysis------------
SELECT
    gender,
    COUNT(*) AS customers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM customer_table),
        2
    ) AS percentage
FROM customer_table
GROUP BY gender
ORDER BY customers DESC;

#-----Geographic customer analysis-------
SELECT
    state,
    COUNT(*) AS customers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM customer_table),
        2
    ) AS customer_share
FROM customer_table
GROUP BY state
ORDER BY customers DESC;

#------Account performance------
SELECT
    account_status,
    COUNT(*) AS accounts,
    SUM(balance) AS total_balance,
    AVG(balance) AS average_balance
FROM account_table
GROUP BY account_status
ORDER BY total_balance DESC;

#---------------------Dormant-account analysis--------------
SELECT
    COUNT(*) AS dormant_accounts,
    SUM(balance) AS dormant_balance,
    AVG(balance) AS average_dormant_balance
FROM account_table
WHERE account_status = 'Dormant';

#--------------And identify high-value dormant accounts:---------------
SELECT
    account_number,
    customer_id,
    balance,
    date_opened
FROM account_table
WHERE account_status = 'Dormant'
ORDER BY balance DESC
LIMIT 20;

#--------------------Transaction performance----------#
SELECT
    transaction_type,
    COUNT(*) AS transaction_count,
    SUM(amount) AS transaction_value,
    AVG(amount) AS average_transaction
FROM transaction_table
WHERE status = 'Successful'
GROUP BY transaction_type
ORDER BY transaction_value DESC;

#-------------Transaction failure analysis------------
SELECT
    status,
    COUNT(*) AS transaction_count,
    SUM(amount) AS transaction_value,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM transaction_table),
        2
    ) AS percentage
FROM transaction_table
GROUP BY status
ORDER BY transaction_count DESC;

#--------------------Channel performance --------------
SELECT
    channel,
    COUNT(*) AS transactions,
    SUM(amount) AS transaction_value,
    AVG(amount) AS average_transaction,
    ROUND(
        SUM(amount) * 100.0 /
        (SELECT SUM(amount)
         FROM transaction_table
         WHERE status = 'Successful'),
        2
    ) AS value_share
FROM transaction_table
WHERE status = 'Successful'
GROUP BY channel
ORDER BY transaction_value DESC;

#-----------------Monthly transaction trend ---------------
SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    COUNT(*) AS transactions,
    SUM(amount) AS transaction_value
FROM transaction_table
WHERE status = 'Successful'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY month;

#---------------Loan portfolio dashboard --------------
SELECT
    loan_status,
    COUNT(*) AS loans,
    SUM(principal_amount) AS principal_amount,
    SUM(outstanding_balance) AS outstanding_balance,
    AVG(interest_rate) AS average_interest_rate
FROM loan_table
GROUP BY loan_status
ORDER BY outstanding_balance DESC;

#---------------------Loan type profitability/risk analysis-------------
SELECT
    loan_type,
    COUNT(*) AS total_loans,
    SUM(principal_amount) AS total_principal,
    SUM(outstanding_balance) AS outstanding_balance,
    SUM(total_payable) AS total_payable,
    AVG(interest_rate) AS avg_interest_rate,

    SUM(
        CASE
            WHEN loan_status = 'Defaulted'
            THEN 1 ELSE 0
        END
    ) AS defaulted_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status = 'Defaulted'
                THEN 1 ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM loan_table
GROUP BY loan_type
ORDER BY outstanding_balance DESC;

#---------------------High-risk loans ----------------
SELECT
    loan_number,
    customer_id,
    loan_type,
    principal_amount,
    outstanding_balance,
    interest_rate,
    maturity_date,
    loan_status
FROM loan_table
WHERE loan_status = 'Defaulted'
ORDER BY outstanding_balance DESC;

#------------------Loan concentration ---------------
SELECT
    loan_type,
    SUM(outstanding_balance) AS outstanding_balance,
    ROUND(
        SUM(outstanding_balance) * 100.0 /
        (
            SELECT SUM(outstanding_balance)
            FROM loan_table
            WHERE loan_status IN ('Active','Defaulted')
        ),
        2
    ) AS portfolio_share
FROM loan_table
WHERE loan_status IN ('Active','Defaulted')
GROUP BY loan_type
ORDER BY outstanding_balance DESC;

#------------------Loan repayment analysis -------
SELECT
    payment_method,
    COUNT(*) AS payments,
    SUM(amount) AS payment_value,
    SUM(principal_paid) AS principal_paid,
    SUM(interest_paid) AS interest_paid,
    SUM(penalty_paid) AS penalties
FROM loan_payment_table
WHERE payment_status = 'Successful'
GROUP BY payment_method
ORDER BY payment_value DESC;

#----------------Bank interest income -----------
SELECT
    SUM(interest_paid) AS loan_interest_income,
    SUM(penalty_paid) AS penalty_income,
    SUM(amount) AS total_loan_payments
FROM loan_payment_table
WHERE payment_status = 'Successful';

#--------------Mortgage interest: -----------
SELECT
    SUM(interest_paid) AS mortgage_interest_income,
    SUM(amount) AS total_mortgage_payments
FROM mortgage_payment_table
WHERE payment_status = 'Successful';

#----------------Fee income ------------
SELECT
    SUM(amount) AS transaction_fee_income
FROM transaction_table
WHERE transaction_type = 'Fee'
AND status = 'Successful';

#----------Transfer fees: -------------
SELECT
    SUM(transfer_fee) AS transfer_fee_income
FROM transfer_table
WHERE transfer_status = 'Successful';

#--------------Customer value analysis------------
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,

    COUNT(DISTINCT a.account_id) AS accounts,

    COALESCE(SUM(a.balance), 0) AS total_balance,

    COALESCE(
        (
            SELECT SUM(t.amount)
            FROM transaction_table t
            JOIN account_table ax
                ON ax.account_id = t.account_id
            WHERE ax.customer_id = c.customer_id
            AND t.status = 'Successful'
        ), 0
    ) AS transaction_value

FROM customer_table c

LEFT JOIN account_table a
    ON a.customer_id = c.customer_id

GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name

ORDER BY total_balance DESC
LIMIT 50;
