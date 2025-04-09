  # language:en
    # encoding UTF8

  Feature: Fluxo de criação de um carrinho

    Background:
      * def yaml = read('classpath:services/data/yaml/' + env + '/variaveis.yaml')
      * def accessToken = call read('classpath:services/data/feature/login/login.feature')
      * def token = accessToken.authToken

    Scenario Outline: Este cenarios deleta os produtos o carrinho de compras

      #Pré requisito: realizar uma busca pelo nome e pegar o ID do produto
      Given url urlBasicNeoway
      And path '<buscar>'
      And param nome = <nomeProduto>
      When method get
      Then status 200
      * print response
      * def id_produto = response.produtos[0]._id


      Given url urlBasicNeoway
      And path <path>
      And header Authorization = token
      When method delete
      Then status <status_code>
      * print response

      @deletar_produto
      Examples:
        | status_code | path                     | response                                     | buscar   | nomeProduto                   |
        | 200         | 'produtos/' + id_produto | {"message": "Registro excluído com sucesso"} | produtos | yaml.nomeProduto.nomeProduto1 |
        | 200         | 'produtos/' + id_produto | {"message": "Registro excluído com sucesso"} | produtos | yaml.nomeProduto.nomeProduto2 |
