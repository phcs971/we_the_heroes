class Texts {
  Texts._();

  static int _lang = 0;

  // 0 => English
  // 1 => Português Brasileiro -> Brazilian Portuguese

  static void changeLang(int newLang) => _lang = newLang;
  static int getLang() => _lang;

  //LOGIN PAGE

  static String get email => [
        'EMAIL',
        'EMAIL',
      ][_lang];
  static String get password => [
        'PASS',
        'SENHA',
      ][_lang];
  static String get name => [
        'NAME',
        'NOME',
      ][_lang];
  static String get logar => [
        'LOGIN',
        'ENTRAR',
      ][_lang];
  static String get or => [
        'OR',
        'OU',
      ][_lang];
  static String get signinwith => [
        'Sign in with...',
        'Entre com...',
      ][_lang];
  static String get changepass => [
        'Change your Password',
        'Mudar sua Senha',
      ][_lang];
  static String get createaccount => [
        'Create an Account',
        'Criar uma Conta',
      ][_lang];
  static String get writeemail => [
        'Write your email:',
        'Forneça seu email:',
      ][_lang];

  //SIGN UP PAGE

  static String get emailsent => [
        'Email Sent',
        'Email Enviado',
      ][_lang];
  static String get emailbad => [
        'Email Bad Formated',
        'Email Mal Formatado',
      ][_lang];
  static String get userNotFound => [
        'User Not Found',
        'Usuário Não Encontrado',
      ][_lang];

  //HOME PAGE

  static String get home => [
        'Home',
        'Página Inicial',
      ][_lang];
  static String get openMenu => [
        'Open Menu',
        'Abrir Menu',
      ][_lang];
  static String get acts => [
        'Current Acts',
        'Atos Atuais',
      ][_lang];
  static String get noCases => [
        'There are no cases in your current region, please create one and share the app with more people!',
        'Não existem casos na sua região atual, por favor crie casos e compartilhe o aplicativo!',
      ][_lang];
  static String get search => [
        'Search',
        'Pesquisar',
      ][_lang];
  static String get createCase => [
        'Create a Case',
        'Criar um Caso',
      ][_lang];

  // MENU

  static String get logout => [
        'Logout',
        'Sair',
      ][_lang];
  static String get myCases => [
        'My Cases',
        'Meus Casos',
      ][_lang];
  static String get caseHistoy => [
        'Case History',
        'HIstórico de Casos',
      ][_lang];
  static String get options => [
        'Options',
        'Opções',
      ][_lang];
  static String get surelogout => [
        'Are you sure you wish to logout?',
        'Tem certeza que deseja sair?',
      ][_lang];

  // NEW CASE

  static String get editCase => [
        'Edit a Case',
        'Editar um Caso',
      ][_lang];
  static String get title => [
        'Title',
        'Título',
      ][_lang];
  static String get hp => [
        'hp',
        'hp',
      ][_lang];
  static String get desc => [
        'Description',
        'Descrição',
      ][_lang];

  // CASE PAGE

  static String get casecompleted => [
        'The case has been completed',
        'O caso foi concluído',
      ][_lang];
  static String get someoneelse => [
        'Another hero has the case',
        'Outro herói tem o caso',
      ][_lang];
  static String get acceptCase => [
        'Accept Case',
        'Aceitar Caso',
      ][_lang];
  static String get finishCase => [
        'Finish Case',
        'Finalizar Caso',
      ][_lang];
  static String get noAction => [
        'No Action Available',
        'Nenhum Ação Disponível',
      ][_lang];

  // MY CASES

  static String get inProgressby => [
        'In Progress by the Hero',
        'Em Progresso pelo Herói',
      ][_lang];
  static String get finishedby => [
        'Finished by the Hero',
        'Finalizado pelo Herói',
      ][_lang];
  static String get noSelfCases => [
        'You do not have any case registered in activity. Register one if you need help from a hero.',
        "Você não tem nenhum caso registrado ativado. Registre um caso necessite da ajuda de um herói",
      ][_lang];

  // CURRENT ACTS

  static String get noAct => [
        'You are not helping anyone at the moment, click on a case and accept it.',
        'Você não está ajudando ninguêm agora, clique num caso e aceite-o.'
      ][_lang];

  // COMUM

  static String get hero => [
        'Hero',
        'Herói',
      ][_lang];
  static String get update => [
        'UPDATE',
        'ATUALIZAR',
      ][_lang];
  static String get delete => [
        'DELETE',
        'DELETAR',
      ][_lang];
  static String get caseWord => [
        'Case',
        'Caso',
      ][_lang];
  static String get needshelp => [
        'needs your help for',
        'precisa da sua ajuda por',
      ][_lang];
  static String get back => [
        'Back',
        'Voltar',
      ][_lang];
  static String get save => [
        'Save and Exit',
        'Salvar e Sair',
      ][_lang];
  static String get no => [
        'No',
        'Não',
      ][_lang];
  static String get yes => [
        'Yes',
        'Sim',
      ][_lang];
  static String get cancel => [
        'Cancel',
        'Cancelar',
      ][_lang];
  static String get send => [
        'Send',
        'Enviar',
      ][_lang];
  static String get error => [
        'ERROR',
        'ERRO',
      ][_lang];
}
