import 'package:firebase_core/firebase_core.dart';
import 'package:soul_comfort/flavors.dart';


class FirebaseOption {
  static FirebaseOptions get currentPlatform {
    switch (F.appFlavor) {
      case Flavor.dev :
        return const FirebaseOptions(
          apiKey : 'AIzaSyAhGBaXD2KLcc5mKCJCG1x-Hx8BHVGp3HE',
          appId : '1:61284782026:android:16d0c3693d1c5f91b04933',
          messagingSenderId : '61284782026',
          projectId : 'soul-comfort-3d60a' ,
          storageBucket: 'soul-comfort-3d60a.appspot.com',
          
        );

      case Flavor.prod :
        return const FirebaseOptions(
          apiKey : 'AIzaSyAhGBaXD2KLcc5mKCJCG1x-Hx8BHVGp3HE',
          appId : '1:61284782026:android:a3e0949d75f4ea9eb04933',
          messagingSenderId : '61284782026',
          projectId : 'soul-comfort-3d60a',
          storageBucket: 'soul-comfort-3d60a.appspot.com',
        );

      default :
        return const FirebaseOptions(
          apiKey : 'AIzaSyAhGBaXD2KLcc5mKCJCG1x-Hx8BHVGp3HE',
          appId : '1:61284782026:android:16d0c3693d1c5f91b04933',
          messagingSenderId : '61284782026',
          projectId : 'soul-comfort-3d60a' ,
          storageBucket: 'soul-comfort-3d60a.appspot.com',
        );
    }
  }
}
