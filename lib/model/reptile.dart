class Reptile {
  int? id;
  String name;
  String species;
  String? clutch;
  DateTime? hatchDate;
  DateTime? acquisitionDate;
  String? acquisitionSource;
  String? notes;

  Reptile({
    this.id,
    required this.name,
    required this.species,
    this.clutch,
    this.hatchDate,
    this.acquisitionDate,
    this.acquisitionSource,
    this.notes,
  });

  factory Reptile.fromJson(Map<String, dynamic> json) {
    return Reptile(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      clutch: json['clutch'],
      hatchDate: json['hatch_date'] != null ? DateTime.parse(json['hatch_date']) : null,
      acquisitionDate: json['acquisition_date'] != null ? DateTime.parse(json['acquisition_date']) : null,
      acquisitionSource: json['acquisition_source'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'clutch': clutch,
      'hatch_date': hatchDate?.toIso8601String(),
      'acquisition_date': acquisitionDate?.toIso8601String(),
      'acquisition_source': acquisitionSource,
      'notes': notes,
    };
  }
}
