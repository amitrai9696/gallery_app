import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class galleryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel = GalleryViewModel()
      
      override func viewDidLoad() {
          super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        setupCollectionView()
          viewModel.reloadCollectionView = { [weak self] in
              DispatchQueue.main.async {
                  self?.collectionView.reloadData()
              }
          }
          viewModel.fetchImages()
        
      }
   

    @IBAction func logoutbutton(_ sender: Any) {
        signOut()
        }
        
        private func signOut() {
        
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
            
           
            GIDSignIn.sharedInstance.signOut()
            
            navigationController?.popViewController(animated: true)
            
        }
        
       
    private func setupCollectionView() {
          collectionView.dataSource = self
          collectionView.delegate = self
          collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
      }
  }

  extension galleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return viewModel.images.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCell
          let imageModel = viewModel.images[indexPath.row]
          cell.configure(with: imageModel)
          return cell
      }

    
  }
