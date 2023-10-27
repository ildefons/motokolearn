import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Float "mo:base/Float";
import Text "mo:base/Text";
import Array "mo:base/Array";
import List "mo:base/List";
import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import TrieSet "mo:base/TrieSet";
import Debug "mo:base/Debug";
import Result "mo:base/Result";
import Error "mo:base/Error";
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
  // tree
  // inpyred by list:
  // https://github.com/dfinity/motoko-base/blob/master/src/List.mo
  
  type BinTree<T> = ?(T, BinTree<T>, BinTree<T>);
  func nilTree<T>() : BinTree<T> = null;
  func setLeftRightBranch<T>(x : T, leftTree : BinTree<T>, rightTree : BinTree<T>) : BinTree<T> {
    ?(x, leftTree, rightTree);
  };

  public type MotokoLearnError = {
    #notAllYsAreSymbol;
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
  
  func hashText(key: Text): Nat32 {
    Prim.hashBlob(Prim.encodeUtf8(key)) & 0x3fffffff;
  };

  // func hashNat(key: Nat): Nat32 {
  //   var hash = Prim.intToNat64Wrap(key);

  //   hash := hash >> 30 ^ hash *% 0xbf58476d1ce4e5b9;
  //   hash := hash >> 27 ^ hash *% 0x94d049bb133111eb;

  //   Prim.nat64ToNat32(hash >> 31 ^ hash & 0x3fffffff);
  // };     

  // Note: in the end I will make a class but by the time being I just make an actor with functions and vars
  // function: set training dataset
  // dummy function declaration to train a tree with the right declaration
  // dummy function declaration to make a prediction
  // function: compute, entropy and Gini index for the dataset

  // Develope matrix module inspyred in Array module
  // 1) understand, to/from vec(vec), filterByListofIndexes, filterbyrowsandcols
  // https://forum.dfinity.org/t/how-to-index-a-matrix-to-get-a-subset-of-rows-and-or-columns/23887/4?u=ildefons
  func rows<T>(rs : [Nat], m : [[T]]) : [[T]] {
    Array.tabulate<[T]>(rs.size(), func r { m[rs[r]] });
  };

  func cols<T>(cs : [Nat], m : [[T]]) : [[T]] {
    Array.tabulate<[T]>(m.size(), func r {
      Array.tabulate<T>(cs.size(), func c { m[r][cs[c]] }) });
  };

  func ncols<T>(m : [[T]]) : Nat {
    // TODO: check all rows habve same number of elements
    m[0].size();
  };

  func nrows<T>(m : [[T]]) : Nat {
    m.size();  
  };
//----->IM HERE
  // func init<X>(sizer : Nat, sizec : Nat, initValue : X) : [var X] {
  //   let row = Prim.Array_init<X>(sizec, initValue);

  // };

  func transpose<T>(m : [[T]]) : [[T]] {
    let myncols = ncols(m);
    let trans = Buffer.Buffer<[T]>(myncols); 
    for (i in Iter.range(0, myncols - 1)) {
      let ys = cols([i], m);
      let ys2 = Array.flatten(ys);
      trans.add(ys2);
      //trans := List.push<[dataMember]>(ys2, trans); // <-----IMHERE: List.push<Nat>(0, null) // => ?(0, null);
    };
    Buffer.toArray(trans); 
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
  // func uniquesNat(rs: [Nat]): [Nat] {
  //   let myset = TrieSet.fromArray<Nat>(rs, hashNat, Nat.equal);
  //   let uniques = TrieSet.toArray(myset);
  //   uniques;
  // };
  func uniquesText(rs: [Text]): [Text] {
    let myset = TrieSet.fromArray<Text>(rs, hashText, Text.equal);
    let uniques = TrieSet.toArray(myset);
    return uniques;
  };
  func log2(n: Float): Float {
    Float.log(n)/Float.log(2);
  };
  func entropy(rs: [Text]): Float { 
    let y_uniques = uniquesText(rs);
    var h_total: Float = 0.0;
    for (i in Iter.range(0,y_uniques.size()-1)) {
      let ys_y =  Array.filter<Text>(rs, func x = x == y_uniques[i]);
      let p_y = Float.fromInt(ys_y.size()) / Float.fromInt(rs.size()); 
      let h_y = p_y * log2(p_y);
      h_total := h_total + h_y;
    };

    -h_total;
  };

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
  
  public query func greet(name : Text) : async () {
    let c = Counter(1);
    let matrix : [[Float]] = [[1,2,3],
                            [4,5,6],
                            [7,8,9],[10,20,30],[11,22,33]]; 

    let auxr : [[Float]] = rows([0, 2], matrix);
    let auxc : [[Float]] = cols([0, 2], matrix);
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
    //   //trans := List.push<[dataMember]>(ys2, trans); // <-----IMHERE: List.push<Nat>(0, null) // => ?(0, null);
    // };
    let ret = transpose(actor_data);//Buffer.toArray(trans); 
    //trans := Array(trans);
    // <-----------------HOW TO ADD ELEMENTS TO A VECTOR
    let myncols = ncols(actor_data);
    let ys = cols([myncols-1], actor_data);
    let ys2 = Array.flatten(ys);
    let aux = ys2[0];
    // Debug.print("is a text:" # aux);
    switch (aux) {
       case (#symbol s) { // classification case
          // 1) convert last column to a vector of text: if something is not a symbol, raise 
          let aux = symbolVecToTextVec(ys2);   // 
          switch (aux) {
            case(#err(#notAllYsAreSymbol)){
              // throw errortype BinTree = ?(?Nat, ?dataMember, ?dataMember, BinTree, BinTree); 
              throw Error.reject("Target column is not totally formed by symbols")
            }; 
            case(#ok(result)) {
              Debug.print("is a text:" # result[0]);
              // compute entropy using "result"
              let y_entropy: Float = entropy(result); 
              Debug.print("The entropy of the target column is:" # Float.toText(y_entropy));
              // how to gow a decision tree?

            };
          };
        };
        case (#number s) { // regresssion case
          Debug.print("is a number:" # Float.toText(s));
       };
     };
    // NEXT:----> check is type symbol?
    // https://internetcomputer.org/docs/current/motoko/main/errors#what-error-type-to-prefer
    // let myuniques = uniquesText(textVec);
    // for (element in myuniques.vals()) {
    //   Debug.print("val:" # element);
    // };
    // //return "matrix value: " # Nat.toText(aux) ;

    // leaf value type: null (non-leaf), Float (leaf regression), [Float] (leaf classoifciation)
    type leafValue = {#number: Float;
                      #symbol: [Float]}; 

    // Tree node fields:
    // 1) 
    type BinTree = ?(?Nat, ?dataMember, leafValue, BinTree, BinTree); 
    func nilTree() : BinTree = null;
    func isTreeNil(bintree : BinTree) : Bool {
      switch bintree {
        case null { true };
        case _ { false }
      }
    };

    // var_id: feature column in [0, N-1]
    //         Note: leafs have null
    // th : in numeric features: <=th samples correspond to the left node
    //                           >th samples are right node
    //      in symbolic features: symbol exist in samples of the left sub-tree
    //                            symbol doesn't exist in samples of the right sub-tree     
    //      Note: leafs have null
    //      Note: symbolic features need to be converted into 1HE (function to be done) 
    // value: Used when node is a leaf: if y numeric then this is the average value of y  
    //                                  if y symbolic then this is a vector of y class probabilities
    //        Note: Non-leaf nodes have null   
    //        Note: Node type is a new type
    func setLeftRightBranch(var_id : ?Nat,         // can be null when leaf
                            th : ?dataMember,      // can be null when leaf
                            value : leafValue,
                            leftTree : BinTree, 
                            rightTree : BinTree) : BinTree {
      ?(var_id, th, value, leftTree, rightTree);
    };
    

     
    var data: [[dataMember]] = [[#number(1), #number(2), #symbol("0")],
                                [#number(2), #number(3), #symbol("0")],
                                [#number(1), #number(4), #symbol("1")],
                                [#number(2), #number(5), #symbol("1")]];

    let leftTree: BinTree  = setLeftRightBranch(null, null, #symbol([1,0]), nilTree(), nilTree());
    let rightTree: BinTree = setLeftRightBranch(null, null, #symbol([0,1]), nilTree(), nilTree());
    let topTree: BinTree   = setLeftRightBranch(?1, ?#number(3.5), #symbol([0.5,0.5]), leftTree, rightTree);
        
    //<-----IM HERE!!!!

    func isLeftNode(feature: dataMember, th: dataMember): Bool {
      return true;
    };

    func predictTree(x : [dataMember], bintree : BinTree) : () {
      // 1) check assert the size of x is > 0
      // 2) check bintree is not nil
      // 3) do until bintree in left or right is nil and return "value" (try first iterative , if not possible recursion)
            
      switch bintree {
        case null {Debug.print("Do nothing");};
        case (?(xvar_id,xth,xvalue,bl,br)) {
          switch xvar_id {
            case null {
              // node leaf: return the value
              switch xvalue {
                case (#number(val)) {
                  //TBD
                  Debug.print("Result: " # Float.toText(val));
                };
                case (#symbol(vec)) {
                  //TBD
                  Debug.print("Probability of 1: " # Float.toText(vec[1]));
                };
                // case null {
                //   //TBD
                // };
              };
            };
            case _ {
              // get feature value
              let var_id : Nat = switch xvar_id {
                case null 0;
                case (?Nat) Nat;
              };
              let feature: dataMember = x[var_id]; // <------------------------IMHERE!!!
              let th : dataMember = switch xth {
                  case (?dataMember) dataMember;
                  case _ #symbol("FAKENULL");
              };
              // if isLeftNode(feature: dataMember, th: dataMember) {
              //   //predict left
              // }
              // else {
              //    //predict right 
              // };
            }; 
          };
          // };
          // // get sample feature
          // let sample_feature = x[xvar_id]; 
          // if (x==xvar_id) {
          //   Debug.print("We found the node with the same var_id:" # Nat.toText(xvar_id));
          // };
          // predictTree(x, bl);
          // predictTree(x, br);
        };
      };
    };

    let sample: [dataMember] = [#number(1), #number(2), #symbol("0")];   
    predictTree(sample, topTree);
  
  
  };
};
