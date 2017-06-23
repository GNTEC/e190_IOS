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
import AlamofireObjectMapper
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
                case 400:
                    self.objEndereco = [:]
                default:
                    
                    let Result = response.result.value
                    self.objEndereco = (Result as? NSDictionary)!
                    
                    if let msgErro = self.objEndereco.object(forKey: "erro"){
                        
                        self.objEndereco = [:]
                    }
                        
                    break
                }
            }
            DispatchQueue.main.async(execute: {
                completionHandler(self.objEndereco)
            })
        }
    }
    
    func inclui(usuario: Array<Any>, compeletionHandler:@escaping (Bool)-> Void) {
        
        let urlString = "http://sekron.azurewebsites.net/api/usuario/novousuario"
        
        
//        @POST("api/usuario/novousuario")
//        Call<tb_usuario> NovoUsuario(@Body tb_usuario usuario);
        
//        private long codUsuario;
//        private long codLogin;
//        private String nome;
//        private String dataNascimento;
//        private String cpf;
//        private String rg;
//        private String celular;
//        private String telefone;
//        private String sexo;
//        private String cep;
//        private String rua;
//        private String complemento;
//        private String numero;
//        private String cidade;
//        private String estado;
//        private boolean ativo;
//        private String voluntario;
//        private String dataCadastro;
//        private boolean pago;
//        private String fotoPerfil;
//        private String uidFirebase;
//        private boolean notificacaoAmarela;
//        private boolean notificacaoLaranja;
//        private boolean notificacaoVermelha;
//        private String enderecoCasa;
//        private String enderecoTrabalho;
//        
//        private String carroMarca;
//        private String carroModelo;
//        private String carroPlaca;
//        private String carroFoto;
//        private String carroCor;
//        
//        private String cepCasa;
//        private String cepTrabalho;
        
    }

    
    //Upload to Azure Blob Storage with help of SAS
    func uploadBlobSAS(container: String, sas: String, blockname: String, fromfile: String ){
        
        // If using a SAS token, fill it in here.  If using Shared Key access, comment out the following line.
        var containerURL = "https://yourblobstorage.blob.core.windows.net/\(container)\(sas)"  //here we have to append sas string: + sas
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
    
        let conectionStringAzure = "DefaultEndpointsProtocol=https;AccountName=pettediag173;AccountKey=tTwgi2UTEyvnW/hMF1LBDwMYLZX9OKAaA9VDtF/3TvqyLJds+4dYd7Y0n9lj6+Ep4wMFcVWc5k9R7BaWLgA0+w==;EndpointSuffix=core.windows.net"
        
//        let conectionStringAzure = "https://pettediag173.file.core.windows.net/?sv=2016-05-31&ss=bfqt&srt=sco&sp=rwdlacup&se=2017-06-24T00:20:50Z&st=2017-06-23T16:20:50Z&spr=https&sig=QtZwEs3TC647Si2RvwawgKgciMADsdWV8LkM8Oqarqc%3D"
        
        let account:AZSCloudStorageAccount
        try! account = AZSCloudStorageAccount(fromConnectionString:conectionStringAzure) //I stored the property in my header file
        let blobClient: AZSCloudBlobClient = account.getBlobClient()
        let blobContainer: AZSCloudBlobContainer = blobClient.containerReference(fromName: "sekronprofile")

        let blob: AZSCloudBlockBlob = blobContainer.blockBlobReference(fromName: imgName) //If you want a random name, I used let imageName = CFUUIDCreateString(nil, CFUUIDCreate(nil))
        let imageData = UIImagePNGRepresentation(img)
        
        blob.upload(from: imageData!, completionHandler: {(NSError) -> Void in

        })
        
        
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
