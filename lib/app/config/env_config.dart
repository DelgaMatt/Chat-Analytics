import 'package:envied/envied.dart';

part 'env_config.g.dart';

@Envied()
abstract class EnvConfig {
  @EnviedField(varName: 'DG_SERVER_URL', obfuscate: true)
  static final String dgServerUrl = _EnvConfig.dgServerUrl;

  @EnviedField(varName: 'DG_API_KEY', obfuscate: true)
  static final String dgApiKey = _EnvConfig.dgApiKey;
}
