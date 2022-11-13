//
//  ExplanationViewController.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 12/11/22.
//

import UIKit

final class ExplanationViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    
    var explanationText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainLabel.text = explanationText
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
