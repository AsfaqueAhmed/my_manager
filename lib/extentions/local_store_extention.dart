import 'package:get_storage/get_storage.dart';
import 'package:my_manager/models/base_models/base_document_model.dart';

extension StorableDocument on BaseDocumentModel {
  save({var id}) async {
    var box = GetStorage();
    await box.write(id ?? runtimeType.toString(), toJson());
  }
}

extension ListStorableDocument on List<BaseDocumentModel> {
  save({var id}) async {
    var box = GetStorage();
    await box.write(
        id ?? runtimeType.toString(), map((e) => e.toJson()).toList());
  }
}
