-- Tabela para VlAvgMonthlyNotional12mUSDPtax
WITH Script1 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlAvgMonthlyNotional12mUSDPtax AS VlAvgMonthlyNotional_Script1_12m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'Old_Script_New_Natures_251206'
),
Script2 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlAvgMonthlyNotional12mUSDPtax AS VlAvgMonthlyNotional_Script2_12m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'New_Script_New_Natures_Inactive_251206'
),
Script3 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlAvgMonthlyNotional12mUSDPtax AS VlAvgMonthlyNotional_Script3_12m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'New_Script_New_Natures_Active_251206'
)
SELECT 
    COALESCE(S1.ClientTaxId, S2.ClientTaxId, S3.ClientTaxId) AS [Client ID],
    COALESCE(S1.ClientLegalName, S2.ClientLegalName, S3.ClientLegalName) AS [Client Name],
    ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) AS [Script 1 - Avg Monthly Notional 12m],
    ISNULL(S2.VlAvgMonthlyNotional_Script2_12m, 0) AS [Script 2 - Avg Monthly Notional 12m],
    ISNULL(S3.VlAvgMonthlyNotional_Script3_12m, 0) AS [Script 3 - Avg Monthly Notional 12m],
    ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) - ISNULL(S2.VlAvgMonthlyNotional_Script2_12m, 0) AS [Diff Avg Monthly Notional 12m - Script 1 vs 2],
    ISNULL(S2.VlAvgMonthlyNotional_Script2_12m, 0) - ISNULL(S3.VlAvgMonthlyNotional_Script3_12m, 0) AS [Diff Avg Monthly Notional 12m - Script 2 vs 3],
    ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) - ISNULL(S3.VlAvgMonthlyNotional_Script3_12m, 0) AS [Diff Avg Monthly Notional 12m - Script 1 vs 3],
    CASE 
        WHEN ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) = 0 THEN NULL
        ELSE ROUND((ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) - ISNULL(S2.VlAvgMonthlyNotional_Script2_12m, 0)) / ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) * 100, 1)
    END AS [Diff Avg Monthly Notional 12m - Percent - Script 1 vs 2],
    CASE 
        WHEN ISNULL(S2.VlAvgMonthlyNotional_Script2_12m, 0) = 0 THEN NULL
        ELSE ROUND((ISNULL(S2.VlAvgMonthlyNotional_Script2_12m, 0) - ISNULL(S3.VlAvgMonthlyNotional_Script3_12m, 0)) / ISNULL(S2.VlAvgMonthlyNotional_Script2_12m, 0) * 100, 1)
    END AS [Diff Avg Monthly Notional 12m - Percent - Script 2 vs 3],
    CASE 
        WHEN ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) = 0 THEN NULL
        ELSE ROUND((ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) - ISNULL(S3.VlAvgMonthlyNotional_Script3_12m, 0)) / ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) * 100, 1)
    END AS [Diff Avg Monthly Notional 12m - Percent - Script 1 vs 3]
FROM Script1 S1
FULL OUTER JOIN Script2 S2 ON S1.ClientTaxId = S2.ClientTaxId
FULL OUTER JOIN Script3 S3 ON COALESCE(S1.ClientTaxId, S2.ClientTaxId) = S3.ClientTaxId

-- Tabela para VlNotionalLast12mUSDPtax
WITH Script1 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlNotionalLast12mUSDPtax AS VlNotional_Script1_Last12m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'Old_Script_New_Natures_251206'
),
Script2 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlNotionalLast12mUSDPtax AS VlNotional_Script2_Last12m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'New_Script_New_Natures_Inactive_251206'
),
Script3 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlNotionalLast12mUSDPtax AS VlNotional_Script3_Last12m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'New_Script_New_Natures_Active_251206'
)
SELECT 
    COALESCE(S1.ClientTaxId, S2.ClientTaxId, S3.ClientTaxId) AS [Client ID],
    COALESCE(S1.ClientLegalName, S2.ClientLegalName, S3.ClientLegalName) AS [Client Name],
    ISNULL(S1.VlNotional_Script1_Last12m, 0) AS [Script 1 - Last 12m],
    ISNULL(S2.VlNotional_Script2_Last12m, 0) AS [Script 2 - Last 12m],
    ISNULL(S3.VlNotional_Script3_Last12m, 0) AS [Script 3 - Last 12m],
    ISNULL(S1.VlNotional_Script1_Last12m, 0) - ISNULL(S2.VlNotional_Script2_Last12m, 0) AS [Diff Script 1 vs 2 - Last 12m],
    ISNULL(S2.VlNotional_Script2_Last12m, 0) - ISNULL(S3.VlNotional_Script3_Last12m, 0) AS [Diff Script 2 vs 3 - Last 12m],
    ISNULL(S1.VlNotional_Script1_Last12m, 0) - ISNULL(S3.VlNotional_Script3_Last12m, 0) AS [Diff Script 1 vs 3 - Last 12m],
    CASE 
        WHEN ISNULL(S1.VlNotional_Script1_Last12m, 0) = 0 THEN NULL
        ELSE ROUND((ISNULL(S1.VlNotional_Script1_Last12m, 0) - ISNULL(S2.VlNotional_Script2_Last12m, 0)) / ISNULL(S1.VlNotional_Script1_Last12m, 0) * 100, 1)
    END AS [Diff Script 1 vs 2 - Percent - Last 12m],
    CASE 
        WHEN ISNULL(S2.VlNotional_Script2_Last12m, 0) = 0 THEN NULL
        ELSE ROUND((ISNULL(S2.VlNotional_Script2_Last12m, 0) - ISNULL(S3.VlNotional_Script3_Last12m, 0)) / ISNULL(S2.VlNotional_Script2_Last12m, 0) * 100, 1)
    END AS [Diff Script 2 vs 3 - Percent - Last 12m],
    CASE 
        WHEN ISNULL(S1.VlNotional_Script1_Last12m, 0) = 0 THEN NULL
        ELSE ROUND((ISNULL(S1.VlNotional_Script1_Last12m, 0) - ISNULL(S3.VlNotional_Script3_Last12m, 0)) / ISNULL(S1.VlNotional_Script1_Last12m, 0) * 100, 1)
    END AS [Diff Script 1 vs 3 - Percent - Last 12m]
FROM Script1 S1
FULL OUTER JOIN Script2 S2 ON S1.ClientTaxId = S2.ClientTaxId
FULL OUTER JOIN Script3 S3 ON COALESCE(S1.ClientTaxId, S2.ClientTaxId) = S3.ClientTaxId

-- Tabela para VlNotionalLast11mUSDPtax
WITH Script1 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlNotionalLast11mUSDPtax AS VlNotional_Script1_Last11m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'Old_Script_New_Natures_251206'
),
Script2 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlNotionalLast11mUSDPtax AS VlNotional_Script2_Last11m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'New_Script_New_Natures_Inactive_251206'
),
Script3 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlNotionalLast11mUSDPtax AS VlNotional_Script3_Last11m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'New_Script_New_Natures_Active_251206'
)
SELECT 
    COALESCE(S1.ClientTaxId, S2.ClientTaxId, S3.ClientTaxId) AS [Client ID],
    COALESCE(S1.ClientLegalName, S2.ClientLegalName, S3.ClientLegalName) AS [Client Name],
    ISNULL(S1.VlNotional_Script1_Last11m, 0) AS [Script 1 - Last 11m],
    ISNULL(S2.VlNotional_Script2_Last11m, 0) AS [Script 2 - Last 11m],
    ISNULL(S3.VlNotional_Script3_Last11m, 0) AS [Script 3 - Last 11m],
    ISNULL(S1.VlNotional_Script1_Last11m, 0) - ISNULL(S2.VlNotional_Script2_Last11m, 0) AS [Diff Script 1 vs 2 - Last 11m],
    ISNULL(S2.VlNotional_Script2_Last11m, 0) - ISNULL(S3.VlNotional_Script3_Last11m, 0) AS [Diff Script 2 vs 3 - Last 11m],
    ISNULL(S1.VlNotional_Script1_Last11m, 0) - ISNULL(S3.VlNotional_Script3_Last11m, 0) AS [Diff Script 1 vs 3 - Last 11m],
    CASE 
        WHEN ISNULL(S1.VlNotional_Script1_Last11m, 0) = 0 THEN NULL
        ELSE ROUND((ISNULL(S1.VlNotional_Script1_Last11m, 0) - ISNULL(S2.VlNotional_Script2_Last11m, 0)) / ISNULL(S1.VlNotional_Script1_Last11m, 0) * 100, 1)
    END AS [Diff Script 1 vs 2 - Percent - Last 11m],
    CASE 
        WHEN ISNULL(S2.VlNotional_Script2_Last11m, 0) = 0 THEN NULL
        ELSE ROUND((ISNULL(S2.VlNotional_Script2_Last11m, 0) - ISNULL(S3.VlNotional_Script3_Last11m, 0)) / ISNULL(S2.VlNotional_Script2_Last11m, 0) * 100, 1)
    END AS [Diff Script 2 vs 3 - Percent - Last 11m],
    CASE 
        WHEN ISNULL(S1.VlNotional_Script1_Last11m, 0) = 0 THEN NULL
        ELSE ROUND((ISNULL(S1.VlNotional_Script1_Last11m, 0) - ISNULL(S3.VlNotional_Script3_Last11m, 0)) / ISNULL(S1.VlNotional_Script1_Last11m, 0) * 100, 1)
    END AS [Diff Script 1 vs 3 - Percent - Last 11m]
FROM Script1 S1
FULL OUTER JOIN Script2 S2 ON S1.ClientTaxId = S2.ClientTaxId
FULL OUTER JOIN Script3 S3 ON COALESCE(S1.ClientTaxId, S2.ClientTaxId) = S3.ClientTaxId
ORDER BY [Client Name];
