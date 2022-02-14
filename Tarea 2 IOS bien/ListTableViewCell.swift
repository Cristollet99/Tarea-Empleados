//
//  ListTableViewCell.swift
//  Tarea 2 IOS bien
//
//  Created by Cristobal Lletget Luque on 25/1/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeWorkstation: UILabel!
    @IBOutlet weak var employeeSalary: UILabel!
    
    func setCellWithValueOf(_ employee: User){
        updateUI(employeeName: employee.name, employeeWorkstation: employee.workstation, salary: employee.salary)
    }
    
    private func updateUI(employeeName: String?, employeeWorkstation: String?, salary: Int?){
        self.employeeName.text = employeeName
        self.employeeWorkstation.text = employeeWorkstation
        if let salary = salary {
            self.employeeSalary.text = String(salary)
            
        }
    }
}
