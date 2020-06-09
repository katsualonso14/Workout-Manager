

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift



class CalendarViewController: UIViewController,FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance {

    var calendarDay: String!
    var calendarWOMenu: String!
    var touchEvent: Event!
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.calendar.dataSource = self
        self.calendar.delegate = self
        
    }
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()

    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)

        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)

        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        
        return (year,month,day)
    }

    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }

    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if self.judgeHoliday(date){
            return UIColor.red
        }

        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }

        return nil
    }
    
//日付が選択されたとき
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        //予定がある場合、スケジュールをDBから取得・表示する。
        //無い場合、「スケジュールはありません」と表示。
        menuLabel.text = "スケジュールはありません"
               menuLabel.textColor = .lightGray
               
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let da = formatter.string(from: date)
        dateLabel.text = da
               
//        スケジュール取得
                       let realm = try! Realm()
                       var result = realm.objects(Event.self)
                result = result.filter("date = '\(da)'")
        

        for ev in result {
                   if ev.date == da {
                    menuLabel.text = ev.event
                    touchEvent = ev
                }
        }

}
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calendar.reloadData()
    }
//    イベントマーク
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int{
                      let formatter = DateFormatter()
                      formatter.dateFormat = "yyyy/MM/dd"
                      let da = formatter.string(from: date)
        
                      let realm = try! Realm()
                      var result = realm.objects(Event.self)

                      result = result.filter("date = '\(da)'")
    
                      for ev in result {
                          if ev.date == da {
                return 1
                       }
                }
//        print(date)
        return 0
    }
    
    
    private func startAndEndOfDay(_ date:Date) -> (start: Date , end: Date) {
        let start = Calendar(identifier: .gregorian).startOfDay(for: date)
        let end = start + 24*60*60
        return (start, end)
    }
    
    //ラベルがタップされると変更できるように
    @IBAction func tapLabel(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
           let fourth = storyboard.instantiateViewController(withIdentifier: "fourth") as! CorrectionsViewController
        
    
        
        fourth.event = touchEvent
        
           self.present(fourth, animated: true, completion: nil)
    }
    
  
    
}
