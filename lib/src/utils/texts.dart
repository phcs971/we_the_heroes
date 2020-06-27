class Texts {
  Texts._();

  static int _lang = 0;

  // 0 => English
  // 1 => Português Brasileiro -> Brazilian Portuguese

  static void changeLang(int newLang) => _lang = newLang;
  static int getLang() => _lang;

  static String get email => ['EMAIL', 'EMAIL'][_lang];
  static String get password => ['PASSWORD', 'SENHA'][_lang];
  static String get logar => ['LOGIN', 'ENTRAR'][_lang];
  static String get or => ['OR', 'OU'][_lang];
  static String get signinwith => ['Sign in with...', 'Entre com...'][_lang];
  static String get changepass =>
      ['Change your Password', 'Mudar sua Senha'][_lang];
  static String get createaccount =>
      ['Create an Account', 'Criar uma Conta'][_lang];
}
