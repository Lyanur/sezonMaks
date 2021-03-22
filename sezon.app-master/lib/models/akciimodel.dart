class AkciiData {
//   "GUID": "3261c984-dfac-11ea-1f80-6a8096f259ad",
//   "GUID_Характеристика": "00000000-0000-0000-0000-000000000000",
//   "Остаток": "5",
//   "Цена": "169",
//   "Скидка": "0",
//   "Фото": "3261c984-dfac-11ea-1f80-6a8096f259ad",
//   "ГруппаМагазина": "af7a608e-734a-11eb-de89-6a8096f259ad",
//   "ГруппаМагазина_Идентификатор": "Мужчинам",
//   "ПодгруппаМагазина": "cea752f0-734a-11eb-de89-6a8096f259ad",
//   "ПодгруппаМагазина_Идентификатор": "Цена",
//   "Акция": "",
//   "Акция_Идентификатор": "",
//   "Артикул": "106060850",
//   "Наименование": "Зажим д/денег"
//

  AkciiData({
    this.GUID = '',
    this.ostatok = '',
    this.type = '',
    this.price = '',
    this.skidka = '',
    this.oldprice = '',
    this.foto = '',
    this.group= '',
    this.podgroup = '',
    this.akcii = '',
    this.articul = '',
    this.title = '',
  });

  String GUID;
  String ostatok;
  String price;
  String type;
  String skidka;
  String foto;
  String group;
  String oldprice;
  String podgroup;
  String akcii;
  String articul;
  String title;

  Map<String, dynamic> toJson() => {
      'GUID': GUID,
      'ostatok': ostatok,
      'price': price,
      'type': type,
      'foto': foto,
      'skidka': skidka,
      'oldprice': oldprice,
      'group': group,
      'podgroup': podgroup,
      'akcii': akcii,
      'articul': articul,
      'title': title,
    };

  AkciiData.fromJson(Map<String, dynamic> json)
      : GUID = json['GUID'] as String,
        ostatok = json['ostatok'] as String,
        foto = json['foto'] as String,
        type = json['type'] as String,
        skidka = json['skidka'] as String,
        group = json['group'] as String,
        oldprice = json['oldprice'] as String,
        podgroup = json['podgroup'] as String,
        akcii = json['akcii'] as String,
        articul = json['articul'] as String,
        title = json['title'] as String,
        price = json['price'] as String;

}