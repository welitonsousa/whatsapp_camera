# whatsapp_camera
<p>
This is a package to open a camera along with a photo gallery, to simplify the steps of the end user
</p>
<p>
It also has a widget for viewing images
</p>

### how to use

Open camera:
```dart
List<File>? res = await Navigator.push(
  context, MaterialPageRoute(
    builder: (context) => const WhatsappCamera(),
  ),
);
```
<br>

Open image: 
```dart
Navigator.push(
  context, MaterialPageRoute(
    builder: (context) => const ViewImage(
      image: 'https://...', 
      imageType: ImageType.network,
    ),
  ),
);
```
<p align="center">
<img  src="https://github.com/welitonsousa/whatsapp_camera/blob/main/assets/example.gif?raw=true" width="250" height="500"/>
</p>

<hr>

## Android
add permissions: <br>
<b>file:</b>  `/android/app/main/AndroidManifest.xml`

```dart
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<application
  android:requestLegacyExternalStorage="true"
  ...
```
<b>file:</b>  `android/app/build.gradle`
```dart
minSdkVersion 21
compileSdkVersion 33
```

## ios
<b>file:</b> `/ios/Runner/Info.plist`

```dart
<key>NSCameraUsageDescription</key>
<string>Can I use the camera please?</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Used to demonstrate image picker plugin</string>
```

 <a target="_blank" href="https://github.com/welitonsousa/whatsapp_camera/blob/main/LICENSE">LICENSE</a>

<br>
<br>
<p align="center">
   Feito com ❤️ by <a target="_blank" href="https://github.com/welitonsousa"><b>Weliton Sousa</b></a>
</p>
