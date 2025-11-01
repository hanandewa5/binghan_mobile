import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/models/item.dart';
import 'package:binghan_mobile/models/item_detail.dart';
import 'api_get.dart';

class ProductService {
  final ApiGet _apiGet = locator<ApiGet>();

  int? _id;

  int? get id => _id;

  void setId(int idP) {
    _id = idP;
  }

  Future<Item> getProductItem(int? id) async {
    var res = await _apiGet.getItem(id);
    return res;
  }

  Future<ItemDetail> getProductItemDetail(int? id) async {
    var res = await _apiGet.getItemDetail(id);
    return res;
  }
}
