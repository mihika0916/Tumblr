//
//  DetailViewController.swift
//  ios101-project6-tumblr
//
//  Created by Mihika Sharma on 11/04/24.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    
    var post : Post!

   
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photo = post.photos.first {
            let url = photo.originalSize.url
            Nuke.loadImage(with: url, into: detailImageView)
        }
        
        detailTextView.text = post.caption;


        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
