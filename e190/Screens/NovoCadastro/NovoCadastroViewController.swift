//
//  NovoCadastroViewController.swift
//  e190
//
//  Created by Marcelo Pavani on 19/06/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import  AZSClient

struct stImgProfile {
    static var nomeImg: String?
    static var img : UIImage?
    static var path : String?
}


class NovoCadastroViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var imgPerfil: UIButton!
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
    @IBOutlet weak var dt_nascimento: UIDatePicker!
    
    
    var imgPicker: UIImagePickerController!
    
    var sexo = ["feminino","masculino"]
    
    var estado = ["Acre AC","Alagoas AL","Amapá AP","Amazonas AM","Bahia BA","Ceará CE","Distrito Federal DF","Espírito Santo ES","Goiás GO","Maranhão MA","Mato Grosso MT","Mato Grosso do Sul MS","Minas Gerais MG","Pará PA","Paraíba PB","Paraná PR","Pernambuco PE","Piauí PI","Rio de Janeiro RJ","Rio Grande do Norte RN","Rio Grande do Sul RS","Rondônia RO","Roraima RR","Santa Catarina SC","São Paulo SP","Sergipe SE","Tocantins TO"]
    
    var pickerView_sexo = UIPickerView()
    var pickerView_estado = UIPickerView()
    var imgTag:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        
        // função que esconde o teclado
        self.hideKeyboardWhenTappedAround()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var controls : Int = 0
        
        if pickerView == pickerView_sexo {
            
            controls = self.sexo.count
        }
            
        else if pickerView == pickerView_estado{
            
            controls = self.estado.count
        }
        
        return controls
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        if pickerView == pickerView_sexo {
        
            let tituloLinha = sexo[row]
            
            return tituloLinha
        }
        else if pickerView == pickerView_estado {
            
            let tituloLinha = estado[row]
            
            return tituloLinha
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == pickerView_sexo {
            self.txt_sexo.text = self.sexo[row]
            //self.pickerView_sexo.isHidden = true
            
        }
        else if pickerView == pickerView_estado {
            
            self.text_estado.text = self.estado[row]
            //self.pickerView_estado.isHidden = true
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == txt_sexo){
            
            self.pickerView_sexo.delegate = self
            textField.inputView = self.pickerView_sexo
            self.pickerView_sexo.isHidden = false
        }
        
        if(textField == text_estado){
            
            self.pickerView_estado.delegate = self
            textField.inputView = self.pickerView_estado
            self.pickerView_estado.isHidden = false
        }
        
        if(textField == text_data_nascimento){
            
            let datePickerView:UIDatePicker = UIDatePicker()
            
            datePickerView.datePickerMode = UIDatePickerMode.date
            
            textField.inputView = datePickerView
            
            datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let api = ApiNovoCadastro()
        let retBool: Bool = true
        let newLength = (textField.text?.characters.count)! + string.characters.count - range.length
        
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        
        if(newLength == 8)
        {
            api.buscaEnderecoPorCep(cep: newString, completionHandler: { (result) in
                
                if result.count > 0
                {
                
                    self.text_endereco.text = result.object(forKey: "logradouro") as? String
                    self.txt_complemento.text = result.object(forKey: "complemento") as? String
                    self.text_cidade.text = result.object(forKey: "localidade") as? String
                    //self.text_estado.text = result.object(forKey: "uf") as? String
                }
                else
                {
                    let alertController = UIAlertController(title: "Alterta", message: "CEP Inválido", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    
                    alertController.addAction(okAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
        
        return retBool
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.text_data_nascimento.text = dateFormatter.string(from: sender.date)
        
    }
    
    @IBAction func btCarregaFotoPerfil(_ sender: Any) {
        
        self.imgTag = (sender as AnyObject).tag
        
        let alerController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Usa Camera", style: .default) { (actionCamera) in
            self.imgPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            self.imgPicker.sourceType = .camera
            self.imgPicker.allowsEditing = true
        
            self.present(self.imgPicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        
        
        alerController.addAction(cameraAction)
        alerController.addAction(cancelAction)
        
        present(alerController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnCarregaFotoCarro(_ sender: Any) {
        
        self.imgTag = (sender as AnyObject).tag
        
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
        
        let img: UIImage!
        
        if imgTag == 1 {
        
            img = info[UIImagePickerControllerEditedImage] as! UIImage
            
            let fileManager = FileManager.default
            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("teste.png")
            print(paths)
            let imageData = UIImageJPEGRepresentation(img!, 0.5)
            fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
            
            stImgProfile.img = img
            stImgProfile.nomeImg = "teste.png"
            stImgProfile.path = paths
            
            UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
            
            imgPerfil.setBackgroundImage(img, for: .normal)
        }
        else
        {
            img = info[UIImagePickerControllerEditedImage] as! UIImage
            imgCarro.setBackgroundImage(img, for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func proximoPasso(_ sender: Any) {
        
//        if validaCamposObrigatorio() == true
//        {
//            let api  = ApiNovoCadastro()
//
//            let nomeImg = stImgProfile.nomeImg
//            let img = stImgProfile.img
//            let pathImg = stImgProfile.path
//        
//            api.uploloadImgToAzure(img: img!, imgName: nomeImg!, pathImg: pathImg!)
//        }
        
        var container: AZSCloudBlobContainer?
        
        let blob = container!.blockBlobReference(fromName: "pettediag173")
        
        blob.upload(fromText: stImgProfile.path!,  completionHandler: { (error: Error?) -> Void in
            
            print(error)
//            if (self.viewToReloadOnBlobAdd != nil) {
//                self.viewToReloadOnBlobAdd!.reloadBlobList()
//            }
        })
        
        
    }
    
    @IBAction func optSocorrista(_ sender: Any) {
        
        alteraEstadoSwitch(nome: "sw_socorrista", opcaoSelecionada: sw_socorrista.isOn)
        
    }
    
    @IBAction func optMedico(_ sender: Any) {
        
        alteraEstadoSwitch(nome: "sw_medico", opcaoSelecionada: sw_medico.isOn)
    }
    
    @IBAction func optPolicial(_ sender: Any) {
        
        alteraEstadoSwitch(nome: "sw_policial", opcaoSelecionada: sw_policial.isOn)
        
    }
    
    @IBAction func optDefesaCivil(_ sender: Any) {
        
        alteraEstadoSwitch(nome: "sw_defesa_civil", opcaoSelecionada: sw_defesa_civil.isOn)
    }
    
    @IBAction func optNenhuma(_ sender: Any) {
    
        alteraEstadoSwitch(nome: "sw_nenhuma", opcaoSelecionada: sw_nenhuma.isOn)
        
    }
    
    func alteraEstadoSwitch ( nome: String, opcaoSelecionada: Bool ){
    
        if nome == "sw_socorrista" {
            self.sw_socorrista.isOn = true
        }
        else
        {
            self.sw_socorrista.isOn = false
        }
        
        if nome == "sw_medico" {
            self.sw_medico.isOn = true
        }
        else
        {
            self.sw_medico.isOn = false
        }
        
        if nome == "sw_policial" {
            self.sw_policial.isOn = true
        }
        else
        {
            self.sw_policial.isOn = false
        }
        
        if nome == "sw_defesa_civil" {
            self.sw_defesa_civil.isOn = true
        }
        else
        {
            self.sw_defesa_civil.isOn = false
        }
        
        if nome == "sw_nenhuma" {
            self.sw_nenhuma.isOn = true
        }
        else
        {
            self.sw_nenhuma.isOn = false
        }
    
    }
    
    func validaCamposObrigatorio () -> Bool
    {

        if text_celular.text == "" {
        
            let alertController = UIAlertController(title: "Alerta", message: "Favor Preencher o Número do Celular !", preferredStyle: .alert)
            let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        
            return false
        }
        
        if text_nome.text == "" {
            
            let alertController = UIAlertController(title: "Alerta", message: "Favor Preencher o Nome !", preferredStyle: .alert)
            let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if text_data_nascimento.text == "" {
            
            let alertController = UIAlertController(title: "Alerta", message: "Favor Preencher a Data de Nascimento !", preferredStyle: .alert)
            let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if text_cpf.text == "" {
            
            let alertController = UIAlertController(title: "Alerta", message: "Favor Preencher o CPF !", preferredStyle: .alert)
            let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }

        if text_rg.text == "" {
            
            let alertController = UIAlertController(title: "Alerta", message: "Favor Preencher o RG !", preferredStyle: .alert)
            let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if txt_sexo.text == "" {
            
            let alertController = UIAlertController(title: "Alerta", message: "Favor Escolha o Sexo !", preferredStyle: .alert)
            let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if text_cep.text == "" {
            
            let alertController = UIAlertController(title: "Alerta", message: "Favor Preencher o CEP !", preferredStyle: .alert)
            let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if text_endereco.text == "" {
            
            let alertController = UIAlertController(title: "Alerta", message: "Favor Preencher o Endereço !", preferredStyle: .alert)
            let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if text_numero.text == "" {
            
            let alertController = UIAlertController(title: "Alerta", message: "Favor Preencher o Número !", preferredStyle: .alert)
            let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if text_cidade.text == "" {
            
            let alertController = UIAlertController(title: "Alerta", message: "Favor Preencher a Cidade !", preferredStyle: .alert)
            let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if text_estado.text == "" {
            
            let alertController = UIAlertController(title: "Alerta", message: "Favor Escolher o Estado !", preferredStyle: .alert)
            let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
    
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
