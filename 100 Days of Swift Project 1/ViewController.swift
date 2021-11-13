//
//  ViewController.swift
//  100 Days of Swift Project 1
//
//  Created by Seb Vidal on 10/11/2021.
//

import UIKit

class ViewController: UITableViewController {

    var pictures: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures.sorted()[indexPath.row]
        cell.textLabel?.font = .preferredFont(forTextStyle: .body)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            viewController.selectedImage = pictures.sorted()[indexPath.row]
            viewController.imageIndex = indexPath.row + 1
            viewController.imageCount = pictures.count
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let message = "Download 100 Days of Swift Project 1!"
        
        let viewController = UIActivityViewController(activityItems: [message], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true)
    }
}

