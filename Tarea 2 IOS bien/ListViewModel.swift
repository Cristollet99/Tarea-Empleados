//
//  ListViewModel.swift
//  Tarea 2 IOS bien
//
//  Created by Cristobal Lletget Luque on 26/1/22.
//

import Foundation
import Alamofire

class EmployeeViewModel{
    
    
    private var employeeList = [User]()
    
        func fetchEmployeeList(completion: @escaping () -> ()){
            
            let api_token = UserDefaults.standard.string(forKey: "token")
            
            NetworkingProvider.shared.employeeList { data, status in
                if let responseList = data{
                    self.employeeList = responseList
                    //self.employeeList = responseList
                    completion()
                }
            } failure: { error in
                print(error)
                
            }

        }
    
    
    func numberOfRowsInSection(section: Int) -> Int{
        
        if employeeList.count != 0{
            return employeeList.count
        }
        return 0
    }
    
    
    
    func cellForRowAt(indexPath: IndexPath) -> User{
        return employeeList[indexPath.row]
    }
    
        
    }

