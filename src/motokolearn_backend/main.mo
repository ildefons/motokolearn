import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Array "mo:base/Array";

// actor {

//   let o = Array.tabulate<Nat>(1000_000, func i { i });

//   func sum(i : Nat, acc : Nat) : Nat {
//     if (i < o.size()) {
//       sum(i + 1, acc + o[i]);
//     } else acc;
//   };

//   func tot(a : [Nat], i : Nat, acc : Nat) : Nat {
//     if (i < a.size()) {
//       tot(a, i + 1, acc + a[i]);
//     } else acc;
//   };

//   class Summer(a : [Nat]) {
//     public func sum(i : Nat, acc : Nat) : Nat {
//       if (i < a.size()) {
//         sum(i + 1, acc + a[i]);
//       } else acc;
//     };
//   };

//   public func doSum() : async Nat {
//     return sum(0, 0);
//   };

//   public func doTot() : async Nat {
//     return tot(o, 0, 0);
//   };

//   public func doSummer() : async Nat {
//     return Summer(o).sum(0, 0);
//   };

// };

actor {

  // var actor_data: [Nat] = [1,2,3];
  type dataMember = {
    #number : Nat; // variant 
    #symbol : Text; 
  };
  var actor_data: [dataMember] = [#number(1), #symbol("2"), #number(3)];
  
  class Counter(init : Nat) {
    var c = init;
    var data : [[Nat]] = [[1, 2, 3], 
                          [4, 5, 6], 
                          [7, 8, 9], 
                          [10, 11, 12]];
    public func inc() : Nat { c += 1; c };
    public func getData() : [[Nat]] {data;};
    public func getC() : Text { 
      var ret: Text = ""; 
      if (c == 0) {
          ret := Int.toText(c);
      }
      else {
          let aux = Int.toText(c);
          c -= 1;
          ret := Int.toText(c) # "," # getC();
      };
      return ret;
    };
  };
  
  // Note: in the end I will make a class but by the time being I just make an actor with functions
  // function: set training dataset
  // dummy function declaration to train a tree with the right declaration
  // dummy function declaration to make a prediction
  // function: compute, entropy and Gini index for the dataset
  // function: identify classification or regression problem
  // think what info is necessary in every node of the tree: 
  // 1) row ids of the dataset considered in this node
  // 2) attribute column id (number) used in this node to partition the dataset
  // 3) threshold of dataset partition
  // 4) left/right child nodes node
  // 5) node average label or probability vector  

  public func vote(entry: [dataMember]) : async dataMember {
    actor_data := entry;
    let aux2: dataMember = actor_data[2];
    return aux2;
  };
  public query func greet(name : Text) : async Text {
    let c = Counter(1);
    let aux = c.getC();
    let aux2 = c.getData()[1][2];
    return Nat.toText(aux2) # " Hello2, " # name # "!";
  };
};
