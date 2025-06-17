// paginated_response.dart
import 'support.dart';

class PaginatedResponse<T> {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<T> data;
  final Support? support;

  PaginatedResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    this.support,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse(
      page: json['page'] as int,
      perPage: json['per_page'] as int,
      total: json['total'] as int,
      totalPages: json['total_pages'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      support: json['support'] == null
          ? null
          : Support.fromJson(json['support'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson(T Function(T) toJsonT) => {
    'page': page,
    'per_page': perPage,
    'total': total,
    'total_pages': totalPages,
    'data': data.map((e) => toJsonT(e)).toList(),
    if (support != null) 'support': support!.toJson(),
  };
}
