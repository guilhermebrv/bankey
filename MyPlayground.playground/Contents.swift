import UIKit

var greeting = "Hello, playground"

var S = "print://axxy/pp.pdf://test"

var newString = S.split(separator: "://", maxSplits: 1)
print(newString)
