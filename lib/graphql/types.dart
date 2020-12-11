import 'package:json_annotation/json_annotation.dart';

part 'types.g.dart';

@JsonSerializable()
class DeviceResponse {
  DeviceResponse(this.addr, this.device);

  num addr;
  Device device;
  factory DeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceResponseFromJson(json);
}

@JsonSerializable()
class Device {
  Device(this.type, this.elements);

  String type;
  List<ElementResponse> elements;
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
}

@JsonSerializable()
class ElementResponse {
  ElementResponse(this.addr, this.element);

  num addr;
  Element element;
  factory ElementResponse.fromJson(Map<String, dynamic> json) =>
      _$ElementResponseFromJson(json);
}

@JsonSerializable()
class Element {
  Element(
    this.name,
    this.state,
    this.stateType,
  );

  String name;
  String state;
  String stateType;
  factory Element.fromJson(Map<String, dynamic> json) =>
      _$ElementFromJson(json);
}

@JsonSerializable()
class SceneResponse {
  SceneResponse(this.number, this.scene);

  num number;
  Scene scene;
  factory SceneResponse.fromJson(Map<String, dynamic> json) =>
      _$SceneResponseFromJson(json);
}

@JsonSerializable()
class Scene {
  Scene(this.name);

  String name;
  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);
}

@JsonSerializable()
class GroupResponse {
  GroupResponse(this.addr, this.group);

  num addr;
  Group group;
  factory GroupResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupResponseFromJson(json);
}

@JsonSerializable()
class Group {
  Group(this.name, this.scenes, this.devices);

  String name;
  List<SceneResponse> scenes;
  List<DeviceResponse> devices;
  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
