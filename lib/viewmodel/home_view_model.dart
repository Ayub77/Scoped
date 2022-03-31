import 'package:bloc/model/post_model.dart';
import 'package:bloc/services/http_service.dart';
import 'package:scoped_model/scoped_model.dart';

class HemeScoped extends Model {
  bool loading = false;
  List<Post> items = [];

  apiPostList() async {
    loading = true; 
    notifyListeners();
    var respons = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (respons != null) {
      items = Network.parsePostList(respons);
    } else {
      items = [];
    }
    loading = false;
    notifyListeners();
  }

  apiPostdelete(Post post) async {
    loading = true;
    notifyListeners();
    var respons = await Network.DEL(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    if (respons != null) {
      apiPostList();
    }
    loading = false;
    notifyListeners();
  }
}
