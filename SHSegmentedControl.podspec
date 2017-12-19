

Pod::Spec.new do |s|

  s.name         = "SHSegmentedControl"
  s.version      = "1.0.2"
  s.summary      = "Custom a SHSegmentedControl."
  s.description  = <<-DESC
                   Both scroll horizontal and vertical for segment scrollview which have a same header
                   DESC
  s.homepage     = "https://github.com/HatsuneMikuV/SHSegmentedControlTableView"
  s.license      = { :type => 'MIT' }
  s.authors      = { "Icarus" => "15188588180@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/HatsuneMikuV/SHSegmentedControlTableView.git", :tag => s.version }
  s.source_files  = "SHSegmentedControl/**/*.{h,m}"
  s.requires_arc = true

end
