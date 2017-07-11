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
    
    
    func criaUsuario(usuario: NSDictionary, compeletionHandler:@escaping (_ result: NSDictionary)-> Void) {
        
        //        @POST("api/usuario/novousuario"
        //        Call<tb_usuario> NovoUsuario(@Body tb_usuario usuario);
        
        let urlString = "http://sekron.azurewebsites.net/api/usuario/novousuario"
        var objUser: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:(usuario as! [String : AnyObject]), encoding: JSONEncoding.default, headers: nil).responseJSON {
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
        
        // If using a SAS token, fill it in here.  If using Shared Key access, comment out the following line.
        let containerURL = "https://myaccount.blob.core.windows.net/mysampleioscontainer?sv=2015-02-21&st=2009-01-01&se=2100-01-01&sr=c&sp=rwdl&sig=mylongsig="
        let usingSAS = true
        
        // If using Shared Key access, fill in your credentials here and un-comment the "UsingSAS" line:
        let connectionString = "DefaultEndpointsProtocol=https;AccountName=myaccount;AccountKey=myAccountKey=="
        let containerName = "sekronprofile"
        // var usingSAS = false
        
        // MARK: Properties
        
        var blobs = [AZSCloudBlob]()
        var container : AZSCloudBlobContainer
        var continuationToken : AZSContinuationToken?
        
        
        // MARK: Initializers
        
        //required init?(coder aDecoder: NSCoder) {
            if (usingSAS) {
                var error: NSError?
                container = AZSCloudBlobContainer(url: URL(string: conectionStringAzure)!, error: &error)
                if ((error) != nil) {
                    print("Error in creating blob container object.  Error code = %ld, error domain = %@, error userinfo = %@", error!.code, error!.domain, error!.userInfo);
                }
            }
            else {
                //            do {
                let storageAccount : AZSCloudStorageAccount;
                try! storageAccount = AZSCloudStorageAccount(fromConnectionString: connectionString)
                let blobClient = storageAccount.getBlobClient()
                container = blobClient.containerReference(fromName: containerName)
                
                let condition = NSCondition()
                var containerCreated = false
                
                container.createContainerIfNotExists { (error : Error?, created) -> Void in
                    condition.lock()
                    containerCreated = true
                    condition.signal()
                    condition.unlock()
                }
                
                condition.lock()
                while (!containerCreated) {
                    condition.wait()
                }
                condition.unlock()
                //            } catch let error as NSError {
                //                print("Error in creating blob container object.  Error code = %ld, error domain = %@, error userinfo = %@", error.code, error.domain, error.userInfo);
                //            }
            }
            
            continuationToken = nil
            
            //super.init(coder: aDecoder)
        
////        let conectionStringAzure = "https://pettediag173.file.core.windows.net/?sv=2016-05-31&ss=bfqt&srt=sco&sp=rwdlacup&se=2017-06-24T00:20:50Z&st=2017-06-23T16:20:50Z&spr=https&sig=QtZwEs3TC647Si2RvwawgKgciMADsdWV8LkM8Oqarqc%3D"
//        
//        let account:AZSCloudStorageAccount
//        try! account = AZSCloudStorageAccount(fromConnectionString:conectionStringAzure) //I stored the property in my header file
//        let blobClient: AZSCloudBlobClient = account.getBlobClient()
//        let blobContainer: AZSCloudBlobContainer = blobClient.containerReference(fromName: "sekronprofile")
//
//        let blob: AZSCloudBlockBlob = blobContainer.blockBlobReference(fromName: imgName) //If you want a random name, I used let imageName = CFUUIDCreateString(nil, CFUUIDCreate(nil))
//        let imageData = UIImagePNGRepresentation(img)
//        
//        blob.upload(from: imageData!, completionHandler: {(NSError) -> Void in
//
//        })
        
        
//        let storageAccount : AZSCloudStorageAccount;
//        try! storageAccount = AZSCloudStorageAccount(fromConnectionString: conectionStringAzure)
//        
//        let blobClient = storageAccount.getBlobClient()
//        
//        let container : AZSCloudBlobContainer = (blobClient.containerReference(fromName: "sekronprofile" ))
//        
//        //modelName = UIDevice.current.modelName
//        _ = Date().timeIntervalSince1970 * 1000
//        //let imageName: String = pathImg
//        
//        let blob: AZSCloudBlockBlob = container.blockBlobReference(fromName: imgName)
//        let imageData = UIImagePNGRepresentation(img)
//        
//        blob.upload(from: imageData!, completionHandler:{(NSError) -> Void in
//            
//        })
    }
}
