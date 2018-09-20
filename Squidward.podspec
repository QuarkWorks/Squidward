Pod::Spec.new do |s|
    s.name = "Squidward"
    s.version = "2.4.0"
    s.summary = "Squidward is an iOS framework that reduces the plumbing of working with UIKit."
    s.homepage = "https://github.com/QuarkWorks/Squidward"
    s.license = "MIT"
    s.author = "QuarkWorks"
    s.platform = :ios, "9.0"
    s.source = { :git => "https://github.com/QuarkWorks/Squidward.git", :tag => "2.4.0" }
    s.source_files = "Squidward", "Source/**/*.{h,m,swift}"
end
