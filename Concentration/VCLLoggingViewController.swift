//
//  VCLLoggingViewController.swift
//  Concentration
//
//  Created by Bogdan Mishura on 9/4/19.
//  Copyright © 2019 Bogdan Mishura. All rights reserved.
//

import UIKit

class VCLLoggingViewController: UIViewController {

   

    deinit {
        print("left the heap")
    }
    
    override func awakeFromNib() {
        print("awakeFromNib()")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad()")
        print(vclLoggingName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear(_ animated: \(animated)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear(_ animated: \(animated)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear(_ animated: \(animated)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear(_ animated: \(animated)")
    }
    
    override func didReceiveMemoryWarning() {
        print("didReceiveMemoryWarning()")
    }
    
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
    var vclLoggingName: String {
        return String(describing: type(of: self))
    }
    
}
