//
//  ListTableViewCell.swift
//  Clase35ServicioWebTableView
//
//  Created by Escurra Colquis on 27/11/24.
//

import UIKit //importamos la librería
import AlamofireImage //importamos la librería

//Celda de la tabla de la receta
class ListTableViewCell: UITableViewCell {
    //componentes de la UI
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var generalView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none //ninguna selección de color
        layer.cornerRadius = 10 //la celda tenga un tamaño de 10 y tenga un círculo
        backgroundColor = UIColor.clear //la celda su background no tenga color
    }

    //para seleccionar la celda
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated) //le pasamos las variables booleanas
    }
    
    //para cofigurar la vista de la celda
    func configureView(viewList: RecipeResponse?) {
        guard let list = viewList else { return } //validamos que tenga valor
        titleLabel.text = list.recipeName //le pasamos el nombre
        let urlPhotoRecipe = list.urlPhoto //obetenemos la foto
        if let url = URL(string: urlPhotoRecipe) {
            //mostramos la imagen de la receta
            listImageView?.af.setImage(withURL: url, placeholderImage:  UIImage(named: "icon"))
        }
        listImageView?.contentMode = .scaleAspectFill //para que no sea tan estirado la foto de la receta
        listImageView?.layer.cornerRadius = 10 //le ponemos de tamaño 10 al círculo de la receta
        generalView?.layer.shadowOffset = CGSize.zero //el generalView para que ocupe la posición 0
        generalView?.layer.shadowRadius = 1 //el generalView tenga una sombra con tamaño 1
        generalView?.layer.shadowOpacity = 1 //el generalView tenga una opacidad de 1
        generalView?.layer.cornerRadius = 40 //le ponemos de tamaño 40 al círculo de la receta
    }
}
