import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Float "mo:base/Float";
import Text "mo:base/Text";
import Array "mo:base/Array";
import TrieSet "mo:base/TrieSet";
import Debug "mo:base/Debug";
import Prim "mo:prim";

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
    #number : Float; // variant 
    #symbol : Text; 
  };
  var actor_data: [[dataMember]] = [[#number(1), #number(3), #symbol("2")],
                                    [#number(2), #number(2), #symbol("1")],
                                    [#number(3), #number(3), #symbol("2")],
                                    [#number(4), #number(2), #symbol("1")]];
  
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
  
  func hashText(key: Text): Nat32 {
    Prim.hashBlob(Prim.encodeUtf8(key)) & 0x3fffffff;
  };
  func hashNat(key: Nat): Nat32 {
    var hash = Prim.intToNat64Wrap(key);

    hash := hash >> 30 ^ hash *% 0xbf58476d1ce4e5b9;
    hash := hash >> 27 ^ hash *% 0x94d049bb133111eb;

    Prim.nat64ToNat32(hash >> 31 ^ hash & 0x3fffffff);
  };
  // Note: in the end I will make a class but by the time being I just make an actor with functions and vars
  // function: set training dataset
  // dummy function declaration to train a tree with the right declaration
  // dummy function declaration to make a prediction
  // function: compute, entropy and Gini index for the dataset

  // Develope matrix module inspyred in Array module
  // 1) understand, to/from vec(vec), filterByListofIndexes, filterbyrowsandcols
  // https://forum.dfinity.org/t/how-to-index-a-matrix-to-get-a-subset-of-rows-and-or-columns/23887/4?u=ildefons
  func rows<T>(rs : [Nat], m : [[T]]) : [[T]] {
    Debug.print("rs size:" # Nat.toText(rs.size()));
    Debug.print("m size:" # Nat.toText(m.size()));
    Array.tabulate<[T]>(rs.size(), func r { m[rs[r]] });
  };

  func cols<T>(cs : [Nat], m : [[T]]) : [[T]] {
    Array.tabulate<[T]>(m.size(), func r {
      Array.tabulate<T>(cs.size(), func c { m[r][cs[c]] }) });
  };
  // 2) do error checking s.t. indexes fall within matrix dimensions
  func min(rs: [Float]) : Float {
    let aux = Array.sort(rs, Float.compare);
    aux[0];
  };
  func max(rs: [Float]) : Float {
    let aux = Array.sort(rs, Float.compare);
    aux[rs.size()-1];
  };
  func mean(rs: [Float]) : Float {
    let sum = Array.foldLeft<Float, Float>(rs, 0, func(sumSoFar, x) = sumSoFar + x);
    let ret : Float = sum/Float.fromInt(rs.size());
    ret;
  };
  func median(rs: [Float]) : Float {
    let aux = Array.sort(rs, Float.compare);
    var ret: Float = 0;
    let pos = aux.size()/2;
    let rem = aux.size()%2;
    if (rem == 0) {
      ret := (aux[pos-1]+aux[pos])/2;
    } else {
      ret := aux[pos];
    };
    ret;
  };
  func uniquesNat(rs: [Nat]): [Nat] {
    let myset = TrieSet.fromArray<Nat>(rs, hashNat, Nat.equal);
    let uniques = TrieSet.toArray(myset);
    uniques;
  };
  func uniquesText(rs: [Text]): [Text] {
    let myset = TrieSet.fromArray<Text>(rs, hashText, Text.equal);
    let uniques = TrieSet.toArray(myset);
    uniques;
  };
  func entropy(rs: [Text]): Float {
    let y_uniques = uniquesText(rs);

    0;
  };
  // are there max min mean median with vector ?

  // function: identify classification or regression problem
  // think what info is necessary in every node of the tree: 
  // 1) row ids of the dataset considered in this node
  // 2) attribute column id (number) used in this node to partition the dataset
  // 3) threshold of dataset partition
  // 4) left/right child nodes node
  // 5) node average label or probability vector  

  public func setTrainingData(data: [[dataMember]]) : async () {
    actor_data := data;
    // identify classification vs regression aaf of last column type
    // 
  };
  
  public func train(): async () {
    //
  };
  
  public func predict(data: [[dataMember]]) : async () {
    //
  }; 
  
  public query func greet(name : Text) : async [[Float]] {
    let c = Counter(1);
    let matrix : [[Float]] = [[1,2,3],
                            [4,5,6],
                            [7,8,9],[10,20,30],[11,22,33]]; 

    let auxr : [[Float]] = rows([0, 2], matrix);
    let auxc : [[Float]] = cols([0, 2], matrix);
    Debug.print("min:" # Float.toText(min(matrix[0])) );
    Debug.print("max:" # Float.toText(max(matrix[0])) );
    Debug.print("mean:" # Float.toText(mean(matrix[0])) ); 
    Debug.print("median1:" # Float.toText(median(matrix[0])) );
    Debug.print("median2:" # Float.toText(median(matrix[1])) );
    // let aux : [[Nat]] = matrix[[1,2]];
    // let set1 = TrieSet.fromArray<Nat>([1, 2, 3, 1, 2, 3, 1], Nat32.fromNat, Nat.equal);
    // let vals1 = TrieSet.toArray(set1);
    // for (element in vals1.vals()) {
    //   Debug.print("val:" # Nat.toText(element));
    // };
    // let set2 = TrieSet.fromArray<Text>(["1", "2", "3", "1", "2", "3", "1"], hashText, Text.equal);
    // let vals2 = TrieSet.toArray(set2);
    let textVec = ["is a text", "2", "3", "1", "2", "3", "1"];
    let aux = textVec[0];
    switch (aux) {
      case (Text) {
        Debug.print("is a text:" # aux);
      };
    };
    // NEXT:----> check is type symbol?
    // https://internetcomputer.org/docs/current/motoko/main/errors#what-error-type-to-prefer
    let myuniques = uniquesText(textVec);
    for (element in myuniques.vals()) {
      Debug.print("val:" # element);
    };
    //return "matrix value: " # Nat.toText(aux) ;
    return auxc;
  };
};
