

class Check  {
  final int? _postId;
  String? _postTitle;
  String? _postImageUrl;
  final String? _createdDate;
  final String? _modifiedDate;
  String? _authorName;
  String? _authorAvatar;
  String? _userRecipientName;
  String? _userRecipientAvatar;
  String? _description;
  String? _checkWeight;
  String? _checkNeck;
  String? _checkChest;
  String? _checkBiceps;
  String? _checkForearm;
  String? _checkWaist;
  String? _checkHip;
  String? _checkThigh;
  String? _checkCalf;
  List<String>? _checkPhotos;

  Check({
    int? postId,
    String? postTitle,
    String? createdDate,
    String? modifiedDate,
    String? authorName,
    String? authorAvatar,
    String? userRecipientName,
    String? userRecipientAvatar,
    String? description,
    String? checkWeight,
    String? checkNeck,
    String? checkChest,
    String? checkBiceps,
    String? checkForearm,
    String? checkWaist,
    String? checkHip,
    String? checkThigh,
    String? checkCalf,
    List<String>? checkPhotos,
  })  : _postId = postId,
        _postTitle = postTitle,
        _createdDate = createdDate,
        _modifiedDate = modifiedDate,
        _authorName = authorName,
        _authorAvatar = authorAvatar,
        _userRecipientName = userRecipientName,
        _userRecipientAvatar = userRecipientAvatar,
        _description = description,
        _checkWeight = checkWeight,
        _checkNeck = checkNeck,
        _checkChest = checkChest,
        _checkBiceps = checkBiceps,
        _checkForearm = checkForearm,
        _checkWaist = checkWaist,
        _checkHip = checkHip,
        _checkThigh = checkThigh,
        _checkCalf = checkCalf,
        _checkPhotos = checkPhotos;

    
 

  
  int get postId => _postId ?? 0;

  
  String get postTitle => _postTitle ?? '';

  set postTitle(String? value) {
    _postTitle = value;
  }

  
  String get postImageUrl => _postImageUrl ?? '';

  
  String get createdDate => _createdDate ?? '';

  
  String get modifiedDate => _modifiedDate ?? '';

  
  String get authorName => _authorName ?? '';

  
  set authorName(String? value) {
    _authorName = value;
  }

  
  String get authorAvatar => _authorAvatar ?? '';

  
  set authorAvatar(String? value) {
    _authorAvatar = value;
  }

  
  String get userRecipientName => _userRecipientName ?? '';

  
  set userRecipientName(String? value) {
    _userRecipientName = value;
  }

  
  String get userRecipientAvatar => _userRecipientAvatar ?? '';

  
  set userRecipientAvatar(String? value) {
    _userRecipientAvatar = value;
  }

  
  String get description => _description ?? '';

  
  set description(String? value) {
    _description = value;
  }

  String get checkWeight => _checkWeight ?? '';

  set checkWeight(String? value) {
    _checkWeight = value;
  }

  String get checkNeck => _checkNeck ?? '';

  set checkNeck(String? value) {
    _checkNeck = value;
  }

  String get checkChest => _checkChest ?? '';

  set checkChest(String? value) {
    _checkChest = value;
  }

  String get checkBiceps => _checkBiceps ?? '';

  set checkBiceps(String? value) {
    _checkBiceps = value;
  }

  String get checkForearm => _checkForearm ?? '';

  set checkForearm(String? value) {
    _checkForearm = value;
  }

  String get checkWaist => _checkWaist ?? '';

  set checkWaist(String? value) {
    _checkWaist = value;
  }

  String get checkHip => _checkHip ?? '';

  set checkHip(String? value) {
    _checkHip = value;
  }

  String get checkThigh => _checkThigh ?? '';

  set checkThigh(String? value) {
    _checkThigh = value;
  }

  String get checkCalf => _checkCalf ?? '';

  set checkCalf(String? value) {
    _checkCalf = value;
  }

  List<String> get checkPhotos => _checkPhotos ?? [];

  // Imagenes en tamaño pequeño para listas
  List<String> get checkPhotosMinis {
    if (_checkPhotos == null) return [];

    return _checkPhotos!.map((url) {
      final int dotIndex = url.lastIndexOf('.');
      if (dotIndex == -1) return url;
      return '${url.substring(0, dotIndex)}-150x150${url.substring(dotIndex)}';
    }).toList();
  }

  set checkPhotos(List<String>? value) {
    _checkPhotos = value;
  }

  static Check fromJson(Map<String, dynamic> json) {
    return Check(
      postId: json['post_id'] ?? 0,
      postTitle: json['post_title'] ?? '',
      createdDate: json['created_date'] ?? '',
      modifiedDate: json['modified_date'] ?? '',
      authorName: json['author_name'] ?? '',
      authorAvatar: json['author_avatar'] ?? '',
      userRecipientName: json['user_recipient_name'] ?? '',
      userRecipientAvatar: json['user_recipient_avatar'] ?? '',
      description: json['post_description'],
      checkWeight: json['check_weight'] ?? '',
      checkNeck: json['check_neck'] ?? '',
      checkChest: json['check_chest'] ?? '',
      checkBiceps: json['check_biceps'] ?? '',
      checkForearm: json['check_forearm'] ?? '',
      checkWaist: json['check_waist'] ?? '',
      checkHip: json['check_hip'] ?? '',
      checkThigh: json['check_thigh'] ?? '',
      checkCalf: json['check_calf'] ?? '',
      checkPhotos: (json['check_photos'] as List<dynamic>?)
              ?.map((photo) => photo.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'post_title': postTitle,
      'created_date': createdDate,
      'modified_date': modifiedDate,
      'author_name': authorName,
      'author_avatar': authorAvatar,
      'user_recipient_name': userRecipientName,
      'user_recipient_avatar': userRecipientAvatar,
      'post_description': description,
      'check_weight': checkWeight,
      'check_neck': checkNeck,
      'check_chest': checkChest,
      'check_biceps': checkBiceps,
      'check_forearm': checkForearm,
      'check_waist': checkWaist,
      'check_hip': checkHip,
      'check_thigh': checkThigh,
      'check_calf': checkCalf,
      'check_photos': List.from(checkPhotos),
    };
  }

  /// Devuelve el registro en un map, se usa en las llamadas a endpoints de Wordpress
  Map<String, dynamic> getCheckMap(Check check) {
    return {
      'post_id': check.postId,
      'post_title': check.postTitle,
      'created_date': check.createdDate,
      'modified_date': check.modifiedDate,
      'author_name': check.authorName,
      'author_avatar': check.authorAvatar,
      'user_recipient_name': check.userRecipientName,
      'user_recipient_avatar': check.userRecipientAvatar,
      'post_description': check.description,
      'check_weight': check.checkWeight,
      'check_neck': check.checkNeck,
      'check_chest': check.checkChest,
      'check_biceps': check.checkBiceps,
      'check_forearm': check.checkForearm,
      'check_waist': check.checkWaist,
      'check_hip': check.checkHip,
      'check_thigh': check.checkThigh,
      'check_calf': check.checkCalf,
      'check_photos': List.from(check.checkPhotos),
    };
  }

  // Método para copiar un objeto Check
  Check copyCheck(Check check) {
    return Check(
      postId: check.postId,
      postTitle: check.postTitle,
      createdDate: check.createdDate,
      modifiedDate: check.modifiedDate,
      authorName: check.authorName,
      authorAvatar: check.authorAvatar,
      userRecipientName: check.userRecipientName,
      userRecipientAvatar: check.userRecipientAvatar,
      description: check.description,
      checkWeight: check.checkWeight,
      checkNeck: check.checkNeck,
      checkChest: check.checkChest,
      checkBiceps: check.checkBiceps,
      checkForearm: check.checkForearm,
      checkWaist: check.checkWaist,
      checkHip: check.checkHip,
      checkThigh: check.checkThigh,
      checkCalf: check.checkCalf,
      checkPhotos: List.from(check.checkPhotos),
    );
  }
}
