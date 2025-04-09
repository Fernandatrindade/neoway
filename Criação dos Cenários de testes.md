Projeto de Enriquecimento de Dados de Livros  

Observação:  

- Qual é o formato do arquivo de edição ex: PDF, TXT, JPEG???  

- Qual é o formado do arquivo que será entregue para o cliente e quais os detalhes dos livros ex: o resumo do livro, título? 

 - Qual é o tamanho do arquivo que o cliente pode adicionar no sistema? 

- Pode editar livros em lote? 

Cenário de teste 01: Adição de livros na base já existente através de um arquivo com as informações como título e as edições dos livros

Dado que esteja logado no sistema da livraria 

Quando adiciono um arquivo com as informações dos títulos dos livros

E as edições 

Então as informações e salva com sucesso no banco de dados 

E as os livros adicionados devem ser atualizados 

E verificar no banco se as informações foram salvas nas colunas corretas  

*** Cenário de teste 02: Adição de livros novos na base através de um arquivo com as informações como título e as edições dos livros ***

Dado que esteja logado no sistema da livraria 

Quando adiciono um arquivo com os livros novos contendo as informações dos títulos dos livros  

E as edições 

Então os livros são adicionados com sucesso na base de dados  

E verificar no banco se as informações foram salvas nas colunas corretas  

** Cenário de teste 03: O sistema deve exportar um arquivo com detalhes dos livros **

Dado que esteja logado no sistema da livraria 

Quando finalizar a importação do arquivo   

Então o sistema irá exportar um arquivo com os detalhes dos livros salvo no banco de dados 

** Cenário de teste 04: Editar e aprimorar a qualidade dos livros fornecidos pelo cliente ** 
 
Dado que esteja logado no sistema da livraria 

E seleciono um livro  

Quando realizo a edição do informações do livro selecionado   

Então o sistema atualiza as informações do livro 

E verificar no banco se as informações foram atualizadas corretamente 

 ** Cenário de teste 05: Facilitar a busca de informações detalhadas sobre os livros ** 

Dado que esteja logado no sistema da livraria 

Quando digito na pesquisa as informações do livro como o título e edição.  

Então o sistema deverá realizar a busca pelo livro de acordo com a pesquisa 

** Cenário de teste 06: Adição de livros de um livro na base de dados **

Dado que esteja logado no sistema da livraria 

Quando adiciono um livro  

E informo todas as informações necessários do livro 

Então as informações e salva com sucesso no banco de dados 

E verificar no banco se as informações foram salvas nas colunas corretas 

E um arquivo e exportado com os livros salvo na base de dados 

** Cenário de teste 07: Desativar um livro no sistema ** 

Dado que esteja logado no sistema da livraria 

Quando seleciono um livro que desejo desativar  

E clico em desativar  

Então o livro será desativado com sucesso do sistema 

E um arquivo e exportado com os livros salvo na base de dados  

E com os livros desativados 


<h2>Desafio: Testes Funcionais- API </h2>

Cenário 1 Validação da funcionalidade de usuários: 

 

Cadastrar 

CT01: Cadastrar um novo usuário 	como administrador 

Dado que esteja na API https://serverest.dev/usuarios 

Quando informo os dados do novo usuário  

E o administrador como TRUE 

E realiza um post  

Então exibido o status code 201 no response e exibido a mensagem de “Cadastro Realizado com Sucesso” 

E o ID  
![Screenshot_2](https://github.com/user-attachments/assets/2fe10d20-241a-4da9-893f-bc30085a80ad)

 

CT02: Cadastrar um novo usuário 	não administrador 

Dado que esteja na API https://serverest.dev/usuarios 

Quando informo os dados do novo usuário  

E o administrador como FALSE 

E realiza um post  

Então exibido o status code 201 no response e exibido a mensagem de “Cadastro Realizado com Sucesso” 

E o ID 
![Screenshot_3](https://github.com/user-attachments/assets/667bd433-4b07-4855-9df0-46d29d584421) 

CT03: Cadastrar um usuário existente 

Dado que esteja na API https://serverest.dev/usuarios 

Quando informo os Email do usuário existente  

E o administrador como FALSE/TRUE 

E realiza um post  

Então exibido o status code 400 no response e exibido a mensagem de “Este Email já está sendo usado” 

![image](https://github.com/user-attachments/assets/6b8f4eb4-ecae-4de6-850c-c89a098f2238) 

CT04: Cadastrar um usuário existente com email diferente 

Dado que esteja na API https://serverest.dev/usuarios 

Quando informo os dados de um usuário existente 

E com um email diferente 

E o administrador como FALSE/TRUE 

E realiza um post  

Então exibido o status code 201 no response e exibido a mensagem de “Cadastro Realizado com Sucesso” 

E o ID 

 
![Screenshot_5](https://github.com/user-attachments/assets/caec96b3-6650-4bd3-b837-e45f27bc137a)

Editar 

CT05: Editar o nome do usuário existente  

Dado que esteja na API https://serverest.dev/usuarios/ID 

Quando edito o nome 

E realiza um PUT 

Então exibido o status code 200 no response e exibido a mensagem de “Registro alterado com sucesso” 

 ![Screenshot_6](https://github.com/user-attachments/assets/9122971f-3bd6-4bd0-a0a4-6e7535d61e5a)


CT06: Editar um usuário existente com um Email de outro usuário 

Dado que esteja na API https://serverest.dev/usuarios/ID 

Quando edito e coloco um Email de outro usuário 

E realiza um PUT 

Então exibido o status code 400 no response e exibido a mensagem de “Este Email já está sendo usado” 

 
![Screenshot_7](https://github.com/user-attachments/assets/fe1b1be3-d46b-4871-b16d-9b88beb41ad5)

CT07: Realizar uma edição sem passar o ID do usuário 

Dado que esteja na API https://serverest.dev/usuarios/ SEM O ID 

Quando edito as informações necessária 

E realiza um PUT 

Então exibido o status code 405 no response e exibido a mensagem de “Não é possível realizar PUT em /usuários/. Acesse https://serverest.dev para ver as rotas disponíveis e como utilizá-las.” 

![Screenshot_8](https://github.com/user-attachments/assets/2eea0469-5105-4038-8ab4-b5785219cd6c)

CT07: Realizar uma edição passando um ID do usuário que não existe na base 

Dado que esteja na API https://serverest.dev/usuarios/ UM NOVO ID 

Quando edito as informações necessária 

E realiza um PUT 

Então exibido o status code 201 no response e exibido a mensagem de “Cadastro Realizado com Sucesso” 

E o um novo ID e criado 
![Screenshot_9](https://github.com/user-attachments/assets/66a22082-a3bf-4efd-a086-94e29da662b6)
 

Deletar 

CT08: Deletar um usuário passando o ID do usuário com um carrinho cadastrado 

Dado que esteja na API https://serverest.dev/usuarios/ ID 

E realiza um DELETE 

Então exibido o status code 400 no response e exibido a mensagem de “Não é permitido excluir usuário com carrinho cadastrado” 
![image](https://github.com/user-attachments/assets/43f942c9-e75d-4266-85d4-f93563bd0217)

 
CT09: Deletar um usuário passando o ID do usuário  

Dado que esteja na API https://serverest.dev/usuarios/ ID 

E realiza um DELETE 

Então exibido o status code 200 no response e exibido a mensagem de “Registro excluído com sucesso” 
![Screenshot_10](https://github.com/user-attachments/assets/432429cd-2834-43e9-a2f5-3922b1fb7394)

 

CT10: Deletar um usuário sem passar o ID do usuário  

Dado que esteja na API https://serverest.dev/usuarios/ SEM O ID 

E realiza um DELETE 

Então exibido o status code 405 no response e exibido a mensagem de “Não é possível realizar DELETE em /usuarios/. Acesse https://serverest.dev para ver as rotas disponíveis e como utilizá-las.” 
![image](https://github.com/user-attachments/assets/cc453be7-4189-4f00-a050-9fa8fd7a58a4)


CT11: Deletar um usuário que já foi excluído  

Dado que esteja na API https://serverest.dev/usuarios/  ID JA EXCLUIDO 

E realiza um DELETE 

Então exibido o status code 200 no response e exibido a mensagem de “Nenhum registro excluído.” 
![image](https://github.com/user-attachments/assets/4c1f5dc9-844c-4c6f-827e-39b4d6e8f437)

 ** Buscar ou Listar usuários ** 

CT11: Buscar usuário por ID 

Dado que esteja na API https://serverest.dev/usuarios/  ID  do usuario 

E realiza um GET 

Então exibido o status code 200 no response e exibido os dados do usuário 
![image](https://github.com/user-attachments/assets/8cdaf891-867a-4912-916f-d05feaba878d)
 

CT12: Buscar usuário por ID que não existe 

Dado que esteja na API https://serverest.dev/usuarios/  ID  do usuário que não existe 

E realiza um GET 

Então exibido o status code 400 no response e exibido a "message": "Usuário não encontrado" 
![image](https://github.com/user-attachments/assets/2529ff78-37ee-4a5a-a48e-7759ab802f79)

 CT12: Buscar usuário por Nome 

Dado que esteja na API https://serverest.dev/usuarios?nome =Nome  do usuario 

E realiza um GET 

Então exibido o status code 200 no response e exibido os dados do usuário 
![image](https://github.com/user-attachments/assets/47799fbe-a61a-48db-b034-6e4261399671)


<b>BUG: Ao executar a API de Listar o Usuário cadastrado e filtrar pelo ID está dando o erro "id": "id não é permitido" </b>

Dado que esteja na API https://serverest.dev/usuarios?id=D4kKeJg9JCK0Ztqy 

E realiza um GET 

Resuldado Obtido: Então exibido o status code 400 no response e exibido  "id": "id não é permitido"
 ![image](https://github.com/user-attachments/assets/f7934e66-ea9f-4aae-ac68-2f9b77f2e010)

 Resultado Esperado: Exibir os dados do usuario conforme o print abaixo.
![image](https://github.com/user-attachments/assets/3569b0ca-3313-438f-8f9a-d9dd2a542f53)


 

 

 

 

 

 

 

 

 

 

 

 

 

 
