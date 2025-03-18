// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:happyblindglish/models/leccion.dart';
// import 'package:happyblindglish/models/reto.dart';
// import 'package:happyblindglish/presentation/blocs/reto_cubit.dart';
// import 'package:happyblindglish/presentation/screens/generic_scaffolds/main_custom_scaffold.dart';
// import 'package:happyblindglish/utils/app_utils.dart';

// class Lecciones extends StatefulWidget {
//   const Lecciones({super.key});

//   @override
//   State<Lecciones> createState() => _LeccionesState();
// }

// class _LeccionesState extends State<Lecciones> {
//   List<Leccion> retosDelDia = [];
//   @override
//   void initState() {
//     super.initState();
//     _obtenerRetosDelDia().then((value) {
//       setState(() {
//         retosDelDia = value;
//       });
//     });
//   }

//   Future<List<Leccion>> _obtenerRetosDelDia() async {
//     return [
//       Leccion(
//           tema: "animales",
//           nombre: 'Aprende los nombres de los animales',
//           dificultad: 2),
//       Leccion(
//         tema: "letras",
//         nombre: 'Aprende las letras',
//         dificultad: 1,
//       ),
//       Leccion(
//         tema: "verbos",
//         nombre: 'Aprende los verbos',
//         dificultad: 3,
//       ),
//       Leccion(
//         tema: "verbos",
//         nombre: 'Aprende los verbos',
//         dificultad: 3,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MainCustomScaffold(
//         returnBottomButtonActivated: true,
//         view: retosDelDia.isNotEmpty
//             ? SizedBox(
//                 height: MediaQuery.of(context).size.height / 3,
//                 child: ListView.builder(
//                     itemCount: retosDelDia.length,
//                     itemBuilder: (context, index) {
//                       return ChallengeCard(
//                         reto: retosDelDia[index],
//                         onPressed: () {
//                           context
//                               .read<RetoCubit>()
//                               .setChallengeSelection(retosDelDia[index]);
//                           Navigator.pushNamed(
//                             context,
//                             "reto_actividad_screen",
//                           );
//                           setState(() {
//                             retosDelDia.remove(retosDelDia[index]);
//                           });
//                         },
//                       );
//                     }),
//               )
//             : const Center(
//                 child: Text("No hay más retos hoy"),
//               ),
//         title: "Retos del día",
//         tutorialText:
//             "En esta pantalla podrás encontrar los retos que tienes que cumplir hoy, entrando en cada reto irás a la lección que te permitirá avanzár en él");
//   }
// }

// class ChallengeCard extends StatelessWidget {
//   final void Function()? onPressed;
//   final Reto reto;
//   const ChallengeCard({
//     super.key,
//     required this.reto,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: AppUtils.textButtonPadding),
//       child: GestureDetector(
//         onTap: onPressed,
//         child: Card(
//           surfaceTintColor: const Color(0xffffffff),
//           child: Semantics(
//             child: ListTile(
//               title: Text(
//                   "Acierta ${reto.datosReto.palabrasPorAprender} ${reto.tema} en inglés"),
//               subtitle: Text(
//                   "${reto.datosReto.palabrasAprendidas} de ${reto.datosReto.palabrasPorAprender} completados"),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// enum TipoDeReto { acertarLasPalabras }
