--tokenized_access_log date column cleaning
SELECT

    product,
    category,

    CASE

        -- Already proper datetime
        WHEN TRY_CAST(log_date AS DATETIME) IS NOT NULL
        THEN TRY_CAST(log_date AS DATETIME)

        -- Excel serial datetime
        WHEN TRY_CAST(log_date AS FLOAT) IS NOT NULL
        THEN DATEADD(
                DAY,
                TRY_CAST(log_date AS FLOAT),
                '1899-12-30'
             )

        -- Invalid values
        ELSE NULL

    END AS log_date,

    log_month,

    TRY_CAST(log_hour AS INT) AS log_hour,

    department,
    ip_address,
    url_path

INTO gold.tokenized_access_logs_cleaned

FROM gold.tokenized_access_logs;