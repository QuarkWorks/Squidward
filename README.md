# Squidward

[![Build Status](https://travis-ci.org/QuarkWorks/Squidward.svg?branch=master)](https://travis-ci.org/QuarkWorks/Squidward)

Squidward is a iOS framework that reduces the plumbing required for creating constraints in code using auto layout. The api is to match the current anchor system as much as possible so the learning curve is small and the magic is minimal. Here are the main use cases to help you get started.


### All Edges
```
// From
NSLayoutConstraint.activate([
    view.topAnchor.constraint(equalTo: superView.topAnchor, constant: 10),
    view.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 20),
    view.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -30),
    view.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -40)
])

// To
NSLayoutConstraint.activate([
    view.edgeAnchors.constraint(equalTo: superView.edgeAnchors, 
    insets: UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40))
])
```

### Center and Size
```
// From

NSLayoutConstraint.activate([
    view.centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: 10),
    view.centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: 20),

    view.widthAnchor.constraint(equalTo: superView.widthAnchor, constant: 30),
    view.heightAnchor.constraint(equalTo: superView.heightAnchor, constant: 30),
])

// To

NSLayoutConstraint.activate([
    view.centerAnchors.constraint(eqaulTo: superView.centerAnchors, offset: UIOffset(horizontal: 10, vertical: 20)),
    view.sizeAnchors.constraint(equalTo: superView.sizeAnchors, offset: UIOffset(horizontal: 20, vertical: 30))
])
```

### Assignment and Priority
```
// From

var leftConstraint: NSLayoutConstraint! = view.leftAnchor.constraint(equalTo: superView.leftAnchor)
leftConstraint.priority = UILayoutPriorityDefaultLow

NSLayoutConstraint.activate([
    leftConstraint,
])

// To 

NSLayoutConstraint.activate([
    view.leftAnchor.constraint(equalTo: superView.leftAnchor)
        .prioritize(UILayoutPriorityDefaultLow).assign(to: &leftConstraint),
])
```

### Corners
```
// From

NSLayoutConstraint.activate([
        view.leftAnchor.constraint(equalTo: superView.rightAnchor),
        view.topAnchor.constraint(equalTo: superView.bottomAnchor)
])

// To

NSLayoutConstraint.activate([
    view.cornerAnchors(for: .topLeft).constraint(eqaulTo: superView.cornerAnchors(for: .bottomRight))
])
```

### Specific Edges
```        
// From

NSLayoutConstraint.activate([
    view.leftAnchor.constraint(equalTo: superView.leftAnchor),
    view.topAnchor.constraint(equalTo: superView.topAnchor),
    view.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
])

// To

NSLayoutConstraint.activate([
    view.edgeAnchors.constraint(edges: [.left, .top, .bottom], equalTo: superView.edgeAnchors)
])
```
