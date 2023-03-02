class TableNow {
  final String id;
  final String name;
  final String status;
  final bool isLocked;
  final int assignee;
  final TableProps? props;

  TableNow({
    required this.id, 
    required this.name, 
    required this.status, 
    required this.isLocked, 
    required this.assignee,
    required this.props,
  });


  TableNow copyWith({
    String? id,
    String? name,
    String? status,
    bool? isLocked,
    int? assignee,
    TableProps? props,
  }) {
    return TableNow(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      isLocked: isLocked ?? this.isLocked,
      assignee: assignee ?? this.assignee,
      props: props ?? this.props
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'isLocked': isLocked,
      'assignee': assignee,
      'props' : props,
    };
  }

  factory TableNow.fromMap(Map<String, dynamic> map) {
    return TableNow(
      id: map['id'] ?? '',
      name: map['table_name'] ?? '',
      status: map['table_status'] ?? '',
      isLocked: map['table_locked'] ?? false,
      assignee: map['table_assigned'] ?? 0,
      props: map['props'] != null ? TableProps.fromMap(map['props']) : null,
    );
  }
}


class TableProps {
  final int id;
  final double dx;
  final double dy;
  final double length;
  final double width;
  final String type;

  TableProps({
    required this.id, 
    required this.dx, 
    required this.dy, 
    required this.length, 
    required this.width, 
    required this.type
});

  TableProps copyWith({
    int? id,
    double? dx,
    double? dy,
    double? length,
    double? width,
    String? type
  }) {
    return TableProps(
      id: id ?? this.id,
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
      length: length ?? this.length,
      width: width ?? this.width,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dx': dx,
      'dy': dy,
      'length': length,
      'width': width,
      'type':type,
    };
  }

  factory TableProps.fromMap(Map<String, dynamic> map) {
    return TableProps(
      id: map['id'] ?? 0,
      dx: map['table_dx'] ?? 0.0,
      dy: map['table_dy'] ?? 0.0,
      length: map['table_len'] ?? 0.0,
      width: map['table_wid'] ?? 0.0,
      type: map['table_type'] ?? ''
    );
  }
}