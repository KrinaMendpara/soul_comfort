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
          apiKey : 'AIzaSyA1v1Si1x6PSyg4izPgy3kAoROKnudqYEc',
          appId : '1:1096908237548:android:167b246e4ecc3302ff93c9',
          messagingSenderId : '1096908237548',
          projectId : 'soul-comfort-9336f',
          storageBucket: 'soul-comfort-9336f.appspot.com',
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
