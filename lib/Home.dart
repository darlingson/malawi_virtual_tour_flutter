import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ArCoreController? augmentedRealityController;
  augumentedRealityViewCreated(ArCoreController coreController) {
    augmentedRealityController = coreController;
    displayEarthMapSphere(augmentedRealityController);
  }

  displayEarthMapSphere(ArCoreController? coreController) async {
    final ByteData bytes =
        await rootBundle.load("images/Mulange_Massif_3D.gif");
    final materials = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: bytes.buffer.asUint8List(),
    );
    final sphere = ArCoreSphere(
      materials: [materials],
      radius: 0.1,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    coreController?.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ArCoreView(onArCoreViewCreated: augumentedRealityViewCreated),
    );
  }
}
