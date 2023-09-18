//
//  VerificationCodeView.swift
//  FluxStore
//
//  Created by Berker Saptas on 30.08.2023.
//

import SwiftUI
import Combine
import Foundation



struct VerificationCodeView: View {
    
    var userEmail : String?
    
    @State private var continueClicked : Bool = false
    @FocusState private var pinFocusState : FocusPin?
    
    @State private var pinOne: String = ""
    @State private var pinTwo: String = ""
    @State private var pinThree: String = ""
    @State private var pinFour: String = ""
    
    @State private var timeRemaining = 59
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timerIsFinish : Bool = false
    
    @State private var toast: Toast? = nil
    
    var body: some View {
        NavigationStack {
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
                if !timerIsFinish {
                    Text("Resend in 00:\(String(format: "%02d", timeRemaining))")
                        .opacity(0.5).frame(maxWidth: .infinity, alignment: .leading)
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                            } else {
                                timerIsFinish = true
                                timer.upstream.connect().cancel()
                            }
                        }
                        .padding()
                } else {
                    Button {
                        timeRemaining = 59
                        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                        timerIsFinish = false
                    } label: {
                        Text("Resend verification code")
                    }.frame(maxWidth: .infinity, alignment: .leading).padding()
                }
                Spacer()
                PrimaryButton(text: "Continue", onTap: {
                    if pinOne.isEmpty || pinTwo.isEmpty || pinThree.isEmpty || pinFour.isEmpty {
                        toast = Toast(type: .warning, title: "Warning", message: "Code field cannot be left blank and must contain")
                        return
                    }
                    timer.upstream.connect().cancel()
                    continueClicked = true
                })
            }
            .adaptsToKeyboard()
            .padding()
            .navigationDestination(isPresented: $continueClicked) {
                CreateNewPasswordView(userEmail: userEmail)
            }
            .modifier(BasicToolBar(destination: AnyView(ForgetPasswordView())))
            .toastView(toast: $toast)
        }
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
