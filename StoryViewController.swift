//
//  StoryViewController.swift
//  Instagram
//
//  Created by Kishor Subedi on 2/25/18.
//  Copyright © 2018 Kishor Subedi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class StoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var posts : [Post] = []
    @IBOutlet weak var tableView: UITableView!
    @IBAction func didLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        /*let query = Post.query()
       
        query?.limit = 20 */
        
        // fetch data asynchronously
        
        
        let query = Post.query()
        query?.addDescendingOrder("createdAt")
        query?.includeKey("author")
        query?.includeKey("media")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }        /*
        query?.findObjectsInBackgroundWithBlock{ (posts: [AnyObject]?, error: Error?) -> Void in
            if let posts = posts {
         
                // do something with the data fetched
                
            } else {
                // handle error
            }
        } */
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photosCell", for: indexPath) as! photosCell
        
        var post = posts[indexPath.row]
        
        if post["media"] != nil
        {
            cell.postedimageView = post["media"] as! PFImageView
        }
        return cell
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
