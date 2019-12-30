typedef EncodeCallback<T> = Map<String, dynamic> Function(T source);
typedef DecodeCallback<T> = T Function(Map<String, dynamic> map);
