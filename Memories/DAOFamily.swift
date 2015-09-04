//
//  DAOFamily.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//


import Foundation
import UIKit


class DAOFamily{
    
    static let sharedInstance = DAOFamily()
    
    //carregar foto de perfil de familia/amigos
    //carregar descricao
    //carregar audio
    
    
    private var contents : NSMutableArray!;
    
    private let familyPath : String;
    
    private let familyPathDoc : String;
    
    init(){
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String;
        var imgPath:String = documentPath
        //caminho ate a pasta family
        familyPathDoc = documentPath.stringByAppendingPathComponent("Family")
        
        familyPath = documentPath.stringByAppendingPathComponent("Family/FamilyData.plist");
        
        println(familyPath)
        
        let fileManager = NSFileManager.defaultManager();
        
        if(fileManager.fileExistsAtPath(familyPathDoc)){
            
            contents = NSMutableArray(contentsOfFile: familyPath);
        }
            
        else
            
        {
            fileManager.createDirectoryAtPath(familyPathDoc, withIntermediateDirectories: false, attributes: nil, error: nil)
            
            createDict()
        }
    }
    
    private func createDict(){
        
        contents = NSMutableArray(contentsOfFile: familyPath);
        var dict = contents[0] as! NSMutableDictionary
        dict["subtitle"] = "NAda que preste"
        contents.writeToFile(familyPath, atomically: true);
        
    }
    //inicializa a classe
    
    func getDataArray() -> [Family] {
        
        var families = [Family]();
        
        for familyDict in contents{
            
            var family = Family();
            family.subtitle = familyDict["nome"] as! String;
            family.connection = (familyDict["connection"] as! String);
            family.audio = familyDict["audio"] as? String
            
            if (!(familyDict["photo"] as! String).isEmpty) {
                var pImg: String = familyPathDoc.stringByAppendingPathComponent(familyDict["photo"] as! String);
                family.photo = pImg;
            }
            families.append(family);
            
        }
        return families
}
    func saveDataArray(families: [Family], photo: UIImage )
    {
         var save = NSMutableArray() //structure to save
        var familyDict  = [String : String]()
        
        for family in families
        {
            familyDict["nome"] = family.subtitle;
            familyDict["connection"] = family.connection;
            save.addObject(familyDict)
            
//            if (!(photo as! String).isEmpty) {
//                var pImg: String = familyPathDoc.stringByAppendingPathComponent(photo["photo"] as! String);
//                family.photo = pImg;
//            }
        }
        
        save.writeToFile(familyPath, atomically: true)
        
        
    }

}