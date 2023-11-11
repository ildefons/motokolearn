import Text "mo:base/Text";
import Char "mo:base/Char";
import Nat8 "mo:base/Nat8";
import Float "mo:base/Float";
import Nat32 "mo:base/Nat32";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

module {

    public type dataMember = {
        #number : Float;
        #symbol : Text; 
    };

    public func printSample(x: [dataMember]): (Text) {
      var x_text: Text = "";
      for (i in Iter.range(0, x.size() - 1)) {
        
        switch (x[i]) {
          case (#symbol(sym)) {
            x_text := x_text # sym;
          };
          case (#number(num)) {
            x_text := x_text # Float.toText(num);
          };
        };
        if (i < x.size()) {
          x_text := x_text #", "
        };
      }; 
      return x_text;
    };
};