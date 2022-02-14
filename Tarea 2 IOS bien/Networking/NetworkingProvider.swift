//
//  NetworkingProvider.swift
//  Tarea 2 IOS bien
//
//  Created by Cristobal Lletget Luque on 19/1/22.
//

import Foundation
import UIKit
import Alamofire

final class NetworkingProvider{
    static let shared = NetworkingProvider()
    private let BaseUrl = "http://localhost/tarea2/public/api/"
    
    private let statusOK = 200...299
    
    //private let Ktoken = "48890d9c811ea67816fcf243419100b2cd581e91e4b6c2f90a7263ea5ca48b1a"
    
    
    //METODO Login
    func login(user: loginUser, success: @escaping (_ user: User?, _ status: Int?) -> (), failure: @escaping (_ error:Error?) -> ())
    {
        let url = "http://localhost/tarea2/public/api/login"
        
        //let headers: HTTPHeaders = [.authorization(bearerToken: Ktoken)]
        
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: statusOK).responseDecodable(of: Response.self) {
            response in
            
            if let data = response.value?.data, let status = response.value?.status{
                success(data, status)
            }
            
            if let error = response.error {
                failure(error)
            }
        }
        
    }
    
    //Registro Put
    func addUser(user: AddUser, api_token: String, success: @escaping (_ msg: User?) -> (), failure: @escaping (_ error:Error?) -> ())
    {
        let url = "http://localhost/tarea2/public/api/create?api_token=\(api_token)"
        
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: statusOK).responseDecodable(of: Response.self) {
            response in
            
            if let data = response.value?.data {
                success(data)
            }
            
            if let error = response.error {
                failure(error)
            }
        }
    }
    
    // Recuperar contraseña POST
    
    func recoveryPassword(email: String, success: @escaping (_ user: User?) -> (), failure: @escaping (_ error:Error?) -> ())
    {
        let url = "http://localhost/tarea2/public/api/password?email=\(email)"
        
        //let headers: HTTPHeaders = [.authorization(bearerToken: Ktoken)]
        
        AF.request(url, method: .post).validate(statusCode: statusOK).responseDecodable(of: Response.self) {
            response in
            
            if let data = response.value?.data{
                success(data)
            }
            
            if let error = response.error {
                failure(error)
            }
        }
        
    }
    
    //Listar empleados metodo get
    
    func employeeList(success: @escaping (_ data: [User]?, _ status: Int?)->(), failure: @escaping (_ error:Error?) ->()){
        
        let api_token = UserDefaults.standard.string(forKey: "token")
        let url = "http://localhost/tarea2/public/api/list?api_token=\(api_token!)"
        
        AF.request(url, method: .get) .validate(statusCode: statusOK).responseDecodable(of:ListResponse.self){
            response in
            
            if let data = response.value?.data, let statusCode = response.value?.status{
                success(data, statusCode)
            }
            
            if let error = response.error{
                failure(error)
            }
        }
    }
    
    
    func employeeDetail(id: Int, success: @escaping (_ data: User?, _ status: Int?) -> (), failure: @escaping (_ error:Error?) ->()){
        
        let api_token = UserDefaults.standard.string(forKey: "token")
        let url = "http://localhost/tarea2/public/api/detail?api_token=\(api_token!)&id=\(id)"
        
        AF.request(url, method: .get).validate(statusCode: statusOK).responseDecodable(of: Response.self, decoder: DateDecoder()) {
            response in
            
            if let data = response.value?.data, let statusCode = response.value?.status {
                success(data, statusCode)
            }
            
            if let error = response.error {
                failure(error)
            }
        }
    }
    
    
    func employeeProfile(success: @escaping (_ data: User?, _ status: Int?) -> (), failure: @escaping (_ error:Error?) ->()){
     
        
        let api_token = UserDefaults.standard.string(forKey: "token")
        let url = "http://localhost/tarea2/public/api/profile?api_token=\(api_token!)"
                
      
        AF.request(url, method: .get).validate(statusCode: statusOK).responseDecodable(of: Response.self, decoder: DateDecoder()) {
            response in

            if let data = response.value?.data, let statusCode = response.value?.status {
                success(data, statusCode)
            }

            if let error = response.error {
                failure(error)
            }
        }
    }
}
