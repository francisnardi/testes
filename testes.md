
Assunto: Justificativa de Ajuste no Processo de Notificação para o PTAX

Oi Tati,

Boa tarde!

Sobre o processo que temos enfrentado alguns problemas, gostaria de compartilhar algumas informações para justificar a necessidade de ajuste.

Identificamos que:

- O processo **5424 - Cesium file to Webequities - Copy TXT to FX** (filhos: **5419 - NEW Cesium file to Webequities - Load TXT** e **5421 - PROCESS Cesium file to Webequities - To EMIS**) falhou algumas vezes por conta do valor nulo do PTAX, sendo tratado como **contingência**.

No caso em que atuei, o erro foi causado pela ausência de colunas no arquivo CSV, o que impediu o EMIS de transformá-lo corretamente para o formato exigido. Em conversas com Leandro Rodrigues, ele mencionou que esse problema já foi observado em outras ocasiões devido ao PTAX, mas ressaltou que o processo EMIS não tem uma notificação de erro definida para este tipo de falha.

Até o momento, o máximo que consegui foi a seguinte estrutura de configuração:

```json
{
    "Name": "MESSAGE_TYPE",
    "Override": false,
    "Value": "1203"
}
```

Não tenho certeza se essa estrutura se refere a um template específico ou não.

Gostaria de ressaltar que não recebi nenhuma notificação automática via e-mail que justificasse a alteração do horário de execução do processo de 10h para 10h30. Para realizar essa mudança oficialmente, seria importante termos uma notificação específica para documentar a necessidade, caso essa funcionalidade já exista no sistema.

Leandro também comentou que o MAPS tem um mapeamento de notificações e mensagens de erro para processos que apresentam falhas. Se puder verificar se existe alguma notificação já configurada para esse tipo de situação ou me orientar sobre como configurar, seria muito útil.

Por fim, anexarei alguns e-mails que documentam a necessidade da mudança no horário do processo de seg a sex como uma evidência adicional.

Muito obrigado pela atenção e suporte!

Atenciosamente,  
[Seu Nome]
