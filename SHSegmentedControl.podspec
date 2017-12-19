

Pod::Spec.new do |s|

  s.name         = "SHSegmentedControl"
  s.version      = "0.0.1"
  s.summary      = "A short description of SHSegmentedControl."
  s.description  = <<-DESC
                   DESC
  s.homepage     = "https://github.com/HatsuneMikuV/SHSegmentedControlTableView"
  s.license      = "Apache-2.0"
  s.authors            = { "Icarus" => "15188588180@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/HatsuneMikuV/SHSegmentedControlTableView.git", :tag => "s.version" }
  s.source_files  = "SHSegmentedControlTableView/SHSegmentedControl/**/*.{h,m}"
  s.requires_arc = true

end
