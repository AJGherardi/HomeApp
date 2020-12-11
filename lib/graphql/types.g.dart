// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceResponse _$DeviceResponseFromJson(Map<String, dynamic> json) {
  return DeviceResponse(
    json['addr'] as num,
    json['device'] == null
        ? null
        : Device.fromJson(json['device'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeviceResponseToJson(DeviceResponse instance) =>
    <String, dynamic>{
      'addr': instance.addr,
      'device': instance.device,
    };

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device(
    json['type'] as String,
    (json['elements'] as List)
        ?.map((e) => e == null
            ? null
            : ElementResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'type': instance.type,
      'elements': instance.elements,
    };

ElementResponse _$ElementResponseFromJson(Map<String, dynamic> json) {
  return ElementResponse(
    json['addr'] as num,
    json['element'] == null
        ? null
        : Element.fromJson(json['element'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ElementResponseToJson(ElementResponse instance) =>
    <String, dynamic>{
      'addr': instance.addr,
      'element': instance.element,
    };

Element _$ElementFromJson(Map<String, dynamic> json) {
  return Element(
    json['name'] as String,
    json['state'] as String,
    json['stateType'] as String,
  );
}

Map<String, dynamic> _$ElementToJson(Element instance) => <String, dynamic>{
      'name': instance.name,
      'state': instance.state,
      'stateType': instance.stateType,
    };

SceneResponse _$SceneResponseFromJson(Map<String, dynamic> json) {
  return SceneResponse(
    json['number'] as num,
    json['scene'] == null
        ? null
        : Scene.fromJson(json['scene'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SceneResponseToJson(SceneResponse instance) =>
    <String, dynamic>{
      'number': instance.number,
      'scene': instance.scene,
    };

Scene _$SceneFromJson(Map<String, dynamic> json) {
  return Scene(
    json['name'] as String,
  );
}

Map<String, dynamic> _$SceneToJson(Scene instance) => <String, dynamic>{
      'name': instance.name,
    };

GroupResponse _$GroupResponseFromJson(Map<String, dynamic> json) {
  return GroupResponse(
    json['addr'] as num,
    json['group'] == null
        ? null
        : Group.fromJson(json['group'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GroupResponseToJson(GroupResponse instance) =>
    <String, dynamic>{
      'addr': instance.addr,
      'group': instance.group,
    };

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    json['name'] as String,
    (json['scenes'] as List)
        ?.map((e) => e == null
            ? null
            : SceneResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['devices'] as List)
        ?.map((e) => e == null
            ? null
            : DeviceResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'name': instance.name,
      'scenes': instance.scenes,
      'devices': instance.devices,
    };
