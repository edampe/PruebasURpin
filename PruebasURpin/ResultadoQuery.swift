//
//  ResultadoQuery.swift
//  PruebasURpin
//
//  Created by Edilberto Amado Perdomo on 31/08/16.
//  Copyright © 2016 Edilberto Amado Perdomo. All rights reserved.
//

import UIKit
import CoreData

class ResultadoQuery: UIViewController {
    
    @IBOutlet weak var _LabelBrand: UILabel!
    @IBOutlet weak var _LabelClothing: UILabel!
    @IBOutlet weak var _LabelQuery: UILabel!
    
    
    var _StrBusqueda =  String()

    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        let (_ResultName, _ResulTipo, _ResiduoQuery) = algoritmoBusqueda()
        
        
        switch _ResulTipo {
        case "ClothingType":
            _LabelClothing.text = _ResultName
            _LabelBrand.text=""
            _LabelQuery.text = _ResiduoQuery
        case "Brand":
            _LabelClothing.text = ""
            _LabelBrand.text=_ResultName
            _LabelQuery.text = _ResiduoQuery
        default:
            _LabelQuery.text = _StrBusqueda
            _LabelClothing.text = ""
            _LabelBrand.text=""
        }
    }
    
    func algoritmoBusqueda()->(String, String, String){
        
        var _ArrayBuqueda = [NSDictionary()]
        var _ResulTipo = "", _ResultName = ""
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let contexto = appDelegate.managedObjectContext
        
        let _StrBusquedaSplit = _StrBusqueda.componentsSeparatedByString(" ")
        
        for _Split in _StrBusquedaSplit{
            
            let requestBrand = NSFetchRequest(entityName: "Brand")
            requestBrand.predicate = NSPredicate(format: " %K CONTAINS[cd] %@ ", "name", _Split)
            let arrayBusqueda = try! contexto.executeFetchRequest(requestBrand) as! [Brand]
            
            print(arrayBusqueda)
            
            if(arrayBusqueda.count > 0){
                for _DatosBusqueda in arrayBusqueda{
                    _ArrayBuqueda.append(["Brand" : _DatosBusqueda.name!])
                    
                }
                
            }
            let request = NSFetchRequest(entityName: "ClothingType")
            request.predicate = NSPredicate(format: " %K CONTAINS[cd] %@ ", "name", _Split)
            let arrayBusClo = try! contexto.executeFetchRequest(request) as! [ClothingType]
            
            if(arrayBusClo.count > 0){
                for _DatosBusqueda in arrayBusClo{
                    _ArrayBuqueda.append(["ClothingType" : _DatosBusqueda.name!])
                    
                }
                
            }
            
        }
        for _Split in _StrBusquedaSplit{
            for _ResultadosBusqueda in _ArrayBuqueda{
                
                let obj = _ResultadosBusqueda as NSDictionary
                for (key, value) in obj {
                    
                    if _Split.rangeOfString((value as! String).lowercaseString) != nil || _StrBusqueda.rangeOfString((value as! String).lowercaseString) != nil {
                        if (value as! String).lowercaseString.characters.count > _ResultName.characters.count {
                            _ResultName = (value as! String).lowercaseString
                            _ResulTipo = key as! String
                            print("key \(key)")
                            print("value \(value)")
                        }
                    }
                }
            }
        }
        var _ResiduoQuery = _StrBusqueda
        
        if let _RangeResiduoQuery = _ResiduoQuery.rangeOfString(_ResultName,
                                                                options: .LiteralSearch,
                                                                range: _ResiduoQuery.startIndex..<_ResiduoQuery.endIndex,
                                                                locale: nil){
            
            _ResiduoQuery.removeRange(_RangeResiduoQuery)
            
        }else{
            let _ResiduoSplit = _ResiduoQuery.componentsSeparatedByString(" ")
            
            for trim in _ResiduoSplit{
                if trim != _ResultName {
                    _ResiduoQuery = _ResiduoQuery +  " " + trim
                }
            }
        }
        return (_ResultName, _ResulTipo, _ResiduoQuery)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonReturn(sender: AnyObject) {
       self.dismissViewControllerAnimated(true, completion: nil);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
