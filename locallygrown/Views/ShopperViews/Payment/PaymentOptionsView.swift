//
//  PaymentOptionsView.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/30/22.
//

import SwiftUI

struct PaymentOptionsView: View {
    
    @State var cards: [CreditCard] = LocallyGrownShopper.shared.loggedUser?.paymentInfo.cards ?? []
    @State var selectedCardId = LocallyGrownShopper.shared.loggedUser?.paymentInfo.selectedCard?.id
    
    var body: some View {
        List {
            ForEach(cards, id: \.self) { card in
                Button(action: {
                    LocallyGrownShopper.shared.setSelectedCard(card: card)
                    selectedCardId = card.id
                }){
                    HStack {
                        Text(card.formattedCardNumber)
                        if card.id == selectedCardId {
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            NavigationLink(destination: AddCardView()) {
                Text("Add Card")
            }
            .onDisappear(){
                cards = LocallyGrownShopper.shared.loggedUser?.paymentInfo.cards ?? []
                selectedCardId = LocallyGrownShopper.shared.loggedUser?.paymentInfo.selectedCard?.id
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(){
            cards = LocallyGrownShopper.shared.loggedUser?.paymentInfo.cards ?? []
            selectedCardId = LocallyGrownShopper.shared.loggedUser?.paymentInfo.selectedCard?.id
        }
    }
}

struct PaymentOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentOptionsView()
    }
}
