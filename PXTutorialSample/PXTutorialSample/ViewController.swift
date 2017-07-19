//
//  ViewController.swift
//  PXTutorialSample
//
//  Created by Malek Belkahla on 19/07/17.
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

import UIKit
import PXTutorial

class ViewController: UIViewController {

    var tutorialConfiguration : PXTutorialConfiguration = PXTutorialConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showTutorial(_ sender: Any) {
        // create tutorial configuration
        self.tutorialConfiguration.contentBundle = Bundle(for: type(of: self))
        
        // set tutorial data source
        let config : PXTutorialJSONDataSource = PXTutorialJSONDataSource.sharedInstance()
        config.parseTutorial("sample-tutorial", with: self.tutorialConfiguration)
        
        // create tutorial view controller
        let tutorialBundle = Bundle(for: PXTutorialJSONDataSource.self)
        let storyboard = UIStoryboard(name: "PXTutorialBoard", bundle: tutorialBundle)
        let tutorialVC : PXTutorialBoardViewController = storyboard.instantiateViewController(withIdentifier: "PXTutorialBoardViewController") as! PXTutorialBoardViewController
        tutorialVC.title = "Sample tutorial"
        tutorialVC.tutorialCloseDelegate = self
        tutorialVC.tutorialDataSource = config
        tutorialVC.configuration = self.tutorialConfiguration
        
        tutorialVC.view.tintColor = UIColor.black
        
        
        self.navigationController?.pushViewController(tutorialVC, animated: true)
        
    }

    @IBAction func backAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}

extension ViewController : PXTutorialCloseDelegate {
    func close() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}

