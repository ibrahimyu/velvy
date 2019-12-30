abstract class Serializable<T> {
  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T model);
}
