
import Foundation
import RealmSwift

class Event: Object {

    @objc dynamic var date: String = ""
    @objc dynamic var event: String = ""

   
    
}

class Arm: Object {
    
    @objc dynamic var arm: Int = 1
    @objc dynamic var chest: Int = 1
     @objc dynamic var shoulder: Int = 1
    @objc dynamic var back: Int = 1
    @objc dynamic var belly: Int = 1
    @objc dynamic var foot: Int = 1
    @objc dynamic var other: Int = 1
    @objc dynamic var total: Int = 1
    
}
