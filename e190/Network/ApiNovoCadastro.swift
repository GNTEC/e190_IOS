//
//  ApiNovoCadastro.swift
//  e190
//
//  Created by Marcelo Pavani on 21/06/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AZSClient

class ApiNovoCadastro {
    
    //https://viacep.com.br/ws/09531000/json/
    var objEndereco: NSDictionary = [:]
    
    func buscaEnderecoPorCep (cep: String, completionHandler:@escaping (NSDictionary)-> Void)
    {
        let urlapi = "https://viacep.com.br/ws/"
        let url = urlapi + cep + "/json/"
    
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 200:
                    guard let Result = response.result.value as? NSDictionary  else {break}
                    self.objEndereco = Result

                default:
                    break
                }
            }
            DispatchQueue.main.async(execute: {
                completionHandler(self.objEndereco)
            })
        }
    }
    
    func criaLogin(login: NSDictionary, completionHandler:@escaping (_ result: NSDictionary) ->Void) {
        
        //@POST("api/login/novologin") Call NovoLogin(@Body tb_login login);
        
        let urlString = "http://sekron.azurewebsites.net/api/login/novologin"
        var objLogin: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:(login as! [String : AnyObject]), encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 200:
                    
                    let Result = response.result.value
                    objLogin = (Result as? NSDictionary)!
                    print(objLogin)
                    
                    break
                    
                default:
                    
                    if let result = response.result.value {
                        print(result)
                    }
                    break
                }
                
                DispatchQueue.main.async(execute: {
                    completionHandler(objLogin)
                })
            }
        }
    }
    
    func criaUsuario(parametros: NSDictionary, compeletionHandler:@escaping (_ result: NSDictionary)-> Void) {
        
        //        @POST("api/usuario/novousuario"
        //        Call<tb_usuario> NovoUsuario(@Body tb_usuario usuario);
        
        let urlString = "http://sekron.azurewebsites.net/api/usuario/novousuario"
        var objUser: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:(parametros as! [String : AnyObject]), encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 200:
                    
                    let Result = response.result.value
                    objUser = (Result as? NSDictionary)!
                    print(objUser)
                    
                    break
                    
                default:
                    
                    if let result = response.result.value {
                        print(result)
                    }
                    break
                }
                
                DispatchQueue.main.async(execute: {
                    compeletionHandler(objUser)
                })
            }
        }
    }
    
//    @POST("api/usuario/atualizarusuario")
//    Call<tb_usuario> AtualizarUsuario(@Body tb_usuario usuario);
    func AtualizarUsuario(parametros: NSDictionary, completionHeadler:@escaping (_ result: NSDictionary) -> Void){
        
        let urlString = "http://sekron.azurewebsites.net/api/usuario/atualizarusuario"
        var objEmedica: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:(parametros as! [String: AnyObject]), encoding: JSONEncoding.default, headers: nil).responseJSON{
            
            response in
            
            if let status = response.response?.statusCode{
                
                
                switch(status){
                case 200:
                    
                    let Result = response.value
                    objEmedica = (Result as? NSDictionary)!
                    print(objEmedica)
                    break
                    
                default:
                    
                    if let result = response.result.value{
                        print(result)
                    }
                    break
                    
                }
                
                DispatchQueue.main.async {
                    completionHeadler(objEmedica)
                }
            }
        }
    }
    
//    func BuscarUsuario(codUsuario: Int, completionHandler: ((NSDictionary) -> ())?){
//        
//        //    @POST("api/usuario/listarusuarioid/{id}")
//        //    Call<tb_usuario> ListarUsuario(@Path("id") long codUsuario);
//        
//        let urlString = "http://sekron.azurewebsites.net/api/usuario/ListarUsuarioId?codUsuario=\(codUsuario)"
//        var objEmedica: NSDictionary = [:]
//        
//        Alamofire.request(urlString, method: .post, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseJSON{
//            
//            response in
//            
//            if let status = response.response?.statusCode{
//                
//                switch(status){
//                case 200:
//                    
//                    let Result = response.value
//                    objEmedica = (Result as? NSDictionary)!
//                    print(objEmedica)
//                    break
//                    
//                default:
//                    
//                    if let result = response.result.value{
//                        print(result)
//                    }
//                    break
//                    
//                }
//                DispatchQueue.main.async(execute: {
//                    completionHandler?(objEmedica)
//                })
//            }
//            
//        }
//    }
    //Upload to Azure Blob Storage with help of SAS
    func uploadBlobSAS(container: String, sas: String, blockname: String, fromfile: String ){
        
        // If using a SAS token, fill it in here.  If using Shared Key access, comment out the following line.
        let containerURL = "https://yourblobstorage.blob.core.windows.net/\(container)\(sas)"  //here we have to append sas string: + sas
        print("containerURL with SAS: \(containerURL) ")
        var container : AZSCloudBlobContainer
        var error: NSError?
        
        container = AZSCloudBlobContainer(url: NSURL(string: containerURL)! as URL, error: &error)
        if ((error) != nil) {
            print("Error in creating blob container object.  Error code = %ld, error domain = %@, error userinfo = %@", error!.code, error!.domain, error!.userInfo);
        }
        else {
            
            let blob = container.blockBlobReference(fromName: blockname)
            blob.uploadFromFile(withPath: fromfile, completionHandler: {(NSError) -> Void in
                NSLog("Ok, uploaded !")
            })
        }
        
    }
    
    func uploloadImgToAzure(img: UIImage, imgName:String, pathImg: String){
        
        // MARK: Authentication
        
        let conectionStringAzure = "DefaultEndpointsProtocol=https;AccountName=pettediag173;AccountKey=tTwgi2UTEyvnW/hMF1LBDwMYLZX9OKAaA9VDtF/3TvqyLJds+4dYd7Y0n9lj6+Ep4wMFcVWc5k9R7BaWLgA0+w==;EndpointSuffix=core.windows.net"
        
        let storageAccount : AZSCloudStorageAccount;
        try! storageAccount = AZSCloudStorageAccount(fromConnectionString: conectionStringAzure)
        
        let blobClient = storageAccount.getBlobClient()
        
        let container : AZSCloudBlobContainer = (blobClient.containerReference(fromName: "sekronprofile" ))
        
        //modelName = UIDevice.current.modelName
        _ = Date().timeIntervalSince1970 * 1000
        //let imageName: String = pathImg
        
        let blob: AZSCloudBlockBlob = container.blockBlobReference(fromName: imgName)
        let imageData = UIImagePNGRepresentation(img)
        
        blob.upload(from: imageData!, completionHandler:{(NSError) -> Void in
            print((NSError))
        })
    }
}
