//
//  ViewController.swift
//  mvvm-example
//
//  Created by COUDSI Julien on 12/06/2017.
//  Copyright © 2017 Blop. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ClientCardViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var completeNameLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    var editClientViewController:EditClientViewController!
    var clientViewModel:ClientViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clientViewModel = ClientViewModel(api: FakeAPI.sharedInstance)
        
        self.clientViewModel?.completeNameText.asObservable().bind(to: self.completeNameLabel.rx.text).addDisposableTo(self.disposeBag)
        self.clientViewModel?.birthdateText.asObservable().bind(to: self.birthdateLabel.rx.text).addDisposableTo(self.disposeBag)
        self.clientViewModel?.jobText.asObservable().bind(to: self.jobLabel.rx.text).addDisposableTo(self.disposeBag)
        
        if let photoURL = self.clientViewModel?.photoURL {
            
            URLSession.shared.rx.data(request: URLRequest(url: photoURL))
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] data in
                    
                    self?.photoImageView.image = UIImage(data: data)
                    
                }).addDisposableTo(self.disposeBag)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "navigationSegue" {
            self.editClientViewController = segue.destination as! EditClientViewController
            self.editClientViewController.clientViewModel = self.clientViewModel
        }
    }
    
}

