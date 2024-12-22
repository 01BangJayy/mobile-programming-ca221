import 'dart:developer';
import 'package:dio/dio.dart';
import '../../core/helpers/dio_interceptor.dart';
import '../../core/resources/constants.dart';
import '../../models/comment.dart';
import '../contracts/abs_api_comment_repository.dart';

class ApiCommentRepository extends AbsApiCommentRepository {
  final String _baseUri = '$baseUrl/api/comments';
  late Dio _dio;

  ApiCommentRepository() {
    final options = BaseOptions(baseUrl: _baseUri);
    _dio = Dio(options);
    _dio.interceptors.add(DioInterceptor(dio: _dio));
  }

  @override
  Future<List<Comment>> getAll([String keyword = '']) async {
    try {
      final response = await _dio.get('', queryParameters: {'keyword': keyword});
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List).map((e) => Comment.fromMap(e)).toList();
      }
    } catch (e, stackTrace) {
      log('Error fetching all comments: $e', name: 'ApiCommentRepository:getAll');
      log(stackTrace.toString(), name: 'ApiCommentRepository:getAll');
    }
    return [];
  }

  @override
  Future<List<Comment>> getWithPagination(
      [int page = 1, int size = 10, String keyword = '']) async {
    try {
      final response = await _dio.get(
        '/pagination',
        queryParameters: {'PageNumber': page, 'PageSize': size, 'Keyword': keyword},
      );
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List).map((e) => Comment.fromMap(e)).toList();
      }
    } catch (e, stackTrace) {
      log('Error fetching comments with pagination: $e', name: 'ApiCommentRepository:getWithPagination');
      log(stackTrace.toString(), name: 'ApiCommentRepository:getWithPagination');
    }
    return [];
  }

  @override
  Future<Comment?> getById(String id) async {
    try {
      final response = await _dio.get('/$id');
      if (response.statusCode == 200 && response.data != null) {
        return Comment.fromMap(response.data);
      }
    } catch (e, stackTrace) {
      log('Error fetching comment by ID: $e', name: 'ApiCommentRepository:getById');
      log(stackTrace.toString(), name: 'ApiCommentRepository:getById');
    }
    return null;
  }

  @override
  Future<Comment?> create(Comment newData) async {
    try {
      final response = await _dio.post('', data: newData.toMap());
      if (response.statusCode == 201 && response.data != null) {
        return Comment.fromMap(response.data);
      }
    } catch (e, stackTrace) {
      log('Error creating comment: $e', name: 'ApiCommentRepository:create');
      log(stackTrace.toString(), name: 'ApiCommentRepository:create');
    }
    return null;
  }

  @override
  Future<bool> update(Comment updatedData) async {
    try {
      final response = await _dio.put('/${updatedData.id}', data: updatedData.toMap());
      if (response.statusCode == 204) {
        return true;
      }
    } catch (e, stackTrace) {
      log('Error updating comment: $e', name: 'ApiCommentRepository:update');
      log(stackTrace.toString(), name: 'ApiCommentRepository:update');
    }
    return false;
  }

  @override
  Future<bool> delete(String id) async {
    try {
      final response = await _dio.delete('/$id');
      if (response.statusCode == 204) {
        return true;
      }
    } catch (e, stackTrace) {
      log('Error deleting comment: $e', name: 'ApiCommentRepository:delete');
      log(stackTrace.toString(), name: 'ApiCommentRepository:delete');
    }
    return false;
  }
}
