Pod::Spec.new do |s|
    s.name = "Squidward"
    s.version = "1.2.1"
    s.summary = "Squidward is an iOS framework that reduces the plumbing required for creating constraints in code using auto layout."
    s.homepage = "https://github.com/QuarkWorks/Squidward"
    s.license = "MIT"
    s.author = "QuarkWorks"
    s.platform = :ios, "9.0"
    s.source = { :git => "https://github.com/QuarkWorks/Squidward.git", :tag => "1.2.1" }
    s.source_files = "Squidward", "Source/*.{h,m,swift}"
end
