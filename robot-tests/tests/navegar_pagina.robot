*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/navigation_keywords.robot
Resource          ../variables/urls.robot

*** Test Cases ***
Acessar Página de Produtos
    # Este é um caso de teste que navega para a URL de produtos.
    Abrir Navegador Na Página     ${PRODUCTS_URL}
    Fechar Navegador

Acessar Página de Carrinho
    # Este é outro caso de teste que navega para a URL do carrinho.
    Abrir Navegador Na Página     ${CART_URL}
    Fechar Navegador