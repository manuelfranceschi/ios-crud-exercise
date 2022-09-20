import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var downloadImage: UIButton!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = ""
        emailLabel.text = ""
        idLabel.text = ""
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
    }
    
    @IBAction func getUserAction(_ sender: Any) {
        
        activityIndicator.startAnimating()
        
        NetworkingProvider.shared.getUser(id: 2975) { (user) in
            
            self.activityIndicator.stopAnimating()
            
            self.setup(user: user)
            
        } failure: { error in
            
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
            
        }
    }
    
    @IBAction func postUserAction(_ sender: Any) {
        
        let newUser = NewUser(name: "manl23", email: "mana123l@test.com", gender: "Male", status: "Active")
        
        activityIndicator.startAnimating()
        
        NetworkingProvider.shared.addUser(user: newUser) { (user) in
            
            self.activityIndicator.stopAnimating()
            
            self.setup(user: user)
            
        } failure: { error in
            
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
            
        }
    }
    
    @IBAction func putUserAction(_ sender: Any) {
        
        let newUser = NewUser(name: "change", email: nil, gender: nil, status: nil)
        
        activityIndicator.startAnimating()
        
        NetworkingProvider.shared.updateUser(id: 2975, user: newUser) { (user) in
            
            self.activityIndicator.stopAnimating()
            
            self.setup(user: user)
            
        } failure: { error in
            
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
            
        }
    }
    
    @IBAction func deleteUserAction(_ sender: Any) {
        
        let id = 2975
        
        activityIndicator.startAnimating()
        
        NetworkingProvider.shared.deleteUser(id: id) {
            
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = "Se ha borrado el usuario con id: \(id)"
            self.emailLabel.text = ""
            self.idLabel.text = ""
        } failure: { error in
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
        }
    }
    
    
    @IBAction func dowloandImageAction(_ sender: Any) {
        downloadImage.isHidden = true
        logoImageView.kf.setImage(with: URL(string: "https://www.apple.com/v/swift/c/images/overview/icon_swift_hero_large.png"))
    }
    
    private func setup(user: User) {
        
        nameLabel.text = user.name
        emailLabel.text = user.email
        idLabel.text = user.id?.description
        
    }
    
}
