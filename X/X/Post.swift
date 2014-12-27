import Foundation

class Post : PFObject, PFSubclassing {
    
    @NSManaged var college: College
    @NSManaged var user: User
    @NSManaged var content: String
    @NSManaged var life: Int
    @NSManaged var likes: Int
    
    override class func load() {
        self.registerSubclass()
    }
    
    class func initWith(content: String) -> Post {
        let post = Post()
        post.user = User.currentUser()
        post.college = User.currentUser().college
        post.life = 24
        post.content = content
        post.likes = 0
        return post
    }
    
    func getReplies(callback: ([Reply]!, NSError!) -> Void) -> Void {
        let q = Reply.query()
        
        q.whereKey("post", equalTo: self)
        q.orderByAscending("createdAt")
        
        q.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            callback(results as? [Reply], error)
        }
    }
    
    class func parseClassName() -> String! {
        return "Post"
    }
    
    func getTTL() -> Int {
        return 1
    }
    
    func getDateStr() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd"
        
        let calendar = NSCalendar.currentCalendar()
        let start = calendar.ordinalityOfUnit(NSCalendarUnit.DayCalendarUnit, inUnit: NSCalendarUnit.EraCalendarUnit, forDate: self.createdAt)
        let end = calendar.ordinalityOfUnit(NSCalendarUnit.DayCalendarUnit, inUnit: NSCalendarUnit.EraCalendarUnit, forDate: NSDate())
        let diff = end - start
        
        switch diff {
        case 0:
            return "Today"
        case 1:
            return "Yesterday"
        default:
            return formatter.stringFromDate(self.createdAt)
        }
    }
}