
import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapFBLogin(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
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
    }
    
}

