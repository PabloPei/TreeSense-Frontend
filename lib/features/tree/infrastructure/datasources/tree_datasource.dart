import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/tree/domain/entities/attribute_value.dart';
import 'package:treesense/features/tree/domain/entities/species_value.dart';
import 'package:treesense/config/api_config.dart';
import 'package:treesense/features/auth/infrastructure/storage/auth_storage.dart';
import 'package:treesense/features/tree/infrastructure/models/tree_impl.dart';
import 'package:treesense/features/tree/infrastructure/models/attribute_value_impl.dart';
import 'package:treesense/features/tree/infrastructure/models/species_value_impl.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class TreeDatasource {
  final AuthStorage _authStorage = AuthStorage();

  Future<String> saveTree(Tree data) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/tree');
    final accessToken = await _authStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception(MessageLoader.get('error_access_token'));
    }

    final body = jsonEncode({
      "species": data.speciesId,
      "type": data.typeId,
      "latitude": data.latitude,
      "longitude": data.longitude,
      "district": data.districtId,
      "isStandingDry": data.isStandingDry,
      "isStumpPresent": data.isStumpPresent,
      "streetWidth": data.streetWidth,
      "height": data.height,
      "stemPerimeter": data.stemPerimeter,
      "isStrainPresent": data.isStrainPresent,
      "canopyType": data.canopyTypeId,
      "shafts": data.shaftsId,
      "isRootIssuePresent": data.isRootIssuePresent,
      "isBranchIssuePresent": data.isBranchIssuePresent,
      "isMechanicalWoundsPresent": data.isMechanicalWoundsPresent,
      "isCankersPresent": data.isCankersPresent,
      "isSuckersPresent": data.isSuckersPresent,
      "stemInclination": data.stemInclination,
      "isBarkPresent": data.isBarkPresent,
      "treeState": data.treeStateId,
      "rotType": data.rotTypeId,
      "cracksType": data.cracksTypeId,
      "planterShape": data.planterShapeId,
      "planterLevel": data.planterLevelId,
      "planterLength": data.planterLength,
      "planterWidth": data.planterWidth,
      "planterLocation": data.planterLocationId,
      "previousCanopyManagement": data.canopyManagementId,
      "photo": data.photosBase64,
      "observations": data.observations,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return MessageLoader.get('tree_saved');
    } else {
      throw Exception(
        "${MessageLoader.get('error_tree_saved')} ${response.statusCode}: ${response.body}",
      );
    }
  }

  Future<List<AttributeValue>> getAttributeValues(String attributeName) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}/tree/attributes/$attributeName',
    );
    final accessToken = await _authStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception(MessageLoader.get('error_access_token'));
    }

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      if (jsonList.isEmpty) {
        throw Exception(
          interpolateMessage('error_attribute_list_empty', {
            'attribute': attributeName,
          }),
        );
      }

      final values =
          jsonList.map((item) {
            if (item['id'] == null || item['id'].toString().trim().isEmpty) {
              throw Exception(
                interpolateMessage('error_attribute_missing_id', {
                  'attribute': attributeName,
                }),
              );
            }

            return AttributeValueImpl.fromJson(item);
          }).toList();

      return values;
    } else {
      throw Exception("${response.statusCode}: ${response.body}");
    }
  }

  Future<List<SpeciesValue>> getSpeciesValues() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/tree/species');
    final accessToken = await _authStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception(MessageLoader.get('error_access_token'));
    }

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      if (jsonList.isEmpty) {
        throw Exception(
          interpolateMessage('error_attribute_list_empty', {
            'attribute': 'species',
          }),
        );
      }

      final values =
          jsonList.map((item) {
            if (item['treeSpeciesId'] == null ||
                item['treeSpeciesId'].toString().trim().isEmpty) {
              throw Exception(MessageLoader.get('error_species_missing_id'));
            }
            return SpeciesValueImpl.fromJson(item as Map<String, dynamic>);
          }).toList();

      return values;
    } else {
      throw Exception("${response.statusCode}: ${response.body}");
    }
  }

  Future<List<Tree>> getUploadedTreeByUser() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/tree');
    final accessToken = await _authStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception(MessageLoader.get('error_access_token'));
    }

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final dynamic responseBody = jsonDecode(response.body);

      final List<dynamic> treeList =
          responseBody is Map && responseBody.containsKey('trees')
              ? responseBody['trees']
              : responseBody;

      return treeList
          .map((item) => TreeImpl.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("${response.statusCode}: ${response.body}");
    }
  }
}
