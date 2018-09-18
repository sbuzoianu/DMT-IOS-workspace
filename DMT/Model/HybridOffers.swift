//
//  HybridOffers.swift
//  DMT
//
//  Created by Racovita Alexandru on 8/22/18.
//  Copyright © 2018 Boggy. All rights reserved.
//
//HybridOffers(msg: Optional("success"), response: Optional("Operatiune desfasurata cu succes."), result: ["oferteluate": [Optional(DMT.HybridOffersDetails(idOferta: Optional("2"), codSpecializare: Optional("1"), specializare: Optional("Om bun"), codLocatie: Optional("1"), numeLocatie: Optional("Galati"), titluOferta: Optional("Ingrijit vaci"), pretOferta: Optional("35"), numeAngajator: Optional("Ionel ")))], "ofertepuse": [Optional(DMT.HybridOffersDetails(idOferta: Optional("3"), codSpecializare: Optional("1"), specializare: Optional("Om bun"), codLocatie: Optional("1"), numeLocatie: Optional("Galati"), titluOferta: Optional("Spart geamuri"), pretOferta: Optional("35"), numeAngajator: Optional("sunt")))]])
//Optional(1)


import Foundation

struct HybridOffersDetails : Codable {
    let idOferta: String?
    let codSpecializare: String?
    let specializare: String?
    let codLocatie: String?
    let numeLocatie: String?
    let titluOferta: String?
    let pretOferta: String?
    let numeAngajator: String?
    
    private enum CodingKeys: String, CodingKey{
        case idOferta = "id_oferta"
        case codSpecializare = "cod_specializare"
        case specializare
        case codLocatie = "cod_locatie"
        case numeLocatie = "nume_locatie"
        case titluOferta = "titlu_oferta"
        case pretOferta = "pret_oferta"
        case numeAngajator = "nume_angajator"
    }
    
}
//struct HybridOffersResult: Codable{
//    let oferteLuate:[HybridOffersDetails]?
//    let ofertePuse:[HybridOffersDetails]?
//
//    private enum CodingKeys: String, CodingKey{
//        case oferteLuate = "oferteluate"
//        case ofertePuse = "ofertepuse"
//    }
//}

struct HybridOffers: Codable{
    let msg: String? // "ERROR" sau "SUCCESS"
    let response: String? // "Operatiune desfasurata cu succes."
    let result: [String:[HybridOffersDetails?]]
}
