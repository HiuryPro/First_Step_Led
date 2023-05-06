import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EnviaEmail {
  enviaEmailConfirmacao(String email, String codigo) async {
    final smtpServer = gmail(dotenv.env['EMAIL']!, dotenv.env['PASSWORD']!);

    final message = Message()
      ..from = Address(dotenv.env['EMAIL']!, 'TEA Games')
      ..recipients.add(email)
      ..subject = 'Email de Cofirmação de Acesso'
      ..html =
          '<h1>TEA Games</h1>\n<p>Seu código de acesso é</p>\n <h2>$codigo</h2>\n<img src="cid:teste" width="200">'
      ..attachments = [
        FileAttachment(File('assets/images/Crianca_semfundo.png'))
          ..location = Location.inline
          ..cid = '<teste>'
      ];

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  enviaEmailRedfinirSenha(String email, String codigo) async {
    final smtpServer = gmail(dotenv.env['EMAIL']!, dotenv.env['PASSWORD']!);

    final message = Message()
      ..from = Address(dotenv.env['EMAIL']!, 'TEA Games')
      ..recipients.add(email)
      ..subject = 'Email de Redefinir Senha'
      ..html =
          '<h1>TEA GAMES</h1>\n<p>Seu código para redefinir sua senha é</p>\n <h2>$codigo</h2>\n<img src="cid:teste" width="200">'
      ..attachments = [
        FileAttachment(File('assets/images/Crianca_semfundo.png'))
          ..location = Location.inline
          ..cid = '<teste>'
      ];

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
