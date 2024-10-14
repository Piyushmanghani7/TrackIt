//
//  ContentView.swift
//  TrackIt
//
//  Created by Piyush Manghani on 10/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        VStack {
            // Camera and Gallery options in horizontal stack
            HStack(spacing: 20) {
                Button(action: {
                    self.sourceType = .camera
                    self.isImagePickerPresented = true
                }) {
                    VStack {
                        Image(systemName: "camera")
                            .font(.system(size: 30))
                        Text("Camera")
                    }
                }
                .buttonStyle(RoundedButtonStyle())

                Button(action: {
                    self.sourceType = .photoLibrary
                    self.isImagePickerPresented = true
                }) {
                    VStack {
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: 30))
                        Text("Gallery")
                    }
                }
                .buttonStyle(RoundedButtonStyle())
            }
            .padding(.top, 30)

            Spacer()

            // Selected image in the middle
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            } else {
                Text("No image selected")
                    .font(.title)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Stylish submit button at the bottom
            Button(action: {
                // Handle submit action here
                print("Image submitted")
            }) {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedImage != nil ? Color.blue : Color.gray)
                    .cornerRadius(10)
            }
            .disabled(selectedImage == nil)
            .padding(.bottom, 30)
            .padding(.horizontal)
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage, sourceType: sourceType)
        }
    }
}

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    ContentView()
}
