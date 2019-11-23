import UIKit

// part1

var str = "Hello, playground"

for l in str {
    print(l)

}

let letter = str[str.index(str.startIndex, offsetBy: 3)]

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

let l2 = str[5]

// part2
 
let password = "12345"

password.hasPrefix("123")
password.hasPrefix("456")

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

let weather = "its going to rain"
print(weather.capitalized)

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}


let input = "Swift is like obj-c without the C"
input.contains("Swift")


let languages = ["Python","Ruby","Swift"]
languages.contains("Swift")

extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }
        return false
    }
}

input.containsAny(of: languages)

languages.contains(where: input.contains)

// part3

let string = "This is test string1"

let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSAttributedString(string: string, attributes: attributes)


let secondAttributedString = NSMutableAttributedString(string: string)
secondAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: 4))
secondAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
secondAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 10, length: 1))

//challenge1
extension String {
    func withPrefix(prefix: String) -> String {
        return prefix+self
    }
}

string.withPrefix(prefix: "WEE")


//challenge2
extension String {
    func isNumeric() -> Bool {
        let numbers = [0,1,2,3,4,5,6,7,8,9]

        for num in numbers {
            if self.contains(String(num)) {
                return true
            }
        }
        return false
    }
}

string.isNumeric()

//challenge3

extension String {
    var lines: [String] {
        guard !self.isEmpty else { return [""] }
        return self.components(separatedBy: "\n")
    }
}

let testString = "this\nis\na\ntest"
print(testString.lines)




