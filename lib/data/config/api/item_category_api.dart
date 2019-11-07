import 'dart:convert';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/response/response..dart';

import '../config.dart';

class ItemCategoryApi {
  BaseApi _baseApi = BaseApi();
  
   Future <List<Item>> getItem(int page, int size) async {
    String itemUrls = itemUrl + "?page=" +page.toString()+"&size="+size.toString() ;
    final response = await _baseApi.dio.get(itemUrls);
    if (response.statusCode == 200){
      return ItemResponse.fromJson(response.data).content;
    }else{
     throw response.statusMessage;
    }
  }

   Future <List<Item>> getItembyName(String itemName) async {
      String itemUrls = itemUrl + "?itemName=" +itemName;
      final response = await _baseApi.dio.get(itemUrls);
      if (response.statusCode == 200){
        return ItemResponse.fromJson(response.data).content;
      }else{
      throw response.statusMessage;
      }
   }
    

  Future <bool> updateItem(Item itemRequest) async {
    final response = await _baseApi.dio.put(
      itemUrl,
      data: itemRequestToJson(itemRequest),
    );
    if (response.statusCode == 204){
      return true;
    }else{
     throw response.statusMessage;
    }
  }
  
  Future <bool> addItem(Item itemRequest) async {
    final response = await _baseApi.dio.post(
      itemUrl,
      data: itemRequestToJson(itemRequest),
    );
    if (response.statusCode == 201){
      return true;
    }else{
     throw response.statusMessage;
    }
  }

  Stream<int> deleteItem(int id) async* {
    final response = await _baseApi.dio.delete(itemUrl+"/$id");
    if (response.statusCode == 200){
      yield id;
    }else{
     throw response.statusMessage;
    }
  }
   ///ITEM REST END

   ///get Category
  Future <CategoryResponse> getCategory() async {
    final response = await _baseApi.dio.get(categoryUrl);
    if (response.statusCode == 200){
      return CategoryResponse.fromJson(response.data);
    }else{
     throw response.statusMessage;
    }
  }

  itemRequestToJson (Item data){
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }
}