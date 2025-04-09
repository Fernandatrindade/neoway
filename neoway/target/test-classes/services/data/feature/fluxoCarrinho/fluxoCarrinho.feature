  # language:en
    # encoding UTF8

  Feature: Fluxo de criação de um carrinho

    Background:
      * def header = read('classpath:services/support/config/headers.yaml')
      * def yaml = read('classpath:services/data/yaml/' + env + '/variaveis.yaml')
      * def accessToken = call read('classpath:services/data/feature/login/login.feature')
      * def token = accessToken.authToken

    Scenario Outline: Este cenarios realiza cadastro dos usuario: <cenarios>
      * def nome = <nome>
      * def email = <email>
      * def password = <password>
      * def administrador = <administrador>
      * def body = read('classpath:services/data/payload/usuarioPayload.json')

      Given url urlBasicNeoway
      And path '<path>'
      And headers header
      And request body
      When method post
      Then status <status_code>
      * print response
      * print response._id
      And match response contains <response>
      * def id_usuario = response._id


      @cadastrar_usuario
      Examples:
        | cenarios                    | status_code | path     | nome                  | email             | password               | administrador                        | response                                      |
        | CT01: Cadastrar um  usuário | 201         | usuarios | yaml.usuario.usuario1 | yaml.email.email1 | yaml.password.password | yaml.administrador.administradorTrue | {"message": "Cadastro realizado com sucesso"} |

    Scenario Outline: Este cenarios realiza cadastro dos produtos:<nomeProduto>
      * def nomeProduto = <nomeProduto>
      * def body = read('classpath:services/data/payload/produtoPayload.json')

      Given url urlBasicNeoway
      And path '<path>'
      And header Authorization = token
      And request body
      When method post
      * print nomeProduto
      Then status <status_code>
      * print response
      * print response._id
      And match response contains <response>
      * def id_produto = response._id

      @cadastrar_produto
      Examples:
        | nomeProduto                   | status_code | path     | response                                      |
        | yaml.nomeProduto.nomeProduto1 | 201         | produtos | {"message": "Cadastro realizado com sucesso"} |
        | yaml.nomeProduto.nomeProduto2 | 201         | produtos | {"message": "Cadastro realizado com sucesso"} |

    Scenario Outline: Este cenarios realiza a adição dos produtos no carrinho de compra:

      #* def id_Produto = <idProduto>


      #Pré execução buscar o ID do produto através do nome
      Given url urlBasicNeoway
      And path '<buscar>'
      And param nome = <nomeProduto>
      When method get
      Then status 200
      * print response.produtos[0]
      * def id_Produto1 = response.produtos[0]._id
      * print id_Produto1

      Given url urlBasicNeoway
      And path '<buscar>'
      And param nome = <nomeProduto2>
      When method get
      Then status 200
      * print response.produtos[0]
      * def id_Produto2 = response.produtos[0]._id
      * print id_Produto2


      #Inicio do cenario de teste
      * def body = read('classpath:services/data/payload/carrinhoPayload.json')
      Given url urlBasicNeoway
      And path '<path>'
      And header Authorization = token
      And request body
      * print body
      When method post
      Then status <status_code>
      * print response
      * print response._id
      And match response contains <response>
      * def id_produto = response._id

      @cadastrar_produto
      Examples:
        | status_code | path      | buscar   | nomeProduto                   | nomeProduto2                  | response                                      | idProduto                |
        | 201         | carrinhos | produtos | yaml.nomeProduto.nomeProduto1 | yaml.nomeProduto.nomeProduto2 | {"message": "Cadastro realizado com sucesso"} | response.produtos[0]._id |


    Scenario Outline: Este cenarios finaliza o carrinho de compras


      Given url urlBasicNeoway
      And path '<path>'
      And header Authorization = token
      When method delete
      Then status <status_code>
      * print response

      @finalizar_carrinho
      Examples:
        | status_code | path                      | response                                     |
        | 200         | carrinhos/concluir-compra | {"message": "Registro excluído com sucesso"} |

    Scenario Outline: Este cenarios verifica a quatidade de produto que sobrou no estoque


      Given url urlBasicNeoway
      And path '<buscar>'
      And param nome = <nomeProduto>
      When method get
      Then status <status_code>
      * print response.produtos[0]
      * def quantidade_Produto = response.produtos[0].quantidade
      * print quantidade_Produto
      And match quantidade_Produto != <response>


      @finalizar_carrinho
      Examples:
        | status_code | buscar   | nomeProduto                   | response |
        | 200         | produtos | yaml.nomeProduto.nomeProduto1 | 39       |
        | 200         | produtos | yaml.nomeProduto.nomeProduto2 | 39       |


