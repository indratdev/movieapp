import 'package:flutter/material.dart';
import 'package:movie_app/shared/colors_app.dart';


enum StatusImage {
  success,
  failed,
  warning,
}

class CustomWidgets {
  String getStatusImage(StatusImage statusImage) {
    String name = "";

    if (statusImage.name == StatusImage.success.name) {
      name = 'assets/images/success.webp';
    } else if (statusImage.name == StatusImage.warning.name) {
      name = 'assets/images/warning.webp';
    } else if (statusImage.name == StatusImage.failed.name) {
      name = 'assets/images/failed.webp';
    } else {
      name = 'assets/images/warning.webp';
    }
    return name;
  }


  // loading widget
  static showLoadingWidget(
    BuildContext context,
  ) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,

              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)), //this right here
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width / 4,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(height: 15),
                    Text('Loading...'),
                  ],
                ),
              ),
            ),
          );
        });
  }

  


  // old version
  showMessageAlert(
    BuildContext context,
    String content,
    StatusImage statusImage,
    Function()? voidCallBack,
  ) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: ColorsApp.backgroundDashboardColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)), //this right here
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 4,
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 8,
                              foregroundColor: Colors.transparent,
                              child: Image.asset(
                                getStatusImage(statusImage),
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              content,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          // onPressed: () => Navigator.pop(context),
                          onPressed: (voidCallBack == null)
                              ? () => Navigator.pop(context)
                              : voidCallBack,
                          child: const Text("OK"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }


}
