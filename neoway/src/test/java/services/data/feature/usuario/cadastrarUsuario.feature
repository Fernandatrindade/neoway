  # language:en
  # encoding UTF8

  Feature: Cadastrar Usuario

    Background:
      * def header = read('classpath:services/support/config/headers.yaml')
      * def yaml = read('classpath:services/data/yaml/' + env + '/variaveis.yaml')

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
        | cenarios                                                 | status_code | path     | nome                      | email                 | password                    | administrador                         | response                                                                                                                                                                            |
        | CT01: Cadastrar um novo usuário como administrador       | 201         | usuarios | yaml.usuario.usuario1     | yaml.email.email1     | yaml.password.password      | yaml.administrador.administradorTrue  | {"message": "Cadastro realizado com sucesso"}                                                                                                                                       |
        | CT02: Cadastrar um novo usuário não administrador        | 201         | usuarios | yaml.usuario.usuario2     | yaml.email.email2     | yaml.password.password      | yaml.administrador.administradorFalse | {"message": "Cadastro realizado com sucesso"}                                                                                                                                       |
        | CT04: Cadastrar um usuário existente com email diferente | 201         | usuarios | yaml.usuario.usuario2     | yaml.email.email3     | yaml.password.password      | yaml.administrador.administradorFalse | {"message": "Cadastro realizado com sucesso"}                                                                                                                                       |

    Scenario Outline: Este cenarios realiza os testes negativos: <cenarios>
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
      And match response contains <response>

      @cenarios_negativos_usuario
      Examples:
        | cenarios                             | status_code | path     | nome                      | email                 | password                    | administrador                         | response                                                                                                                                                                            |
        | CT03: Cadastrar um usuário existente | 400         | usuarios | yaml.usuario.usuario2     | yaml.email.email2     | yaml.password.password      | yaml.administrador.administradorFalse | {"message": "Este email já está sendo usado"}                                                                                                                                       |
        | CT05: Todos os campos nulos          | 400         | usuarios | yaml.usuario.usuario_null | yaml.email.email_null | yaml.password.password_null | yaml.administrador.administrador_null | {"nome": "nome deve ser uma string", "email": "email deve ser uma string", "password": "password deve ser uma string", "administrador": "administrador deve ser 'true' ou 'false'"} |
