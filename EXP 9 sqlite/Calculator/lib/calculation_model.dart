class Calculation {
  final int? id;
  final String expression;
  final String result;
  final String timestamp;

  const Calculation({
    this.id,
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expression': expression,
      'result': result,
      'timestamp': timestamp,
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map) {
    return Calculation(
      id: map['id'] as int?,
      expression: map['expression'] as String,
      result: map['result'] as String,
      timestamp: map['timestamp'] as String,
    );
  }

  @override
  String toString() {
    return 'Calculation{id: $id, expression: $expression, result: $result, timestamp: $timestamp}';
  }
}
