//
//  WithStroyboardViewController.swift
//  CreditCardForm
//
//  Created by Atakishiyev Orazdurdy on 11/29/16.
//  Copyright © 2016 Veriloft. All rights reserved.
//

import UIKit

class WithStroyboardViewController: UIViewController {
    @IBOutlet weak var creditCardForm: CreditCardForumView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func flip(_ sender: Any) {
        creditCardForm.flip()
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
