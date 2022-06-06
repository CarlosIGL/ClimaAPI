import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/services/open_wheater.dart';
import 'package:intl/intl.dart';

class AppState extends StatelessWidget {

  const AppState({Key? key}) : super(key: key);
  get nombreFinal => _HomePageState().nombreFinal;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OpenWheater(city: nombreFinal),
        )
      ],
      child:  const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   String nombreFinal = '';


   @override
   void initState() {
     super.initState();
   }

  @override
  Widget build(BuildContext context) {
    final openWeatherServices = Provider.of<OpenWheater>(context);
    final today = DateTime.now().toUtc().add(Duration(seconds: openWeatherServices.timeZone));
    String formatoFecha = DateFormat('kk:mm EEE d MMM').format(today);
    if(openWeatherServices.condiciones.isEmpty){
      return Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.pink),
          )
      );
    }



    Widget verticalList = SizedBox(
      height: 250.0,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index){
          final intervalo = index * 8;
          final intervalo2 = intervalo +4;
          final double temperaturaMin;
          final double temperaturaMax;
          if(openWeatherServices.tempManiana[intervalo].main.tempMax.toDouble()-273.15 > openWeatherServices.tempManiana[intervalo2].main.tempMin.toDouble()-273.15 ){
            temperaturaMax = openWeatherServices.tempManiana[intervalo].main.tempMax.toDouble()-273.15;
            temperaturaMin = openWeatherServices.tempManiana[intervalo2].main.tempMin.toDouble()-273.15;
          }else{
            temperaturaMax = openWeatherServices.tempManiana[intervalo2].main.tempMin.toDouble()-273.15;
            temperaturaMin = openWeatherServices.tempManiana[intervalo].main.tempMax.toDouble()-273.15;
          }


          final tiempo2 = DateTime(openWeatherServices.tempManiana[intervalo].dtTxt.year,
              openWeatherServices.tempManiana[intervalo].dtTxt.month,
              openWeatherServices.tempManiana[intervalo].dtTxt.day,
              openWeatherServices.tempManiana[intervalo].dtTxt.hour,
              openWeatherServices.tempManiana[intervalo].dtTxt.minute,
              openWeatherServices.tempManiana[intervalo].dtTxt.second).add(Duration(seconds: openWeatherServices.timeZone));
          String formatoDia = DateFormat('EEE').format(tiempo2);
          return Row(
            children: [
              Column(
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 5, left: 10)),
                  Text(formatoDia, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(DateFormat('d MMM').format(tiempo2)),
                ],
              ),
              const Padding(padding: EdgeInsets.only(left: 30)),

              Image.network(scale: 1.75,'https://openweathermap.org/img/wn/${openWeatherServices.tempManiana[intervalo].weather[0].icon}@2x.png'),

              const Padding(padding: EdgeInsets.only(left: 70)),

              Text.rich(TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: '${temperaturaMax.toInt()}°',
                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                    ),
                    const TextSpan(
                      text: '/',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${temperaturaMin.toInt()}°',
                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                    )
                  ]
              )),
              const Padding(padding: EdgeInsets.only(left: 60)),
              Image.network(scale: 25,'https://cdn-icons-png.flaticon.com/512/91/91977.png'),
              Text(' Wind: ${(openWeatherServices.tempManiana[intervalo].wind.speed*3.6).toInt()}k/h')
            ],
          );
        },
      ),
    );


    Widget horizontalList1 = Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: 100.0,
        child: ListView.builder(
          itemCount: openWeatherServices.tempManiana.length,
          itemBuilder: (context, index){

            final tiempo = DateTime(openWeatherServices.tempManiana[index].dtTxt.year,
                openWeatherServices.tempManiana[index].dtTxt.month,
                openWeatherServices.tempManiana[index].dtTxt.day,
                openWeatherServices.tempManiana[index].dtTxt.hour,
                openWeatherServices.tempManiana[index].dtTxt.minute,
                openWeatherServices.tempManiana[index].dtTxt.second).add(Duration(seconds: openWeatherServices.timeZone));
            String formatoHora = DateFormat('kk:mm').format(tiempo);
            return Column(
              children: [
                Text(' ${(openWeatherServices.tempManiana[index].main.feelsLike.toDouble()-273.15).toInt()}° C', style: const TextStyle(fontWeight: FontWeight.bold),),
                Image.network(scale: 1.75,'https://openweathermap.org/img/wn/${openWeatherServices.tempManiana[index].weather[0].icon}@2x.png'),
                Text(formatoHora, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            );
          },
          scrollDirection: Axis.horizontal,
        )
    );



    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffFF5733),
          title: Text('${openWeatherServices.ciudad}, ${openWeatherServices.pais}'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: ()async{
                final nombre = await showSearch(
                    context: context,
                    delegate: MySearchDelegate()
                );
                  nombreFinal = nombre;
                  OpenWheater(city: nombre);

              },
            )
          ],
        ),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20,left: 20,bottom: 5),
              child: Text(formatoFecha, style: const TextStyle(fontSize: 17),),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                height: 150,
                width: 370,
                decoration: ShapeDecoration(
                  color: const Color(0xffCC8A68 ),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 10,
                      cornerSmoothing: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Text(openWeatherServices.condiciones[0].description),
                        Row(
                          children: [
                            Image.network(scale: 1,'https://openweathermap.org/img/wn/${openWeatherServices.condiciones[0].icon}@2x.png'),
                            Text('${openWeatherServices.temAmbienteC}° C',style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Text('Feels Like: ${openWeatherServices.temAmbienteC} C')
                      ],
                    ),

                    const Padding(padding: EdgeInsets.only(left: 35)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.network(scale: 25,'https://cdn-icons-png.flaticon.com/512/727/727790.png'),
                            Text(' Humidity: ${openWeatherServices.humedad}%',style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),

                        Row(
                          children: [
                            Image.network(scale: 25,'https://cdn-icons-png.flaticon.com/512/91/91977.png'),
                            Text(' Wind: ${openWeatherServices.velocidad}k/h',style: const TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            horizontalList1,
            const Divider(thickness: 5,color: Colors.black12,),
            verticalList,
          ],
        )
    );
  }
}


class MySearchDelegate extends SearchDelegate{

  String value='';

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: (){
        query = '';
      },
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back)  ,
    onPressed: (){
      close(context, null);
    },
  );

  @override
  Widget buildResults(BuildContext context)=>TextButton(
    onPressed: (){
      value = query;
      close(context, value);
    },
    child: Text(query),
  );

  @override
  Widget buildSuggestions(BuildContext context){
    List<String> sugerencias = [
      'Ensenada',
      'Tijuana',
      'Dallas',
      'Tokio',
    ];
    return ListView.builder(
        itemCount: sugerencias.length,
        itemBuilder: (context, index){
          final sugerencia = sugerencias[index];

          return ListTile(
            title: Text(sugerencia),
            onTap: (){
              query = sugerencia;
            },
          );
        }
    );
  }
}

