//
//  NovoCadastroViewController.swift
//  e190
//
//  Created by Marcelo Pavani on 19/06/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

class NovoCadastroViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var text_nome: UITextField!
    @IBOutlet weak var text_celular: UITextField!
    @IBOutlet weak var text_data_nascimento: UITextField!
    @IBOutlet weak var text_cpf: UITextField!
    @IBOutlet weak var text_rg: UITextField!
    @IBOutlet weak var text_telefone_fixo: UITextField!
    @IBOutlet weak var text_endereco: UITextField!
    @IBOutlet weak var text_cep: UITextField!
    @IBOutlet weak var text_numero: UITextField!
    @IBOutlet weak var txt_complemento: UITextField!
    @IBOutlet weak var text_cidade: UITextField!
    @IBOutlet weak var text_marca: UITextField!
    @IBOutlet weak var text_modelo: UITextField!
    @IBOutlet weak var text_placa: UITextField!
    @IBOutlet weak var text_cor: UITextField!
    @IBOutlet weak var text_email: UITextField!
    @IBOutlet weak var text_confirma_email: UITextField!
    @IBOutlet weak var text_senha: UITextField!
    @IBOutlet weak var text_confirma_senha: UITextField!
    @IBOutlet weak var sw_socorrista: UISwitch!
    @IBOutlet weak var sw_medico: UISwitch!
    @IBOutlet weak var sw_policial: UISwitch!
    @IBOutlet weak var sw_defesa_civil: UISwitch!
    @IBOutlet weak var sw_nenhuma: UISwitch!
    @IBOutlet weak var imgCarro: UIButton!
    @IBOutlet weak var txt_sexo: UITextField!
    @IBOutlet weak var drop_sexo: UIPickerView!
    @IBOutlet weak var text_estado: UITextField!
    @IBOutlet weak var drop_estado: UIPickerView!
    
    
    var imgPicker: UIImagePickerController!
    var sexo = ["feminino","masculino"]
    var estado = ["Acre AC","Alagoas AL","Amapá AP","Amazonas AM","Bahia BA","Ceará CE","Distrito Federal DF","Espírito Santo ES","Goiás GO","Maranhão MA","Mato Grosso MT","Mato Grosso do Sul MS","Minas Gerais MG","Pará PA","Paraíba PB","Paraná PR","Pernambuco PE","Piauí PI","Rio de Janeiro RJ","Rio Grande do Norte RN","Rio Grande do Sul RS","Rondônia RO","Roraima RR","Santa Catarina SC","São Paulo SP","Sergipe SE","Tocantins TO"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPicker = UIImagePickerController()
        imgPicker.delegate = self
    
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var controls : Int = 0
        
        if pickerView == drop_sexo {
            
            controls = self.sexo.count
        }
            
        else if pickerView == drop_estado{
            
            controls = self.estado.count
        }
        
        return controls
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        if pickerView == drop_sexo {
        
            let tituloLinha = sexo[row]
            
            return tituloLinha
        }
        else if pickerView == drop_estado {
            
            let tituloLinha = estado[row]
            
            return tituloLinha
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == drop_sexo {
            
            self.txt_sexo.text = self.sexo[row]
            self.drop_sexo.isHidden = true
        }
        else if pickerView == drop_estado {
            
            self.text_estado.text = self.estado[row]
            self.drop_estado.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == txt_sexo){
            self.drop_sexo.isHidden = false
        }
        
        if(textField == text_estado){
            self.drop_estado.isHidden = false
        }
    }
    
    @IBAction func btnCarregaFotoCarro(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Usar Camera", style: .default) { (actionCamera) in
            self.imgPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            self.imgPicker.sourceType = .camera
            self.imgPicker.allowsEditing = true
            
            self.present(self.imgPicker, animated: true, completion: nil)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Usar Biblioteca de Fotos", style: .default) { (actionPhotoLibrary) in
            self.imgPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.imgPicker.sourceType = .photoLibrary
            self.imgPicker.allowsEditing = true
            
            self.present(self.imgPicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let img = info[UIImagePickerControllerEditedImage] as! UIImage
        imgCarro.setBackgroundImage(img, for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func proximoPasso(_ sender: Any) {
    
    
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
