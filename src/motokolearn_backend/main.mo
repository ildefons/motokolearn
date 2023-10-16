import Int "mo:base/Int";

actor {
  class Counter(init : Nat) {
    var c = init;
    public func inc() : Nat { c += 1; c };
    public func getC() : Nat { c };
  };
  public query func greet(name : Text) : async Text {
    let c = Counter(2);
    let aux = Int.toText(c.getC());
    return aux # "Hello2, " # name # "!";
  };
};
