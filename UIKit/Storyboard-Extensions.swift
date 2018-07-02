import UIKit

extension UIStoryboard {
    
    static func instantiateViewController(withIdentifier:String, fromStoryboard:String = "Main") -> UIViewController? {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: fromStoryboard, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: withIdentifier)
    }
}