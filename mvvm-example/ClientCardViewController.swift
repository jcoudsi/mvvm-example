//
//  ViewController.swift
//  mvvm-example
//
//  Created by COUDSI Julien on 12/06/2017.
//  Copyright © 2017 Blop. All rights reserved.
//

import UIKit

class ClientCardViewController: UIViewController, EditClientViewControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var completeNameLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    var editClientViewController:EditClientViewController!
    var client:Client!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.client = FakeAPI.sharedInstance.getClient()
        self.updateData()
        
    }
    
    func updateData() {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        self.completeNameLabel.text = "\(self.client.firstName) \(self.client.lastName)"
        self.birthdateLabel.text = dateFormatter.string(from: client.birthdate)
        self.jobLabel.text = "Profession : \(self.client.job)"
        
        if let photoUrlString = self.client.photoUrl, let photoUrl = URL(string:photoUrlString)  {
            
            let dataTask = URLSession.shared.dataTask(with: URLRequest(url: photoUrl), completionHandler: { [weak self] (data, reponse, error) in
                
                if let data = data {
                    DispatchQueue.main.async {
                        self?.photoImageView.image = UIImage(data: data)
                    }
                }
                
            })
            
            dataTask.resume()
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "navigationSegue" {
            self.editClientViewController = segue.destination as! EditClientViewController
            self.editClientViewController.client = self.client
            self.editClientViewController.delegate = self
        }
    }
    
    // MARK: - EditClientViewControllerDelegate
    
    func editClientViewController(editClientViewController: EditClientViewController, shouldUpdateWithClient client: Client) {
        self.updateData()
    }
}

