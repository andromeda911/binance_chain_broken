import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '../environment.dart';
import '../messages/messages.dart';
import 'http_response_models.dart';
import '../utils/constants.dart';

class HttpApiClient {
  BinanceEnvironment _env;
  final Client _httpClient = Client();

  HttpApiClient({BinanceEnvironment env}) {
    _env = env ?? BinanceEnvironment.getProductionEnv();
  }

  BinanceEnvironment get env => _env;

  String _createFullPath(String path) {
    return '${_env.apiUrl}/v1/$path';
  }

  Future<APIResponse> _request(String method, String path, {Map<String, String> headers, dynamic body}) async {
    var url = _createFullPath(path);
    var resp;
    switch (method) {
      case 'post':
        resp = await _httpClient.post(url, headers: headers, body: body);
        break;
      case 'get':
        resp = await _httpClient.get(url, headers: headers);
        break;
    }

    return _handle_response(resp);
  }

  APIResponse _handle_response(Response response) {
    var res = json.decode(response.body);
    if (res is Map) {
      APIResponse(response.statusCode, res.containsKey('data') ? res['data'] : res);
    }
    return APIResponse(response.statusCode, res);
  }

  Future<APIResponse<dynamic>> _post(String path, {Map<String, String> headers = const {}, dynamic body = ''}) async {
    return _request('post', path, headers: headers, body: body);
  }

  Future<APIResponse<dynamic>> _get(String path, {Map<String, String> headers}) async {
    return _request('get', path, headers: headers);
  }

  Future<APIResponse<Account>> getAccount(String address) async {
    var res = await _get('account/$address');
    res.load = Account.fromJson(res.load);
    return APIResponse.fromOther(res);
  }

  Future<APIResponse<List<Transaction>>> broadcastMsg(Msg msg, {bool sync = false}) async {
    await msg.wallet.initialize_wallet();
    print(msg.wallet.sequence);
    var res = await _post('broadcast${sync ? '?sync=true' : ''}', headers: <String, String>{'content-type': 'text/plain'}, body: msg.to_hex_data());
    msg.wallet.increment_account_sequence();

    print(res.load);
    print(msg.wallet.sequence);
    if (res.statusCode == 200) {
      res.load = List<Transaction>.generate(res.load.length, (index) => Transaction.fromJson(res.load[index]));
    } else {
      res.load = null;
    }

    return APIResponse.fromOther(res);
  }

  Future<APIResponse<NodeInfo>> getNodeInfo() async {
    var res = await _get('node-info');
    res.load = NodeInfo.fromJson(res.load);
    return APIResponse.fromOther(res);
  }
}

class APIResponse<DataModel_T> {
  int statusCode;
  DataModel_T load;
  APIResponse(this.statusCode, this.load);

  APIResponse.fromOther(APIResponse other) {
    statusCode = other.statusCode;
    load = other.load;
  }
}

class BinanceChainAPIException implements Exception {
  String message;
  BinanceChainAPIException([this.message]);

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: $message';
  }
}

class BinanceChainRequestException implements Exception {
  String message;
  BinanceChainRequestException([this.message]);
  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: $message';
  }
}
