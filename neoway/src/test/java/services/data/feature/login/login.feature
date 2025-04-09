  # language:en
    # encoding UTF8

  Feature: Login

    Background:
      * def header = read('classpath:services/support/config/headers.yaml')
      * def yaml = read('classpath:services/data/yaml/' + env + '/login.yaml')

    Scenario Outline: Este cenarios realiza cadastro dos usuario: <cenarios>
      * def email = <email>
      * def password = <password>
      * def body = read('classpath:services/data/payload/loginPayload.json')

      Given url urlBasicNeoway
      And path '<path>'
      And headers header
      And request body
      When method post
      * print body
      Then status <status_code>
      * print response
      * print response.authorization
      And match response contains <response>
      * def authToken = response.authorization


      @cadastrar_usuario
      Examples:
        | cenarios                                 | status_code | path  | email            | password               | response                                      |
        | CT01: Logar com um usuario ja cadastrado | 200         | login | yaml.email.email | yaml.password.password | {"message": "Login realizado com sucesso"} |
