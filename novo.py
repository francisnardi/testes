import pandas as pd

# Carregar os CSVs exportados do SQL Server para DataFrames
# Suponha que você tenha os arquivos CSVs para os três atributos:
# 1. Avg Monthly Notional 12m
# 2. Last 12m
# 3. Last 11m

df_1 = pd.read_csv("path_to_avg_monthly_notional_12m.csv")  # Substitua com o caminho correto
df_2 = pd.read_csv("path_to_last_12m.csv")  # Substitua com o caminho correto
df_3 = pd.read_csv("path_to_last_11m.csv")  # Substitua com o caminho correto

# Formatar colunas de valores em US$
value_columns_1 = [
    "Script 1 - Avg Monthly Notional 12m", 
    "Script 2 - Avg Monthly Notional 12m", 
    "Script 3 - Avg Monthly Notional 12m", 
    "Diff Avg Monthly Notional 12m - Script 1 vs 2", 
    "Diff Avg Monthly Notional 12m - Script 2 vs 3", 
    "Diff Avg Monthly Notional 12m - Script 1 vs 3"
]

value_columns_2 = [
    "Script 1 - Last 12m", 
    "Script 2 - Last 12m", 
    "Script 3 - Last 12m", 
    "Diff Script 1 vs 2 - Last 12m", 
    "Diff Script 2 vs 3 - Last 12m", 
    "Diff Script 1 vs 3 - Last 12m"
]

value_columns_3 = [
    "Script 1 - Last 11m", 
    "Script 2 - Last 11m", 
    "Script 3 - Last 11m", 
    "Diff Script 1 vs 2 - Last 11m", 
    "Diff Script 2 vs 3 - Last 11m", 
    "Diff Script 1 vs 3 - Last 11m"
]

# Função para formatar valores em US$
def format_usd(df, columns):
    for col in columns:
        df[col] = df[col].apply(lambda x: f"${x:,.2f}" if pd.notnull(x) else "$0.00")
    return df

# Formatar os valores para US$
df_1 = format_usd(df_1, value_columns_1)
df_2 = format_usd(df_2, value_columns_2)
df_3 = format_usd(df_3, value_columns_3)

# Formatar as porcentagens
percent_columns_1 = [
    "Diff Avg Monthly Notional 12m - Percent - Script 1 vs 2", 
    "Diff Avg Monthly Notional 12m - Percent - Script 2 vs 3", 
    "Diff Avg Monthly Notional 12m - Percent - Script 1 vs 3"
]

percent_columns_2 = [
    "Diff Script 1 vs 2 - Percent - Last 12m", 
    "Diff Script 2 vs 3 - Percent - Last 12m", 
    "Diff Script 1 vs 3 - Percent - Last 12m"
]

percent_columns_3 = [
    "Diff Script 1 vs 2 - Percent - Last 11m", 
    "Diff Script 2 vs 3 - Percent - Last 11m", 
    "Diff Script 1 vs 3 - Percent - Last 11m"
]

# Função para formatar as porcentagens no Excel
def format_percentage(df, columns):
    for col in columns:
        df[col] = df[col].apply(lambda x: f"{x:.1f}%" if pd.notnull(x) else "0.0%")
    return df

# Formatar as porcentagens
df_1 = format_percentage(df_1, percent_columns_1)
df_2 = format_percentage(df_2, percent_columns_2)
df_3 = format_percentage(df_3, percent_columns_3)

# Salvar tudo em um único arquivo Excel com 3 abas
output_path = "path_to_output_excel_file.xlsx"  # Substitua com o caminho de saída desejado
with pd.ExcelWriter(output_path) as writer:
    df_1.to_excel(writer, sheet_name="Avg Monthly Notional 12m", index=False)
    df_2.to_excel(writer, sheet_name="Last 12m", index=False)
    df_3.to_excel(writer, sheet_name="Last 11m", index=False)

print(f"Arquivo Excel gerado em: {output_path}")
