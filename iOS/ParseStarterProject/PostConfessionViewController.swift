//
//  PostConfessionViewController.swift
//  Confessions
//
//  Created by Kirill Kudaev on 7/15/17.
//

import UIKit
import Parse

class PostConfessionViewController: UIViewController, UITextFieldDelegate {
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var confessionDescription: UITextView!
    @IBOutlet weak var includePollSwitch: UISwitch!
    
    @IBAction func post(_ sender: Any) {
        
        let hasPoll = includePollSwitch.isOn
        
        let pfItem = PFObject(className:"Post")
        let confession = PostConfession(body: confessionDescription.text, hasPoll: hasPoll)
        
        if confession.error {
            
            createOkAlert(title: "Error in form", message: confession.errorMessage!)
            
        } else {
            
            showActivityIndicator()
            
            pfItem["userId"] = UIDevice.current.identifierForVendor!.uuidString
            pfItem["body"] = confession.body
            pfItem["hasPoll"] = confession.hasPoll
            pfItem["approved"] = false
            pfItem["likes"] = 0
            pfItem["yesAnswers"] = 0
            pfItem["noAnswers"] = 0
            
            
            pfItem.saveInBackground { (succcess, error) in
                
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if error != nil {
                    self.createOkAlert(title: "Could not post confession", message: "Please try again")
                } else {
                    self.createOkAlert(title: "Posted", message: "Confession has been posted!")
                    self.confessionDescription.text = "";
                    self.includePollSwitch.setOn(false, animated: true)
                }
            }
        }
    }
    
    func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
