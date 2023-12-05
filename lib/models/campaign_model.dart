import 'package:json_annotation/json_annotation.dart';

import 'author_model.dart';

part 'campaign_model.g.dart';

@JsonSerializable()
class CampaignModel {
  @JsonKey(name: 'startTime')
  int? startTime;

  @JsonKey(name: 'endTime')
  int? endTime;

  @JsonKey(name: 'thumbnail')
  String? thumbnail;

  @JsonKey(name: 'amount_target')
  int? amount_target;

  @JsonKey(name: 'current_amount')
  int? current_amount;

  @JsonKey(name: 'author')
  AuthorModel? author;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'backers')
  List<AuthorModel>? backers;

  @JsonKey(name: 'id')
  String? id;

  CampaignModel();

  factory CampaignModel.fromJson(Map<String, dynamic> json) => _$CampaignModelFromJson(json);
  Map<String, dynamic> toJson() => _$CampaignModelToJson(this);
}