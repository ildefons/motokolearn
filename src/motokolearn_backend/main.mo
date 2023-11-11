import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Bool "mo:base/Bool";
//import Nat32 "mo:base/Nat32";
import Float "mo:base/Float";
import Text "mo:base/Text";
import Array "mo:base/Array";
import List "mo:base/List";
import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Hash "mo:base/Hash";
import TrieSet "mo:base/TrieSet";
import Debug "mo:base/Debug";
import Result "mo:base/Result";
import Error "mo:base/Error";
import Prim "mo:prim";
import Random "mo:base/Random";
import Blob "mo:base/Blob";
import Fuzz "mo:fuzz";

import mtkl "../Mtklearn/Mtklearn";

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
  // tree
  // inpyred by list:
  // https://github.com/dfinity/motoko-base/blob/master/src/List.mo
  
  // type BinTree<T> = ?(T, BinTree<T>, BinTree<T>);
  // func nilTree<T>() : BinTree<T> = null;
  // func setLeftRightBranch<T>(x : T, leftTree : BinTree<T>, rightTree : BinTree<T>) : BinTree<T> {
  //   ?(x, leftTree, rightTree);
  // };

  public type MotokoLearnError = {
    #notAllYsAreSymbol;
    #sizeMissmatchXY;
    #notAllYsymbols;
    #notExactly2UniqueXSymbols;
    #notAllNumbers;
    #noBestGiniError;
  };

  type dataMember = {
    #number : Float; // variant 
    #symbol : Text; 
  };

  var actor_data: [[dataMember]] = [[#number(1), #number(3), #symbol("1")],
                                    [#number(2), #number(2), #symbol("2")],
                                    [#number(3), #number(3), #symbol("3")],
                                    [#number(4), #number(2), #symbol("4")]];
  
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
  
  // func hashText(key: Text): Nat32 {
  //   Prim.hashBlob(Prim.encodeUtf8(key)) & 0x3fffffff;
  // };

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
//   func rows<T>(rs : [Nat], m : [[T]]) : [[T]] {
//     Array.tabulate<[T]>(rs.size(), func r { m[rs[r]] });
//   };
//   func rowsVector<T>(rs : [Nat], v : [T]) : [T] {
//     Array.tabulate<T>(rs.size(), func r { v[rs[r]] });
//   };
//   func removeRows<T>(rs : [Nat], m : [[T]]) : [[T]] {
//     let rs2 = Buffer.Buffer<Nat>(m.size()); 
//     for (i in Iter.range(0, m.size() - 1)) {
//       let myindex = Array.indexOf<Nat>(i, rs, Nat.equal);
//       switch(myindex) {
//         case null rs2.add(i);
//         case (_) {};
//       };
//     };
//     // for (i in Iter.range(0, Buffer.toArray(rs2).size() - 1)) {
//     //   Debug.print("rs2:"#Nat.toText(Buffer.toArray(rs2)[i]));
//     // };
//     let m2 = rows(Buffer.toArray(rs2), m);
//     return m2;
//   };
//   func removeRowsVector<T>(rs : [Nat], v : [T]) : [T] {
//     let rs2 = Buffer.Buffer<Nat>(v.size()); 
//     for (i in Iter.range(0, v.size() - 1)) {

//       let myindex = Array.indexOf<Nat>(i, rs, Nat.equal);
//       switch(myindex) {
//         case null rs2.add(i);
//         case (_) {};
//       };
//     };
//     let v2 = rowsVector(Buffer.toArray(rs2), v);
//     return v2;
//   };
//   func cols<T>(cs : [Nat], m : [[T]]) : [[T]] {
//     //Debug.print(Nat.toText(cs.size())#":");
//     //Debug.print(Nat.toText(transpose(m).size()));
//     let ret = Array.tabulate<[T]>(m.size(), func r {
//       Array.tabulate<T>(cs.size(), func c { m[r][cs[c]] }) });
//     return ret;
//   };

//   func ncols<T>(m : [[T]]) : Nat {
//     // TODO: check all rows habve same number of elements
//     m[0].size();
//   };

//   func nrows<T>(m : [[T]]) : Nat {
//     m.size();  
//   };
// //----->IM HERE
//   // func init<X>(sizer : Nat, sizec : Nat, initValue : X) : [var X] {
//   //   let row = Prim.Array_init<X>(sizec, initValue);

//   // };

//   func transpose<T>(m : [[T]]) : [[T]] {
//     let myncols = ncols(m);
//     let trans = Buffer.Buffer<[T]>(myncols); 
//     for (i in Iter.range(0, myncols - 1)) {
//       let ys = cols([i], m);
//       let ys2 = Array.flatten(ys);
//       trans.add(ys2);
//       //trans := List.push<[dataMember]>(ys2, trans); // 
//     };
//     Buffer.toArray(trans); 
//   };


//   // 2) do error checking s.t. indexes fall within matrix dimensions
//   func linspace(xs_min: Float, xs_max: Float, num: Nat): [Float] {
//     let ret = Buffer.Buffer<Float>(num);
//     let A: Float = (xs_max-xs_min)/Float.fromInt(num);
//     for (i in Iter.range(0, num - 1)) {
//       ret.add(xs_min + Float.fromInt(i)*A)
//     }; 
//     Buffer.toArray(ret);
//   };
//   func min(rs: [Float]) : Float {
//     let aux = Array.sort(rs, Float.compare);
//     aux[0];
//   };
//   func minNat(rs: [Nat]) : Nat {
//     let aux = Array.sort(rs, Nat.compare);
//     aux[0];
//   };
//   func max(rs: [Float]) : Float {
//     let aux = Array.sort(rs, Float.compare);
//     aux[rs.size()-1];
//   };
//   func maxNat(rs: [Nat]) : Nat {
//     let aux = Array.sort(rs, Nat.compare);
//     aux[rs.size()-1];
//   };
//   func sumTrues(rs: [Bool]) : Nat {
//     let sum = Array.foldLeft<Bool, Nat>(rs, 0, func(sumSoFar, x) = switch x {case true sumSoFar + 1; case false sumSoFar + 0});
//     sum;
//   };
//   func sumFalses(rs: [Bool]) : Nat {
//     let sum = Array.foldLeft<Bool, Nat>(rs, 0, func(sumSoFar, x) = switch x {case true sumSoFar + 0; case false sumSoFar + 1});
//     sum;
//   };
//   func mean(rs: [Float]) : Float {
//     let sum = Array.foldLeft<Float, Float>(rs, 0, func(sumSoFar, x) = sumSoFar + x);
//     let ret : Float = sum/Float.fromInt(rs.size());
//     ret;
//   };
//   func median(rs: [Float]) : Float {
//     let aux = Array.sort(rs, Float.compare);
//     var ret: Float = 0;
//     let pos = aux.size()/2;
//     let rem = aux.size()%2;
//     if (rem == 0) {
//       ret := (aux[pos-1]+aux[pos])/2;
//     } else {
//       ret := aux[pos];
//     };
//     ret;
//   };
//   // func uniquesNat(rs: [Nat]): [Nat] {
//   //   let myset = TrieSet.fromArray<Nat>(rs, hashNat, Nat.equal);
//   //   let uniques = TrieSet.toArray(myset);
//   //   uniques;
//   // };
//   func uniquesText(rs: [Text]): [Text] {
//     let myset = TrieSet.fromArray<Text>(rs, Text.hash, Text.equal);
//     let uniques = TrieSet.toArray(myset);
//     return uniques;
//   };
//   func log2(n: Float): Float {
//     Float.log(n)/Float.log(2);
//   };
//   func entropy(rs: [Text], y_uniques: [Text]): Float { 
//     //let y_uniques = uniquesText(rs);
//     var h_total: Float = 0.0;
//     for (i in Iter.range(0,y_uniques.size()-1)) {
//       let ys_y =  Array.filter<Text>(rs, func x = x == y_uniques[i]);
//       let p_y = Float.fromInt(ys_y.size()) / Float.fromInt(rs.size()); 
//       let h_y = p_y * log2(p_y);
//       h_total := h_total + h_y;
//     };

//     -h_total;
//   };

  // func example(a: Nat): Nat {
  //   if (Nat.equal(a,0)) {
  //       throw Error.reject("Som");
  //   };
  //   return 0;
  // };

  func symbolVecToTextVec(ys: [dataMember]):  Result.Result<[Text], MotokoLearnError> {
    let aux = ys[0];
    let textBuf = Buffer.Buffer<Text>(ys.size());
    // Debug.print("is a text:" # aux);
    for (i in Iter.range(0, ys.size() - 1)) {
      let aux = ys[i];
      switch (aux) {
        case (#symbol s) {
            textBuf.add(s);
        };
        case (#number s) { 
          return #err(#notAllYsAreSymbol);
        };
      };
    };

    return #ok(Buffer.toArray(textBuf));
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
  
  type leafValue = {#number: Float;
                  #symbol: [Float]}; 
  type BinTree = ?(?Nat, ?Float, leafValue, BinTree, BinTree); 
  func nilTree() : BinTree = null;
  func isTreeNil(bintree : BinTree) : Bool {
    switch bintree {
      case null { true };
      case _ { false }
    }
  };

  public query func greet(name : Text) : async (BinTree) {
    let c = Counter(1);
    let matrix : [[Float]] = [[1,2,3],
                            [4,5,6],
                            [7,8,9],[10,20,30],[11,22,33]]; 

    let auxr : [[Float]] = mtkl.rows([0, 2], matrix);
    let auxc : [[Float]] = mtkl.cols([0, 2], matrix);
    // Debug.print("min:" # Float.toText(min(matrix[0])) );
    // Debug.print("max:" # Float.toText(max(matrix[0])) );
    // Debug.print("mean:" # Float.toText(mean(matrix[0])) ); 
    // Debug.print("median1:" # Float.toText(median(matrix[0])) );
    // Debug.print("median2:" # Float.toText(median(matrix[1])) );
    // let aux : [[Nat]] = matrix[[1,2]];
    // let set1 = TrieSet.fromArray<Nat>([1, 2, 3, 1, 2, 3, 1], Nat32.fromNat, Nat.equal);
    // let vals1 = TrieSet.toArray(set1);
    // for (element in vals1.vals()) {
    //   Debug.print("val:" # Nat.toText(element));
    // };
    // let set2 = TrieSet.fromArray<Text>(["1", "2", "3", "1", "2", "3", "1"], hashText, Text.equal);
    // let vals2 = TrieSet.toArray(set2);
    // let textVec = ["is a text", "2", "3", "1", "2", "3", "1"];
    // let ys = cols([0], actor_data);
    // let aux: dataMember = ys[0][0];
    
    //var trans = List.nil<[dataMember]>();
    //use buffer and convert: https://internetcomputer.org/docs/current/motoko/main/base/Buffer<<<<<<<<<<--------
    // let myncols = ncols(actor_data);
    // let trans = Buffer.Buffer<[dataMember]>(myncols); 
    // for (i in Iter.range(0, myncols - 1)) {
    //   let ys = cols([i], actor_data);
    //   let ys2 = Array.flatten(ys);
    //   trans.add(ys2);
    //   //trans := List.push<[dataMember]>(ys2, trans); 
    // };
    // let ret = transpose(actor_data);//Buffer.toArray(trans); 
    // //trans := Array(trans);
    // // <-----------------HOW TO ADD ELEMENTS TO A VECTOR
    // let myncols = ncols(actor_data);
    // let ys = cols([myncols-1], actor_data);
    // let ys2 = Array.flatten(ys);
    // let aux = ys2[0];
    // // Debug.print("is a text:" # aux);
    // switch (aux) {
    //    case (#symbol s) { // classification case
    //       // 1) convert last column to a vector of text: if something is not a symbol, raise 
    //       let aux = symbolVecToTextVec(ys2);   // 
    //       switch (aux) {
    //         case(#err(#notAllYsAreSymbol)){
    //           // throw errortype BinTree = ?(?Nat, ?dataMember, ?dataMember, BinTree, BinTree); 
    //           throw Error.reject("Target column is not totally formed by symbols")
    //         }; 
    //         case(#ok(result)) {
    //           Debug.print("is a text:" # result[0]);
    //           // compute entropy using "result"
    //           let y_entropy: Float = entropy(result); 
    //           Debug.print("The entropy of the target column is:" # Float.toText(y_entropy));
    //           // how to gow a decision tree?

    //         };
    //       };
    //     };
    //     case (#number s) { // regresssion case
    //       Debug.print("is a number:" # Float.toText(s));
    //    };
    //  };
    // NEXT:----> check is type symbol?
    // https://internetcomputer.org/docs/current/motoko/main/errors#what-error-type-to-prefer
    // let myuniques = uniquesText(textVec);
    // for (element in myuniques.vals()) {
    //   Debug.print("val:" # element);
    // };
    // //return "matrix value: " # Nat.toText(aux) ;

    // leaf value type: null (non-leaf), Float (leaf regression), [Float] (leaf classoifciation)
    // type leafValue = {#number: Float;
    //                   #symbol: [Float]}; 

    // Tree node fields:
    // 1) 
  // type BinTree = ?(?Nat, ?Float, leafValue, BinTree, BinTree); 
  // func nilTree() : BinTree = null;
  // func isTreeNil(bintree : BinTree) : Bool {
  //   switch bintree {
  //     case null { true };
  //     case _ { false }
  //   }
  // };

    // var_id(?Nat): feature column in [0, N-1]
    //               Note: leafs have null
    // th(?float) : in numeric features: <=th samples correspond to the left node
    //                                   >th samples are right node
    //              in symbolic features: Not used becasue left tree is "false cases"~"0", right tree is "true cases"~"1"     
    //              Note: leafs have null
    //              Note: symbolic features need to be converted into 1HE (function to be done) 
    // value(leafValue): Used when node is a leaf: if y numeric then this is the average value of y  
    //                                  if y symbolic then this is a vector of y class probabilities
    //                   Note: Non-leaf nodes have null   
    //                   Note: Node type is a new type
    func setLeftRightBranch(var_id : ?Nat,         // can be null when leaf
                            th : ?Float,           // can be null when leaf
                            value : leafValue,
                            leftTree : BinTree, 
                            rightTree : BinTree) : BinTree {
      ?(var_id, th, value, leftTree, rightTree);
    };
    
    var wine_data: [[dataMember]] =  [[#number(14.2), #number(1.7), #number(2.4), #number(15.6), #number(127.0), #number(2.8), #number(3.1), #number(0.3), #number(2.3), #number(5.6), #number(1.0), #number(3.9), #number(1065.0), #symbol("0")],
                  [#number(13.2), #number(1.8), #number(2.1), #number(11.2), #number(100.0), #number(2.6), #number(2.8), #number(0.3), #number(1.3), #number(4.4), #number(1.1), #number(3.4), #number(1050.0), #symbol("0")],
                  [#number(13.2), #number(2.4), #number(2.7), #number(18.6), #number(101.0), #number(2.8), #number(3.2), #number(0.3), #number(2.8), #number(5.7), #number(1.0), #number(3.2), #number(1185.0), #symbol("0")],
                  [#number(14.4), #number(1.9), #number(2.5), #number(16.8), #number(113.0), #number(3.9), #number(3.5), #number(0.2), #number(2.2), #number(7.8), #number(0.9), #number(3.5), #number(1480.0), #symbol("0")],
                  [#number(13.2), #number(2.6), #number(2.9), #number(21.0), #number(118.0), #number(2.8), #number(2.7), #number(0.4), #number(1.8), #number(4.3), #number(1.0), #number(2.9), #number(735.0), #symbol("0")],
                  [#number(14.2), #number(1.8), #number(2.5), #number(15.2), #number(112.0), #number(3.3), #number(3.4), #number(0.3), #number(2.0), #number(6.8), #number(1.1), #number(2.9), #number(1450.0), #symbol("0")],
                  [#number(14.4), #number(1.9), #number(2.5), #number(14.6), #number(96.0), #number(2.5), #number(2.5), #number(0.3), #number(2.0), #number(5.2), #number(1.0), #number(3.6), #number(1290.0), #symbol("0")],
                  [#number(14.1), #number(2.1), #number(2.6), #number(17.6), #number(121.0), #number(2.6), #number(2.5), #number(0.3), #number(1.2), #number(5.0), #number(1.1), #number(3.6), #number(1295.0), #symbol("0")],
                  [#number(14.8), #number(1.6), #number(2.2), #number(14.0), #number(97.0), #number(2.8), #number(3.0), #number(0.3), #number(2.0), #number(5.2), #number(1.1), #number(2.9), #number(1045.0), #symbol("0")],
                  [#number(13.9), #number(1.4), #number(2.3), #number(16.0), #number(98.0), #number(3.0), #number(3.1), #number(0.2), #number(1.9), #number(7.2), #number(1.0), #number(3.5), #number(1045.0), #symbol("0")],
                  [#number(14.1), #number(2.2), #number(2.3), #number(18.0), #number(105.0), #number(3.0), #number(3.3), #number(0.2), #number(2.4), #number(5.8), #number(1.2), #number(3.2), #number(1510.0), #symbol("0")],
                  [#number(14.1), #number(1.5), #number(2.3), #number(16.8), #number(95.0), #number(2.2), #number(2.4), #number(0.3), #number(1.6), #number(5.0), #number(1.2), #number(2.8), #number(1280.0), #symbol("0")],
                  [#number(13.8), #number(1.7), #number(2.4), #number(16.0), #number(89.0), #number(2.6), #number(2.8), #number(0.3), #number(1.8), #number(5.6), #number(1.1), #number(2.9), #number(1320.0), #symbol("0")],
                  [#number(14.8), #number(1.7), #number(2.4), #number(11.4), #number(91.0), #number(3.1), #number(3.7), #number(0.4), #number(2.8), #number(5.4), #number(1.2), #number(2.7), #number(1150.0), #symbol("0")],
                  [#number(14.4), #number(1.9), #number(2.4), #number(12.0), #number(102.0), #number(3.3), #number(3.6), #number(0.3), #number(3.0), #number(7.5), #number(1.2), #number(3.0), #number(1547.0), #symbol("0")],
                  [#number(13.6), #number(1.8), #number(2.7), #number(17.2), #number(112.0), #number(2.9), #number(2.9), #number(0.3), #number(1.5), #number(7.3), #number(1.3), #number(2.9), #number(1310.0), #symbol("0")],
                  [#number(14.3), #number(1.9), #number(2.7), #number(20.0), #number(120.0), #number(2.8), #number(3.1), #number(0.3), #number(2.0), #number(6.2), #number(1.1), #number(2.6), #number(1280.0), #symbol("0")],
                  [#number(13.8), #number(1.6), #number(2.6), #number(20.0), #number(115.0), #number(3.0), #number(3.4), #number(0.4), #number(1.7), #number(6.6), #number(1.1), #number(2.6), #number(1130.0), #symbol("0")],
                  [#number(14.2), #number(1.6), #number(2.5), #number(16.5), #number(108.0), #number(3.3), #number(3.9), #number(0.3), #number(1.9), #number(8.7), #number(1.2), #number(2.8), #number(1680.0), #symbol("0")],
                  [#number(13.6), #number(3.1), #number(2.6), #number(15.2), #number(116.0), #number(2.7), #number(3.0), #number(0.2), #number(1.7), #number(5.1), #number(1.0), #number(3.4), #number(845.0), #symbol("0")],
                  [#number(14.1), #number(1.6), #number(2.3), #number(16.0), #number(126.0), #number(3.0), #number(3.2), #number(0.2), #number(2.1), #number(5.7), #number(1.1), #number(3.7), #number(780.0), #symbol("0")],
                  [#number(12.9), #number(3.8), #number(2.6), #number(18.6), #number(102.0), #number(2.4), #number(2.4), #number(0.2), #number(2.0), #number(4.5), #number(1.0), #number(3.5), #number(770.0), #symbol("0")],
                  [#number(13.7), #number(1.9), #number(2.4), #number(16.6), #number(101.0), #number(2.6), #number(2.9), #number(0.3), #number(1.7), #number(3.8), #number(1.1), #number(4.0), #number(1035.0), #symbol("0")],
                  [#number(12.8), #number(1.6), #number(2.5), #number(17.8), #number(95.0), #number(2.5), #number(2.4), #number(0.3), #number(1.5), #number(3.9), #number(1.1), #number(3.6), #number(1015.0), #symbol("0")],
                  [#number(13.5), #number(1.8), #number(2.6), #number(20.0), #number(96.0), #number(2.5), #number(2.6), #number(0.3), #number(1.7), #number(3.5), #number(1.1), #number(3.8), #number(845.0), #symbol("0")],
                  [#number(13.1), #number(2.0), #number(3.2), #number(25.0), #number(124.0), #number(2.6), #number(2.7), #number(0.5), #number(1.9), #number(3.6), #number(1.1), #number(3.2), #number(830.0), #symbol("0")],
                  [#number(13.4), #number(1.8), #number(2.6), #number(16.1), #number(93.0), #number(2.9), #number(2.9), #number(0.3), #number(1.4), #number(4.8), #number(0.9), #number(3.2), #number(1195.0), #symbol("0")],
                  [#number(13.3), #number(1.7), #number(2.1), #number(17.0), #number(94.0), #number(2.4), #number(2.2), #number(0.3), #number(1.4), #number(4.0), #number(1.0), #number(2.8), #number(1285.0), #symbol("0")],
                  [#number(13.9), #number(1.9), #number(2.8), #number(19.4), #number(107.0), #number(3.0), #number(3.0), #number(0.4), #number(1.8), #number(4.5), #number(1.2), #number(3.4), #number(915.0), #symbol("0")],
                  [#number(14.0), #number(1.7), #number(2.2), #number(16.0), #number(96.0), #number(2.6), #number(2.3), #number(0.3), #number(2.0), #number(4.7), #number(1.0), #number(3.6), #number(1035.0), #symbol("0")],
                  [#number(13.7), #number(1.5), #number(2.7), #number(22.5), #number(101.0), #number(3.0), #number(3.2), #number(0.3), #number(2.4), #number(5.7), #number(1.2), #number(2.7), #number(1285.0), #symbol("0")],
                  [#number(13.6), #number(1.7), #number(2.4), #number(19.1), #number(106.0), #number(2.9), #number(3.2), #number(0.2), #number(1.9), #number(6.9), #number(1.1), #number(2.9), #number(1515.0), #symbol("0")],
                  [#number(13.7), #number(1.8), #number(2.4), #number(17.2), #number(104.0), #number(2.4), #number(2.7), #number(0.4), #number(2.0), #number(3.8), #number(1.2), #number(2.9), #number(990.0), #symbol("0")],
                  [#number(13.8), #number(1.5), #number(2.7), #number(19.5), #number(132.0), #number(3.0), #number(2.7), #number(0.5), #number(1.4), #number(5.4), #number(1.2), #number(3.0), #number(1235.0), #symbol("0")],
                  [#number(13.5), #number(1.8), #number(2.6), #number(19.0), #number(110.0), #number(2.4), #number(2.5), #number(0.3), #number(1.5), #number(4.2), #number(1.1), #number(2.9), #number(1095.0), #symbol("0")],
                  [#number(13.5), #number(1.8), #number(2.4), #number(20.5), #number(100.0), #number(2.7), #number(3.0), #number(0.3), #number(1.9), #number(5.1), #number(1.0), #number(3.5), #number(920.0), #symbol("0")],
                  [#number(13.3), #number(1.6), #number(2.8), #number(15.5), #number(110.0), #number(2.6), #number(2.7), #number(0.3), #number(1.4), #number(4.6), #number(1.1), #number(2.8), #number(880.0), #symbol("0")],
                  [#number(13.1), #number(1.6), #number(2.5), #number(18.0), #number(98.0), #number(2.5), #number(2.4), #number(0.3), #number(1.4), #number(4.2), #number(1.1), #number(2.5), #number(1105.0), #symbol("0")],
                  [#number(13.1), #number(1.5), #number(2.1), #number(15.5), #number(98.0), #number(2.4), #number(2.6), #number(0.3), #number(1.4), #number(3.7), #number(1.2), #number(2.7), #number(1020.0), #symbol("0")],
                  [#number(14.2), #number(4.0), #number(2.5), #number(13.2), #number(128.0), #number(3.0), #number(3.0), #number(0.2), #number(2.1), #number(5.1), #number(0.9), #number(3.5), #number(760.0), #symbol("0")],
                  [#number(13.6), #number(1.7), #number(2.3), #number(16.2), #number(117.0), #number(3.1), #number(3.3), #number(0.3), #number(2.3), #number(6.1), #number(0.9), #number(3.4), #number(795.0), #symbol("0")],
                  [#number(13.4), #number(3.8), #number(2.1), #number(18.8), #number(90.0), #number(2.5), #number(2.7), #number(0.3), #number(1.5), #number(4.3), #number(0.9), #number(3.0), #number(1035.0), #symbol("0")],
                  [#number(13.9), #number(1.9), #number(2.6), #number(15.0), #number(101.0), #number(3.2), #number(3.6), #number(0.2), #number(1.7), #number(5.4), #number(0.9), #number(3.6), #number(1095.0), #symbol("0")],
                  [#number(13.2), #number(4.0), #number(2.3), #number(17.5), #number(103.0), #number(2.6), #number(2.6), #number(0.3), #number(1.7), #number(4.4), #number(0.8), #number(3.0), #number(680.0), #symbol("0")],
                  [#number(13.1), #number(1.8), #number(2.1), #number(17.0), #number(107.0), #number(3.0), #number(3.0), #number(0.3), #number(2.0), #number(5.0), #number(0.9), #number(3.4), #number(885.0), #symbol("0")],
                  [#number(14.2), #number(4.0), #number(2.4), #number(18.9), #number(111.0), #number(2.9), #number(2.6), #number(0.3), #number(1.2), #number(5.2), #number(0.9), #number(3.3), #number(1080.0), #symbol("0")],
                  [#number(14.4), #number(3.6), #number(2.3), #number(16.0), #number(102.0), #number(3.2), #number(3.2), #number(0.3), #number(2.2), #number(4.9), #number(1.0), #number(3.4), #number(1065.0), #symbol("0")],
                  [#number(13.9), #number(1.7), #number(2.1), #number(16.0), #number(101.0), #number(3.1), #number(3.4), #number(0.2), #number(2.1), #number(6.1), #number(0.9), #number(3.3), #number(985.0), #symbol("0")],
                  [#number(14.1), #number(2.0), #number(2.4), #number(18.8), #number(103.0), #number(2.8), #number(2.9), #number(0.3), #number(2.4), #number(6.2), #number(1.1), #number(2.8), #number(1060.0), #symbol("0")],
                  [#number(13.9), #number(1.7), #number(2.3), #number(17.4), #number(108.0), #number(2.9), #number(3.5), #number(0.3), #number(2.1), #number(8.9), #number(1.1), #number(3.1), #number(1260.0), #symbol("0")],
                  [#number(13.1), #number(1.7), #number(2.0), #number(12.4), #number(92.0), #number(2.7), #number(3.3), #number(0.2), #number(2.9), #number(7.2), #number(1.1), #number(2.9), #number(1150.0), #symbol("0")],
                  [#number(13.8), #number(1.6), #number(2.6), #number(17.2), #number(94.0), #number(2.5), #number(3.0), #number(0.2), #number(2.3), #number(5.6), #number(1.2), #number(3.4), #number(1265.0), #symbol("0")],
                  [#number(13.8), #number(1.8), #number(2.4), #number(14.0), #number(111.0), #number(3.9), #number(3.7), #number(0.3), #number(1.9), #number(7.0), #number(1.0), #number(3.3), #number(1190.0), #symbol("0")],
                  [#number(13.8), #number(1.9), #number(2.7), #number(17.1), #number(115.0), #number(3.0), #number(2.8), #number(0.4), #number(1.7), #number(6.3), #number(1.1), #number(2.9), #number(1375.0), #symbol("0")],
                  [#number(13.7), #number(1.7), #number(2.2), #number(16.4), #number(118.0), #number(2.6), #number(2.9), #number(0.2), #number(1.6), #number(5.8), #number(0.9), #number(3.2), #number(1060.0), #symbol("0")],
                  [#number(13.6), #number(1.7), #number(2.5), #number(20.5), #number(116.0), #number(3.0), #number(2.8), #number(0.2), #number(2.5), #number(6.2), #number(1.0), #number(3.0), #number(1120.0), #symbol("0")],
                  [#number(14.2), #number(1.7), #number(2.3), #number(16.3), #number(118.0), #number(3.2), #number(3.0), #number(0.3), #number(2.0), #number(6.4), #number(0.9), #number(3.3), #number(970.0), #symbol("0")],
                  [#number(13.3), #number(2.0), #number(2.7), #number(16.8), #number(102.0), #number(3.0), #number(3.2), #number(0.3), #number(1.7), #number(6.0), #number(1.1), #number(2.8), #number(1270.0), #symbol("0")],
                  [#number(13.7), #number(1.4), #number(2.5), #number(16.7), #number(108.0), #number(3.4), #number(3.7), #number(0.2), #number(2.0), #number(6.8), #number(0.9), #number(2.9), #number(1285.0), #symbol("0")],
                  [#number(12.4), #number(0.9), #number(1.4), #number(10.6), #number(88.0), #number(2.0), #number(0.6), #number(0.3), #number(0.4), #number(1.9), #number(1.1), #number(1.8), #number(520.0), #symbol("1")],
                  [#number(12.3), #number(1.1), #number(2.3), #number(16.0), #number(101.0), #number(2.0), #number(1.1), #number(0.6), #number(0.4), #number(3.3), #number(1.2), #number(1.7), #number(680.0), #symbol("1")],
                  [#number(12.6), #number(1.4), #number(2.0), #number(16.8), #number(100.0), #number(2.0), #number(1.4), #number(0.5), #number(0.6), #number(5.8), #number(1.0), #number(1.6), #number(450.0), #symbol("1")],
                  [#number(13.7), #number(1.2), #number(1.9), #number(18.0), #number(94.0), #number(2.1), #number(1.8), #number(0.3), #number(0.7), #number(3.8), #number(1.2), #number(2.5), #number(630.0), #symbol("1")],
                  [#number(12.4), #number(1.1), #number(2.2), #number(19.0), #number(87.0), #number(3.5), #number(3.1), #number(0.2), #number(1.9), #number(4.5), #number(1.2), #number(2.9), #number(420.0), #symbol("1")],
                  [#number(12.2), #number(1.4), #number(2.5), #number(19.0), #number(104.0), #number(1.9), #number(1.8), #number(0.5), #number(1.0), #number(3.0), #number(1.4), #number(2.2), #number(355.0), #symbol("1")],
                  [#number(12.4), #number(1.2), #number(2.6), #number(18.1), #number(98.0), #number(2.4), #number(2.6), #number(0.4), #number(2.1), #number(4.6), #number(1.2), #number(2.3), #number(678.0), #symbol("1")],
                  [#number(13.1), #number(1.0), #number(1.7), #number(15.0), #number(78.0), #number(3.0), #number(3.2), #number(0.3), #number(2.3), #number(5.3), #number(1.1), #number(3.2), #number(502.0), #symbol("1")],
                  [#number(12.4), #number(1.2), #number(1.9), #number(19.6), #number(78.0), #number(2.1), #number(2.0), #number(0.3), #number(1.0), #number(4.7), #number(1.1), #number(3.5), #number(510.0), #symbol("1")],
                  [#number(13.3), #number(0.9), #number(2.4), #number(17.0), #number(110.0), #number(2.5), #number(1.3), #number(0.6), #number(0.4), #number(3.2), #number(1.0), #number(1.9), #number(750.0), #symbol("1")],
                  [#number(12.2), #number(1.2), #number(1.8), #number(16.8), #number(151.0), #number(1.9), #number(1.3), #number(0.1), #number(2.5), #number(2.9), #number(1.3), #number(3.1), #number(718.0), #symbol("1")],
                  [#number(12.3), #number(1.6), #number(2.2), #number(20.4), #number(103.0), #number(1.1), #number(1.0), #number(0.4), #number(1.5), #number(3.0), #number(0.9), #number(1.8), #number(870.0), #symbol("1")],
                  [#number(13.9), #number(1.5), #number(2.7), #number(25.0), #number(86.0), #number(3.0), #number(2.9), #number(0.2), #number(1.9), #number(3.4), #number(1.4), #number(3.2), #number(410.0), #symbol("1")],
                  [#number(13.5), #number(1.7), #number(2.2), #number(24.0), #number(87.0), #number(1.9), #number(1.8), #number(0.3), #number(1.0), #number(3.7), #number(1.0), #number(2.8), #number(472.0), #symbol("1")],
                  [#number(13.0), #number(1.7), #number(2.6), #number(30.0), #number(139.0), #number(3.3), #number(2.9), #number(0.2), #number(2.0), #number(3.4), #number(1.3), #number(3.5), #number(985.0), #symbol("1")],
                  [#number(12.0), #number(1.1), #number(2.3), #number(21.0), #number(101.0), #number(3.4), #number(2.1), #number(0.1), #number(1.6), #number(3.2), #number(1.0), #number(3.1), #number(886.0), #symbol("1")],
                  [#number(11.7), #number(1.9), #number(1.9), #number(16.0), #number(97.0), #number(1.6), #number(1.6), #number(0.3), #number(1.1), #number(3.8), #number(1.2), #number(2.1), #number(428.0), #symbol("1")],
                  [#number(13.0), #number(0.9), #number(1.7), #number(16.0), #number(86.0), #number(1.9), #number(2.0), #number(0.2), #number(1.5), #number(4.6), #number(1.2), #number(2.5), #number(392.0), #symbol("1")],
                  [#number(11.8), #number(2.9), #number(2.2), #number(18.0), #number(112.0), #number(1.7), #number(1.3), #number(0.4), #number(0.9), #number(2.6), #number(1.0), #number(2.5), #number(500.0), #symbol("1")],
                  [#number(12.3), #number(1.0), #number(1.9), #number(14.8), #number(136.0), #number(1.9), #number(1.9), #number(0.3), #number(2.8), #number(3.4), #number(1.1), #number(2.3), #number(750.0), #symbol("1")],
                  [#number(12.7), #number(3.9), #number(2.4), #number(23.0), #number(101.0), #number(2.8), #number(2.5), #number(0.4), #number(1.9), #number(2.6), #number(1.2), #number(3.1), #number(463.0), #symbol("1")],
                  [#number(12.0), #number(0.9), #number(2.0), #number(19.0), #number(86.0), #number(2.4), #number(2.3), #number(0.3), #number(1.4), #number(2.5), #number(1.4), #number(3.1), #number(278.0), #symbol("1")],
                  [#number(12.7), #number(1.8), #number(2.2), #number(18.8), #number(86.0), #number(2.2), #number(2.5), #number(0.3), #number(1.8), #number(3.9), #number(1.2), #number(3.1), #number(714.0), #symbol("1")],
                  [#number(12.1), #number(1.1), #number(2.5), #number(24.0), #number(78.0), #number(2.0), #number(1.6), #number(0.4), #number(1.4), #number(2.2), #number(1.3), #number(2.7), #number(630.0), #symbol("1")],
                  [#number(13.1), #number(3.9), #number(2.3), #number(22.5), #number(85.0), #number(1.6), #number(1.6), #number(0.6), #number(1.6), #number(4.8), #number(0.8), #number(2.0), #number(515.0), #symbol("1")],
                  [#number(11.8), #number(0.9), #number(2.6), #number(18.0), #number(94.0), #number(2.2), #number(2.2), #number(0.2), #number(2.4), #number(3.0), #number(0.8), #number(3.1), #number(520.0), #symbol("1")],
                  [#number(12.7), #number(1.0), #number(2.2), #number(18.0), #number(99.0), #number(2.2), #number(1.9), #number(0.3), #number(1.5), #number(2.6), #number(1.2), #number(3.2), #number(450.0), #symbol("1")],
                  [#number(12.2), #number(1.6), #number(2.3), #number(22.8), #number(90.0), #number(1.8), #number(1.7), #number(0.4), #number(1.6), #number(2.5), #number(1.3), #number(2.3), #number(495.0), #symbol("1")],
                  [#number(11.7), #number(1.7), #number(2.6), #number(26.0), #number(88.0), #number(1.9), #number(1.6), #number(0.4), #number(1.3), #number(2.6), #number(1.4), #number(3.2), #number(562.0), #symbol("1")],
                  [#number(11.6), #number(2.1), #number(2.5), #number(21.6), #number(84.0), #number(1.9), #number(1.7), #number(0.5), #number(1.4), #number(2.8), #number(1.0), #number(2.8), #number(680.0), #symbol("1")],
                  [#number(12.1), #number(1.3), #number(2.3), #number(23.6), #number(70.0), #number(2.2), #number(1.6), #number(0.4), #number(1.4), #number(1.7), #number(1.1), #number(3.2), #number(625.0), #symbol("1")],
                  [#number(12.1), #number(1.8), #number(2.3), #number(18.5), #number(81.0), #number(1.6), #number(1.5), #number(0.5), #number(1.6), #number(2.4), #number(1.1), #number(2.3), #number(480.0), #symbol("1")],
                  [#number(12.0), #number(1.5), #number(2.4), #number(22.0), #number(86.0), #number(1.4), #number(1.2), #number(0.5), #number(1.6), #number(3.6), #number(1.1), #number(2.6), #number(450.0), #symbol("1")],
                  [#number(12.7), #number(1.5), #number(2.3), #number(20.7), #number(80.0), #number(1.4), #number(1.5), #number(0.6), #number(1.6), #number(3.0), #number(1.0), #number(2.1), #number(495.0), #symbol("1")],
                  [#number(12.3), #number(2.8), #number(2.2), #number(18.0), #number(88.0), #number(2.5), #number(2.2), #number(0.2), #number(2.0), #number(2.1), #number(1.1), #number(3.3), #number(290.0), #symbol("1")],
                  [#number(11.6), #number(2.0), #number(2.3), #number(18.0), #number(98.0), #number(3.0), #number(2.3), #number(0.2), #number(1.4), #number(3.2), #number(1.2), #number(3.0), #number(345.0), #symbol("1")],
                  [#number(12.5), #number(1.5), #number(2.2), #number(19.0), #number(162.0), #number(2.5), #number(2.3), #number(0.3), #number(3.3), #number(2.6), #number(1.2), #number(2.6), #number(937.0), #symbol("1")],
                  [#number(11.8), #number(2.1), #number(2.7), #number(21.5), #number(134.0), #number(1.6), #number(1.0), #number(0.1), #number(1.6), #number(2.5), #number(0.9), #number(2.3), #number(625.0), #symbol("1")],
                  [#number(12.3), #number(1.4), #number(2.0), #number(16.0), #number(85.0), #number(2.5), #number(2.5), #number(0.3), #number(1.8), #number(2.9), #number(1.2), #number(2.7), #number(428.0), #symbol("1")],
                  [#number(12.4), #number(1.1), #number(2.1), #number(18.5), #number(88.0), #number(3.5), #number(3.8), #number(0.2), #number(1.9), #number(4.5), #number(1.0), #number(2.8), #number(660.0), #symbol("1")],
                  [#number(12.3), #number(3.2), #number(2.2), #number(18.0), #number(88.0), #number(2.9), #number(3.0), #number(0.5), #number(2.8), #number(2.3), #number(1.4), #number(2.8), #number(406.0), #symbol("1")],
                  [#number(12.1), #number(2.1), #number(1.7), #number(17.5), #number(97.0), #number(2.2), #number(2.2), #number(0.3), #number(1.4), #number(3.3), #number(1.3), #number(3.0), #number(710.0), #symbol("1")],
                  [#number(12.6), #number(1.3), #number(1.9), #number(18.5), #number(88.0), #number(1.4), #number(1.4), #number(0.3), #number(1.4), #number(2.5), #number(1.0), #number(2.8), #number(562.0), #symbol("1")],
                  [#number(12.3), #number(2.5), #number(2.5), #number(21.0), #number(98.0), #number(2.6), #number(2.1), #number(0.3), #number(1.3), #number(2.8), #number(0.8), #number(3.4), #number(438.0), #symbol("1")],
                  [#number(11.8), #number(1.7), #number(1.9), #number(19.5), #number(86.0), #number(2.5), #number(1.6), #number(0.4), #number(1.4), #number(2.1), #number(0.9), #number(2.4), #number(415.0), #symbol("1")],
                  [#number(12.5), #number(1.7), #number(2.0), #number(20.5), #number(85.0), #number(2.2), #number(1.9), #number(0.3), #number(1.5), #number(2.9), #number(1.0), #number(3.6), #number(672.0), #symbol("1")],
                  [#number(12.4), #number(2.5), #number(2.3), #number(22.0), #number(90.0), #number(1.7), #number(1.8), #number(0.7), #number(1.4), #number(2.7), #number(0.9), #number(3.3), #number(315.0), #symbol("1")],
                  [#number(12.2), #number(1.7), #number(2.1), #number(19.0), #number(80.0), #number(1.6), #number(2.0), #number(0.4), #number(1.6), #number(3.4), #number(1.0), #number(3.2), #number(510.0), #symbol("1")],
                  [#number(12.7), #number(1.8), #number(2.3), #number(22.5), #number(84.0), #number(1.4), #number(1.8), #number(0.5), #number(1.6), #number(3.3), #number(0.9), #number(2.4), #number(488.0), #symbol("1")],
                  [#number(12.2), #number(1.3), #number(1.9), #number(19.0), #number(92.0), #number(2.4), #number(2.0), #number(0.4), #number(2.1), #number(2.7), #number(0.9), #number(3.0), #number(312.0), #symbol("1")],
                  [#number(11.6), #number(1.4), #number(2.7), #number(20.0), #number(94.0), #number(2.7), #number(2.9), #number(0.3), #number(2.5), #number(2.6), #number(1.0), #number(3.3), #number(680.0), #symbol("1")],
                  [#number(11.5), #number(3.7), #number(1.8), #number(19.5), #number(107.0), #number(3.2), #number(2.6), #number(0.2), #number(3.6), #number(2.9), #number(0.8), #number(2.8), #number(562.0), #symbol("1")],
                  [#number(12.5), #number(2.4), #number(2.2), #number(21.0), #number(88.0), #number(2.5), #number(2.3), #number(0.3), #number(1.2), #number(2.0), #number(0.9), #number(2.8), #number(325.0), #symbol("1")],
                  [#number(11.8), #number(2.7), #number(2.9), #number(20.0), #number(103.0), #number(1.8), #number(2.0), #number(0.6), #number(1.1), #number(3.8), #number(1.2), #number(2.5), #number(607.0), #symbol("1")],
                  [#number(11.4), #number(0.7), #number(2.5), #number(21.0), #number(88.0), #number(2.5), #number(2.0), #number(0.4), #number(1.4), #number(3.1), #number(1.1), #number(2.3), #number(434.0), #symbol("1")],
                  [#number(12.1), #number(1.4), #number(2.5), #number(22.5), #number(84.0), #number(2.6), #number(2.3), #number(0.4), #number(1.0), #number(2.9), #number(0.9), #number(3.2), #number(385.0), #symbol("1")],
                  [#number(11.0), #number(1.5), #number(2.2), #number(21.5), #number(85.0), #number(2.5), #number(2.2), #number(0.5), #number(2.0), #number(1.9), #number(1.7), #number(2.9), #number(407.0), #symbol("1")],
                  [#number(11.8), #number(1.5), #number(2.0), #number(20.8), #number(86.0), #number(2.0), #number(1.6), #number(0.3), #number(1.5), #number(1.9), #number(0.9), #number(3.3), #number(495.0), #symbol("1")],
                  [#number(12.4), #number(1.6), #number(2.2), #number(22.5), #number(108.0), #number(2.0), #number(2.1), #number(0.3), #number(1.6), #number(2.1), #number(1.1), #number(3.0), #number(345.0), #symbol("1")],
                  [#number(12.8), #number(3.4), #number(2.0), #number(16.0), #number(80.0), #number(1.6), #number(1.2), #number(0.4), #number(0.8), #number(3.4), #number(0.7), #number(2.1), #number(372.0), #symbol("1")],
                  [#number(12.0), #number(3.4), #number(2.0), #number(19.0), #number(87.0), #number(2.0), #number(1.6), #number(0.4), #number(1.9), #number(1.3), #number(0.9), #number(3.0), #number(564.0), #symbol("1")],
                  [#number(11.4), #number(2.4), #number(2.4), #number(20.0), #number(96.0), #number(2.9), #number(2.8), #number(0.3), #number(1.8), #number(3.2), #number(0.8), #number(3.4), #number(625.0), #symbol("1")],
                  [#number(11.6), #number(2.0), #number(3.2), #number(28.5), #number(119.0), #number(3.2), #number(5.1), #number(0.5), #number(1.9), #number(6.0), #number(0.9), #number(3.7), #number(465.0), #symbol("1")],
                  [#number(12.4), #number(4.4), #number(2.7), #number(26.5), #number(102.0), #number(2.2), #number(2.1), #number(0.4), #number(1.7), #number(2.1), #number(0.9), #number(3.1), #number(365.0), #symbol("1")],
                  [#number(13.1), #number(5.8), #number(2.1), #number(21.5), #number(86.0), #number(2.6), #number(2.6), #number(0.3), #number(2.0), #number(2.6), #number(0.7), #number(3.1), #number(380.0), #symbol("1")],
                  [#number(11.9), #number(4.3), #number(2.4), #number(21.0), #number(82.0), #number(2.9), #number(3.0), #number(0.2), #number(2.9), #number(2.8), #number(0.8), #number(3.6), #number(380.0), #symbol("1")],
                  [#number(12.1), #number(2.2), #number(2.2), #number(21.0), #number(85.0), #number(2.6), #number(2.6), #number(0.4), #number(1.4), #number(2.8), #number(0.9), #number(3.3), #number(378.0), #symbol("1")],
                  [#number(12.4), #number(1.5), #number(2.3), #number(21.5), #number(86.0), #number(2.7), #number(3.1), #number(0.4), #number(1.8), #number(3.9), #number(0.7), #number(2.8), #number(352.0), #symbol("1")],
                  [#number(11.8), #number(2.1), #number(2.8), #number(28.5), #number(92.0), #number(2.1), #number(2.2), #number(0.6), #number(1.8), #number(3.0), #number(1.0), #number(2.4), #number(466.0), #symbol("1")],
                  [#number(12.4), #number(1.6), #number(2.3), #number(24.5), #number(88.0), #number(2.2), #number(2.5), #number(0.4), #number(1.9), #number(2.1), #number(0.9), #number(2.8), #number(342.0), #symbol("1")],
                  [#number(12.0), #number(4.3), #number(2.4), #number(22.0), #number(80.0), #number(2.1), #number(1.8), #number(0.4), #number(1.4), #number(2.6), #number(0.8), #number(2.6), #number(580.0), #symbol("1")],
                  [#number(12.9), #number(1.4), #number(2.3), #number(18.0), #number(122.0), #number(1.5), #number(1.2), #number(0.2), #number(0.9), #number(4.1), #number(0.8), #number(1.3), #number(630.0), #symbol("2")],
                  [#number(12.9), #number(3.0), #number(2.4), #number(20.0), #number(104.0), #number(1.3), #number(1.2), #number(0.2), #number(0.8), #number(5.4), #number(0.7), #number(1.4), #number(530.0), #symbol("2")],
                  [#number(12.8), #number(2.3), #number(2.4), #number(24.0), #number(98.0), #number(1.1), #number(1.1), #number(0.3), #number(0.8), #number(5.7), #number(0.7), #number(1.4), #number(560.0), #symbol("2")],
                  [#number(12.7), #number(3.5), #number(2.4), #number(21.5), #number(106.0), #number(1.7), #number(1.2), #number(0.2), #number(0.8), #number(5.0), #number(0.8), #number(1.3), #number(600.0), #symbol("2")],
                  [#number(12.5), #number(1.2), #number(2.2), #number(17.5), #number(85.0), #number(2.0), #number(0.6), #number(0.6), #number(1.2), #number(5.5), #number(0.8), #number(1.5), #number(650.0), #symbol("2")],
                  [#number(12.6), #number(2.5), #number(2.2), #number(18.5), #number(94.0), #number(1.6), #number(0.7), #number(0.6), #number(0.9), #number(7.1), #number(0.7), #number(1.6), #number(695.0), #symbol("2")],
                  [#number(12.2), #number(4.7), #number(2.5), #number(21.0), #number(89.0), #number(1.4), #number(0.5), #number(0.5), #number(0.8), #number(3.9), #number(0.8), #number(1.3), #number(720.0), #symbol("2")],
                  [#number(12.5), #number(5.5), #number(2.6), #number(25.0), #number(96.0), #number(1.8), #number(0.6), #number(0.6), #number(1.1), #number(5.0), #number(0.8), #number(1.7), #number(515.0), #symbol("2")],
                  [#number(13.5), #number(3.6), #number(2.2), #number(19.5), #number(88.0), #number(1.6), #number(0.5), #number(0.6), #number(0.9), #number(5.7), #number(0.8), #number(1.8), #number(580.0), #symbol("2")],
                  [#number(12.8), #number(3.0), #number(2.6), #number(24.0), #number(101.0), #number(2.3), #number(0.6), #number(0.5), #number(0.8), #number(4.9), #number(0.9), #number(2.1), #number(590.0), #symbol("2")],
                  [#number(12.9), #number(2.8), #number(2.7), #number(21.0), #number(96.0), #number(1.5), #number(0.5), #number(0.5), #number(0.8), #number(4.6), #number(0.8), #number(2.3), #number(600.0), #symbol("2")],
                  [#number(13.4), #number(2.6), #number(2.4), #number(20.0), #number(89.0), #number(1.4), #number(0.5), #number(0.4), #number(0.6), #number(5.6), #number(0.7), #number(2.5), #number(780.0), #symbol("2")],
                  [#number(13.5), #number(3.2), #number(2.7), #number(23.5), #number(97.0), #number(1.6), #number(0.5), #number(0.5), #number(0.6), #number(4.3), #number(0.9), #number(2.1), #number(520.0), #symbol("2")],
                  [#number(13.6), #number(5.0), #number(2.4), #number(20.0), #number(92.0), #number(2.0), #number(0.8), #number(0.5), #number(1.0), #number(4.4), #number(0.9), #number(2.0), #number(550.0), #symbol("2")],
                  [#number(12.2), #number(3.9), #number(2.2), #number(18.5), #number(112.0), #number(1.4), #number(0.8), #number(0.3), #number(1.1), #number(8.2), #number(0.7), #number(2.0), #number(855.0), #symbol("2")],
                  [#number(13.2), #number(3.6), #number(2.1), #number(21.0), #number(102.0), #number(1.5), #number(0.6), #number(0.4), #number(1.3), #number(4.0), #number(0.6), #number(1.7), #number(830.0), #symbol("2")],
                  [#number(13.9), #number(5.0), #number(2.2), #number(20.0), #number(80.0), #number(1.0), #number(0.3), #number(0.4), #number(0.7), #number(4.9), #number(0.6), #number(1.3), #number(415.0), #symbol("2")],
                  [#number(12.9), #number(4.6), #number(2.5), #number(21.5), #number(86.0), #number(1.7), #number(0.7), #number(0.5), #number(0.9), #number(7.7), #number(0.5), #number(1.9), #number(625.0), #symbol("2")],
                  [#number(13.3), #number(3.2), #number(2.4), #number(21.5), #number(92.0), #number(1.9), #number(0.8), #number(0.5), #number(1.2), #number(8.4), #number(0.6), #number(1.6), #number(650.0), #symbol("2")],
                  [#number(13.1), #number(3.9), #number(2.4), #number(21.5), #number(113.0), #number(1.4), #number(1.4), #number(0.3), #number(1.1), #number(9.4), #number(0.6), #number(1.3), #number(550.0), #symbol("2")],
                  [#number(13.5), #number(3.1), #number(2.6), #number(24.0), #number(123.0), #number(1.4), #number(1.6), #number(0.2), #number(1.2), #number(8.6), #number(0.6), #number(1.3), #number(500.0), #symbol("2")],
                  [#number(12.8), #number(2.7), #number(2.5), #number(22.0), #number(112.0), #number(1.5), #number(1.4), #number(0.2), #number(1.3), #number(10.8), #number(0.5), #number(1.5), #number(480.0), #symbol("2")],
                  [#number(13.1), #number(1.9), #number(2.8), #number(25.5), #number(116.0), #number(2.2), #number(1.3), #number(0.3), #number(1.6), #number(7.1), #number(0.6), #number(1.3), #number(425.0), #symbol("2")],
                  [#number(13.2), #number(3.3), #number(2.3), #number(18.5), #number(98.0), #number(1.8), #number(0.8), #number(0.6), #number(1.9), #number(10.5), #number(0.6), #number(1.5), #number(675.0), #symbol("2")],
                  [#number(12.6), #number(1.3), #number(2.1), #number(20.0), #number(103.0), #number(1.5), #number(0.6), #number(0.5), #number(1.4), #number(7.6), #number(0.6), #number(1.6), #number(640.0), #symbol("2")],
                  [#number(13.2), #number(5.2), #number(2.3), #number(22.0), #number(93.0), #number(1.7), #number(0.6), #number(0.6), #number(1.6), #number(7.9), #number(0.6), #number(1.5), #number(725.0), #symbol("2")],
                  [#number(13.8), #number(4.1), #number(2.4), #number(19.5), #number(89.0), #number(1.8), #number(0.8), #number(0.5), #number(1.6), #number(9.0), #number(0.6), #number(1.6), #number(480.0), #symbol("2")],
                  [#number(12.4), #number(3.0), #number(2.6), #number(27.0), #number(97.0), #number(1.9), #number(0.6), #number(0.6), #number(1.1), #number(7.5), #number(0.7), #number(1.7), #number(880.0), #symbol("2")],
                  [#number(14.3), #number(1.7), #number(2.7), #number(25.0), #number(98.0), #number(2.8), #number(1.3), #number(0.5), #number(2.7), #number(13.0), #number(0.6), #number(2.0), #number(660.0), #symbol("2")],
                  [#number(13.5), #number(1.7), #number(2.6), #number(22.5), #number(89.0), #number(2.6), #number(1.1), #number(0.5), #number(2.3), #number(11.8), #number(0.6), #number(1.8), #number(620.0), #symbol("2")],
                  [#number(12.4), #number(3.8), #number(2.4), #number(21.0), #number(88.0), #number(2.3), #number(0.9), #number(0.5), #number(1.0), #number(7.7), #number(0.6), #number(1.6), #number(520.0), #symbol("2")],
                  [#number(13.7), #number(3.3), #number(2.5), #number(20.0), #number(107.0), #number(1.8), #number(0.6), #number(0.5), #number(0.8), #number(5.9), #number(1.0), #number(1.8), #number(680.0), #symbol("2")],
                  [#number(12.8), #number(3.3), #number(2.6), #number(22.0), #number(106.0), #number(1.6), #number(0.6), #number(0.6), #number(1.0), #number(5.6), #number(0.9), #number(2.1), #number(570.0), #symbol("2")],
                  [#number(13.0), #number(3.5), #number(2.4), #number(18.5), #number(106.0), #number(1.4), #number(0.7), #number(0.4), #number(0.9), #number(5.3), #number(0.7), #number(1.8), #number(675.0), #symbol("2")],
                  [#number(13.8), #number(2.8), #number(2.3), #number(22.0), #number(90.0), #number(1.4), #number(0.7), #number(0.4), #number(1.0), #number(9.6), #number(0.7), #number(1.7), #number(615.0), #symbol("2")],
                  [#number(13.7), #number(4.4), #number(2.3), #number(22.5), #number(88.0), #number(1.3), #number(0.5), #number(0.5), #number(1.1), #number(6.6), #number(0.8), #number(1.8), #number(520.0), #symbol("2")],
                  [#number(13.4), #number(3.7), #number(2.6), #number(23.0), #number(111.0), #number(1.7), #number(0.9), #number(0.4), #number(1.5), #number(10.7), #number(0.8), #number(1.6), #number(695.0), #symbol("2")],
                  [#number(12.8), #number(3.4), #number(2.3), #number(19.5), #number(88.0), #number(1.5), #number(0.7), #number(0.4), #number(1.0), #number(10.3), #number(0.7), #number(1.8), #number(685.0), #symbol("2")],
                  [#number(13.6), #number(2.6), #number(2.7), #number(24.5), #number(105.0), #number(1.6), #number(0.8), #number(0.4), #number(1.5), #number(8.7), #number(0.7), #number(1.8), #number(750.0), #symbol("2")],
                  [#number(13.4), #number(4.6), #number(2.9), #number(25.0), #number(112.0), #number(2.0), #number(1.0), #number(0.3), #number(1.1), #number(8.5), #number(0.7), #number(1.9), #number(630.0), #symbol("2")],
                  [#number(12.2), #number(3.0), #number(2.3), #number(19.0), #number(96.0), #number(1.2), #number(0.5), #number(0.4), #number(0.7), #number(5.5), #number(0.7), #number(1.8), #number(510.0), #symbol("2")],
                  [#number(12.8), #number(2.4), #number(2.3), #number(19.5), #number(86.0), #number(1.4), #number(0.5), #number(0.5), #number(0.6), #number(9.9), #number(0.6), #number(1.6), #number(470.0), #symbol("2")],
                  [#number(14.2), #number(2.5), #number(2.5), #number(20.0), #number(91.0), #number(1.7), #number(0.7), #number(0.4), #number(1.2), #number(9.7), #number(0.6), #number(1.7), #number(660.0), #symbol("2")],
                  [#number(13.7), #number(5.7), #number(2.5), #number(20.5), #number(95.0), #number(1.7), #number(0.6), #number(0.5), #number(1.1), #number(7.7), #number(0.6), #number(1.7), #number(740.0), #symbol("2")],
                  [#number(13.4), #number(3.9), #number(2.5), #number(23.0), #number(102.0), #number(1.8), #number(0.8), #number(0.4), #number(1.4), #number(7.3), #number(0.7), #number(1.6), #number(750.0), #symbol("2")],
                  [#number(13.3), #number(4.3), #number(2.3), #number(20.0), #number(120.0), #number(1.6), #number(0.7), #number(0.4), #number(1.4), #number(10.2), #number(0.6), #number(1.6), #number(835.0), #symbol("2")],
                  [#number(13.2), #number(2.6), #number(2.4), #number(20.0), #number(120.0), #number(1.6), #number(0.7), #number(0.5), #number(1.5), #number(9.3), #number(0.6), #number(1.6), #number(840.0), #symbol("2")],
                  [#number(14.1), #number(4.1), #number(2.7), #number(24.5), #number(96.0), #number(2.0), #number(0.8), #number(0.6), #number(1.4), #number(9.2), #number(0.6), #number(1.6), #number(560.0), #symbol("2")]];

    var iris_data: [[dataMember]] =  [[#number(5.1), #number(3.5), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(4.9), #number(3.0), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(4.7), #number(3.2), #number(1.3), #number(0.2), #symbol("0")],
                                      [#number(4.6), #number(3.1), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.6), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(5.4), #number(3.9), #number(1.7), #number(0.4), #symbol("0")],
                                      [#number(4.6), #number(3.4), #number(1.4), #number(0.3), #symbol("0")],
                                      [#number(5.0), #number(3.4), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(4.4), #number(2.9), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(4.9), #number(3.1), #number(1.5), #number(0.1), #symbol("0")],
                                      [#number(5.4), #number(3.7), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(4.8), #number(3.4), #number(1.6), #number(0.2), #symbol("0")],
                                      [#number(4.8), #number(3.0), #number(1.4), #number(0.1), #symbol("0")],
                                      [#number(4.3), #number(3.0), #number(1.1), #number(0.1), #symbol("0")],
                                      [#number(5.8), #number(4.0), #number(1.2), #number(0.2), #symbol("0")],
                                      [#number(5.7), #number(4.4), #number(1.5), #number(0.4), #symbol("0")],
                                      [#number(5.4), #number(3.9), #number(1.3), #number(0.4), #symbol("0")],
                                      [#number(5.1), #number(3.5), #number(1.4), #number(0.3), #symbol("0")],
                                      [#number(5.7), #number(3.8), #number(1.7), #number(0.3), #symbol("0")],
                                      [#number(5.1), #number(3.8), #number(1.5), #number(0.3), #symbol("0")],
                                      [#number(5.4), #number(3.4), #number(1.7), #number(0.2), #symbol("0")],
                                      [#number(5.1), #number(3.7), #number(1.5), #number(0.4), #symbol("0")],
                                      [#number(4.6), #number(3.6), #number(1.0), #number(0.2), #symbol("0")],
                                      [#number(5.1), #number(3.3), #number(1.7), #number(0.5), #symbol("0")],
                                      [#number(4.8), #number(3.4), #number(1.9), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.0), #number(1.6), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.4), #number(1.6), #number(0.4), #symbol("0")],
                                      [#number(5.2), #number(3.5), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(5.2), #number(3.4), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(4.7), #number(3.2), #number(1.6), #number(0.2), #symbol("0")],
                                      [#number(4.8), #number(3.1), #number(1.6), #number(0.2), #symbol("0")],
                                      [#number(5.4), #number(3.4), #number(1.5), #number(0.4), #symbol("0")],
                                      [#number(5.2), #number(4.1), #number(1.5), #number(0.1), #symbol("0")],
                                      [#number(5.5), #number(4.2), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(4.9), #number(3.1), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.2), #number(1.2), #number(0.2), #symbol("0")],
                                      [#number(5.5), #number(3.5), #number(1.3), #number(0.2), #symbol("0")],
                                      [#number(4.9), #number(3.6), #number(1.4), #number(0.1), #symbol("0")],
                                      [#number(4.4), #number(3.0), #number(1.3), #number(0.2), #symbol("0")],
                                      [#number(5.1), #number(3.4), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.5), #number(1.3), #number(0.3), #symbol("0")],
                                      [#number(4.5), #number(2.3), #number(1.3), #number(0.3), #symbol("0")],
                                      [#number(4.4), #number(3.2), #number(1.3), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.5), #number(1.6), #number(0.6), #symbol("0")],
                                      [#number(5.1), #number(3.8), #number(1.9), #number(0.4), #symbol("0")],
                                      [#number(4.8), #number(3.0), #number(1.4), #number(0.3), #symbol("0")],
                                      [#number(5.1), #number(3.8), #number(1.6), #number(0.2), #symbol("0")],
                                      [#number(4.6), #number(3.2), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(5.3), #number(3.7), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.3), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(7.0), #number(3.2), #number(4.7), #number(1.4), #symbol("1")],
                                      [#number(6.4), #number(3.2), #number(4.5), #number(1.5), #symbol("1")],
                                      [#number(6.9), #number(3.1), #number(4.9), #number(1.5), #symbol("1")],
                                      [#number(5.5), #number(2.3), #number(4.0), #number(1.3), #symbol("1")],
                                      [#number(6.5), #number(2.8), #number(4.6), #number(1.5), #symbol("1")],
                                      [#number(5.7), #number(2.8), #number(4.5), #number(1.3), #symbol("1")],
                                      [#number(6.3), #number(3.3), #number(4.7), #number(1.6), #symbol("1")],
                                      [#number(4.9), #number(2.4), #number(3.3), #number(1.0), #symbol("1")],
                                      [#number(6.6), #number(2.9), #number(4.6), #number(1.3), #symbol("1")],
                                      [#number(5.2), #number(2.7), #number(3.9), #number(1.4), #symbol("1")],
                                      [#number(5.0), #number(2.0), #number(3.5), #number(1.0), #symbol("1")],
                                      [#number(5.9), #number(3.0), #number(4.2), #number(1.5), #symbol("1")],
                                      [#number(6.0), #number(2.2), #number(4.0), #number(1.0), #symbol("1")],
                                      [#number(6.1), #number(2.9), #number(4.7), #number(1.4), #symbol("1")],
                                      [#number(5.6), #number(2.9), #number(3.6), #number(1.3), #symbol("1")],
                                      [#number(6.7), #number(3.1), #number(4.4), #number(1.4), #symbol("1")],
                                      [#number(5.6), #number(3.0), #number(4.5), #number(1.5), #symbol("1")],
                                      [#number(5.8), #number(2.7), #number(4.1), #number(1.0), #symbol("1")],
                                      [#number(6.2), #number(2.2), #number(4.5), #number(1.5), #symbol("1")],
                                      [#number(5.6), #number(2.5), #number(3.9), #number(1.1), #symbol("1")],
                                      [#number(5.9), #number(3.2), #number(4.8), #number(1.8), #symbol("1")],
                                      [#number(6.1), #number(2.8), #number(4.0), #number(1.3), #symbol("1")],
                                      [#number(6.3), #number(2.5), #number(4.9), #number(1.5), #symbol("1")],
                                      [#number(6.1), #number(2.8), #number(4.7), #number(1.2), #symbol("1")],
                                      [#number(6.4), #number(2.9), #number(4.3), #number(1.3), #symbol("1")],
                                      [#number(6.6), #number(3.0), #number(4.4), #number(1.4), #symbol("1")],
                                      [#number(6.8), #number(2.8), #number(4.8), #number(1.4), #symbol("1")],
                                      [#number(6.7), #number(3.0), #number(5.0), #number(1.7), #symbol("1")],
                                      [#number(6.0), #number(2.9), #number(4.5), #number(1.5), #symbol("1")],
                                      [#number(5.7), #number(2.6), #number(3.5), #number(1.0), #symbol("1")],
                                      [#number(5.5), #number(2.4), #number(3.8), #number(1.1), #symbol("1")],
                                      [#number(5.5), #number(2.4), #number(3.7), #number(1.0), #symbol("1")],
                                      [#number(5.8), #number(2.7), #number(3.9), #number(1.2), #symbol("1")],
                                      [#number(6.0), #number(2.7), #number(5.1), #number(1.6), #symbol("1")],
                                      [#number(5.4), #number(3.0), #number(4.5), #number(1.5), #symbol("1")],
                                      [#number(6.0), #number(3.4), #number(4.5), #number(1.6), #symbol("1")],
                                      [#number(6.7), #number(3.1), #number(4.7), #number(1.5), #symbol("1")],
                                      [#number(6.3), #number(2.3), #number(4.4), #number(1.3), #symbol("1")],
                                      [#number(5.6), #number(3.0), #number(4.1), #number(1.3), #symbol("1")],
                                      [#number(5.5), #number(2.5), #number(4.0), #number(1.3), #symbol("1")],
                                      [#number(5.5), #number(2.6), #number(4.4), #number(1.2), #symbol("1")],
                                      [#number(6.1), #number(3.0), #number(4.6), #number(1.4), #symbol("1")],
                                      [#number(5.8), #number(2.6), #number(4.0), #number(1.2), #symbol("1")],
                                      [#number(5.0), #number(2.3), #number(3.3), #number(1.0), #symbol("1")],
                                      [#number(5.6), #number(2.7), #number(4.2), #number(1.3), #symbol("1")],
                                      [#number(5.7), #number(3.0), #number(4.2), #number(1.2), #symbol("1")],
                                      [#number(5.7), #number(2.9), #number(4.2), #number(1.3), #symbol("1")],
                                      [#number(6.2), #number(2.9), #number(4.3), #number(1.3), #symbol("1")],
                                      [#number(5.1), #number(2.5), #number(3.0), #number(1.1), #symbol("1")],
                                      [#number(5.7), #number(2.8), #number(4.1), #number(1.3), #symbol("1")],
                                      [#number(6.3), #number(3.3), #number(6.0), #number(2.5), #symbol("2")],
                                      [#number(5.8), #number(2.7), #number(5.1), #number(1.9), #symbol("2")],
                                      [#number(7.1), #number(3.0), #number(5.9), #number(2.1), #symbol("2")],
                                      [#number(6.3), #number(2.9), #number(5.6), #number(1.8), #symbol("2")],
                                      [#number(6.5), #number(3.0), #number(5.8), #number(2.2), #symbol("2")],
                                      [#number(7.6), #number(3.0), #number(6.6), #number(2.1), #symbol("2")],
                                      [#number(4.9), #number(2.5), #number(4.5), #number(1.7), #symbol("2")],
                                      [#number(7.3), #number(2.9), #number(6.3), #number(1.8), #symbol("2")],
                                      [#number(6.7), #number(2.5), #number(5.8), #number(1.8), #symbol("2")],
                                      [#number(7.2), #number(3.6), #number(6.1), #number(2.5), #symbol("2")],
                                      [#number(6.5), #number(3.2), #number(5.1), #number(2.0), #symbol("2")],
                                      [#number(6.4), #number(2.7), #number(5.3), #number(1.9), #symbol("2")],
                                      [#number(6.8), #number(3.0), #number(5.5), #number(2.1), #symbol("2")],
                                      [#number(5.7), #number(2.5), #number(5.0), #number(2.0), #symbol("2")],
                                      [#number(5.8), #number(2.8), #number(5.1), #number(2.4), #symbol("2")],
                                      [#number(6.4), #number(3.2), #number(5.3), #number(2.3), #symbol("2")],
                                      [#number(6.5), #number(3.0), #number(5.5), #number(1.8), #symbol("2")],
                                      [#number(7.7), #number(3.8), #number(6.7), #number(2.2), #symbol("2")],
                                      [#number(7.7), #number(2.6), #number(6.9), #number(2.3), #symbol("2")],
                                      [#number(6.0), #number(2.2), #number(5.0), #number(1.5), #symbol("2")],
                                      [#number(6.9), #number(3.2), #number(5.7), #number(2.3), #symbol("2")],
                                      [#number(5.6), #number(2.8), #number(4.9), #number(2.0), #symbol("2")],
                                      [#number(7.7), #number(2.8), #number(6.7), #number(2.0), #symbol("2")],
                                      [#number(6.3), #number(2.7), #number(4.9), #number(1.8), #symbol("2")],
                                      [#number(6.7), #number(3.3), #number(5.7), #number(2.1), #symbol("2")],
                                      [#number(7.2), #number(3.2), #number(6.0), #number(1.8), #symbol("2")],
                                      [#number(6.2), #number(2.8), #number(4.8), #number(1.8), #symbol("2")],
                                      [#number(6.1), #number(3.0), #number(4.9), #number(1.8), #symbol("2")],
                                      [#number(6.4), #number(2.8), #number(5.6), #number(2.1), #symbol("2")],
                                      [#number(7.2), #number(3.0), #number(5.8), #number(1.6), #symbol("2")],
                                      [#number(7.4), #number(2.8), #number(6.1), #number(1.9), #symbol("2")],
                                      [#number(7.9), #number(3.8), #number(6.4), #number(2.0), #symbol("2")],
                                      [#number(6.4), #number(2.8), #number(5.6), #number(2.2), #symbol("2")],
                                      [#number(6.3), #number(2.8), #number(5.1), #number(1.5), #symbol("2")],
                                      [#number(6.1), #number(2.6), #number(5.6), #number(1.4), #symbol("2")],
                                      [#number(7.7), #number(3.0), #number(6.1), #number(2.3), #symbol("2")],
                                      [#number(6.3), #number(3.4), #number(5.6), #number(2.4), #symbol("2")],
                                      [#number(6.4), #number(3.1), #number(5.5), #number(1.8), #symbol("2")],
                                      [#number(6.0), #number(3.0), #number(4.8), #number(1.8), #symbol("2")],
                                      [#number(6.9), #number(3.1), #number(5.4), #number(2.1), #symbol("2")],
                                      [#number(6.7), #number(3.1), #number(5.6), #number(2.4), #symbol("2")],
                                      [#number(6.9), #number(3.1), #number(5.1), #number(2.3), #symbol("2")],
                                      [#number(5.8), #number(2.7), #number(5.1), #number(1.9), #symbol("2")],
                                      [#number(6.8), #number(3.2), #number(5.9), #number(2.3), #symbol("2")],
                                      [#number(6.7), #number(3.3), #number(5.7), #number(2.5), #symbol("2")],
                                      [#number(6.7), #number(3.0), #number(5.2), #number(2.3), #symbol("2")],
                                      [#number(6.3), #number(2.5), #number(5.0), #number(1.9), #symbol("2")],
                                      [#number(6.5), #number(3.0), #number(5.2), #number(2.0), #symbol("2")],
                                      [#number(6.2), #number(3.4), #number(5.4), #number(2.3), #symbol("2")],
                                      [#number(5.9), #number(3.0), #number(5.1), #number(1.8), #symbol("2")]];

    var data: [[dataMember]] = [[#symbol("0"), #number(1), #number(2), #symbol("0")],
                                [#symbol("0"), #number(2), #number(3), #symbol("0")],
                                [#symbol("0"), #number(5), #number(4), #symbol("1")],
                                [#symbol("0"), #number(8), #number(5), #symbol("1")],
                                [#symbol("1"), #number(5), #number(2), #symbol("1")],
                                [#symbol("1"), #number(6), #number(3), #symbol("1")],
                                [#symbol("1"), #number(3), #number(4), #symbol("0")],
                                [#symbol("1"), #number(4), #number(5), #symbol("1")]];

    let LeftLeftTree: BinTree  = setLeftRightBranch(null, null, #symbol([1,0]), nilTree(), nilTree());
    let LeftRightTree: BinTree = setLeftRightBranch(null, null, #symbol([0,1]), nilTree(), nilTree());
    let LeftTopTree: BinTree   = setLeftRightBranch(?1, ?(3.5), #symbol([0.5,0.5]), LeftLeftTree, LeftRightTree);
    let RightLeftTree: BinTree  = setLeftRightBranch(null, null, #symbol([0,1]), nilTree(), nilTree());
    let RightRightTree: BinTree = setLeftRightBranch(null, null, #symbol([1,0]), nilTree(), nilTree());
    let RightTopTree: BinTree   = setLeftRightBranch(?1, ?(3.5), #symbol([0.5,0.5]), RightLeftTree, RightRightTree);
    let TopTree: BinTree   = setLeftRightBranch(?0, ?(2.5), #symbol([0.5,0.5]), LeftTopTree, RightTopTree);  
    //<-----IM HERE!!!!

    //todo:
    // 1) test that "predict" works
    // 2) learnTree function (paramters hardcoded btb) 
    // 3) more complex "data" (more features and more samples)
    //

      
    // let bufaux = Buffer.Buffer<Nat>(nsamples);
        
    // while (TrieSet.toArray<Nat>(TrieSet.fromArray<Nat>(Buffer.toArray<Nat>(bufaux),Hash.hash, Nat.equal)).size() < nsamples) { 
    //   let randNat: Nat = fuzz.nat.randomRange(0, iris_data.size()-1);
    //   bufaux.add(randNat);
    // };


    // let pos_vec = TrieSet.toArray<Nat>(TrieSet.fromArray<Nat>(Buffer.toArray<Nat>(bufaux),Hash.hash, Nat.equal)); 
    // Debug.print("size: " # Nat.toText(pos_vec.size()));


    func randomSample(min_: Nat, max_: Nat, nsamples_: Nat, withRepetition_: Bool): [Nat] {
      let bufaux = Buffer.Buffer<Nat>(nsamples_);
      if (withRepetition_ == false) {
        while (TrieSet.toArray<Nat>(TrieSet.fromArray<Nat>(Buffer.toArray<Nat>(bufaux),Hash.hash, Nat.equal)).size() < nsamples_) { 
          let randNat: Nat = fuzz.nat.randomRange(min_, max_);
          bufaux.add(randNat);
        };
      }
      else {
        while (Buffer.toArray<Nat>(bufaux).size() < nsamples_) { 
          let randNat: Nat = fuzz.nat.randomRange(min_, max_);
          bufaux.add(randNat);
        };
      };
      let pos_vec = TrieSet.toArray<Nat>(TrieSet.fromArray<Nat>(Buffer.toArray<Nat>(bufaux),Hash.hash, Nat.equal)); 
      return pos_vec;
    };
    
    //let pos_vec = randomSample(0, iris_data.size(), 20, false);

    //let xtrain = cols([0,1], data); 
    //let ytrain = transpose(cols([2], data));

    func checkAllSymbol(y : [dataMember]): (Bool) {
      for (i in Iter.range(0, y.size() - 1)) {
        switch(y[i]) {
          case (#number(num)) {
            return false;
          };
          case (_) {
            //donothing
          };
        };
      };
      return true;
    };

    func gini(y: [Text], y_uniques: [Text]): (Float) {
      // 
      var g_total: Float = 0.0;
      for (i in Iter.range(0,y_uniques.size()-1)) {
        let ys_y =  Array.filter<Text>(y, func x = x == y_uniques[i]);
        let p_y = Float.fromInt(ys_y.size()) / Float.fromInt(y.size()); 
        let g_y = p_y * (1 - p_y);
        g_total := g_total + g_y;
      };
      return g_total;
    };
  
    let NUM_CHECKS_GINI : Nat = 10;
    let X_UNIQUES : [Text] = ["0","1"];

    func computeFeatureGini(xcol: [dataMember],y:[Text],y_uniques:[Text]): Result.Result<(Float,Float), MotokoLearnError> {
      // check whether this a nueric or a symbolic feature
      let aux: dataMember = xcol[0];
      switch(aux) {
        case (#number(num)) {
          let xs = dataMemberVectorToFloatVector(xcol);
          switch (xs) {
            case (#ok(xs_num)) {
              let xs_min = mtkl.min(xs_num);
              let xs_max = mtkl.max(xs_num);
              let th_vec: [Float] = mtkl.linspace(xs_min,xs_max,NUM_CHECKS_GINI); // NUM_CHECKS_GINI : Nat = 10; it should be a private constant of the future module
              let ginis = Buffer.Buffer<Float>(th_vec.size());
              for (i in Iter.range(0, th_vec.size() - 1)) {
                let th = th_vec[i];
                let ret_xi = Array.mapEntries<Float, Bool>(xs_num, func (xx, ii) = (xx <= th));
                let ret_xi_size: Nat = Array.filter<Bool>(ret_xi, func xx = xx == true).size();
                let ret_yi_l = Buffer.Buffer<Text>(ret_xi_size);
                let ret_yi_r = Buffer.Buffer<Text>(ret_xi.size()-ret_xi_size);
                var gini_l: Float = 0;
                var gini_r: Float = 0;
                var weight_l: Float = 0;
                var weight_r: Float = 0;
                if (ret_xi_size > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    if (ret_xi[j]==true) {
                      ret_yi_l.add(y[j]);
                    }
                  };
                  gini_l := gini(Buffer.toArray(ret_yi_l), y_uniques);
                  weight_l := Float.fromInt(Buffer.toArray(ret_yi_l).size())/Float.fromInt(y.size());
                };
                if ( (ret_xi.size()-ret_xi_size) > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    if (ret_xi[j]==false) {
                      ret_yi_r.add(y[j]);
                    }
                  };
                  gini_r := gini(Buffer.toArray(ret_yi_r), y_uniques);
                  weight_r := Float.fromInt(Buffer.toArray(ret_yi_r).size())/Float.fromInt(y.size());
                };
                ginis.add(weight_l*gini_l+weight_r*gini_r);
              }; 
              let bestgini = mtkl.min(Buffer.toArray(ginis));
              let bestth_i: ?Nat = Array.indexOf<Float>(bestgini, Buffer.toArray(ginis), Float.equal);
              let bestth_ix: Nat = switch bestth_i {
                case null 0;
                case (?Nat) Nat;
              };
              return #ok(bestgini,th_vec[bestth_ix]);
            };
            case (#err(err)) {
              // TBD
            }
          };

          return (#ok(0,0)); //TBD
        };
        case (#symbol(sym)) {
          let xs = dataMemberVectorToTextVector(xcol);
          switch (xs) {
            case (#ok(xs_text)) {
              // check exatly 2 different symbolic features: remeber it will require 
              //let x_uniques = ["0","1"];   // NOTE: x_uniques is always ["0","1"], y_uniques is problem dependent. E.g. has 4 classes
              // if (x_uniques.size() != 2) {
              //   return (#err(#notExactly2UniqueXSymbols))
              // };
              // for each unique x get the corresponding y vector and compute gini and weight
              let ginis = Buffer.Buffer<Float>(2);
              let weigths = Buffer.Buffer<Float>(2);
              for (i in Iter.range(0, 2 - 1)) {
                //let num_ys: Nat = Array.filter<Text>(xs_text, func x = x == x_uniques[i]);
                //Debug.print("211:"#Nat.toText(xs_text.size()));
                let ret_xi = Array.mapEntries<Text, Bool>(xs_text, func (xx, ii) = Text.equal(xx,X_UNIQUES[i]));//Debug.print("2111");
                let ret_xi_size: Nat = Array.filter<Bool>(ret_xi, func xx = xx == true).size();//Debug.print("21:"#Nat.toText(ret_xi_size));
                let ret_yi = Buffer.Buffer<Text>(ret_xi_size);//Debug.print("212");
                if (ret_xi_size > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    //Debug.print("j"#Nat.toText(j));
                    if (ret_xi[j]) {
                      ret_yi.add(y[j]);//Debug.print("214");
                    }
                  };
                  //Debug.print("219:"#Nat.toText(ret_yi.size()));
                  let gini_aux: Float = gini(Buffer.toArray(ret_yi), y_uniques);//Debug.print("215");
                  ginis.add(gini_aux);//Debug.print("216:"#Float.toText(gini_aux)#Float.toText(Float.fromInt(Buffer.toArray(ret_yi).size())/Float.fromInt(y.size())));
                  weigths.add(Float.fromInt(Buffer.toArray(ret_yi).size())/Float.fromInt(y.size()));//Debug.print("217");
                }
                else { // case x_uniques[i] does not exist in xcol, then weight is 0
                  ginis.add(0);
                  weigths.add(0);
                };
              };
              let ws = Buffer.toArray(weigths);
              let gs = Buffer.toArray(ginis);
              return #ok(ws[0]*gs[0]+ws[1]*gs[1],0);
            };
            case (#err(xs_text)) {
              return #err(#notAllYsymbols);
            };
          };
        };
      };
    };
    
    func computeThLeftRightNumeric(x: [dataMember], y: [Text], y_uniques: [Text], bestth: Float): ([Nat], [Nat]) {
      let xs = dataMemberVectorToFloatVector(x);
      switch (xs) {
        case (#ok(xs_num)) {
          let ret_xi: [Bool]= Array.mapEntries<Float, Bool>(xs_num, func (xx, ii) = (xx <= bestth));
          let sumtrues = mtkl.sumTrues(ret_xi);
          let left_i = Buffer.Buffer<Nat>(sumtrues);
          let right_i = Buffer.Buffer<Nat>(ret_xi.size()-sumtrues);
          for (j in Iter.range(0, ret_xi.size() - 1)) {
            if (ret_xi[j]==true) left_i.add(j)
            else right_i.add(j);
          };
           Debug.print("cols:"#Nat.toText(x.size())#":"#Nat.toText(Buffer.toArray(left_i).size())#":"#Nat.toText(Buffer.toArray(right_i).size()));
          return (Buffer.toArray(left_i),Buffer.toArray(right_i));
        };
        case (_) {return ([0],[0]);};
      };
    };

    func computeLeftRightSymbolic(x: [dataMember], y: [Text], y_uniques: [Text]): ([Nat], [Nat]) {
      let xs = dataMemberVectorToTextVector(x);
      switch (xs) {
        case (#ok(xs_sym)) {
          let ret_xi: [Bool] = Array.mapEntries<Text, Bool>(xs_sym, func (xx, ii) = Text.equal(xx,X_UNIQUES[0]));
          let sumtrues = mtkl.sumTrues(ret_xi);
          let left_i = Buffer.Buffer<Nat>(sumtrues);
          let right_i = Buffer.Buffer<Nat>(ret_xi.size()-sumtrues);
          for (j in Iter.range(0, ret_xi.size() - 1)) {
            if (ret_xi[j]==true) left_i.add(j)
            else right_i.add(j);
          };
         
          return (Buffer.toArray(left_i),Buffer.toArray(right_i));
        };
        case (_) {return ([0],[0]);};
      };
    };

    func dataMemberVectorToTextVector(y: [dataMember]): Result.Result<[Text], MotokoLearnError> {
      let ysize = y.size();
      let ret = Buffer.Buffer<Text>(ysize); 
      for (i in Iter.range(0, ysize - 1)) {
        let aux = y[i];
        switch(aux) {
          case (#symbol(sym)) {
            ret.add(sym);
          };
          case (_) {
            return #err(#notAllYsymbols);
          };
        };
      };   
      return #ok(Buffer.toArray(ret)); 
    };

    func dataMemberVectorToFloatVector(y: [dataMember]): Result.Result<[Float], MotokoLearnError> {
      let ysize = y.size();
      let ret = Buffer.Buffer<Float>(ysize); 
      for (i in Iter.range(0, ysize - 1)) {
        let aux = y[i];
        switch(aux) {
          case (#number(num)) {
            ret.add(num);
          };
          case (_) {
            return #err(#notAllNumbers);
          };
        };
      };   
      return #ok(Buffer.toArray(ret)); 
    };

    
    // let x = transpose(cols([1],data));
    // let ycol = cols([3],data);
    // let yvec = transpose(ycol);
    // let y_txt = dataMemberVectorToTextVector(yvec[0]);
    // switch (y_txt) {
    //   case (#ok(ys_text)) {
    //     // check exatly 2 different symbolic features: remeber it will require 
    //     let y_uniques = uniquesText(ys_text);
    //     let aux = computeFeatureGini(x[0],ys_text,y_uniques);
    //     switch (aux) {
    //       case (#ok(num)){
    //         Debug.print("Gini:"#Float.toText(num));
    //       };
    //       case (_) {
    //         //
    //       };
    //     };
    //   };
    //   case (_) {

    //   };
    // };


  

    func fitClassification(x : [[dataMember]], 
                           y : [Text], 
                           current_depth : Nat, 
                           y_uniques: [Text], 
                           max_depth: Nat, 
                           min_node_data_size: Nat,
                           col_ids: [Nat]): Result.Result<BinTree, MotokoLearnError> {
      for (i in Iter.range(0, col_ids.size() - 1)) {
        Debug.print(Nat.toText(col_ids[i]));
      }; 
      // check size of x is at least the minimum size and we are not at the deepest level allowed
      let probs = Buffer.Buffer<Float>(y_uniques.size());
      for (i in Iter.range(0, y_uniques.size() - 1)) { 
          let num_ys: Nat = Array.filter<Text>(y, func x = x == y_uniques[i]).size();
          let prob = Float.fromInt(num_ys) / Float.fromInt(y.size());
          Debug.print("prob:"#Float.toText(prob));
          Debug.print("i:"#Nat.toText(i));
          Debug.print("y:"#y_uniques[i]);
          Debug.print("num_ys:"#Nat.toText(num_ys));
          probs.add(prob);
        };
      // Debug.print("before Entropy");
      let node_entropy = mtkl.entropy(y, y_uniques);
      let x_ncols = mtkl.transpose(x).size();   // if we only have 1 feature, we finish branch 
      // Debug.print("After Entropy)");
      if (x.size() <= min_node_data_size or current_depth >= max_depth or node_entropy==0 or x_ncols == 1) {
        // Debug.print("Reason to leaf:");
        // Debug.print("x.size() <= min_node_data_size:" # Bool.toText(x.size() <= min_node_data_size));
        // Debug.print("current_depth >= max_depth:"#Bool.toText(current_depth >= max_depth));
        // Debug.print("node_entropy==0:"#Bool.toText(node_entropy==0));

        let leafNode: BinTree  = setLeftRightBranch(null, null, #symbol(Buffer.toArray(probs)), nilTree(), nilTree());
        return #ok(leafNode);
      };
      // create node  
      // for all features
      let xt = mtkl.transpose(x);// Debug.print("11");
      let ginis = Buffer.Buffer<Float>(xt.size());// Debug.print("12");
      let ths = Buffer.Buffer<Float>(xt.size());// Debug.print("13:"#Nat.toText(col_ids.size())#":"#Nat.toText(xt.size()));
      for (i in Iter.range(0, xt.size() - 1)) {
        let xcol = xt[i];
        let gini = computeFeatureGini(xcol,y,y_uniques);
        switch (gini) {
          case (#ok(gini_float, th_float)) {
            ginis.add(gini_float);// Debug.print("14");
            ths.add(th_float);// Debug.print("15");
          };
          case (#err(err)) {
            return #err(err);// Debug.print("16");
          };
        }; 
      }; 
      // compute gini index of the
      let ginis_array = Buffer.toArray(ginis);// Debug.print("17");
      let ths_array: [Float] = Buffer.toArray(ths);// Debug.print("18");
      let bestgini = mtkl.min(ginis_array);// Debug.print("19");
      let bestcol: ?Nat = Array.indexOf<Float>(bestgini, ginis_array, Float.equal);// Debug.print("101");
      if (bestcol==null) {
        return #err(#noBestGiniError);
      };
      let xbestcol : Nat = switch bestcol {
        case null 0;
        case (?Nat) Nat;
      };
      let bestth = ths_array[xbestcol];// Debug.print("102");
      
      // recursive call left and right and connect to node and return 
      let myx = mtkl.transpose(mtkl.cols<dataMember>([xbestcol], x))[0];// Debug.print("103");

      let (left_rows,right_rows) = switch (myx[0]) {
        case (#number(num)) computeThLeftRightNumeric(myx, y, y_uniques, bestth);
        case (#symbol(sym)) computeLeftRightSymbolic(myx, y, y_uniques);
      };Debug.print("104");

      let x2 = mtkl.removeRows([xbestcol], x);// Debug.print("105");
      let y2 = mtkl.removeRowsVector([xbestcol], y);// Debug.print("106");
      
      // pick the true col_id from col_ids
      // Debug.print("xbestcol:"#Nat.toText(xbestcol));
      let true_colid: Nat = col_ids[xbestcol];// Debug.print("107");
      Debug.print("TRUE_COLID: "#Nat.toText(true_colid)#" "#Nat.toText(ginis.size())#" "#Nat.toText(ginis_array.size()));
      // remove "true_colid" from col_ids before passing recursively
      let next_col_ids: [Nat] = mtkl.removeRowsVector([xbestcol], col_ids);Debug.print("108");
      
      //let next_x: [[dataMember]] = cols(next_col_ids, x);Debug.print("109");
      Debug.print("xbestcol: "#Nat.toText(xbestcol));
      Debug.print("size(X): "#Nat.toText(mtkl.transpose(x).size()));
      let next_x: [[dataMember]] = mtkl.transpose(mtkl.removeRows([xbestcol], mtkl.transpose(x))); Debug.print("109");


      Debug.print("Next col ids: "#Nat.toText(next_col_ids.size())#":"#Nat.toText(mtkl.transpose(next_x).size())); Debug.print("110");
      let x_left = mtkl.rows(left_rows,next_x);
      let y_left = mtkl.rowsVector(left_rows,y);
      let x_right = mtkl.rows(right_rows,next_x);
      let y_right = mtkl.rowsVector(right_rows,y);

      let leftNode_aux  = fitClassification(x_left, y_left, current_depth + 1, y_uniques, max_depth, min_node_data_size, next_col_ids);
      let rightNode_aux  = fitClassification(x_right, y_right, current_depth + 1, y_uniques, max_depth, min_node_data_size, next_col_ids);
      let leftNode = switch leftNode_aux {
        case (#ok(leftNode)) leftNode;
        case (#err(err)) return leftNode_aux;
      };
      let rightNode = switch rightNode_aux {
        case (#ok(rightNode)) rightNode;
        case (#err(err)) return rightNode_aux;
      };
      let thisNode: BinTree = setLeftRightBranch(?true_colid, ?bestth, #symbol(Buffer.toArray(probs)), leftNode, rightNode);
      
      return #ok(thisNode);
    };   

    // 
    // Inference code
    //

    func isLeftNode(feature_: dataMember, th_: Float): (Bool) { 
      switch feature_ {
        case (#number(num)) {
          //TBD
          //Debug.print("numeric feature: " # Float.toText(num));
          if (num <= th_) {
            return true;
          }
          else {
            return false;
          };
        };
        case (#symbol(txt)) {
          //Debug.print("symbol feature: " # txt);
          if (Text.equal(txt, "0")) {
            return true;
          }
          else {
            return false;
          }
        };
      };
    };

    func predictTree(x : [dataMember], bintree : BinTree) : () {
      // 1) check assert the size of x is > 0
      // 2) check bintree is not nil
      // 3) do until bintree in left or right is nil and return "value" (try first iterative , if not possible recursion)         
      switch bintree {
        case null {
          //Debug.print("Do nothing");
        };
        case (?(xvar_id,xth,xvalue,bl,br)) {
          switch xvar_id {
            case null {
              //Debug.print("I am in leaf node");
              // node leaf: return the value
              switch xvalue {
                case (#number(val)) {
                  //TBD
                  Debug.print("Result: " # Float.toText(val));
                };
                case (#symbol(vec)) {
                  //TBD
                  Debug.print("Probs vector: ");
                  for (i in Iter.range(0, vec.size() - 1)) {
                    Debug.print(Float.toText(vec[i]));
                  };
                };
                // case null {
                //   //TBD
                // };
              };
            };
            case _ {
              //Debug.print("I am in a tree node");
              // get feature value
              let var_id : Nat = switch xvar_id {
                case null 0;
                case (?Nat) Nat;
              };
              //Debug.print("var_id:" # Nat.toText(var_id));
              let feature: dataMember = x[var_id]; 
              let th : Float = switch xth {
                  case null 0;
                  case (?Float) Float;
              };
              //Debug.print("th:" # Float.toText(th));
              if (isLeftNode(feature: dataMember, th: Float)) {
                 //Debug.print("predict left");
                 predictTree(x, bl);
               }
              else {
                 //predict right
                 //Debug.print("predict right");
                 predictTree(x, br);
              };
            }; 
          };
        };
      };
    };
 

    func predictClassificationTree(x : [dataMember], bintree : BinTree) : ([Float]) {
      // 1) check assert the size of x is > 0
      // 2) check bintree is not nil
      // 3) do until bintree in left or right is nil and return "value" (try first iterative , if not possible recursion)         
      switch bintree {
        case null {
          //Debug.print("Do nothing");
          Debug.print("UNEXPECTED");
          return [0,0,0];
        };
        case (?(xvar_id,xth,xvalue,bl,br)) {
          switch xvar_id {
            case null {
              //Debug.print("I am in leaf node");
              // node leaf: return the value
              switch xvalue {
                case (#symbol(vec)) {
                  //TBD
                  // Debug.print("p1");
                  return vec;
                };
                case (_) {
                  Debug.print("UNEXPECTED");
                  return [0,0,0];
                //   //TBD
                };
              };
            };
            case _ {
              //Debug.print("I am in a tree node");
              // get feature value
              let var_id : Nat = switch xvar_id {
                case null 0;
                case (?Nat) Nat;
              };// Debug.print("p2");
              // Debug.print("var_id:" # Nat.toText(var_id));
              let feature: dataMember = x[var_id]; // Debug.print("p3");
              let th : Float = switch xth {
                  case null 0;
                  case (?Float) Float;
              };// Debug.print("p4");
              //Debug.print("th:" # Float.toText(th));
              if (isLeftNode(feature: dataMember, th: Float)) {
                 //Debug.print("predict left");
                 // Debug.print("p5");
                 predictClassificationTree(x, bl);
               }
              else {
                 //predict right
                 //Debug.print("predict right");
                 // Debug.print("p6");
                 predictClassificationTree(x, br);
              };
            }; 
          };
        };
      };
    };

    // func printSample(x: [dataMember]): (Text) {
    //   var x_text: Text = "";
    //   for (i in Iter.range(0, x.size() - 1)) {
        
    //     switch (x[i]) {
    //       case (#symbol(sym)) {
    //         x_text := x_text # sym;
    //       };
    //       case (#number(num)) {
    //         x_text := x_text # Float.toText(num);
    //       };
    //     };
    //     if (i < x.size()) {
    //       x_text := x_text #", "
    //     };
    //   }; 
    //   return x_text;
    // };

    //<----------------------------------IMHERE: test fitted classifciation tree
    let seed = 123456789;
    let fuzz = Fuzz.fromSeed(seed);

    let nsamples: Nat = 100;
    let alldata = wine_data;
    let pos_vec = randomSample(0, alldata.size()-1, nsamples, false);Debug.print("1");

    let Xtrain = mtkl.rows(pos_vec, alldata); Debug.print("11");
    let Xtest = mtkl.removeRows(pos_vec, alldata); Debug.print("11");
    let xcols = Iter.toArray(Iter.range(0, mtkl.transpose(Xtrain).size()-1));
    let xtrain = mtkl.cols(xcols, Xtrain);Debug.print("12"#":"#Nat.toText(mtkl.transpose(Xtrain).size()));
    let yaux = mtkl.transpose(mtkl.cols([mtkl.transpose(Xtrain).size()-1], Xtrain))[0];Debug.print("13");
    let ytrain = dataMemberVectorToTextVector(yaux);Debug.print("14");
    let xtest = mtkl.cols(xcols, Xtest);Debug.print("141");
    let yauxtest = mtkl.transpose(mtkl.cols([mtkl.transpose(Xtest).size()-1], Xtest))[0];Debug.print("142");
    let ytest = dataMemberVectorToTextVector(yauxtest);Debug.print("143");
   
    switch(ytrain) {
      case (#ok(yvec)) {
        let y_uniques = mtkl.uniquesText(yvec);Debug.print("15");
        let myiter = Iter.range(0, mtkl.transpose(xtrain).size()-1);Debug.print("16");
        let col_ids = Iter.toArray(myiter);Debug.print("17");
        let ret_tree = fitClassification(xtrain, yvec, 0, y_uniques, 3, 10, col_ids); Debug.print("18");
        Debug.print("Tree created");
        switch(ret_tree) {
          case (#ok(mytree)) {
            switch(ytest) {
              case (#ok(yvectest)) {
                var ncorrect: Nat = 0; 
                for (i in Iter.range(0, xtest.size() - 1)) {
                  //return mytree;
                  Debug.print(Nat.toText(i));
                  let sample: [dataMember] = xtest[i]; // Debug.print("11");
                  let vec = predictClassificationTree(sample, mytree);// Debug.print("12");
                  let myindex = Array.indexOf<Float>(mtkl.max(vec), vec, Float.equal);// Debug.print("13");
                  let xindex: Nat = switch(myindex) {
                    case (?Nat) Nat; 
                    case _ 10;
                  };// Debug.print("14");
                  let text_sample = mtkl.printSample(sample);
                  Debug.print("sample: " # text_sample);
                  if (Text.equal(y_uniques[xindex], yvectest[i])) {
                    Debug.print("correct");
                    ncorrect := ncorrect + 1;  
                  }
                  else {
                    Debug.print("wrong"#y_uniques[xindex]#":"#yvectest[i]); 
                  };
                };
                Debug.print("Percentage correct predictions:"#Float.toText(100*Float.fromInt(ncorrect)/Float.fromInt(yvectest.size())));
              };
              case (_) {
                //TBD
              }
            };
            return mytree;
          };
          case (_) {
            return TopTree;
          };
        }
      };
      case (_) {
        return TopTree;
      };
    };
    //return TopTree;
  };


    //return TopTree;

    // func fit(x : [[dataMember]], y : [dataMember]): Result.Result<BinTree, MotokoLearnError> {
    //   // Algorithm guide: https://machinelearningmastery.com/classification-and-regression-trees-for-machine-learning/
    //   // 1) check x,y dimesnions are consistent
    //   if (x.size() != y.size()) {
    //     return #err(#sizeMissmatchXY);
    //   };
    //   // 2) call specific function for classification or regression: classwificationFit, regressionFit (these 2 functions are recursive)
    //   let aux: dataMember = y[0];
    //   switch(aux) {
    //     case (#number(num)) {
    //       return (#ok(TopTree));
    //     };
    //     case (#symbol(sym)) {
    //       let ys = dataMemberVectorToTextVector(y);
    //       switch (ys) {
    //         case (#ok(ys_text)) {
    //            let y_uniques = uniquesText(ys_text);
    //            let current_depth = 0;
    //            let max_depth = 3;
    //            let min_node_data_size = 0;
    //            let tree_or_error = fitClassification(x, ys_text, current_depth, y_uniques, max_depth, min_node_data_size);
    //            switch(tree_or_error) {
    //             case(#err(_)) {
    //                return tree_or_error;
    //             };
    //             case(#ok(tree)) {
    //                return tree_or_error;
    //             };
    //           };
    //         };
    //         case (_) {
    //           return #err(#notAllYsymbols); // forward error
    //         };
    //       };
    //     };
    //   };
      // 3) When to create a division: number of samples larger than leaf_min_samples and entropy larger than 0 and depth is lower than max depth
      //    how to know current depth?: function caller passes parameter "current_depth = current_depth+1", later we also pass structure with HPs  
      //    how to know what data to use? function caller passes only the necessary x rows to each branch
      //    3.1) determine the var_id to use: it can be  numeric or symbolic
      //         do we remove a var_id once used?
      //         how do we compare symbolic with numeric seprability performance? no problem, we always compare according to y
      //         what order do we follow to test among the available var_ids giving best partition?
      //         showld we test all var_ids? if more than M, pick only M randomly  
      //         how do we find the th on numeric features?
      //return #ok(TopTree);
    //};

    

    //let Xtest = cols([0,1], data); 
    // for (i in Iter.range(0, Xtest.size() - 1)) {
    //   let sample: [dataMember] = Xtest[i];//[#number(1), #number(2), #symbol("0")];   
    //   predictTree(sample, TopTree);
    // };
  
//   return TopTree;
};