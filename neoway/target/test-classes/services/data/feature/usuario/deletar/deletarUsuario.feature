  # language:en
    # encoding UTF8

  Feature: Deletar Usuario

    Background:
      * def header = read('classpath:services/support/config/headers.yaml')
      * def yaml = read('classpath:services/data/yaml/' + env + '/variaveis.yaml')

    Scenario Outline: Estes cenarios executa a exclução dos usuario na base: <cenarios>

      #Pré requisito: realizar uma busca pelo email e pegar o ID de usuario
      Given url urlBasicNeoway
      And path <buscar>
      And param email = <email>
      When method get
      Then status 200
      #* print response.usuarios[0]
      * def id_user = response.usuarios[0]._id

      #Inicio do cenario de teste

      Given url urlBasicNeoway
      And path <path>
      And headers header
      * print id_user
      When method delete
      Then status <status_code>
      * print response

      @deletar_usuario @ignore
      Examples:
        | cenarios                                                                     | status_code | buscar     | path                        | email             | response                                                                                                                                    |
        | CT01: Deletar um usuário passando o ID do usuário                            | 200         | 'usuarios' | 'usuarios/' + id_user       | yaml.email.email1 | {"message": "Registro excluído com sucesso"}                                                                                                |
        | CT02: Deletar um usuário passando o ID do usuário com um carrinho cadastrado | 400         | 'usuarios' | 'usuarios/0uxuPY0cbmQhpEz1' | yaml.email.email2 | {"message": "Não é permitido excluir usuário com carrinho cadastrado"}                                                                      |
        | CT03: Deletar um usuário sem passar o ID do usuário                          | 405         | 'usuarios' | 'usuarios/'                 | yaml.email.email3 | {"message": "Não é possível realizar DELETE em /usuarios/. Acesse https://serverest.dev para ver as rotas disponíveis e como utilizá-las."} |
        | CT04: Deletar um usuário que já foi excluído                                 | 200         | 'usuarios' | 'usuarios/uSFeaiPMWa9BRBlE' | yaml.email.email1 | {"message": "Nenhum registro excluído."}                                                                                                    |

    Scenario Outline:  <cenarios>

      Given url urlBasicNeoway
      And path <path>
      And headers header
      When method delete
      Then status <status_code>
      * print response

      @deletar_usuario
      Examples:
        | cenarios                                     | status_code | path                        | email             | response                                 |
        | CT04: Deletar um usuário que já foi excluído | 200         | 'usuarios/uSFeaiPMWa9BRBlE' | yaml.email.email1 | {"message": "Nenhum registro excluído."} |


