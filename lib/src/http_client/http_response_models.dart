class Validator {
  String address;
  List<int> pub_key;
  int voting_power;
  int accum;

  Validator({this.address, this.pub_key, this.voting_power, this.accum});

  Validator.fromJson(var json) {
    address = json['address'];
    pub_key = json['pub_key'].cast<int>();
    voting_power = json['voting_power'];
    accum = json[accum];
  }
}

class Validators {
  int blockHeight;
  List<Validator> validators;

  Validators({this.blockHeight, this.validators});

  Validators.fromJson(var json) {
    blockHeight = json['block_height'];
    if (json['validators' != null]) {
      validators = [for (var validatorInfo in json['validators']) Validator.fromJson(validatorInfo)];
    }
  }
}

class Peer {
  bool accelerated;
  String accessAddr;
  List<String> capabilities;
  String id;
  String listenAddr;
  String moniker;
  String network;
  String originalListenAddr;
  String streamAddr;
  String version;

  Peer({this.accelerated, this.accessAddr, this.capabilities, this.id, this.listenAddr, this.moniker, this.network, this.originalListenAddr, this.streamAddr, this.version});

  Peer.fromJson(Map<String, dynamic> json) {
    accelerated = json['accelerated'];
    accessAddr = json['access_addr'];
    capabilities = json['capabilities'].cast<String>();
    id = json['id'];
    listenAddr = json['listen_addr'];
    moniker = json['moniker'];
    network = json['network'];
    originalListenAddr = json['original_listen_addr'];
    streamAddr = json['stream_addr'];
    version = json['version'];
  }
}

class NodeInfo {
  ProtocolVersion protocolVersion;
  String id;
  String listenAddr;
  String network;
  String version;
  String channels;
  String moniker;
  Other other;

  NodeInfo({this.protocolVersion, this.id, this.listenAddr, this.network, this.version, this.channels, this.moniker, this.other});

  NodeInfo.fromJson(Map<String, dynamic> json) {
    json = json['node_info'];
    protocolVersion = json['protocol_version'] != null ? ProtocolVersion.fromJson(json['protocol_version']) : null;
    id = json['id'];
    listenAddr = json['listen_addr'];
    network = json['network'];
    version = json['version'];
    channels = json['channels'];
    moniker = json['moniker'];
    other = json['other'] != null ? Other.fromJson(json['other']) : null;
  }
}

class ProtocolVersion {
  int p2p;
  int block;
  int app;

  ProtocolVersion({this.p2p, this.block, this.app});

  ProtocolVersion.fromJson(Map<String, dynamic> json) {
    p2p = json['p2p'];
    block = json['block'];
    app = json['app'];
  }
}

class Other {
  String txIndex;
  String rpcAddress;

  Other({this.txIndex, this.rpcAddress});

  Other.fromJson(Map<String, dynamic> json) {
    txIndex = json['tx_index'];
    rpcAddress = json['rpc_address'];
  }
}

class SyncInfo {
  String latestBlockHash;
  String latestAppHash;
  int latestBlockHeight;
  String latestBlockTime;
  bool catchingUp;

  SyncInfo({this.latestBlockHash, this.latestAppHash, this.latestBlockHeight, this.latestBlockTime, this.catchingUp});

  SyncInfo.fromJson(Map<String, dynamic> json) {
    latestBlockHash = json['latest_block_hash'];
    latestAppHash = json['latest_app_hash'];
    latestBlockHeight = json['latest_block_height'];
    latestBlockTime = json['latest_block_time'];
    catchingUp = json['catching_up'];
  }
}

class ValidatorInfo {
  String address;
  List<int> pubKey;
  int votingPower;

  ValidatorInfo({this.address, this.pubKey, this.votingPower});

  ValidatorInfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    pubKey = json['pub_key'].cast<int>();
    votingPower = json['voting_power'];
  }
}

class ResultStatus {
  NodeInfo nodeInfo;
  SyncInfo syncInfo;
  ValidatorInfo validatorInfo;

  ResultStatus({this.nodeInfo, this.syncInfo, this.validatorInfo});

  ResultStatus.fromJson(Map<String, dynamic> json) {
    nodeInfo = json['node_info'] != null ? NodeInfo.fromJson(json['node_info']) : null;
    syncInfo = json['sync_info'] != null ? SyncInfo.fromJson(json['sync_info']) : null;
    validatorInfo = json['validator_info'] != null ? ValidatorInfo.fromJson(json['validator_info']) : null;
  }
}

class Account {
  int accountNumber;
  String address;
  List<Balance> balances;
  int flags;
  List<int> publicKey;
  int sequence;

  Account({this.accountNumber, this.address, this.balances, this.flags, this.publicKey, this.sequence});

  Account.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    address = json['address'];
    if (json['balances'] != null) {
      balances = <Balance>[];
      json['balances'].forEach((v) {
        balances.add(Balance.fromJson(v));
      });
    }
    flags = json['flags'];
    publicKey = json['public_key']?.cast<int>();
    sequence = json['sequence'];
  }
}

class Balance {
  String free;
  String frozen;
  String locked;
  String symbol;

  Balance({this.free, this.frozen, this.locked, this.symbol});

  Balance.fromJson(Map<String, dynamic> json) {
    free = json['free'];
    frozen = json['frozen'];
    locked = json['locked'];
    symbol = json['symbol'];
  }
}

class AccountSequence {
  int sequence;

  AccountSequence({this.sequence});

  AccountSequence.fromJson(Map<String, dynamic> json) {
    sequence = json['sequence'];
  }
}

class Transaction {
  String hash;
  String log;
  dynamic data;
  String height;
  int code;
  bool ok;
  dynamic tx;

  Transaction({this.hash, this.log, this.data, this.height, this.code, this.ok});

  Transaction.fromJson(Map<String, dynamic> json) {
    hash = json['hash'];
    log = json['log'];
    data = json['data'];
    height = json['height'];
    code = json['code'];
    ok = json['ok'];
    tx = json['tx'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'hash': hash, 'log': log, 'data': data, 'height': height, 'code': code, 'ok': ok, 'tx': tx};
  }
}

class TxPage {
  List<Tx> tx;
  int total;

  TxPage({this.tx, this.total});

  TxPage.fromJson(Map<String, dynamic> json) {
    if (json['tx'] != null) {
      tx = <Tx>[];
      json['tx'].forEach((v) {
        tx.add(Tx.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class Tx {
  String txHash;
  int blockHeight;
  String txType;
  String timeStamp;
  String fromAddr;
  String toAddr;
  String value;
  String txAsset;
  String txFee;
  String proposalId;
  int txAge;
  String orderId;
  int code;
  String data;
  int confirmBlocks;
  String memo;
  int source;
  int sequence;

  Tx({this.txHash, this.blockHeight, this.txType, this.timeStamp, this.fromAddr, this.toAddr, this.value, this.txAsset, this.txFee, this.proposalId, this.txAge, this.orderId, this.code, this.data, this.confirmBlocks, this.memo, this.source, this.sequence});

  Tx.fromJson(Map<String, dynamic> json) {
    txHash = json['txHash'];
    blockHeight = json['blockHeight'];
    txType = json['txType'];
    timeStamp = json['timeStamp'];
    fromAddr = json['fromAddr'];
    toAddr = json['toAddr'];
    value = json['value'];
    txAsset = json['txAsset'];
    txFee = json['txFee'];
    proposalId = json['proposalId'];
    txAge = json['txAge'];
    orderId = json['orderId'];
    code = json['code'];
    data = json['data'];
    confirmBlocks = json['confirmBlocks'];
    memo = json['memo'];
    source = json['source'];
    sequence = json['sequence'];
  }
}
