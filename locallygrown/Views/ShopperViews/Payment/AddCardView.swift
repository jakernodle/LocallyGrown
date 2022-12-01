//
//  AddCardView.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/22/22.
//

import SwiftUI
import Combine
import AVFoundation

class AddCardViewModel: ObservableObject{
    
    var cardIsValidPublisher = PassthroughSubject<Bool, Never>()
    var cardIsValid: Bool = false {
        didSet {
            cardIsValidPublisher.send(cardIsValid)
        }
    }
    
    var cardSavedPublisher = PassthroughSubject<Bool, Never>()
    var cardSaved: Bool = false {
        didSet {
            cardSavedPublisher.send(cardSaved)
        }
    }

    @Published var cardNumber = "" {
        didSet {
            checkCard()
        }
    }
    
    @Published var cvv = "" {
        didSet {
            checkCard()
        }
    }
    
    @Published var expDate = "" {
        didSet {
            checkCard()
        }
    }
    
    @Published var zip = "" {
        didSet {
            checkCard()
        }
    }
        
    func checkCard(){
        cardIsValid = checkCVV() && checkCardNumber()
    }
    
    func checkCVV() -> Bool {
        return cvv.count == 3
    }
    
    func checkCardNumber() -> Bool {
        return cardNumber.count == 16
    }
    
    func saveCard(cardNumber: String, cvv: String, expDate: String, zip: String){
        let card = CreditCard(cardNumber: cardNumber, expDate: expDate, cvv: cvv, zipCode: zip)
        ShopperService().addPaymentOption(params: ["cardInfo": card]) { result in
            switch result {
            case .success():
                self.cardSaved = true
            case .failure(let error):
                print("error saving card") //TODO: allert user of error
            }
        }
    }
}

struct AddCardView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = AddCardViewModel()
    @State var cardIsValid: Bool = false
    
    var body: some View {
        VStack{
            DebitCardTextField(cardNumber: $viewModel.cardNumber)
            
            HStack {
                TextField("Exp. Date", text: $viewModel.expDate)
                    .padding(.all, 6)
                    .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 18).fill(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06))))
                
                TextField("CVV", text: $viewModel.cvv)
                    .keyboardType(.numberPad)
                    .padding(.all, 6)
                    .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 18).fill(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06))))
            }
            .padding(.bottom, 10)
            .padding([.leading, .trailing], 20)
            
            TextField("Zip Code", text: $viewModel.zip)
                .padding(.all, 6)
                .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 18).fill(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06))))
                .padding([.leading, .trailing], 20)
            
            Spacer()
        }
        .navigationBarTitle("Add Card")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button(action: {
                    //conditional action based on card is Valid
                    if cardIsValid == true {
                        viewModel.saveCard(cardNumber: viewModel.cardNumber, cvv: viewModel.cvv, expDate: viewModel.expDate, zip: viewModel.zip)
                    }
                }) {
                    Text("Save")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(cardIsValid == true ? .black : .white)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                }
                    .tint(.black)
            }
        }
        .onReceive(viewModel.cardIsValidPublisher) { isValid in
            cardIsValid = isValid
        }
        .onReceive(viewModel.cardSavedPublisher) { saved in
            if saved == true {
                dismiss()
            }
        }
    }
}

struct DebitCardTextField: View {
    @Binding var cardNumber: String

    var body: some View {
        TextField("Card Number", text: $cardNumber)
            .keyboardType(.numberPad)
            .padding(.all, 6)
            .padding(.leading, 30)
            .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 18).fill(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06))))
            .padding([.leading, .trailing], 20)
            .padding(.bottom, 10)
            .overlay(
                HStack {
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.bottom, 10)
                }
            )
            .background(.white)
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView()
    }
}
