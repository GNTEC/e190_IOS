//
//  EMedicaViewController.swift
//  e190
//
//  Created by Ivan on 19/07/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

class EMedicaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //outlets
    
    @IBOutlet weak var txt_numero_cartao_sus: UITextField!
    
    @IBOutlet weak var txt_plano_saude: UITextField!
    
    @IBOutlet weak var txt_numero_plano_saude: UITextField!
    
    @IBOutlet weak var txt_probleas_saude: UITextField!
    
    @IBOutlet weak var txt_notas_medicas: UITextField!
    
    @IBOutlet weak var txt_alergias_reacoes: UITextField!
    
    @IBOutlet weak var txt_medicamentos: UITextField!
    
    @IBOutlet weak var txt_peso: UITextField!
    
    @IBOutlet weak var txt_altura: UITextField!
    
    @IBOutlet weak var txt_tipo_sanguineo: UITextField!
    
    var tipoSanguineo = ["Tipo A+","Tipo A-","Tipo B+","Tipo B-","Tipo AB+","Tipo AB-","Tipo O+", "Tipo O-"]
    let picker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        txt_tipo_sanguineo.inputView = picker

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //chamar api para baixar o cadastro usuario
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //Salvar dados quando sai da tela
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.view.endEditing(false)
    }
    
    
    @IBAction func btn_salvar(_ sender: Any) {
        
        var erroValidar: Bool = false
        
        if txt_peso.text == nil || txt_peso.text == ""{
            
            erroValidar = true
            
            let alertController = UIAlertController(title: "Alerta", message: "Peso Inválido", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        
        if erroValidar == false{
            
            let peso : Float = Float(txt_peso.text!)!
        
            if peso > 300{
                
                let alertController = UIAlertController(title: "Alerta", message: "Peso Inválido", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            
            }else{
                //Verificar se tem cadastro se tem cadastro chama função atualizar se não chama a função novo cadastro
            }
        }
    }
}
