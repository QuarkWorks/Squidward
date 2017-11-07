Pod::Spec.new do |s|
          #1.
          s.name               = "Squidward"
          #2.
          s.version            = "1.0.0"
          #3.  
          s.summary         = "Squidward is an iOS framework that reduces the plumbing required for creating constraints in code using auto layout."
          #4.
          s.homepage        = "https://github.com/QuarkWorks/Squidward"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "QuarkWorks"
          #7.
          s.platform            = :ios, "11.0"
          #8.
          s.source              = { :git => "https://github.com/QuarkWorks/Squidward.git", :tag => "1.0.0" }
          #9.
          s.source_files     = "Squidward", "Source/*.{h,m,swift}"
    end