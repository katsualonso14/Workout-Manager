

import UIKit
import RealmSwift

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource,UIScrollViewDelegate {
    
    let workOutMenu = ["腕","胸","肩","背中","腹","足","その他"]
    var picker: String!
    var workOutDay:String!
    var Text: String!
//    let sc = UIScrollView();

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//    Picker View の列を１にする
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workOutMenu.count
    }
//    Picker View の行数は配列数にする
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return workOutMenu[row]
    }
//    表示する文字列を指定する
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker = workOutMenu[row]
    }
//    表示する
    
    
    @IBOutlet weak var workOutPickerView:
    UIPickerView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var WOText: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func doneButton(_ sender: Any) {
        
        //datePickerで指定した日付が表示される
        workOutDay = "\(self.format(date: datePicker.date))"
        
        let realm = try! Realm()
        //        Eventsの追加
        try! realm.write {
        //日付表示の内容とスケジュール入力の内容が書き込まれる。
            let Events = [Event(value: ["date": workOutDay, "event": picker + "　" + WOText.text])]
            realm.add(Events)
            
            print(Events)
        }
        
        
//        Armの全体を呼ぶ
        let armAll = realm.objects(Arm.self)
        
//        Armのarmで最後に追加したものを更新する
//        pickerの値が「腕」で　realmに初保存なら　１足す
        try! realm.write(){
            if  picker ?? "腕" == workOutMenu[0] {
                
                armAll.last?.arm += 1
            }
        }
  
        try! realm.write(){

            if picker == workOutMenu[1] {

                armAll.last?.chest += 1
            }
        }
        
       
     try! realm.write(){

                if picker == workOutMenu[2] {

                    armAll.last?.shoulder += 1
                }
            }
            
       try! realm.write(){

              if picker == workOutMenu[3] {

                armAll.last?.back += 1
              }
          }
          
        try! realm.write(){

               if picker == workOutMenu[4] {

                   armAll.last?.belly += 1
               }
           }
           
        try! realm.write(){

               if picker == workOutMenu[5] {

                   armAll.last?.foot += 1
               }
           }
           
        try! realm.write(){

               if picker == workOutMenu[6] {

                   armAll.last?.other += 1
               }
           }
           
        
        
        print(armAll.last?.arm ?? "nil")
        print(armAll.last?.chest ?? "nil")
        print(armAll.last?.shoulder ?? "nil")
        print(armAll.last?.belly ?? "nil")
        print(armAll.last?.back ?? "nil")
        print(armAll.last?.foot ?? "nil")
        print(armAll.last?.other ?? "nil")
        print(armAll.last?.total ?? "nil")
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //tabbarでの遷移
        let UINavigationController = tabBarController?.viewControllers?[1];
        tabBarController?.selectedViewController = UINavigationController;

    }

//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//
//        return true
//    }
    
    
    override func viewDidLoad() {
                super.viewDidLoad()
        
        //        ピッカービューのデリゲートの設定
               workOutPickerView.delegate = self
               workOutPickerView.dataSource = self
//Realmに保存する際、pickerのドラムロールが選択されてない時　”腕”とする
        picker = "腕"
    
        
        WOText.text = ""
        WOText.layer.borderColor = UIColor.gray.cgColor
        WOText.layer.borderWidth = 1.0
        WOText.layer.cornerRadius = 10.0
//        view.addSubview(WOText)
        
        doneButton.layer.cornerRadius = 10.0

        
        let defaults = UserDefaults.standard
//        初回起動時のみ　armsを追加
        if defaults.bool(forKey: "firstLaunch") {
            

             let realm = try! Realm()
             let arms = Arm()
             
             arms.arm = 1
             arms.chest = 1
             arms.shoulder = 1
             arms.back = 1
             arms.belly = 1
             arms.foot = 1
             arms.other = 1
             arms.total = 1
             
            try! realm.write(){
             realm.add(arms)
             }
//            2回目以降はキーをfalseに
            defaults.set(false, forKey: "firstLaunch")
        }
        
    }

    
       func format(date:Date)->String{
              
              let dateformatter = DateFormatter()
              dateformatter.dateFormat = "yyyy/MM/dd"
              let strDate = dateformatter.string(from: date)
              
              return strDate
    }
   
    
}

