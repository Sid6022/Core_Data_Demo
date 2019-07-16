//
//  ValidationService.swift
//
//  Created by Pritesh Patel on 11/23/16.
//  Copyright © 2016 Pritesh Patel. All rights reserved.
//

/// frameworks import
// MARK: - frameworks import
import UIKit
import Foundation


/// classes import
// MARK: - classes import



struct ValidationConstant {
    
    struct Regex {
            
        //static let EmailValidation : String! = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
        //static let EmailValidation : String! = "[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}"
        static let EmailValidation = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" + "\\@" + "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" + "(" + "\\." + "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" + ")+"
        
        //static let PhoneValidation : String! = "^\\d{3}-\\d{3}-\\d{4}$"
        static let PhoneValidation : String! = "^((\\+)|(00)|(\\*)|())[0-9]{10,16}((\\#)|())$"

        static let UrlValidation = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?"

    }

    struct Numeric {
        
        static let INTEGER : String! = "0123456789"
        static let FLOAT : String! = ".0123456789"
        static let NUMERIC : String! = "0123456789@$ +!=*&"

        static let zero = 0
        static let one = 0

    }
    
    struct Text {
        
        static let ALPHA : String! = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        static let ALPHA_NUMERIC : String! = ALPHA + Numeric.NUMERIC

        static let null1 = "<null>"
        static let null2 = "<NULL>"
        static let null3 = "(null)"
        static let null4 = "(NULL)"
        static let null5 = "null"
        static let null6 = "NULL"
        static let blank = ""
        static let space = " "
        static let newline = "\n"
        
    }

    
}

//***********************************************************************

// MARK: - String
extension String
{
    
    // MARK: - length
    var length: Int {
        return self.count
    }

    // MARK: - isNull
    var isNull: Bool
    {
        
        let string = self.replacingOccurrences(of: " ", with: "")
        
        if (
            string.isEmpty
            || string == ValidationConstant.Text.null1
            || (string == ValidationConstant.Text.null2)
            || (string == ValidationConstant.Text.null3)
            || (string == ValidationConstant.Text.null4)
            || (string == ValidationConstant.Text.null5)
            || (string == ValidationConstant.Text.null6)
            || string.count == ValidationConstant.Numeric.zero
            || (string == ValidationConstant.Text.blank)
            || (string == ValidationConstant.Text.space)
            || (string == ValidationConstant.Text.newline)
            || string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == ValidationConstant.Numeric.zero
            )
        {
            return true
        }

        return false

    }
    
    // Mark:  trim
    var trim: String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    // MARK: - isEqualTo
    func isEqual(string: String) -> Bool
    {
        return self == string
    }

    // MARK: - isValidLength
    func isValidLength(min: Int, max: Int) -> Bool
    {
        if (self.count >= min) && (self.count <= max)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    // MARK: - isValidTrimLength
    func isValidTrimLength(min: Int, max: Int) -> Bool
    {
        if (self.trim.count >= min) && (self.trim.count <= max)
        {
            return true
        }
        else
        {
            return false
        }
    }

    // MARK: - occurenceCount
    func occurenceCount(occurenceString: String) -> Int
    {
        return self.components(separatedBy: occurenceString).count - ValidationConstant.Numeric.one
    }
    
    // MARK: - isValidEmail
    var isValidEmail: Bool
    {
        
        //let emailTest = NSPredicate(format:"SELF MATCHES %@", ValidationConstant.Regex.EmailValidation)
        //return emailTest.evaluate(with: self.trim())
        
        let inputText = self as NSString
        let emailRegex = ValidationConstant.Regex.EmailValidation
        let email = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        var aRange: NSRange
        if email.evaluate(with: inputText) {
            aRange = inputText.range(of: ".", options: .backwards, range: NSRange(location: ValidationConstant.Numeric.zero, length: inputText.length))
            let indexOfDot = aRange.location
            if aRange.location != NSNotFound {
                var topLevelDomain = inputText.substring(from: indexOfDot)
                topLevelDomain = topLevelDomain.lowercased()
                let TLD = Set([".aero", ".asia", ".biz", ".cat", ".com", ".coop", ".edu", ".gov", ".info", ".int", ".jobs", ".mil", ".mobi", ".museum", ".name", ".net", ".org", ".pro", ".tel", ".travel", ".ac", ".ad", ".ae", ".af", ".ag", ".ai", ".al", ".am", ".an", ".ao", ".aq", ".ar", ".as", ".at", ".au", ".aw", ".ax", ".az", ".ba", ".bb", ".bd", ".be", ".bf", ".bg", ".bh", ".bi", ".bj", ".bm", ".bn", ".bo", ".br", ".bs", ".bt", ".bv", ".bw", ".by", ".bz", ".ca", ".cc", ".cd", ".cf", ".cg", ".ch", ".ci", ".ck", ".cl", ".cm", ".cn", ".co", ".cr", ".cu", ".cv", ".cx", ".cy", ".cz", ".de", ".dj", ".dk", ".dm", ".do", ".dz", ".ec", ".ee", ".eg", ".er", ".es", ".et", ".eu", ".fi", ".fj", ".fk", ".fm", ".fo", ".fr", ".ga", ".gb", ".gd", ".ge", ".gf", ".gg", ".gh", ".gi", ".gl", ".gm", ".gn", ".gp", ".gq", ".gr", ".gs", ".gt", ".gu", ".gw", ".gy", ".hk", ".hm", ".hn", ".hr", ".ht", ".hu", ".id", ".ie", " No", ".il", ".im", ".in", ".io", ".iq", ".ir", ".is", ".it", ".je", ".jm", ".jo", ".jp", ".ke", ".kg", ".kh", ".ki", ".km", ".kn", ".kp", ".kr", ".kw", ".ky", ".kz", ".la", ".lb", ".lc", ".li", ".lk", ".lr", ".ls", ".lt", ".lu", ".lv", ".ly", ".ma", ".mc", ".md", ".me", ".mg", ".mh", ".mk", ".ml", ".mm", ".mn", ".mo", ".mp", ".mq", ".mr", ".ms", ".mt", ".mu", ".mv", ".mw", ".mx", ".my", ".mz", ".na", ".nc", ".ne", ".nf", ".ng", ".ni", ".nl", ".no", ".np", ".nr", ".nu", ".nz", ".om", ".pa", ".pe", ".pf", ".pg", ".ph", ".pk", ".pl", ".pm", ".pn", ".pr", ".ps", ".pt", ".pw", ".py", ".qa", ".re", ".ro", ".rs", ".ru", ".rw", ".sa", ".sb", ".sc", ".sd", ".se", ".sg", ".sh", ".si", ".sj", ".sk", ".sl", ".sm", ".sn", ".so", ".sr", ".st", ".su", ".sv", ".sy", ".sz", ".tc", ".td", ".tf", ".tg", ".th", ".tj", ".tk", ".tl", ".tm", ".tn", ".to", ".tp", ".tr", ".tt", ".tv", ".tw", ".tz", ".ua", ".ug", ".uk", ".us", ".uy", ".uz", ".va", ".vc", ".ve", ".vg", ".vi", ".vn", ".vu", ".wf", ".ws", ".ye", ".yt", ".za", ".zm", ".zw"])
                if topLevelDomain.isEmpty == false && (TLD.contains(topLevelDomain)) {
                    return true
                }
            }
        }

        return false
        
    }
    /**
     * Password validation
     */
    var isValidPassword : Bool
    {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    var isValidURL : Bool
    {
        //linkDetector.matches(in: string, options: [], range: NSRange(location: 0, length: length))
        let text = self
        let types: NSTextCheckingResult.CheckingType = .link
        
        let detector = try? NSDataDetector(types: types.rawValue)
        
        let matches = detector?.matches(in: text, options: .reportCompletion, range: NSMakeRange(0, text.count))
        
        for _ in matches! {
            //debugPrint(match)
            return true
        }
        
        return false
    }
    
//    func isValidURL() -> Bool {
//        var length: Int = self.length
//        // Empty strings should return NO
//        do {
//            if length > 0 {
//                var error: Error? = nil
//                var dataDetector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//                if dataDetector && !error {
//                    var range = NSRange(location: 0, length: length)
//                    var notFoundRange: NSRange = [NSNotFound, 0]
//                    var linkRange: NSRange = dataDetector.rangeOfFirstMatch(in: self, options: [], range: range)
//                    if !NSEqualRanges(notFoundRange, linkRange) && NSEqualRanges(range, linkRange) {
//                        return true
//                    }
//                }
//                else {
//                    print("Could not create link data detector: \(error?.localizedDescription) \(error?._userInfo)")
//                }
//            }
//        }
//        catch {
//        }
//        return false
//    }
    // MARK: - isValidPhone
    var isValidPhone: Bool
    {
        let phone = NSPredicate(format:"SELF MATCHES %@", ValidationConstant.Regex.PhoneValidation)
        return phone.evaluate(with: trim)
    }
    
    // MARK: - isValidUrl
    var isValidUrl: Bool
    {
        let url = NSPredicate(format:"SELF MATCHES %@", argumentArray:[ValidationConstant.Regex.UrlValidation])
        return url.evaluate(with: trim)
    }
    
    // MARK: - isInteger
    var isInteger: Bool
    {
        let numbersOnly = NSCharacterSet(charactersIn: ValidationConstant.Numeric.INTEGER)
        let characterSetFromText = NSCharacterSet(charactersIn: self)
        let isValid = numbersOnly.isSuperset(of: characterSetFromText as CharacterSet)
        return isValid
    }
    
    // MARK: - isFloat
    var isFloat: Bool
    {
        let floatsOnly = NSCharacterSet(charactersIn: ValidationConstant.Numeric.FLOAT)
        let characterSetFromText = NSCharacterSet(charactersIn: self)
        let isValid = floatsOnly.isSuperset(of: characterSetFromText as CharacterSet)
        if isValid == true {
            let charCount = self.count
            if charCount == ValidationConstant.Numeric.one
            {
                let firstChar = self.first
                return firstChar != "."
            }
        }
        return isValid
    }
    
    // MARK: - isAlphabetic
    var isAlphabetic: Bool
    {
        let alphabetsOnly = NSCharacterSet(charactersIn: ValidationConstant.Text.ALPHA)
        let characterSetFromText = NSCharacterSet(charactersIn: self)
        let isValid = alphabetsOnly.isSuperset(of: characterSetFromText as CharacterSet)
        return isValid
    }
    
    // MARK: - isNumeric
    var isNumeric: Bool
    {
        let numericsOnly = NSCharacterSet(charactersIn: ValidationConstant.Numeric.NUMERIC)
        let characterSetFromText = NSCharacterSet(charactersIn: self)
        let isValid = numericsOnly.isSuperset(of: characterSetFromText as CharacterSet)
        return isValid
    }
    
    // MARK: - isAlphaNumeric
    var isAlphaNumeric: Bool
    {
        let alphaNumericsOnly = NSCharacterSet(charactersIn: ValidationConstant.Text.ALPHA_NUMERIC)
        let characterSetFromText = NSCharacterSet(charactersIn: self)
        let isValid = alphaNumericsOnly.isSuperset(of: characterSetFromText as CharacterSet)
        return isValid
    }

    // MARK: - isIntegerWithValidLength
    func isIntegerWithValidLength(maxLength: Int) -> Bool {
        let numbersOnly = NSCharacterSet(charactersIn: ValidationConstant.Numeric.INTEGER)
        let characterSetFromText = NSCharacterSet(charactersIn: self)
        let isValid = numbersOnly.isSuperset(of: characterSetFromText as CharacterSet)
        if isValid == true {
            if maxLength > ValidationConstant.Numeric.zero && self.count > maxLength {
                return !isValid
            }
        }
        return isValid
    }
    
    // MARK: - isFloatWithValidLength
    func isFloatWithValidLength(maxLength: Int) -> Bool {
        let floatsOnly = NSCharacterSet(charactersIn: ValidationConstant.Numeric.FLOAT)
        let characterSetFromText = NSCharacterSet(charactersIn: self)
        let isValid = floatsOnly.isSuperset(of: characterSetFromText as CharacterSet)
        if isValid == true {
            if  maxLength > ValidationConstant.Numeric.zero && self.count > maxLength {
                return !isValid
            }
            let charCount = self.count
            if charCount == ValidationConstant.Numeric.one
            {
                let firstChar = self.first
                return firstChar != "."
            }
        }
        return isValid
    }
    
    // MARK: - isAlphabeticWithValidLength
    func isAlphabeticWithValidLength(maxLength: Int) -> Bool {
        let alphabetsOnly = NSCharacterSet(charactersIn: ValidationConstant.Text.ALPHA)
        let characterSetFromText = NSCharacterSet(charactersIn: self)
        let isValid = alphabetsOnly.isSuperset(of: characterSetFromText as CharacterSet)
        if isValid == true {
            if  maxLength > ValidationConstant.Numeric.zero && self.count > maxLength {
                return !isValid
            }
        }
        return isValid
    }
    
    // MARK: - isNumericWithValidLength
    func isNumericWithValidLength(maxLength: Int) -> Bool {
        let numericsOnly = NSCharacterSet(charactersIn: ValidationConstant.Numeric.NUMERIC)
        let characterSetFromText = NSCharacterSet(charactersIn: self)
        let isValid = numericsOnly.isSuperset(of: characterSetFromText as CharacterSet)
        if isValid == true {
            if  maxLength > ValidationConstant.Numeric.zero && self.count > maxLength {
                return !isValid
            }
        }
        return isValid
    }
    
    // MARK: - isAlphaNumericWithValidLength
    func isAlphaNumericWithValidLength(maxLength: Int) -> Bool {
        let alphaNumericsOnly = NSCharacterSet(charactersIn: ValidationConstant.Text.ALPHA_NUMERIC)
        let characterSetFromText = NSCharacterSet(charactersIn: self)
        let isValid = alphaNumericsOnly.isSuperset(of: characterSetFromText as CharacterSet)
        if isValid == true {
            if  maxLength > ValidationConstant.Numeric.zero && self.count > maxLength {
                return !isValid
            }
        }
        return isValid
    }
//    // MARK: URL Validation
//    func verifyUrl (urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url  = NSURL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url as URL)
//            }
//        }
//        return false
//    }
    /*
     NSPredicate *websitePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(((((h|H)(t|T){2}(p|P)s?)|((f|F)(t|T)(p|P)))://(w{3}.)?)|(w{3}.))[A-Za-z0-9]+(.[A-Za-z0-9-:;\?#_]+)+"];
     if ([websitePredicate evaluateWithObject:##MY_STRING##])
     {
     printf"Valid"
     }
     */
//    func validateURL(strURL :  Any)-> Bool
//    {
//        /*
//         NSURLRequest *req = [NSURLRequest requestWithURL:candidate];
//         return [NSURLConnection canHandleRequest:req];
//         */
//        
//        
//        
////        let strRegex = "(http|https|www|Www)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
////        //  NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
////        //return [urlTest evaluateWithObject:candidate];
////        let urlTest = NSPredicate(format: "SELF MATCHES %@", strRegex)
////        return urlTest.evaluate(with: strURL)
//    }
    
    func verifyUrl (urlString: String?) -> Bool {
        
        if let urlString = urlString {
            
            if let _  = NSURL(string: urlString) {
                
                return true
                
            }
            
        }
        
        return false
        
    }
    
    /**
     Verify Mobile number
     */
    var verifyPhoneNumber: Bool
    {
        let strMoNo = self
        
        if strMoNo.isEmpty == true
        {
            return false
        }
        else
        {
            if strMoNo.count > 5 && strMoNo.count < 10+1
            {
                if strMoNo.first == "6" || strMoNo.first == "7" || strMoNo.first == "8" || strMoNo.first == "9"
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            else
            {
                return false
            }
        }
        
       
    }
    
    
}

//***********************************************************************

// MARK: - Dictionary
extension Dictionary
{

    // MARK: - isNonEmpty
    var isNonEmpty: Bool
    {
        if self.count > ValidationConstant.Numeric.zero
        {
            return true
        }
        return false
    }
    
    // MARK: - hasKey
    func hasKey(key: String) -> Bool
    {
        if self.count > ValidationConstant.Numeric.zero
        {
            for dictKey in self.keys
            {
                if dictKey as! String == key
                {
                    return true
                }
            }
        }
        return false
    }

}

//***********************************************************************

// MARK: - Array
extension Array
{
    
    // MARK: - isNonEmpty
    var isNonEmpty: Bool
    {
        if self.count > ValidationConstant.Numeric.zero
        {
            return true
        }
        return false
    }

}

//***********************************************************************

extension String{
    
    func getDateFromInterval(formate : String) -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = formate
        return dateformatter.string(from: NSDate(timeIntervalSinceReferenceDate: ceil(Double(self)!)) as Date)
    }
    

}
extension Date{
    
    func getDoubleTimeInterval() -> Double{
        return self.timeIntervalSinceReferenceDate * 100000
    }
    func getInt64TimeInterval() -> Int64{
        return Int64(self.timeIntervalSinceReferenceDate * 100000)
    }
    func getStringTimeInterval() -> String{
        
        return String(self.timeIntervalSinceReferenceDate )
    }
    
    func getStringDate(formate:String) -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = formate
        return dateformatter.string(from: self)
    }
    
}
