import '/core/repositories/log/log.dart';
import 'package:talker/talker.dart';

class LogImpl implements Log {
  final talker = Talker();
  @override
  void d(String tag, String content) {
    talker.debug('$tag: $content');
  }

  @override
  void e(String tag, String content) {
    talker.error('$tag: $content');
  }

  @override
  void i(String tag, String content) {
    talker.info('$tag: $content');
  }
}
