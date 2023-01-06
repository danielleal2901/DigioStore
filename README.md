# DigioStore

## O projeto
- Se trata de uma cena contendo uma lista de banners e itens (produtos) aonde é possível o usuário clicar em algum desses itens e ser levado para uma tela de detalhes respectiva. 

## Organização do Projeto
### Resources: Arquivos externos como imagens, fontes, textos/localizable.
### DAO: Camada responsável por persistir e recuperar os dados, sejam eles via API, repositório local e etc.
    Network: Acesso à API's.
### Common: Arquivos úteis/comuns para várias cenas, como Extensions.
### Scenes: Cenas/Fluxos da aplicação.

## Arquitetura
- MVVM-C: Foi optado essa arquitetura por se tratar de um projeto mais simples, onde as camadas dessa arquitetura foram suficientes para se ter uma boa separação de reponsabilidades, um código limpo e permitir escalabilidade.
### Scene:
- Para a preparação dos dados para a View, foram utilizadas de ViewData's, camada adicional utilizada para retirar essa responsabilidade da ViewModel, que nesse caso, foi utilizada apenas para o controle das regras de negócio e fluxos da tela.
- Para o acesso a DAO foi criada uma camada de Service, responsável por criar o Endpoint e acessar o objeto de DAO necessário.
- Para o autolayout foi utilizado ViewCode e UIKit.

## Testes
- Para os testes foram utilizados a framework nativa (XCTest), test doubles (Spy, Mock) e do Design Pattern "Fixture".

## Frameworks Externas
### SwiftLint: As regras podem ser configuradas no arquivo .swiftlint.yml (na root do projeto).

 
