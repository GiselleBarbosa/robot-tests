*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Abrir Navegador Na Página
    [Arguments]    ${url}
    Open Browser    ${url}    Chrome
    Maximize Browser Window

Fechar Navegador
    Close Browser