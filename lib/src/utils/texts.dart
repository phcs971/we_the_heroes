class Texts {
  Texts._();

  static int _lang = 0;

  // 0 => English
  // 1 => Português Brasileiro -> Brazilian Portuguese

  static void changeLang(int newLang) => _lang = newLang;
  static int getLang() => _lang;

  static String get error => ['ERROR', 'ERRO'][_lang];
  static String get email => ['EMAIL', 'EMAIL'][_lang];
  static String get password => ['PASS', 'SENHA'][_lang];
  static String get name => ['NAME', 'NOME'][_lang];
  static String get logar => ['LOGIN', 'ENTRAR'][_lang];
  static String get or => ['OR', 'OU'][_lang];
  static String get signinwith => ['Sign in with...', 'Entre com...'][_lang];
  static String get changepass =>
      ['Change your Password', 'Mudar sua Senha'][_lang];
  static String get createaccount =>
      ['Create an Account', 'Criar uma Conta'][_lang];
  static String get writeemail =>
      ['Write your email:', 'Forneça seu email:'][_lang];

  static String get emailsent => ['Email Sent', 'Email Enviado'][_lang];
  static String get emailbad =>
      ['Email Bad Formated', 'Email Mal Formatado'][_lang];
  static String get userNotFound =>
      ['User Not Found', 'Usuário Não Encontrado'][_lang];
  static String get cancel => ['Cancel', 'Cancelar'][_lang];
  static String get send => ['Send', 'Enviar'][_lang];
}
