  # language:en
    # encoding UTF8

  Feature: Editar Usuario

    Background:
      * def header = read('classpath:services/support/config/headers.yaml')
      * def yaml = read('classpath:services/data/yaml/' + env + '/variaveis.yaml')

    Scenario Outline: Este cenarios realiza edição dos usuario: <cenarios>
      * def nome = <nome>
      * def email = <emailEdit>
      * def password = <password>
      * def administrador = <administrador>
      * def body = read('classpath:services/data/payload/usuarioPayload.json')

      #Pré requisito: realizar uma busca pelo email para pegar o ID de usuario

      Given url urlBasicNeoway
      And path <buscar>
      And param email = <email>
      When method get
      Then status 200
      * print response.usuarios[0]
      * def id_user = response.usuarios[0]._id

      #Inicio do cenario de teste
      Given url urlBasicNeoway
      And path <path>
      And headers header
      And request body
      * print id_user
      When method put
      Then status <status_code>
      * print response
      And match response contains <response>


      @editar_usuario
      Examples:
        | cenarios                                                        | status_code | buscar     | path                  | nome                      | email             | emailEdit         | password               | administrador                         | response                                                                                                                                |
        | CT01: Editar o nome do usuário existente                        | 200         | 'usuarios' | 'usuarios/' + id_user | yaml.usuario.usuarioEdit  | yaml.email.email1 | yaml.email.email1 | yaml.password.password | yaml.administrador.administradorFalse | {"message": "Registro alterado com sucesso"}                                                                                            |
        | CT02: Editar um usuário existente com um email de outro usuário | 400         | 'usuarios' | 'usuarios/' + id_user | yaml.usuario.usuarioEdit2 | yaml.email.email2 | yaml.email.email1 | yaml.password.password | yaml.administrador.administradorFalse | {"message": "Este email já está sendo usado"}                                                                                           |
        | CT03: Realizar uma edição sem passar o ID do usuário            | 405         | 'usuarios' | 'usuarios/'           | yaml.usuario.usuarioEdit2 | yaml.email.email2 | yaml.email.email1 | yaml.password.password | yaml.administrador.administradorFalse | {"message": "Não é possível realizar PUT em /usuarios. Acesse https://serverest.dev para ver as rotas disponíveis e como utilizá-las."} |

    @editar_usuario_sem_id
    Scenario Outline: <cenarios>
      * def nome = <nome>
      * def email = <email>
      * def password = <password>
      * def administrador = <administrador>
      * def body = read('classpath:services/data/payload/usuarioPayload.json')

      #Pré requisito: realizar uma busca pelo email e pegar o ID de usuario, nesse caso não vai existir um usuario então ele vai cadastrar na base gerando um novo ID
      Given url urlBasicNeoway
      And path '<path>'
      When method get
      Then status 400
      And match response == {"message": "Usuário não encontrado"}

      Given url urlBasicNeoway
      And path '<path>'
      And headers header
      And request body
      When method put
      Then status <status_code>
      * print response
      And match response contains <response>

      Examples:
        | cenarios                                                                   | status_code | path                      | nome                  | email             | password               | administrador                         | response                                      | buscar     |
        | CT04: Realizar uma edição passando um ID do usuário que não existe na base | 201         | usuarios/rjDjl9H3F7qiFo4x | yaml.usuario.usuario2 | yaml.email.email4 | yaml.password.password | yaml.administrador.administradorFalse | {"message": "Cadastro realizado com sucesso"} | 'usuarios' |

