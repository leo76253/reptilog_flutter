class Reptile {
  final int? id;
  final String name;
  final String species;
  final String? clutch;
  final DateTime? hatch_date;
  final DateTime? acquisition_date;
  final String? acquisition_source;
  final String? notes;

  Reptile({
    this.id,
    required this.name,
    required this.species,
    this.clutch,
    this.hatch_date,
    this.acquisition_date,
    this.acquisition_source,
    this.notes,
  });

  factory Reptile.fromJson(Map<String, dynamic> json) {
    return Reptile(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      clutch: json['clutch'],
      hatch_date: json['hatch_date'] != null ? DateTime.parse(json['hatch_date']) : null,
      acquisition_date: json['acquisition_date'] != null ? DateTime.parse(json['acquisition_date']) : null,
      acquisition_source: json['acquisition_source'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'clutch': clutch,
      'hatch_date': hatch_date?.toIso8601String(),
      'acquisition_date': acquisition_date?.toIso8601String(),
      'acquisition_source': acquisition_source,
      'notes': notes,
    };
  }
}
