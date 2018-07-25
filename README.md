
	1)	Login to https://developers.facebook.com/ 
	2)	My Apps -> Add New App  enter display name and email click on create App ID button  
	3)	Settings -> Basic enter privacy policy and choose category click on save change button  
	4)	click on switch (ON)  
	5)	click on products(+) -> facebook setup -> ios  
	6)	Download SDK and add Bolts, FBSDKCorekit and FBSDKLoginKit  
	7)	copy info.plist data 

      <key>CFBundleURLTypes</key>
      <array>
          <dict>
              <key>CFBundleURLSchemes</key>
              <array>
                  <string>fb123123123123123</string>
              </array>
          </dict>
      </array>
      <key>FacebookAppID</key>
      <string>FB-APP-ID</string>
      <key>FacebookDisplayName</key>
      <string>DISPLAY-NAME</string>
      <key>LSApplicationQueriesSchemes</key>
      <array>
          <string>fbapi</string>
          <string>fb-messenger-share-api</string>
          <string>fbauth2</string>
          <string>fbshareextension</string>
      </array>

      Replace 123123123123123 to your FB-APP-ID

	8)	add code in appdelegate  

      import FBSDKLoginKit
      
      FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

	9)	Copy code to your button click

      FBSDKLoginManager().logOut()
              FBSDKAccessToken.setCurrent(nil)
              FBSDKProfile.setCurrent(nil)

              FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: { (result, error) -> Void in

                  if error != nil {
                      FBSDKLoginManager().logOut()
                      if let error = error as NSError? {
                          let errorDetails = [NSLocalizedDescriptionKey : "Processing Error. Please try again!"]
                          let customError = NSError(domain: "Error!", code: error.code, userInfo: errorDetails)
                          print(customError)
                          //onCompletion(nil, customError)
                      } else {
                          //onCompletion(nil, error as NSError?)
                      }

                  } else if (result?.isCancelled)! {
                      FBSDKLoginManager().logOut()
                      let errorDetails = [NSLocalizedDescriptionKey : "Request cancelled!"]
                      let customError = NSError(domain: "Request cancelled!", code: 1001, userInfo: errorDetails)
                      print(customError)
                      //onCompletion(nil, customError)
                  } else {
                      //picture.width(1000).height(1000)
                      let pictureRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id,name,email,picture.type(large)"])
                      let _ = pictureRequest?.start(completionHandler: {
                          (connection, result, error) -> Void in

                          if error == nil {


                              let FBResult = result as! Dictionary<String, AnyObject>

                              print(FBResult)

                          } else {
                              //onCompletion(nil, error as NSError?)
                          }
                      })
                  }
              })

   10) Enjoy, You are done...!!
