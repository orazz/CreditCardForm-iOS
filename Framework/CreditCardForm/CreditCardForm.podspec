
Pod::Spec.new do |s|

  s.name         = "CreditCardForm"
  s.version      = "1.0.0"
  s.summary      = "CreditCardForm is iOS framework"

  s.description  = "CreditCardForm is iOS framework that allows developers to create the UI which replicates an actual Credit Card"
  s.homepage     = "https://github.com/CreditCardForm"

  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }

  s.author             = { "orazz" => "orazz.tm@gmail.com" }

  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/orazz/CreditCardForm-iOS.git", :tag => "v1.0.0" }

  s.source_files  = "CreditCardForm", "Classes/**/*.{h,m,swift}"

  s.resource  = "CreditCardForm/*.png"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }
end
