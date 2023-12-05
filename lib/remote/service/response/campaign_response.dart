import 'package:json_annotation/json_annotation.dart';
import 'package:test_project/models/campaign_model.dart';

import '../../../models/author_model.dart';
part 'campaign_response.g.dart';

@JsonSerializable()

class CampaignResponse{

  @JsonKey(name:'startTime')
  int? startTime;

  @JsonKey(name:'endTime')
  int? endTime;

  @JsonKey(name:'thumbnail')
  String? thumbnail;

  @JsonKey(name:'amount_target')
  int? amount_target;

  @JsonKey(name:'current_amount')
  int? current_amount;

  @JsonKey(name:'author')
  AuthorModel? author;

  @JsonKey(name:'title')
  String? title;

  @JsonKey(name:'backers')
  List<AuthorModel>? backers;

  @JsonKey(name:'id')
  String? id;

  CampaignResponse();
  factory CampaignResponse.fromJson(Map<String, dynamic> json) =>
      _$CampaignResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignResponseToJson(this);
}