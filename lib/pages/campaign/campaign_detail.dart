import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:overlapping_avatar/overlapping_avatar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:http/http.dart' as http;
import 'package:test_project/remote/service/response/campaign_response.dart';

class CampaignDetailPage extends StatefulWidget {
  const CampaignDetailPage({super.key});

  @override
  State<CampaignDetailPage> createState() => _CampaignDetailPageState();
}

class _CampaignDetailPageState extends State<CampaignDetailPage> {
  late CampaignResponse _campaignResponse;
  var dateRange;
  @override
  void initState() {
    getCampaignAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        )),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.network(_campaignResponse.thumbnail ?? ''),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                  child: Text(
                    _campaignResponse.title ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '20 days left',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                )
              ]),
              const SizedBox(
                height: 10,
              ),
              LinearPercentIndicator(
                lineHeight: 15,
                percent: 0.5,
                progressColor: Colors.green,
                barRadius: const Radius.circular(10),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Target: \$ ${_campaignResponse.amount_target ?? 0} ",
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  Text(
                    '${_campaignResponse.current_amount! / _campaignResponse.amount_target! * 100}%',
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  CircleAvatar(
                      child: Image.network(
                          _campaignResponse.author?.avatar ?? '')),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sponsored by',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        '${_campaignResponse.author?.name}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.greenAccent)),
                    child: Text('${_campaignResponse.author?.job}'),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                  child: Text(
                _campaignResponse.author?.describe ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey),
              )),
              const SizedBox(height: 15),
              CircleAvatar(
                child: Image.network(_campaignResponse.author?.avatar ?? ''),
              ),
              const SizedBox(height: 30),
              Center(
                  child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        child: const Text('BACK THIS PROJECTS',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getCampaignAPI() async {
    try {
      final client = await http.Client();
      final response = await client
          .get(Uri.https("6551f0255c69a77903294d34.mockapi.io", "campaigns/1"));
      Map<String, dynamic> campaignMap = jsonDecode(response.body);
      final dataCampaign = CampaignResponse.fromJson(campaignMap);
      _campaignResponse = dataCampaign;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
}
