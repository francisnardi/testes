WITH Script1 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlNotionalLast12mUSDPTax AS VNotional_Script1_Last12m,
        p.VlNotionalLast11mUSDPTax AS VNotional_Script1_Last11m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'Old_Script_New_Natures_251206'
),
Script2 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlNotionalLast12mUSDPTax AS VNotional_Script2_Last12m,
        p.VlNotionalLast11mUSDPTax AS VNotional_Script2_Last11m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'New_Script_New_Natures_Inactive_251206'
),
Script3 AS (
    SELECT 
        c.ClientTaxId,
        c.ClientLegalName,
        p.VlNotionalLast12mUSDPTax AS VNotional_Script3_Last12m,
        p.VlNotionalLast11mUSDPTax AS VNotional_Script3_Last11m
    FROM [change].[dbo].[TB_RISKBASED_CLIENTTRANSACTIONALPROFILE] p
    INNER JOIN TB_RISKBASED_CLIENT c ON c.ClientTaxId = p.ClientTaxId
    WHERE p.UserLastUpdate = 'New_Script_New_Natures_Active_251206'
)
SELECT 
    COALESCE(S1.ClientTaxId, S2.ClientTaxId, S3.ClientTaxId) AS [Client ID],
    COALESCE(S1.ClientLegalName, S2.ClientLegalName, S3.ClientLegalName) AS [Client Name],
    -- Valores de cada script
    ISNULL(S1.VNotional_Script1_Last12m, 0) AS [Script 1 - Last 12m],
    ISNULL(S2.VNotional_Script2_Last12m, 0) AS [Script 2 - Last 12m],
    ISNULL(S3.VNotional_Script3_Last12m, 0) AS [Script 3 - Last 12m],
    -- Diferenças entre scripts
    ISNULL(S1.VNotional_Script1_Last12m, 0) - ISNULL(S2.VNotional_Script2_Last12m, 0) AS [Diff Script 1 vs 2 - Last 12m],
    ISNULL(S2.VNotional_Script2_Last12m, 0) - ISNULL(S3.VNotional_Script3_Last12m, 0) AS [Diff Script 2 vs 3 - Last 12m],
    ISNULL(S1.VNotional_Script1_Last12m, 0) - ISNULL(S3.VNotional_Script3_Last12m, 0) AS [Diff Script 1 vs 3 - Last 12m],
    -- Repita o mesmo para a coluna Last 11m
    ISNULL(S1.VNotional_Script1_Last11m, 0) AS [Script 1 - Last 11m],
    ISNULL(S2.VNotional_Script2_Last11m, 0) AS [Script 2 - Last 11m],
    ISNULL(S3.VNotional_Script3_Last11m, 0) AS [Script 3 - Last 11m],
    ISNULL(S1.VNotional_Script1_Last11m, 0) - ISNULL(S2.VNotional_Script2_Last11m, 0) AS [Diff Script 1 vs 2 - Last 11m],
    ISNULL(S2.VNotional_Script2_Last11m, 0) - ISNULL(S3.VNotional_Script3_Last11m, 0) AS [Diff Script 2 vs 3 - Last 11m],
    ISNULL(S1.VNotional_Script1_Last11m, 0) - ISNULL(S3.VNotional_Script3_Last11m, 0) AS [Diff Script 1 vs 3 - Last 11m]
FROM Script1 S1
FULL OUTER JOIN Script2 S2 ON S1.ClientTaxId = S2.ClientTaxId
FULL OUTER JOIN Script3 S3 ON COALESCE(S1.ClientTaxId, S2.ClientTaxId) = S3.ClientTaxId
ORDER BY [Client Name];
