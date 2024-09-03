import 'package:flutter/material.dart';
import 'package:to_do_list/data/api/api_service.dart';
import 'package:to_do_list/data/db/auth_repository.dart';
import 'package:to_do_list/data/model/checklist.dart';

enum ResultState { loading, noData, hasData, error }

class ChecklistProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiService apiService;

  ChecklistProvider(this.apiService, this.authRepository);

  List<Data> _checklistResult = [];
  late ResultState _state;
  String _message = '';

  List<Data> get checklistResult => _checklistResult;
  ResultState get state => _state;
  String get message => _message;

  Future<void> getChecklist() async {
    _state = ResultState.loading;
    final token = await authRepository.getToken();
    if (token != null) {
      final checklist = await apiService.getChecklist(token);

      if (checklist.data.isEmpty) {
        _state = ResultState.noData;
        _message = checklist.message;
        notifyListeners();
      } else {
        _checklistResult = checklist.data;
        _state = ResultState.hasData;
      }
    }
  }
}
