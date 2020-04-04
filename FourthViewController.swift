//
//  FourthViewController.swift
//  WorkOutApp
//
//  Created by 玉井　勝也 on 2020/03/10.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit
import RealmSwift

class FourthViewController: UIViewController {

    var event: Event!
    var textViewString = ""
    

    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var memoTextView: UITextView!
    @IBAction func doneButton(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
           let calendar = storyboard.instantiateViewController(withIdentifier: "calendar") as! CalendarViewController
        
        textViewString = memoTextView.text!
        
       let realm = try! Realm()
       try! realm.write {
        event.event = textViewString
//        　　 アップデートする処理
            realm.add(event)
       }
        print(event ?? "error")
       
           self.present(calendar, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.layer.borderColor = UIColor.gray.cgColor
              memoTextView.layer.borderWidth = 1.0
              memoTextView.layer.cornerRadius = 10.0
        
        doneButton.layer.cornerRadius = 10.0
        
           }
    
}
