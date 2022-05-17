import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ml_flutter_cookbook/picture_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription>? cameras ;
  List<Widget>? cameraButtons;

  CameraDescription? activeCamera;
  CameraController? cameraController;
  CameraPreview? cameraPreview;

  Future<List<Widget>?> listCameras() async{
    List<Widget> buttons = [];
    cameras = await availableCameras();
    if(cameras == null) return null;
    if(activeCamera == null) activeCamera = cameras?.first;
    if(cameras!.length > 0){
      for(CameraDescription camera in cameras!){
        buttons.add(
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff4f000b))
              ),
              onPressed: (){
            setState(() {
              activeCamera = camera;
              setCameraController();
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.camera_alt , color: Colors.white,),
                SizedBox(width: 10,),
                Text(camera == null ? '' : camera.name == '0' ? 'back' : camera.name == '1' ? 'front': '' ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white
                  ),)
              ],
          )
          )
        );
      }
      return buttons;
    }else{
      return [];
    }
  }

  Future setCameraController()async {
    if (activeCamera == null) return;
    cameraController = CameraController(activeCamera!, ResolutionPreset.high);
    await cameraController?.initialize();

    setState(() {
      cameraPreview =  CameraPreview(cameraController!);

    });
  }

  Future takePicture()async{
    if( !cameraController!.value.isInitialized) return;
    if(cameraController!.value.isTakingPicture) return;
    try {
      await cameraController?.setFlashMode(FlashMode.off);
      XFile? picture = await cameraController?.takePicture();

      Navigator.push(context, MaterialPageRoute(builder: (context) => PictureScreen(picture!)));
    }catch(exception){
      print(exception.toString());
    }
  }

  @override
  void initState(){
    super.initState();
    listCameras().then((result) {
      setState(() {
        cameraButtons = result;
        setCameraController();
      });
    });
  }

  @override
  void dispose(){
    if(activeCamera ==  null){
      cameraController?.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
            children:
              cameraButtons ?? [Container(child: Text('no Cameras Available '))],
            ),
            Container(width: MediaQuery.of(context).size.height / 3, child: cameraPreview) ,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff4f000b))
                  ),
                    onPressed: (){
                      if(cameraController != null){
                        takePicture().then((dynamic picture) async{
                          XFile pic= await picture;
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PictureScreen(pic)));
                        });
                      }
                    },
                    child: Text('Take Picture'))
              ],
            ),
          ],
        ),
      ),
    );
  }


}

