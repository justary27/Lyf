import '../config/cdn_configuration.dart';
import '../enums/query_type.dart';

class UriHelper {
  UriHelper._();

  static constructUri({
    QueryType? queryType = QueryType.test,
    List<String>? pathSegs,
    Map<String, String>? queryParams,
    String? frag,
  }) {
    QueryType qType = LyfCdnConfig.getQueryType(
      queryType: queryType,
    );
    return Uri(
      scheme: LyfCdnConfig.getScheme(queryType: qType),
      host: LyfCdnConfig.getHost(queryType: qType),
      port: LyfCdnConfig.getPort(queryType: qType),
      pathSegments: pathSegs,
      queryParameters: queryParams,
      fragment: frag,
    );
  }
}
