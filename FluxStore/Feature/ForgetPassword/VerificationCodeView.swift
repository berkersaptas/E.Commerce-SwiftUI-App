//
//  VerificationCodeView.swift
//  FluxStore
//
//  Created by Berker Saptas on 30.08.2023.
//

import SwiftUI
import Combine


struct VerificationCodeView: View {

    @State var continueClicked : Bool = false
    @FocusState private var pinFocusState : FocusPin?
    
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    
    
    var body: some View {
        VStack {
            Text("Verification code").font(.title).frame(maxWidth: .infinity, alignment: .leading)
            Text("Please enter the verification code we sent to your email address").font(.subheadline).frame(maxWidth: .infinity, alignment: .leading).padding(.vertical)
            Spacer()
            HStack(spacing:15, content: {
                TextField("", text: $pinOne)
                    .modifier(OtpModifer(pin:$pinOne))
                
                    .onChange(of:pinOne){newVal in
                        if (newVal.count == 1) {
                            
                            pinFocusState = .pinTwo
                        }
                    }
                    .focused($pinFocusState, equals: .pinOne)
                TextField("", text:  $pinTwo)
                    .modifier(OtpModifer(pin:$pinTwo))
                    .onChange(of:pinTwo){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinThree
                        }
                    }
                    .focused($pinFocusState, equals: .pinTwo)
                TextField("", text:$pinThree)
                    .modifier(OtpModifer(pin:$pinThree))
                    .onChange(of:pinThree){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinFour
                        }
                    }
                    .focused($pinFocusState, equals: .pinThree)
                TextField("", text:$pinFour)
                    .modifier(OtpModifer(pin:$pinFour))
                    .focused($pinFocusState, equals: .pinFour)
            })
            .padding(.vertical)
            Spacer()
            PrimaryButton(text: "Continue", onTap: {
                
                continueClicked = true
            })
        }.padding()
    }
}

enum FocusPin {
    case  pinOne, pinTwo, pinThree, pinFour
}


struct VerificationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationCodeView()
    }
}

struct OtpModifer: ViewModifier {
    @Binding var pin : String
    var textLimt = 1
    
    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
            .frame(width: 50, height: 50)
            .textContentType(.oneTimeCode)
            .overlay(
                Circle()
                    .stroke(.gray, lineWidth: 1)
            )
    }
}
