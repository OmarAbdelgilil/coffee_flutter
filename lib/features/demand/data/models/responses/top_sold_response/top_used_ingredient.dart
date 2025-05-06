class TopUsedIngredient {
  String? wholeMilk;
  String? espressoBeans;
  String? baristaChocolateSyrup;
  String? sugar;
  String? salami;
  String? baristaWhiteChocolateSyrup;
  String? whippedCream;
  String? ham;
  String? cocoaPowder;
  String? mozzarella;
  String? baristaCaramelSauce;
  String? chocolate;
  String? cheddar;
  String? blackTea;
  String? paniniBread;
  String? lemons;

  TopUsedIngredient({
    this.wholeMilk,
    this.espressoBeans,
    this.baristaChocolateSyrup,
    this.sugar,
    this.salami,
    this.baristaWhiteChocolateSyrup,
    this.whippedCream,
    this.ham,
    this.cocoaPowder,
    this.mozzarella,
    this.baristaCaramelSauce,
    this.chocolate,
    this.cheddar,
    this.blackTea,
    this.paniniBread,
    this.lemons,
  });

  factory TopUsedIngredient.fromJson(Map<String, dynamic> json) {
    return TopUsedIngredient(
      wholeMilk: json['Whole Milk'] as String?,
      espressoBeans: json['Espresso beans'] as String?,
      baristaChocolateSyrup: json['Barista chocolate syrup'] as String?,
      sugar: json['Sugar'] as String?,
      salami: json['Salami'] as String?,
      baristaWhiteChocolateSyrup:
          json['Barista white chocolate syrup'] as String?,
      whippedCream: json['Whipped cream'] as String?,
      ham: json['Ham'] as String?,
      cocoaPowder: json['Cocoa powder'] as String?,
      mozzarella: json['Mozzarella'] as String?,
      baristaCaramelSauce: json['Barista caramel sauce'] as String?,
      chocolate: json['Chocolate'] as String?,
      cheddar: json['Cheddar'] as String?,
      blackTea: json['Black Tea'] as String?,
      paniniBread: json['Panini Bread'] as String?,
      lemons: json['Lemons'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'Whole Milk': wholeMilk,
    'Espresso beans': espressoBeans,
    'Barista chocolate syrup': baristaChocolateSyrup,
    'Sugar': sugar,
    'Salami': salami,
    'Barista white chocolate syrup': baristaWhiteChocolateSyrup,
    'Whipped cream': whippedCream,
    'Ham': ham,
    'Cocoa powder': cocoaPowder,
    'Mozzarella': mozzarella,
    'Barista caramel sauce': baristaCaramelSauce,
    'Chocolate': chocolate,
    'Cheddar': cheddar,
    'Black Tea': blackTea,
    'Panini Bread': paniniBread,
    'Lemons': lemons,
  };
}
