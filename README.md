## Guia de Configuração e Execução de Testes com Robot Framework

Este README detalha os passos necessários para configurar seu ambiente, instalar as dependências e executar os testes de automação web desenvolvidos com Robot Framework e SeleniumLibrary.

### Pré-requisitos

Antes de começar, certifique-se de ter o seguinte instalado em seu sistema:

- **Python 3.8+**: Baixe e instale do [site oficial do Python](https://www.python.org/downloads/)
  - Importante: Durante a instalação no Windows, marque a opção "Add Python to PATH"

- **Google Chrome** (ou outro navegador de sua escolha, como Firefox, Edge)

- **ChromeDriver** (ou GeckoDriver para Firefox, EdgeDriver para Edge): Baixe o driver correspondente à versão do seu navegador
  - [ChromeDriver](https://chromedriver.chromium.org/downloads)
  - Coloque o arquivo executável do driver (ex: chromedriver.exe) em um diretório que esteja no seu PATH do sistema ou na pasta Scripts do seu ambiente virtual

### Configuração do Ambiente

#### 1. Política de Execução do PowerShell (Apenas Windows PowerShell)

Se você estiver usando o Windows PowerShell, pode ser necessário ajustar a política de execução:

1. Abra o PowerShell como Administrador:
   - Clique no botão Iniciar do Windows
   - Digite "PowerShell"
   - Clique com o botão direito em "Windows PowerShell"
   - Selecione "Executar como administrador"
   - Confirme a permissão de administrador

2. Execute o comando:

   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

   - Digite S (Sim) quando solicitado
   - Feche a janela do PowerShell de administrador

#### 2. Criação e Ativação do Ambiente Virtual

1. Navegue até a pasta raiz do projeto:

   ```powershell
   cd C:\Users\user\venv\robot-tests
   ```

2. Remova qualquer ambiente virtual existente:

   ```powershell
   Remove-Item -Recurse -Force venv
   ```

3. Crie um novo ambiente virtual:

   ```powershell
   python -m venv venv
   ```

4. Ative o ambiente virtual:

   ```powershell
   . .\venv\Scripts\Activate.ps1
   ```

#### 3. Instalação das Dependências

Com o ambiente virtual ativado:

1. Atualize o pip:

   ```powershell
   pip install --upgrade pip
   ```

2. Instale o Robot Framework e a SeleniumLibrary:

   ```powershell
   pip install robotframework robotframework-seleniumlibrary
   ```

### Estrutura do Projeto

```
robot-tests/
├── venv/                     # Ambiente virtual do projeto
├── tests/
│   └── navegar_pagina.robot  # Arquivo principal dos casos de teste
├── resources/
│   └── navigation_keywords.robot # Palavras-chave reutilizáveis para navegação
└── variables/
    └── urls.robot            # Variáveis de URLs e outros dados globais
```

### Conteúdo dos Arquivos Robot Framework

#### tests/navegar_pagina.robot

```robotframework
*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/navigation_keywords.robot
Resource          ../variables/urls.robot

*** Test Cases ***
Acessar Página de Produtos
    Abrir Navegador Na Página     ${PRODUCTS_URL}
    Page Should Contain Element   css:h1
    Fechar Navegador

Acessar Página de Carrinho
    Abrir Navegador Na Página     ${CART_URL}
    Page Should Contain Element   css:h1
    Fechar Navegador
```

#### resources/navigation_keywords.robot

```robotframework
*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Abrir Navegador Na Página
    [Arguments]    ${url}
    Open Browser    ${url}    Chrome
    Maximize Browser Window

Fechar Navegador
    Close Browser
```

#### variables/urls.robot

```robotframework
*** Variables ***
${BASE_URL}           http://localhost:4201
${PRODUCTS_URL}       ${BASE_URL}/products
${CART_URL}           ${BASE_URL}/cart
```

### Execução dos Testes

1. Certifique-se de que seu ambiente virtual está ativo:

   ```powershell
   cd C:\Users\user\venv\robot-tests
   . .\venv\Scripts\Activate.ps1
   ```

2. Navegue até a pasta tests:

   ```powershell
   cd tests
   ```

3. Execute os testes:

   ```powershell
   robot navegar_pagina.robot
   ```

O Robot Framework gerará relatórios (.html) e logs (.html) detalhados na pasta tests.

### Resolução de Problemas Comuns

#### AttributeError: module 'certifi' has no attribute 'where' ou No keyword with name 'Open Browser' found

- Solução: Recriar o ambiente virtual e reinstalar as dependências conforme as seções anteriores.

#### Resource file '...' does not exist

- Verifique se há comentários (#) na mesma linha que a declaração Resource
- Exemplo correto:

  ```robotframework
  Resource          ../resources/navigation_keywords.robot
  # Comentário aqui
  ```

#### DevTools listening on ws://127.0.0.1:... e teste FAIL

Se o teste falhar com "Page Should Contain Element 'css:h1' but did not":

1. Inspecione a página web (<http://localhost:4201/products>)
2. Verifique a estrutura HTML
3. Ajuste o seletor CSS, ID ou XPath conforme necessário
