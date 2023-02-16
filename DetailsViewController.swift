

import UIKit
import CoreData


class DetailsViewController: UIViewController {
    
    //var
    var movieName:String?
    
    
    
    
    //Widgets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    
    
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //OnStart
        movieImageView.image = UIImage(named: movieName!)
        movieNameLabel.text = movieName!

}
    
    
    
    //IBActions
    @IBAction func saveFavoritesAction(_ sender: Any) {
        

        
        if getByCreateria(movieName: movieName!) {
            
            let alert = UIAlertController(title: "BoxOffice", message: "Movie already exists.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Got it!", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
            
        }else {
            
            save()
            let alert = UIAlertController(title: "BoxOffice", message: "Movie saved successfully. ", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
                
    }
    
    
    //FUNCTIONS
    
    func save() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        object.setValue(movieName!, forKey: "movieName")
        
        do {
            
            try managedContext.save()
            print("Movie saved successfully !")
            
        } catch {
            
            print("Movie insert error !")
        }
    }
    
    
    func getByCreateria(movieName: String) -> Bool{
        
        var movieExist = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let predicate = NSPredicate(format: "movieName = %@", movieName)
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                
                movieExist = true
                print("Movie exists !")
                
            }
            
        } catch {
            
            print("Fetching by criteria error !")
        }
        
        
        return movieExist
    }
    
    
    
    


}
