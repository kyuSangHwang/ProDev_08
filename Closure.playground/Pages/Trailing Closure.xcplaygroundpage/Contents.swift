//: [Previous](@previous)

var a: () -> Void = { () -> Void in return print("Hello, world") }

a()

func simpleExample(closure: () -> Void) {
    print("1. Wake up")
    closure()
    print("4. Eat breakfast")
}

simpleExample() {
    print("---2. Go to bathroom")
    print("---3. Brush teeth")
}

//: [Next](@next)
