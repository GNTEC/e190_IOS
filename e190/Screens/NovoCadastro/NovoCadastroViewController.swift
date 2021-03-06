//
//  NovoCadastroViewController.swift
//  e190
//
//  Created by Marcelo Pavani on 19/06/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import AZSClient
import SwiftMaskText

struct stImgProfile {
    static var nomeImg: String?
    static var img : UIImage?
    static var path : String?
}

class NovoCadastroViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var stack_email: UIStackView!
    @IBOutlet weak var stack_confirmaEmail: UIStackView!
    @IBOutlet weak var stack_senha: UIStackView!
    @IBOutlet weak var stack_ConfirmaSenha: UIStackView!
    @IBOutlet weak var imgPerfil: UIButton!
    @IBOutlet weak var text_nome: UITextField!
    @IBOutlet weak var text_celular: SwiftMaskField!
    @IBOutlet weak var text_data_nascimento: UITextField!
    @IBOutlet weak var text_cpf: SwiftMaskField!
    @IBOutlet weak var text_rg: SwiftMaskField!
    @IBOutlet weak var text_telefone_fixo: SwiftMaskField!
    @IBOutlet weak var text_endereco: UITextField!
    @IBOutlet weak var text_cep: SwiftMaskField!
    @IBOutlet weak var text_numero: UITextField!
    @IBOutlet weak var txt_complemento: UITextField!
    @IBOutlet weak var text_cidade: UITextField!
    @IBOutlet weak var text_marca: UITextField!
    @IBOutlet weak var text_modelo: UITextField!
    @IBOutlet weak var text_placa: SwiftMaskField!
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
    
    var indicator:ProgressIndicator?
    var imgPicker: UIImagePickerController!
    
    var sexo = ["feminino","masculino"]
    var sexoSelecionado: String! = ""
    
    var estado = ["Acre AC","Alagoas AL","Amapá AP","Amazonas AM","Bahia BA","Ceará CE","Distrito Federal DF","Espírito Santo ES","Goiás GO","Maranhão MA","Mato Grosso MT","Mato Grosso do Sul MS","Minas Gerais MG","Pará PA","Paraíba PB","Paraná PR","Pernambuco PE","Piauí PI","Rio de Janeiro RJ","Rio Grande do Norte RN","Rio Grande do Sul RS","Rondônia RO","Roraima RR","Santa Catarina SC","São Paulo SP","Sergipe SE","Tocantins TO"]
    
    var pickerView_sexo = UIPickerView()
    var pickerView_estado = UIPickerView()
    var imgTag:Int = 0
    var estadoSelecionado: String! = ""
    var voluntatioSelecionado: String = ""
    var strCelular: String = ""
    var codLogin: Int = 0
    var codUsuario: Int = 0
    var atualizarDados: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        
        // função que esconde o teclado
        self.hideKeyboardWhenTappedAround()
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Aguarde....")
        
        // VERIFICA SE EXISTE USUARIO
        self.BuscarUsuario()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        self.BuscarUsuario()
        
        self.indicator?.stop()
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
            
            if let gender = self.sexo[row].characters.first {
                self.sexoSelecionado = "\(gender)"
            }
            
            self.txt_sexo.text = self.sexo[row]
        }
        else if pickerView == pickerView_estado {
            
            self.estadoSelecionado = self.estado[row].substring(from:self.estado[row].index(self.estado[row].endIndex, offsetBy: -2))
            
            self.text_estado.text = self.estado[row]
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == txt_sexo){
            
            self.pickerView_sexo.delegate = self
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor.red //UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.done  , target: self, action: #selector(donePickerSexo))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action:nil)
            let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.done, target: self, action:#selector(cancelPickerSexo))
            
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            textField.inputView = self.pickerView_sexo
            textField.inputAccessoryView = toolBar
            self.pickerView_sexo.isHidden = false
        }
        
        if(textField == text_estado){
            
            self.pickerView_estado.delegate = self
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor.red //UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.done  , target: self, action: #selector(donePickerEstado))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action:nil)
            let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.done, target: self, action:#selector(cancelPickerEstado))
            
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            textField.inputView = self.pickerView_estado
            textField.inputAccessoryView = toolBar
            self.pickerView_estado.isHidden = false
        }
        
        if(textField == text_data_nascimento){
            
            let datePickerView:UIDatePicker = UIDatePicker()
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor.red //UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.done  , target: self, action: #selector(donePickerDataNascimento))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action:nil)
            let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.done, target: self, action:#selector(cancelPickerDataNascimento))
            
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            datePickerView.datePickerMode = UIDatePickerMode.date
            
            textField.inputView = datePickerView
            textField.inputAccessoryView = toolBar
            
            datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    
    func donePickerDataNascimento(){
        self.text_data_nascimento.resignFirstResponder()
    }
    
    func cancelPickerDataNascimento(){
        
        self.text_data_nascimento.resignFirstResponder()
        self.text_data_nascimento.text = ""
    }
    
    func donePickerEstado(){
        self.text_estado.resignFirstResponder()
    }
    
    func cancelPickerEstado(){
        
        self.text_estado.resignFirstResponder()
        self.text_estado.text = ""
    }
    
    func donePickerSexo(){
        self.txt_sexo.resignFirstResponder()
    }
    
    func cancelPickerSexo(){
        
        self.txt_sexo.resignFirstResponder()
        self.txt_sexo.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.text_cep {
        
            let api = ApiNovoCadastro()
            
            let newLength = (textField.text?.characters.count)! + string.characters.count - range.length
            let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
            
            if(newLength == 9)
            {
                self.text_cep.text = newString
                let cepSemMascara = self.removeMascara(text: self.text_cep, mascara: "NNNNN-NNN")
                
                self.view.addSubview(indicator!)
                self.indicator!.start()
                
                api.buscaEnderecoPorCep(cep: cepSemMascara, completionHandler: { (result) in
                    
                    if result.count > 0
                    {
                        self.text_endereco.text = result.object(forKey: "logradouro") as? String
                        self.txt_complemento.text = result.object(forKey: "complemento") as? String
                        self.text_cidade.text = result.object(forKey: "localidade") as? String
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
        
            self.indicator?.stop()
            return true
        }
        
        return false
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        
        dateFormatter.dateStyle = .short
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
        
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        if validaCamposObrigatorio() == true
        {
            if self.atualizarDados == false {
                
                if gravar() == true {
                    
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "TokenViewController") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                    
                }
                else
                {
                    // ERRO DO GRAVAR
                    self.indicator!.stop()
                }
            }
            else {
               // altera os dados
                if atualizar() == true
                {
                    self.indicator?.stop()
                    
                    let alertController = UIAlertController(title: "Informação", message: "Dados Atualizados com Sucesso !", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (Ok) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else
                {
                    //ERRO DO ALTERAR
                    self.indicator!.stop()
                }
            }
        }
        else
        {
            // else dos campos obrigatorios
            self.indicator!.stop()
        }
    }
    
    
    func gravar() -> Bool{
        
        let api  = ApiNovoCadastro()
        let removeMascara = CustomTextField()
        
        // remove mascara
        let celularSemMascara = removeMascara.removeMascara(text: self.text_celular, mascara: "(NN) NNNNN-NNNN")
        let cpfSemMascara = removeMascara.removeMascara(text: self.text_cpf, mascara: "NNN.NNN.NNN-NN")
        let rgSemMascara = removeMascara.removeMascara(text: self.text_rg, mascara: "NN.NNN.NNN-%")
        let telefoneFixoSemMascara = removeMascara.removeMascara(text: self.text_telefone_fixo, mascara: "(NN) NNNN-NNNN")
        let cepSemMascara = removeMascara.removeMascara(text: self.text_cep, mascara: "NNNNN-NNN")
        let placaSemMascara = removeMascara.removeMascara(text: self.text_placa, mascara: "UUU-NNNN")
        
        // CHAMA A FUNÇÃO QUE GRAVA O LOGIN
        let modelLogin = NovoLogin(codLogin: 0, email: text_email.text!, senha: text_senha.text!, token: "0", serialChip: "1").toJSON()
        
        // GRAVA USUARIO PRIMEIRO
        api.criaLogin(login: modelLogin, completionHandler: { (retornoLgin) in
            
            // SE GRAVOU LOGIN GRAVA USUARIO
            if (retornoLgin["codLogin"] as? Int) != nil {
                
                self.codLogin = retornoLgin["codLogin"] as! Int
                
                let modelUsuario = NovoUsuario(codUsuario: 0, codLogin: self.codLogin  , nome: self.text_nome.text!, dataNascimento: self.text_data_nascimento.text!, cpf: cpfSemMascara, rg: rgSemMascara, celular: celularSemMascara, telefone: telefoneFixoSemMascara, sexo:self.sexoSelecionado.uppercased(), cep: cepSemMascara, rua: self.text_endereco.text!, complemento: self.txt_complemento.text!, numero: self.text_numero.text!, cidade: self.text_cidade.text!, estado: self.estadoSelecionado, ativo: false, voluntario: self.voluntatioSelecionado , dataCadastro: "", pago: true, fotoPerfil: "", uidFirebase: "", notificacaoAmarela: true, notificacaoLaranja: true, notificacaoVermelha: true, enderecoCasa: "", enderecoTrabalho: "", carroMarca: self.text_marca.text!, carroModelo: self.text_modelo.text!, carroPlaca: placaSemMascara, carroFoto: "", carroCor: self.text_cor.text!, cepCasa: "", cepTrabalho: "").toJSON()
                
                
                // CRIA O USUARIO
                api.criaUsuario(parametros: modelUsuario, compeletionHandler: { (retornoUsuario) in
                    
                    //GRAVA VARIAVEIS DE AMBIENTE
                    UserDefaults.standard.setValue(retornoUsuario["codLogin"], forKey: "codLogin")
                    UserDefaults.standard.setValue(retornoUsuario["codUsuario"], forKey: "codUsuario")
                    
                    //FAZ UPLOAD DA IMAGEM PARA O AZURE
                    //self.uploadImagsAzure()
                })
            }
            
            self.indicator!.stop()
        })

        return true
    }
    
    func atualizar() -> Bool{
    
        let removeMascara = CustomTextField()
        let api  = ApiNovoCadastro()
        
        //REMOVE MASCARA
        // remove mascara
        let celularSemMascara = removeMascara.removeMascara(text: self.text_celular, mascara: "(NN) NNNNN-NNNN")
        let cpfSemMascara = removeMascara.removeMascara(text: self.text_cpf, mascara: "NNN.NNN.NNN-NN")
        let rgSemMascara = removeMascara.removeMascara(text: self.text_rg, mascara: "NN.NNN.NNN-%")
        let telefoneFixoSemMascara = removeMascara.removeMascara(text: self.text_telefone_fixo, mascara: "(NN) NNNN-NNNN")
        let cepSemMascara = removeMascara.removeMascara(text: self.text_cep, mascara: "NNNNN-NNN")
        let placaSemMascara = removeMascara.removeMascara(text: self.text_placa, mascara: "UUU-NNNN")
        
        codUsuario = UserDefaults.standard.object(forKey: "codUsuario") as! Int
        
        // VERIFICA SE OS HOUVE MUDANÇA NO ESTADO E NA CIDADE
        if self.estadoSelecionado == ""{
        
            self.estadoSelecionado = self.text_estado.text
        }
        
        if self.sexoSelecionado == "" {
        
            self.sexoSelecionado = self.txt_sexo.text
        }
        
        // VERIFCA SE O USUARIO ESTÁ LOGAGO
        if codUsuario != 0 {
            
            let modelUsuario = NovoUsuario(codUsuario: codUsuario, codLogin: self.codLogin  , nome: self.text_nome.text!, dataNascimento: self.text_data_nascimento.text!, cpf: cpfSemMascara, rg: rgSemMascara, celular: celularSemMascara, telefone: telefoneFixoSemMascara, sexo:self.sexoSelecionado.uppercased(), cep: cepSemMascara, rua: self.text_endereco.text!, complemento: self.txt_complemento.text!, numero: self.text_numero.text!, cidade: self.text_cidade.text!, estado: self.estadoSelecionado, ativo: false, voluntario: self.voluntatioSelecionado , dataCadastro: "", pago: true, fotoPerfil: "", uidFirebase: "", notificacaoAmarela: true, notificacaoLaranja: true, notificacaoVermelha: true, enderecoCasa: "", enderecoTrabalho: "", carroMarca: self.text_marca.text!, carroModelo: self.text_modelo.text!, carroPlaca: placaSemMascara, carroFoto: "", carroCor: self.text_cor.text!, cepCasa: "", cepTrabalho: "").toJSON()
            
            
            // CRIA O USUARIO
            api.AtualizarUsuario(parametros: modelUsuario, completionHeadler: { (retornoUsuario) in
                
                
                // SALVA OS DADOS DO USAURIO COMPARTILHADO
                //let objUsuario = NovoUsuario(json: retorno).toJSON()
                UserDefaults.standard.set(modelUsuario, forKey: "dict")
                
                //FAZ UPLOAD DA IMAGEM PARA O AZURE
                //self.uploadImagsAzure()
                
                self.indicator?.stop()
            })
        }
        
        return true
    }
    
    func uploadImagsAzure()
    {

        let api  = ApiNovoCadastro()

        let nomeImg = stImgProfile.nomeImg
        let img = stImgProfile.img
        let pathImg = stImgProfile.path

        api.uploloadImgToAzure(img: img!, imgName: nomeImg!, pathImg: pathImg!)
    
    }
    
    func BuscarUsuario(){
    
        codUsuario = UserDefaults.standard.object(forKey: "codUsuario") as! Int
    
        if let objUsuario = UserDefaults.standard.value(forKey: "dict")
        {
            self.carregaTela(dados: objUsuario as! NSDictionary)
            self.atualizarDados = true
        }
    }

    func carregaTela(dados : NSDictionary){
        
        self.codUsuario = dados["codUsuario"] as! Int
        self.codLogin = dados["codLogin"] as! Int
        self.text_nome.text = dados["nome"] as? String
        self.text_data_nascimento.text = dados["dataNascimento"] as? String
        self.text_cpf.text = dados["cpf"] as? String
        self.text_rg.text = dados["rg"] as? String
        self.text_celular.text = dados["celular"] as? String
        self.text_telefone_fixo.text = dados["telefone"] as? String
        
        if dados["sexo"] as? String == "M"
        {
            self.txt_sexo.text = "masculino"
            self.sexoSelecionado = dados["sexo"] as? String
        }
        else
        {
           self.txt_sexo.text = "feminino"
            self.sexoSelecionado = dados["sexo"] as? String
        }
    
        self.text_endereco.text = dados["rua"] as? String
        self.txt_complemento.text = dados["complemento"] as? String
        self.text_numero.text = dados["numero"] as? String
        self.text_cidade.text = dados["cidade"] as? String
        
        for (item) in estado
        {
            self.estadoSelecionado = item.substring(from:item.index(item.endIndex, offsetBy: -2))
            
            if self.estadoSelecionado == dados["estado"] as? String
            {
                self.text_estado.text = item
            }
        }
        
        UserDefaults.standard.set(dados["ativo"], forKey: "Ativo")
        
        if let voluntario = dados["voluntario"] as? String
        {
            alteraEstadoSwitch(nome: voluntario)
            self.voluntatioSelecionado = voluntario
        }
        
        //self.text_nome.text = dados["fotoPerfil"] as? String
        //static let uidFirebase = "uidFirebase"
        UserDefaults.standard.set(dados["notificacaoAmarela"], forKey: "notificacaoAmarela")
        UserDefaults.standard.set(dados["notificacaoLaranja"], forKey: "notificacaoLaranja")
        UserDefaults.standard.set(dados["notificacaoVermelha"], forKey: "notificacaoVermelha")
        //self.text_nome.text = dados["enderecoCasa"] as? String
        //self.text_nome.text = dados["enderecoTrabalho"] as? String
        self.text_marca.text = dados["carroMarca"] as? String
        self.text_modelo.text = dados["carroModelo"] as? String
        self.text_placa.text = dados["carroPlaca"] as? String
        //self.text_nome.text = dados["carroFoto"] as? String
        self.text_cor.text = dados["carroCor"] as? String
        //self.text_cep.text = dados["cepCasa"] as? String
        self.text_cep.text = dados["cep"] as? String
        //self.text_nome.text = dados["cepTrabalho"] as? String
        
        //esconde campos
        self.escondeCampos()
    }
    
    func escondeCampos()
    {
        self.text_email.isEnabled = false
        self.text_confirma_email.isEnabled = false
        self.text_senha.isEnabled = false
        self.text_confirma_senha.isEnabled = false
    }
    
    func removeMascara(text:SwiftMaskField, mascara: String) -> String
    {
        if let textRecuperado = text.text {
            return text.removeMaskCharacters(text: textRecuperado, withMask: mascara)
        }
        
        return ""
    }
    
    @IBAction func optSocorrista(_ sender: Any) {
        
        alteraEstadoSwitch(nome: "sw_socorrista")
        self.voluntatioSelecionado = "SOCORRISTA"
    }
    
    @IBAction func optMedico(_ sender: Any) {
        
        alteraEstadoSwitch(nome: "sw_medico")
        self.voluntatioSelecionado = "MEDICO"
    }
    
    @IBAction func optPolicial(_ sender: Any) {
        
        alteraEstadoSwitch(nome: "sw_policial")
        self.voluntatioSelecionado = "POLICIAL"
    }
    
    @IBAction func optDefesaCivil(_ sender: Any) {
        
        alteraEstadoSwitch(nome: "sw_defesa_civil")
        self.voluntatioSelecionado = "DEFESA CIVIL"
        
    }
    
    @IBAction func optNenhuma(_ sender: Any) {
    
        alteraEstadoSwitch(nome: "sw_nenhuma")
        self.voluntatioSelecionado = "NAO OBRIGADO"
        
    }
    
    func alteraEstadoSwitch (nome: String){
        
        if nome == "sw_socorrista" || nome == "SOCORRISTA" {
            self.sw_socorrista.isOn = true
        }
        else
        {
            self.sw_socorrista.isOn = false
        }
        
        if nome == "sw_medico" || nome == "MEDICO" {
            self.sw_medico.isOn = true
        }
        else
        {
            self.sw_medico.isOn = false
        }
        
        if nome == "sw_policial" || nome == "POLICIAL" {
            self.sw_policial.isOn = true
        }
        else
        {
            self.sw_policial.isOn = false
        }
        
        if nome == "sw_defesa_civil" || nome == "DEFESA CIVIL" {
            self.sw_defesa_civil.isOn = true
        }
        else
        {
            self.sw_defesa_civil.isOn = false
        }
        
        if nome == "sw_nenhuma" || nome == "NAO OBRIGADO" {
            self.sw_nenhuma.isOn = true
        }
        else
        {
            self.sw_nenhuma.isOn = false
        }
    
    }
    
    func validaCamposObrigatorio () -> Bool
    {
        let alerta = Alert();
        
        if text_celular.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o Celular !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_nome.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o Nome !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_data_nascimento.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o Nascimento !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_cpf.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o CPF !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_rg.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o RG !"), animated: true, completion: nil)
            
            return false
        }
        
        if txt_sexo.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o Sexo !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_cep.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o CEP !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_endereco.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o Endereço !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_numero.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o Número !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_cidade.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher a Cidade !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_estado.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Escolher o Estado !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_email.text != text_confirma_email.text {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "E-Mails digitados não conferem !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_senha.text != text_confirma_senha.text {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Senhas digitados não conferem !"), animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    @IBAction func voltar(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
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
