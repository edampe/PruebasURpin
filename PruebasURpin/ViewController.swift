//
//  ViewController.swift
//  PruebasURpin
//
//  Created by Edilberto Amado Perdomo on 31/08/16.
//  Copyright © 2016 Edilberto Amado Perdomo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    var _StrBusqueda = ""

    @IBOutlet weak var _SearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _SearchBar.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        _StrBusqueda = searchBar.text!.lowercaseString
      
        self.performSegueWithIdentifier("Result", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
       
        
        let destinationVC = segue.destinationViewController as! ResultadoQuery
        destinationVC._StrBusqueda = _StrBusqueda

    }


}

