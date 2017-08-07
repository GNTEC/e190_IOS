//
//  EMedicaViewController.swift
//  e190
//
//  Created by Ivan on 19/07/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import SwiftMaskText

class EMedicaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //outlets
    
    @IBOutlet weak var txt_numero_cartao_sus: UITextField!
    @IBOutlet weak var txt_plano_saude: UITextField!
    @IBOutlet weak var txt_numero_plano_saude: UITextField!
    @IBOutlet weak var txt_probleas_saude: UITextField!
    @IBOutlet weak var txt_notas_medicas: UITextField!
    @IBOutlet weak var txt_alergias_reacoes: UITextField!
    @IBOutlet weak var txt_medicamentos: UITextField!
    @IBOutlet weak var txt_peso: SwiftMaskField!
    @IBOutlet weak var txt_altura: SwiftMaskField!
    @IBOutlet weak var txt_tipo_sanguineo: UITextField!
    
    var indicator:ProgressIndicator?
    var codUsuario: Int = 0
    var atualizarEmedica: Bool = false
    
    var tipoSanguineo = ["Tipo A+","Tipo A-","Tipo B+","Tipo B-","Tipo AB+","Tipo AB-","Tipo O+", "Tipo O-"]
    let picker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Aguarde....")
        
        // função que esconde o teclado
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        //chamar api para baixar o cadastro usuario
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        self.BuscarEMedica()
        
        self.indicator?.stop()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //Salvar dados quando sai da tela
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == txt_tipo_sanguineo){
            
            self.picker.delegate = self
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor.red //UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.done  , target: self, action: #selector(donePicker))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action:nil)
            let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.done, target: self, action:#selector(cancelPicker))
            
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            textField.inputView = self.picker
            textField.inputAccessoryView = toolBar
            self.picker.isHidden = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txt_numero_cartao_sus {
            
            let newLength = (textField.text?.characters.count)! + string.characters.count - range.length

            if(newLength == 15)
            {
                return false
            }
        }
        
        if (textField == self.txt_altura)
        {
            self.txt_peso.maskString = "NN.NN"
            return true
        }
        
        if (textField == self.txt_altura)
        {
            self.txt_altura.maskString = "N.NN"
            return true
        }
        
        return true
    }
    
    func donePicker(){
        self.txt_tipo_sanguineo.resignFirstResponder()
    }
    
    func cancelPicker(){
        
        self.txt_tipo_sanguineo.resignFirstResponder()
        self.txt_tipo_sanguineo.text = ""
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return tipoSanguineo.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipoSanguineo[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txt_tipo_sanguineo.text = tipoSanguineo[row]
    }
    
    @IBAction func btn_salvar(_ sender: Any) {
        
        var erroValidar: Bool = false
        let alerta = Alert();
        
        if txt_peso.text == nil || txt_peso.text == ""{
            
            erroValidar = true

            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Peso Inválido !"), animated: true, completion: nil)
        }
        
        if erroValidar == false{
            
            let peso : Float = Float(txt_peso.text!)!
        
            if peso > 300 {
    
                self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Peso Inválido !"), animated: true, completion: nil)
            
            }else{
                
                self.view.addSubview(indicator!)
                self.indicator!.start()
                
                // VERIFICA SE É PARA ATUALIZAR OU SALVAR OS DADOS
                if self.atualizarEmedica == false
                {
                    //Verificar se tem cadastro se tem cadastro chama função atualizar se não chama a função novo cadastro
                    if self.gravar() == true
                    {
                        self.indicator?.stop()
                        
                        let alertController = UIAlertController(title: "Informação", message: "Dados Incluídos com Sucesso !", preferredStyle: .alert)

                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (Ok) in
                            self.dismiss(animated: true, completion: nil)
                        })
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    else
                    {
                        self.indicator?.stop()
                    }
                }
                else
                {
                    // Atualizada dados.
                    //Verificar se tem cadastro se tem cadastro chama função atualizar se não chama a função novo cadastro
                    if self.atualizar() == true
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
                        self.indicator?.stop()
                    }
                }
            }
        }
    }
    
    func BuscarEMedica(){
        
        let api  = ApiEmedica()
        
        codUsuario = UserDefaults.standard.object(forKey: "codUsuario") as! Int
        
        if codUsuario != 0 {
            
            api.BuscarEmedica(codUsuario: codUsuario, completionHandler: { (retorno) in
                
                if retorno.count > 0
                {
                    self.carregaTela(dadosEMedica: retorno)
                    self.atualizarEmedica = true
                }
            })
        }
        else
        {
            self.indicator?.stop()
        }
    }
    
    func gravar() -> Bool{
        
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        let removeMascara = CustomTextField()
        let api  = ApiEmedica()
        
        //REMOVE MASCARA
        let pesoSemMascara =  removeMascara.removeMascara(text: self.txt_peso, mascara: "NN.NN")
        let alturaSemMacara = removeMascara.removeMascara(text: self.txt_altura, mascara: "N.NN")
        
        codUsuario = UserDefaults.standard.object(forKey: "codUsuario") as! Int
        
        // VERIFCA SE O USUARIO ESTÁ LOGAGO
        if codUsuario != 0 {
    
            // CHAMA A FUNÇÃO QUE GRAVA O LOGIN
            let modelEMedica  = EmergenciaMedica(codUsuario: codUsuario, cartaoSus: self.txt_numero_cartao_sus.text!, planoSaude: self.txt_plano_saude.text!, numeroPlanoSaude: self.txt_numero_plano_saude.text!, problemaSaude: self.txt_probleas_saude.text!, notasMedicas: self.txt_notas_medicas.text!, alergiasReacoes: self.txt_alergias_reacoes.text!, medicamentos: self.txt_medicamentos.text!, tipoSanguineo: self.txt_tipo_sanguineo.text!, peso: pesoSemMascara, altura: alturaSemMacara).toJSON()
            
            api.AdicionarEmedica(emedica: modelEMedica) { (retorno) in
                
                self.indicator?.stop()
            }
        }
        
        return true
    }

    func atualizar() -> Bool{
        
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        let removeMascara = CustomTextField()
        let api  = ApiEmedica()
        
        //REMOVE MASCARA
        let pesoSemMascara =  removeMascara.removeMascara(text: self.txt_peso, mascara: "NN.NN")
        let alturaSemMacara = removeMascara.removeMascara(text: self.txt_altura, mascara: "N.NN")
        
        codUsuario = UserDefaults.standard.object(forKey: "codUsuario") as! Int
        
        // VERIFCA SE O USUARIO ESTÁ LOGAGO
        if codUsuario != 0 {
            
            // CHAMA A FUNÇÃO QUE GRAVA O LOGIN
            let modelEMedica  = EmergenciaMedica(codUsuario: codUsuario, cartaoSus: self.txt_numero_cartao_sus.text!, planoSaude: self.txt_plano_saude.text!, numeroPlanoSaude: self.txt_numero_plano_saude.text!, problemaSaude: self.txt_probleas_saude.text!, notasMedicas: self.txt_notas_medicas.text!, alergiasReacoes: self.txt_alergias_reacoes.text!, medicamentos: self.txt_medicamentos.text!, tipoSanguineo: self.txt_tipo_sanguineo.text!, peso: pesoSemMascara, altura: alturaSemMacara).toJSON()
            
            api.AtualizarEmedica(emedica: modelEMedica) { (retorno) in
        
                self.indicator?.stop()
            }
        }
        
        return true
    }
    
    func carregaTela(dadosEMedica : NSDictionary){
        
        self.txt_numero_cartao_sus.text = dadosEMedica["cartaoSus"] as? String
        self.txt_plano_saude.text = dadosEMedica["planoSaude"] as? String
        self.txt_numero_plano_saude.text = dadosEMedica["numeroPlanoSaude"] as? String
        self.txt_probleas_saude.text = dadosEMedica["problemaSaude"] as? String
        self.txt_notas_medicas.text = dadosEMedica["notasMedicas"] as? String
        self.txt_alergias_reacoes.text = dadosEMedica["alergiasReacoes"] as? String
        self.txt_medicamentos.text = dadosEMedica["medicamentos"] as? String
        self.txt_tipo_sanguineo.text = dadosEMedica["tipoSanguineo"] as? String
        self.txt_peso.text = dadosEMedica["peso"] as? String
        self.txt_altura.text = dadosEMedica["altura"] as? String
        
    }
    
    @IBAction func voltar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
