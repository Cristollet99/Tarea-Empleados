//
//  EmployeeDetailViewController.swift
//  Tarea 2 IOS bien
//
//  Created by Cristobal Lletget Luque on 27/1/22.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var nameDetail: UILabel!
    @IBOutlet weak var emailDetail: UILabel!
    @IBOutlet weak var workstationDetail: UILabel!
    @IBOutlet weak var salaryDetail: UILabel!
    @IBOutlet weak var biographyDetail: UILabel!
    
    
    //variables
    var id: Int = 0
    var detailUserName : String? = ""
    var detailUserEmail: String? = ""
    var detailUserWorkstation : String = ""
    var detailUserSalary: String = ""
    var detailUserBiography: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        print(id)
        employeeDetail()
    }
    
    
    func employeeDetail() {
        NetworkingProvider.shared.employeeDetail(id: id) { data, status in
            print(data)
            if let detailName = data?.name , let detailEmail = data?.email , let detailWork = data?.workstation , let detailSalary = data?.salary, let detailBio = data?.biography{
                self.nameDetail.text = detailName
                self.emailDetail.text = detailEmail
                self.workstationDetail.text = detailWork
                self.salaryDetail.text = String(detailSalary)
                self.biographyDetail.text = detailBio
            }
            
        } failure: { error in
            print(error)
        }
    }
}

