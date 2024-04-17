//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource {
    private var posts: [Post] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell = UITableViewCell()
        let cell = tumblrTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell

        //WRONG --
        let post = posts[indexPath.row]
        
        if let postImageURL = post.photos.first?.originalSize.url {
                // Use Nuke to load the image
                Nuke.loadImage(with: postImageURL, into: cell.postImageView)
            }
        //WRONG --
        cell.postLabel.text = post.summary
        
        return cell;
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        tumblrTableView.dataSource = self

        
        fetchPosts()
    }

    @IBOutlet weak var tumblrTableView: UITableView!
    

    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)

                DispatchQueue.main.async { [weak self] in

                    let posts = blog.response.posts
                    self?.posts = posts;
                    self?.tumblrTableView.reloadData()


                    print("✅ We got \(posts.count) posts!")
                    for post in posts {
                        print("🍏 Summary: \(post.summary)")
                    }
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
