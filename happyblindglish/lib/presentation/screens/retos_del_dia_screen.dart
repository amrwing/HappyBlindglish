import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyblindglish/models/reto.dart';
import 'package:happyblindglish/presentation/blocs/reto_cubit.dart';
import 'package:happyblindglish/presentation/screens/generic_scaffolds/main_custom_scaffold.dart';
import 'package:happyblindglish/utils/app_utils.dart';
import 'package:happyblindglish/utils/constants.dart';

class RetosDelDiaScreen extends StatefulWidget {
  const RetosDelDiaScreen({super.key});

  @override
  State<RetosDelDiaScreen> createState() => _RetosDelDiaScreenState();
}

class _RetosDelDiaScreenState extends State<RetosDelDiaScreen> {
  late List<Reto> retosDelDia;

  Future<List<Reto>?> _obtenerRetosDelDia() async {
    return [
      Reto(
          nombre: "Acierta 5 palabras básicas",
          descripcion:
              "Elige la traducción correcta de 20 palabras esenciales en inglés a partir de su equivalente en español.",
          estatusCompletado: false,
          datosReto: DatosReto(
              puntosReto: 40, palabrasPorAprender: 1, palabrasAprendidas: 0),
          tipo: TipoDeReto.acertarLasPalabras.name),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
        returnBottomButtonActivated: true,
        view: FutureBuilder(
            future: _obtenerRetosDelDia(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final List<Reto> retos = snapshot.data!;
                return Column(
                    children: retos
                        .map((reto) => ChallengeCard(reto: reto))
                        .toList());
              }
            }),
        title: "Retos del día",
        tutorialText:
            "En esta pantalla podrás encontrar los retos que tienes que cumplir hoy, entrando en cada reto irás a la lección que te permitirá avanzár en él");
  }
}

class ChallengeCard extends StatelessWidget {
  final Reto reto;
  const ChallengeCard({
    super.key,
    required this.reto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppUtils.textButtonPadding),
      child: Card(
        surfaceTintColor: const Color(0xffffffff),
        child: Semantics(
          child: ListTile(
            title: Text(reto.nombre),
            subtitle: Text(
                "${reto.datosReto.palabrasAprendidas} de ${reto.datosReto.palabrasPorAprender} completados"),
            trailing: MergeSemantics(
              child: ElevatedButton(
                onPressed: () {
                  context.read<RetoCubit>().setChallengeSelection(reto);
                  Navigator.pushNamed(context, "reto_actividad_screen");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8755c9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppUtils.buttonBorderRadius)),
                      side: const BorderSide(color: Colors.black)),
                ),
                child: MergeSemantics(
                  child: Text(
                    Strings.empezarReto,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum TipoDeReto { acertarLasPalabras }
