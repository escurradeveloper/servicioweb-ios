//
//  Model.swift
//  Clase35ServicioWebTableView
//
//  Created by Escurra Colquis on 27/11/24.
//

//Campos del SERVICIO WEB DE LA API DE RECETAS
struct RecipeResponse: Codable {
    //creamos las constantes y su tipo de datos
    let recipeName: String
    let description: String
    let urlPhoto: String
    let countryOrigin: String
    let address: String
    let rating: Int
    let latitude: Double
    let longitude: Double
    let preparationTime: String
    let ingredients: [String]
}
