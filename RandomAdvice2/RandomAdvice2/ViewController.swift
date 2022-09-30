//
//  ViewController.swift
//  RandomAdvice2
//
//  Created by user on 24/09/22.
//

import UIKit

struct Post: Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var MyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeRequest{(posts) in
            print("posts: \(posts[0].id)")
            self.MyLabel.text = "\(posts[0].title)"
        }
    }
    
    private func makeRequest(compeltion: @escaping ([Post]) -> ()){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            print("response: \(String(describing: response))")
            print("error: \(String(describing: error))")
            //print("data: \(String(describing: data))")
            
            guard let responseData = data else { return }
            //if let responseString = String(data: responseData, encoding: .utf8)
            //{
                //print(responseString)
            //}
            
            do{
                let posts = try JSONDecoder().decode([Post].self, from: responseData)
                //print("Objects post: \(posts)")
                compeltion(posts)
            } catch let error{
                print("error: \(error)")
            }
            
            
            
        }
        task.resume()
    }
        
}

