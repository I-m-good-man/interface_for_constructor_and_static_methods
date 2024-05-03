class UserModel implements JsonSerializeInterface, JsonDeserializeInterface {
  /*
  Модель UserModel представляет сущность из базы данных.
  Данная модель должна содержать функционал сериализации в JSON и генерации из
  JSON'a.
   */
  final int userId;
  final String userEmail;

  UserModel(this.userId, this.userEmail);

  static UserModel fromJson(Map<String, dynamic> json) {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

abstract class JsonSerializeInterface {
  Map<String, dynamic> toJson();
}

typedef Constructor<T extends JsonDeserializeInterface> = T Function(
    Map<String, dynamic>);

abstract class JsonDeserializeInterface {
  /*
  JsonDeserializeInterface - это класс-фабрика, которая используется для:
  1) Генерации экземпляра класса из JSON'а путем передачи ей JSON'a и типа данных инстанциируемого класса.
  2) Создания интерфейса, который обязывает другие классы реализовать в своем теле статические поля.

  Данный класс является абстрактным, поскольку его экземпляры не имеют никакого смысла.
  Он должен использоваться только как интерфейс или как фабрика.
   */

  /*
  Словарь _fromJsons содержит в себе соответствия - класс, который обязан определить статический метод, и статический метод-конструктор данного класса.
  Благодаря тому, что обращение к статическому методу происходит явным образом, данные классы обязаны содержать в своем теле определения этих методов.
  Таким образом создается контракт, согласно которому, классы, определенный в словаре, обязаны иметь перечисленные в этом же словаре статические методы.

  Чтобы создать аналогию с синтаксисом реализации интерфейсов, классы, которые обязаны содержать в себе реализацию статического метода, реализуют данный класс как интерфейс и поэтому становятся его потомками.
  Таким образом, метод, генерирующий экземпляры данных классов из json'а, создает объекты, которые также неявно являются экземплярами класса интерфейса JsonDeserializeInterface.
  Поскольку данный словарь определяет контракты для классов, этот словарь нельзя изменять, поэтому он является compile-time константой и инкапсулируется.
   */

  static const Map<Type, Constructor<JsonDeserializeInterface>> _fromJsons = {
    ImplementedSubclass1: ImplementedSubclass1.fromJson,
    ImplementedSubclass2: ImplementedSubclass2.fromJson,
    ImplementedSubclass3: ImplementedSubclass3.fromJson,
    UserModel: UserModel.fromJson
  };

  /*
  Поскольку JsonDeserializeInterface - это класс фабрика, то метод fromJson способен генерировать экземпляры его подклассов из JSON'a.
  Для этого данному классу нужно передавать тип данных класса, экземпляр которого будет создан из JSON'a.

  Это делается при помощи параметризации класса одним из подклассов данного класса. Возвращаться будет также экземляр подкласса данного класса.
   */
  static T fromJson<T extends JsonDeserializeInterface>(
          Map<String, dynamic> json) =>
      _fromJsons[T]!(json) as T;
}

class ImplementedSubclass1 implements JsonDeserializeInterface {
  static ImplementedSubclass1 fromJson(Map<String, dynamic> json) =>
      ImplementedSubclass1();

  void test1() => print("Worked");
}

class ImplementedSubclass2 implements JsonDeserializeInterface {
  static ImplementedSubclass2 fromJson(Map<String, dynamic> json) =>
      ImplementedSubclass2();

  void test2() => print("Worked v2");
}

class ImplementedSubclass3 implements JsonDeserializeInterface {
  static ImplementedSubclass3 fromJson(Map<String, dynamic> json) =>
      ImplementedSubclass3();
}

void main() {
  Map<String, dynamic> json = {};
  ImplementedSubclass1 result = JsonDeserializeInterface.fromJson(json);
  result.test1();
  ImplementedSubclass2 result2 = JsonDeserializeInterface.fromJson(json);
  result2.test2();
}
