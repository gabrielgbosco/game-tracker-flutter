# Game Tracker

Aplicativo Flutter desenvolvido para a atividade **N1 — Faixa 8**.

## Como abrir e executar o projeto

Este pacote contém o **código-fonte completo** (`lib/`), o `pubspec.yaml`
e as imagens de capa dos jogos (`assets/images/`). As pastas de
plataforma (`android/`, `ios/`, etc.) **não estão incluídas**, pois
precisam ser geradas pela sua instalação local do Flutter SDK.

Passo a passo:

1. Instale o [Flutter SDK](https://docs.flutter.dev/get-started/install)
   e confirme que está tudo certo com `flutter doctor`.
2. Extraia este `.zip` em uma pasta, por exemplo `game_tracker/`.
3. Dentro da pasta, rode:
   ```bash
   flutter create .
   ```
   Isso gera as pastas de plataforma (`android/`, `ios/`, `web/`, etc.)
   sem sobrescrever o `lib/`, o `pubspec.yaml` já existentes (o Flutter
   detecta os arquivos já presentes e só completa o que falta; caso
   ele pergunte sobre sobrescrever o `pubspec.yaml`, escolha **não** e
   depois confira se as dependências abaixo estão nele).
4. Instale as dependências:
   ```bash
   flutter pub get
   ```
5. Rode no emulador Android (ou dispositivo conectado):
   ```bash
   flutter run
   ```

## Dependências usadas

- [`fl_chart`](https://pub.dev/packages/fl_chart): geração do gráfico
  de barras (horas jogadas por jogo) na tela de Estatísticas.

## Estrutura do projeto

```
lib/
  main.dart                     -> ponto de entrada do app
  theme/
    app_theme.dart              -> cores e estilos centrais
  models/
    game.dart                   -> classe Game (modelo de dados)
  data/
    game_repository.dart        -> coleção de jogos em memória (singleton)
  widgets/
    game_card.dart              -> card reutilizável da lista de jogos
    stat_tile.dart               -> cartão reutilizável de estatística
    section_title.dart          -> título de seção reutilizável
  screens/
    dashboard_screen.dart       -> tela inicial / resumo
    game_list_screen.dart       -> lista de jogos
    game_detail_screen.dart     -> detalhes + edição de horas/avaliação
    statistics_screen.dart      -> gráfico e números calculados
    random_pick_screen.dart     -> funcionalidade "O que jogar?"
assets/
  images/                       -> capas dos 6 jogos (geradas localmente,
                                    sem uso de imagens de terceiros)
```

## Funcionalidades implementadas

- **Dashboard**: nome do app, total de jogos, total de horas, média
  das avaliações, acesso à lista e às estatísticas.
- **Lista de jogos**: cards com imagem, nome, gênero, plataforma e
  avaliação; toque abre os detalhes.
- **Detalhes do jogo**: imagem, nome, gênero, plataforma, descrição,
  horas jogadas e avaliação, com botões para aumentar/diminuir horas
  (sem permitir valores negativos) e aumentar/diminuir avaliação
  (limitada entre 0 e 10).
- **Estado em memória**: as alterações feitas na tela de detalhes
  persistem enquanto o app estiver aberto, pois o `GameRepository` é
  um singleton e os objetos `Game` são mutáveis (alterações refletem
  em qualquer tela que os leia novamente).
- **Estatísticas**: gráfico de barras (horas por jogo) com `fl_chart`,
  além de jogo mais jogado, melhor avaliado, total de horas e média
  geral.
- **O que jogar?**: sorteio aleatório de um jogo (usando `dart:math`),
  com botão para sortear novamente.

## Observação sobre as imagens

As capas dos jogos em `assets/images/` foram geradas localmente (não
são capturas de jogos reais nem imagens de terceiros), apenas para
ilustrar o uso de `Image.asset` no aplicativo. Sinta-se à vontade para
substituí-las por imagens próprias antes da entrega.
