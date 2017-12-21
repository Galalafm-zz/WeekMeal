//
//  PreferenciesModel.swift
//  WeekMealDebug
//
//  Created by Louis Rialland on 20/12/2017.
//  Copyright © 2017 Gala Pillot. All rights reserved.
//


class PreferenceModel {
    
    var id: String?
    var calories: String?
    var diet: String?
    var id_user: String?

    
    init(id: String?, calories: String?, diet: String?, id_user: String?){
        self.id = id
        self.calories = calories
        self.diet = diet
        self.id_user = id_user
    }
}
