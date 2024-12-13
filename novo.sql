WITH Script1 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlAvgMonthlyNotional12mUSDPtax AS VlAvgMonthlyNotional_Script1_12m,
        p.VlNotionalLast12mUSDPtax AS VlNotional_Script1_Last12m,
        p.VlNotionalLast11mUSDPtax AS VlNotional_Script1_Last11m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'Old_Script_New_Natures_251206'
),
Script2 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlAvgMonthlyNotional12mUSDPtax AS VlAvgMonthlyNotional_Script2_12m,
        p.VlNotionalLast12mUSDPtax AS VlNotional_Script2_Last12m,
        p.VlNotionalLast11mUSDPtax AS VlNotional_Script2_Last11m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'New_Script_New_Natures_Inactive_251206'
)
SELECT 
    COALESCE(S1.ClientTaxId, S2.ClientTaxId) AS [Client ID],
    COALESCE(S1.ClientLegalName, S2.ClientLegalName) AS [Client Name],
    
    -- VlAvgMonthlyNotional12mUSDPtax comparison
    ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) AS [Script 1 - Avg Monthly Notional 12m],
    ISNULL(S2.VlAvgMonthlyNotional_Script2_12m, 0) AS [Script 2 - Avg Monthly Notional 12m],
    ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) - ISNULL(S2.VlAvgMonthlyNotional_Script2_12m, 0) AS [Diff Avg Monthly Notional 12m],
    CASE 
        WHEN ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) = 0 THEN NULL
        ELSE (ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) - ISNULL(S2.VlAvgMonthlyNotional_Script2_12m, 0)) / ISNULL(S1.VlAvgMonthlyNotional_Script1_12m, 0) * 100
    END AS [Diff Avg Monthly Notional 12m - Percent],
    
    -- VlNotionalLast12mUSDPtax comparison
    ISNULL(S1.VlNotional_Script1_Last12m, 0) AS [Script 1 - Last 12m],
    ISNULL(S2.VlNotional_Script2_Last12m, 0) AS [Script 2 - Last 12m],
    ISNULL(S1.VlNotional_Script1_Last12m, 0) - ISNULL(S2.VlNotional_Script2_Last12m, 0) AS [Diff Script 1 vs 2 - Last 12m],
    CASE 
        WHEN ISNULL(S1.VlNotional_Script1_Last12m, 0) = 0 THEN NULL
        ELSE (ISNULL(S1.VlNotional_Script1_Last12m, 0) - ISNULL(S2.VlNotional_Script2_Last12m, 0)) / ISNULL(S1.VlNotional_Script1_Last12m, 0) * 100
    END AS [Diff Script 1 vs 2 - Percent - Last 12m],

    -- VlNotionalLast11mUSDPtax comparison
    ISNULL(S1.VlNotional_Script1_Last11m, 0) AS [Script 1 - Last 11m],
    ISNULL(S2.VlNotional_Script2_Last11m, 0) AS [Script 2 - Last 11m],
    ISNULL(S1.VlNotional_Script1_Last11m, 0) - ISNULL(S2.VlNotional_Script2_Last11m, 0) AS [Diff Script 1 vs 2 - Last 11m],
    CASE 
        WHEN ISNULL(S1.VlNotional_Script1_Last11m, 0) = 0 THEN NULL
        ELSE (ISNULL(S1.VlNotional_Script1_Last11m, 0) - ISNULL(S2.VlNotional_Script2_Last11m, 0)) / ISNULL(S1.VlNotional_Script1_Last11m, 0) * 100
    END AS [Diff Script 1 vs 2 - Percent - Last 11m]
FROM Script1 S1
FULL OUTER JOIN Script2 S2 ON S1.ClientTaxId = S2.ClientTaxId
ORDER BY [Client Name];
