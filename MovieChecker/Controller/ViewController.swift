//
//  ViewController.swift
//  MovieChecker
//
//  Created by Yatharth Mahawar on 18/08/20.
//  Copyright © 2020 Yatharth Mahawar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,MovieManagerDelegate {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieSearch: UITextField!
    @IBOutlet weak var movieBackground: UIImageView!
    
    var movie = MovieManager()
    let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearch.delegate = self
        movie.delegate = self
        self.setupToHideKeyboardOnTapOnView()
        movieImage.layer.cornerRadius = 35
        movieImage.clipsToBounds = true
        movieImage.layer.borderColor = UIColor.white.cgColor
        movieImage.frame = CGRect(x: 75, y: 462, width: 280, height: 350)
        
        
        
        
        
        
    }
    
    @IBAction func movieSearch(_ sender: UIButton) {
        movie.fetchMovieData(movieName: movieSearch.text!)
        
        
    }
    
    
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }
        else {
            textField.placeholder = "Type Movie Name"
            return false
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        movieSearch.endEditing(true)
        print(movieSearch.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        movie.fetchMovieData(movieName: textField.text!)
        movieSearch.text = ""
    }
    
    
    func dipUpdateMovie(movie: MovieDataModel) {
        DispatchQueue.main.async {
            self.movieTitle.text = movie.movieTitle
            self.movieDescription.text = movie.movieDescription
            self.movieRating.text = "\(movie.movieRating)/10"
            let url = URL(string: movie.moviePoster)
            
            if let data = try? Data(contentsOf: url!) {
                // Create Image and Update Image View
                self.movieImage.image = UIImage(data: data)
                
                let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
                blurredView.frame = self.view.bounds
                self.movieBackground.image = self.movieImage.image
                self.movieBackground.addSubview(blurredView)
                
                
                
                
                
                
                
                
            }
            
            
            
        }
    }
    
    
    
    
}


extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}





