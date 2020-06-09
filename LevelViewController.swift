

import UIKit
import RealmSwift

class LevelViewController: UIViewController,UITabBarDelegate {

    
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var armScore: UILabel!
    @IBOutlet weak var chestScore: UILabel!
    @IBOutlet weak var shoulderScore: UILabel!
    @IBOutlet weak var backScore: UILabel!
    @IBOutlet weak var bellyScore: UILabel!
    @IBOutlet weak var footScore: UILabel!
    @IBOutlet weak var otherScore: UILabel!
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        let arms = realm.objects(Arm.self)
        let a: Int! = arms.last?.arm
        let c: Int! = arms.last?.chest
        let s: Int!  = arms.last?.shoulder
        let ba: Int!  = arms.last?.back
        let be: Int!  = arms.last?.belly
        let f: Int!  = arms.last?.foot
        let o: Int! = arms.last?.other
        var t = arms.last?.total
        
        let Total1 = (a + c)
        let Total2 = (s + ba)
        let Total3 = (be + f)
        let Total = (Total1 + Total2 + Total3 + o) / 5
        
        
        try! realm.write() {
            t = Total
        }
        
        totalScore.text = "総合レベル　　 Lv" + "\(t ?? 1)"
        
        print(Total)
        print(t ?? 1)
        armScore.text = "腕レベル　　  Lv" + "\(a ?? 1)"
        
        print(a ?? 1)
        
        chestScore.text = "胸レベル　　  Lv" + "\(c ?? 1)"
        
        
        shoulderScore.text = "肩レベル　　  Lv" + "\(s ?? 1)"
        print(s ?? 1)
        
        backScore.text = "背中レベル　 Lv" + "\(ba ?? 1)"
        print(ba ?? 1)
        
        bellyScore.text = "腹レベル　　  Lv" + "\(be ?? 1)"
        print(be ?? 1)
        
        footScore.text = "足レベル　　  Lv" + "\(f ?? 1)"
        print(f ?? 1)
        
        otherScore.text = "その他レベル Lv" + "\(o ?? 1)"
        print(o ?? 1)
        

    }
   
    

}
