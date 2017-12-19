

Pod::Spec.new do |s|

  s.name         = "SHSegmentedControl"
  s.version      = "0.0.1"
  s.summary      = "A short description of SHSegmentedControl."
  s.description  = <<-DESC
                   DESC
  s.homepage     = "http://EXAMPLE/SHSegmentedControl"
  s.license      = "Apache-2.0"
  s.authors            = { "Icarus" => "15188588180@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "http://EXAMPLE/SHSegmentedControl.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.requires_arc = true

end
