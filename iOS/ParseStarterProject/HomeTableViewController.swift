//
//  HomeTableViewController.swift
//  Confessions
//
//  Created by Kirill Kudaev on 7/15/17.
//

import UIKit
import Parse

// TODO: use MVC or MVP pattern
class HomeTableViewController: UITableViewController {

    // TODO: Consider putting this method and a protocol for it in ConfessionCell.
    // "UIButton in UITableViewCell using Delegates and Protocols in Swift" https://www.youtube.com/watch?v=UPrBXUWPf6Q
    @IBAction func like(_ sender: UIButton) {
        print(sender.tag)
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! ConfessionCell
        
        // TODO: use bool isLiked in the ConfessionCell to identify this
        if cell.btnLike.titleLabel?.text == "Like" {
            cell.btnLike.setTitle("Unlike", for: .normal)
        } else if cell.btnLike.titleLabel?.text == "Unlike" {
            cell.btnLike.setTitle("Like", for: .normal)
        }
    }
    
    var confessionArray = Array<Confession>()
    var refresher: UIRefreshControl!
    
    func refresh() {
        let query = PFQuery(className:"Post")
        query.whereKey("approved", equalTo: true)
        query.order(byDescending: "createdAt")
        query.limit = 10000
        query.findObjectsInBackground { (objects, error) -> Void in
            
            if error == nil {
                self.confessionArray.removeAll()

                for object in objects! {
                    
//                    TESTING
//                    let _ = object.objectId!
//                    let _ = object["body"] as! String
//                    let _ = object["hasPoll"] as! Bool
//                    let _ = object["likes"] as! Int
//                    let _ = object["yesAnswers"] as! Int
//                    let _ = object["noAnswers"] as! Int
//                    let _ = object.createdAt!
//                    let _ = object.updatedAt!
                    
                    // TODO: use guards
                    let confession = Confession(id: object.objectId!, body: object["body"] as! String, hasPole: object["hasPoll"] as! Bool, likes: object["likes"] as! Int, yesAnswers: object["yesAnswers"] as! Int, noAnswers: object["noAnswers"] as! Int, createdAt: object.createdAt!, updatedAt: object.updatedAt!)
                    
                    self.confessionArray.append(confession)
                }
                
                print("Count: " + String(self.confessionArray.count))
                
                // Reload tableview
                self.tableView.reloadData()
            } else {
                print(error)
            }
            
            print(self.confessionArray)
            
            self.refresher.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh...")
        refresher.addTarget(self, action: #selector(HomeTableViewController.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refresher)
        
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Customizing Tab Bar
        let color = UIColor(red: 85/255.0, green: 199/255.0, blue: 147/255.0, alpha: 1.0)
        self.tabBarController?.tabBar.tintColor = color
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.confessionArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // TODO: use guard
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConfessionCell
        
        cell.lblDescription.text = self.confessionArray[indexPath.row].body
        cell.lblLikesNumber.text = String(self.confessionArray[indexPath.row].likes)
        cell.lblYesNumber.text = String(self.confessionArray[indexPath.row].yesAnswers)
        cell.lblNoNumber.text = String(self.confessionArray[indexPath.row].noAnswers)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy HH:mm:ss"
        let createdAt = dateFormatter.string(from:self.confessionArray[indexPath.row].createdAt)
        
        cell.lblTime.text = createdAt
        
        cell.btnLike.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(HomeTableViewController.like(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }
}

