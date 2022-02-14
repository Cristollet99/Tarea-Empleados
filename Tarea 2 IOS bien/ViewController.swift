//
//  ViewController.swift
//  Tarea 2 IOS bien
//
//  Created by Cristobal Lletget Luque on 18/1/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPass: UITextField!
    
    var email:String?
    var password:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //METODO PUT LOGIN
    @IBAction func loginAction(_ sender: UIButton) {
        
        email = loginEmail.text
        password = loginPass.text
        
        if let email = email, let password = password {
            if email != "" && password != "" {
                let userLogin = loginUser(email: email, password: password)
                
                NetworkingProvider.shared.login(user: userLogin) { user, status in
                    
                    
                    if status == 1 {
                        print("Error")
                        self.showToast(message:"Error contraseña o email incorrecto" , font: .systemFont(ofSize: 12.0))
                    } else  {
                        if let user_token = user?.token {
                            UserDefaults.standard.set(user_token, forKey: "token")
                            self.performSegue(withIdentifier: "loginSegue", sender: Any?.self)
                            
                        }
                    }
                } failure: { error in
                    print(error)
                }
            } else {
                loginEmail.attributedPlaceholder = NSAttributedString(string: "*Introduce un email valido*", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                loginPass.attributedPlaceholder = NSAttributedString(string: "*Introduce la contraseña*",attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                
                
                
                
            }
            
            
            
            //                NetworkingProvider.shared.login(user: userLogin) { user in
            //                    print(user?.token)
            //                    UserDefaults.standard.set(user?.token, forKey: "token")
            //                } failure: { error in
            //                    print(error)
            //                }
        }
    }
    
    
    //METODO PUT REGISTRO
    @IBOutlet weak var addUserName: UITextField!
    @IBOutlet weak var addUserEmail: UITextField!
    @IBOutlet weak var addUserPass: UITextField!
    @IBOutlet weak var addUserWorstation: UITextField!
    
    @IBOutlet weak var addUserSalary: UITextField!
    @IBOutlet weak var addUserBiography: UITextField!
    
    
    var name:String?
    var workstation: String?
    var salary: Int?
    var biography: String?
    
    
    @IBAction func addUserAction(_ sender: UIButton) {
        
        name = addUserName.text
        email = addUserEmail.text
        password = addUserPass.text
        workstation = addUserWorstation.text
        salary = Int(addUserSalary.text!)
        biography = addUserBiography.text
        
        
        
        
        if let name = name,let email = email, let password = password, let workstation = workstation, let salary = salary, let biography = biography{
            
            if name != "" || email != "" || password != "" || workstation != "" || biography != ""{
                
                let addUser = AddUser( name: name, email: email, password: password, Workstation: workstation, salary: salary, biography: biography, created_at: nil, updated_at: nil)
                
                let api_token = UserDefaults.standard.string(forKey: "token")
                
                NetworkingProvider.shared.addUser(user: addUser, api_token: api_token!) { user in
                    //                print(user)
                    self.showToast(message: "Usuario Creado", font: .systemFont(ofSize: 12.0))
                    
                } failure: { error in
                    print(error)
                    
                }
                
                
            }
            
        }else{
            //            addUserName.attributedPlaceholder = NSAttributedString(string: "*Introduce un nombre*", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            //            addUserEmail.attributedPlaceholder = NSAttributedString(string: "*Introduce un email*", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            //            addUserPass.attributedPlaceholder = NSAttributedString(string: "*Introduce un contraseña valida*", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            //            addUserWorstation.attributedPlaceholder = NSAttributedString(string: "*Introduce un puesto trabajo*", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            //            addUserSalary.attributedPlaceholder = NSAttributedString(string: "*Introduce un Salario*", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            //            addUserBiography.attributedPlaceholder = NSAttributedString(string: "*Introduce una Biografia*", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            self.showToast(message: "Rellena todos los campos", font: .systemFont(ofSize: 12.0))
        }
        
        
    }
    
    
    
    //Recuperar contraseña POST
    
    @IBOutlet weak var emailRecovery: UITextField!
    
    
    var recoveryEmail : String?
    
    
    @IBAction func recoveryPassAction(_ sender: UIButton) {
        
        recoveryEmail = emailRecovery.text
        
        //        if let email = email, let password = password {
        //                let userLogin = loginUser(email: email, password: password)
        //
        //            NetworkingProvider.shared.login(user: userLogin) { user in
        //                print(user)
        //                UserDefaults.standard.set(user?.token, forKey: "token")
        //            } failure: { error in
        //                print(error)
        //            }
        //
        //
        //        }
        
        if let email = recoveryEmail {
            NetworkingProvider.shared.recoveryPassword(email: email){ user in
                print("Nueva contraseña enviada")
                
            }failure: { error in
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            if ((segue.destination as? ListViewController) != nil) {
                
            }
        }
    }
}

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
