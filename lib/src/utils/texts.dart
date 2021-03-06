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
        'PASSWORD',
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
  static String get confirmPassword => [
        'CONFIRM PASSWORD',
        'CONFIRME A SENHA',
      ][_lang];
  static String get signUpPart1 => [
        'Let\'s create your account!\nWe\'ll start with your email',
        'Vamos criar sua conta!\nComeçaremos com seu email',
      ][_lang];
  static String get signUpPart2 => [
        'Sorry! I forgot to ask...\nWhat\'s your name?',
        'Desculpa! Nem perguntei...\nQual seu nome?',
      ][_lang];
  static String get signUpPart3 => [
        'Nice! Time for your Password\nRelax, I won\'t look',
        'Belo nome! Agora vem sua senha\nRelaxa, não vou olhar',
      ][_lang];
  static String get passHelper => [
        'The password must contain at least:\n  One upper case (A-Z)\n  One lower case (a-z)\n  One numeric digit (0-9)\nAnd it must be between 6 to 24 characteres long',
        'A sua senha deve conter no mínimo:\n  Uma letra maiúscula (A-Z)\n  Uma letra minúscula (a-z)\n  Um dígito numérico (0-9)\nE deve conter 6 a 24 caractéres',
      ][_lang];
  static String get signUpPart4 => [
        'We need it one more time\nConfirm your Password',
        'Você pode repetir?\nConfirme sua senha',
      ][_lang];
  static String get signUpPart5 => [
        'You are all done,\nclick on the + icon\nand it will be created. \nThanks you!\nSee you around!',
        'Pronto, acabamos!\nClique no ícone de + e\nsua conta será criada.\nMuito Obrigado!\nNos vemos por ai!',
      ][_lang];
  static String get haveAccount => [
        'Already have an account?',
        'Já possui uma conta?',
      ][_lang];
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

  // CASE HISTORY

  static String get nohistory => [
        'You have no finished cases yet, work on one and click to finish it.',
        'Você não tem nenhum caso finalizado ainda, conclua um e clique em finalizá-lo.'
      ][_lang];

  // OPTIONS

  static String get applang => [
        'Choose app language',
        'Mudar língua do aplicativo',
      ][_lang];
  static String get changename => [
        'Change your Name:',
        'Mudar seu Nome:',
      ][_lang];
  static String get dangerZOne => [
        'Danger Zone',
        'Área Perigosa',
      ][_lang];
  static String get deleteCases => [
        'Delete Cases',
        'Deletar Casos',
      ][_lang];
  static String get deleteAccount => [
        'Delete Account',
        'Deletar Conta',
      ][_lang];
  static String get resetAccount => [
        'Reset Account',
        'Resetar Conta',
      ][_lang];
  static String get cannotUndo => [
        'Are you sure you want to do this? You cannot undo it later.',
        'Tem certeza que quer fazer isso? Você não poderá desfazer depois.'
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
  static String get saveonly => [
        'Save',
        'Salvar',
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
