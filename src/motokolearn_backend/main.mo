import Int "mo:base/Int";

actor {
  class Counter(init : Nat) {
    var c = init;
    public func inc() : Nat { c += 1; c };
    public func getC() : Text { 
      var ret: Text = ""; 
      if (c == 0) {
          ret := Int.toText(c);
      }
      else {
          let aux = Int.toText(c);
          c -= 1;
          ret := Int.toText(c) # getC();
      };
      return ret;
    };
  };
  public query func greet(name : Text) : async Text {
    let c = Counter(2);
    let aux = c.getC();
    return aux # "Hello2, " # name # "!";
  };
};
