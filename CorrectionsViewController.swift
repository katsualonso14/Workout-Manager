

import UIKit
import RealmSwift

class CorrectionsViewController: UIViewController {

    var event: Event!
    var textViewString = ""
    

    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var memoTextView: UITextView!
    @IBAction func doneButton(_ sender: Any) {
        
//        let storyboard: UIStoryboard = self.storyboard!
//        let calendar = storyboard.instantiateViewController(withIdentifier: "calendar") as! CalendarViewController

        textViewString = memoTextView.text!
        
       let realm = try! Realm()
       try! realm.write {
        event.event = textViewString
//        　　 アップデートする処理
            realm.add(event)
    }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.layer.borderColor = UIColor.gray.cgColor
        memoTextView.layer.borderWidth = 1.0
        memoTextView.layer.cornerRadius = 10.0
   memoTextView.text! = "\(event.event)"
        
   
    
        doneButton.layer.cornerRadius = 10.0
        
           }
    
}
