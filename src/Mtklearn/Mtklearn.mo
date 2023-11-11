import Text "mo:base/Text";
import Char "mo:base/Char";
import Nat8 "mo:base/Nat8";
import Float "mo:base/Float";
import Nat32 "mo:base/Nat32";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Buffer "mo:base/Buffer";
import TrieSet "mo:base/TrieSet";

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

    public func rows<T>(rs : [Nat], m : [[T]]) : [[T]] {
      Array.tabulate<[T]>(rs.size(), func r { m[rs[r]] });
    };
    
    public func rowsVector<T>(rs : [Nat], v : [T]) : [T] {
      Array.tabulate<T>(rs.size(), func r { v[rs[r]] });
    };

    public func removeRows<T>(rs : [Nat], m : [[T]]) : [[T]] {
      let rs2 = Buffer.Buffer<Nat>(m.size()); 
      for (i in Iter.range(0, m.size() - 1)) {
        let myindex = Array.indexOf<Nat>(i, rs, Nat.equal);
        switch(myindex) {
          case null rs2.add(i);
          case (_) {};
        };
      };
   
      let m2 = rows(Buffer.toArray(rs2), m);
      return m2;
    };

    public func removeRowsVector<T>(rs : [Nat], v : [T]) : [T] {
      let rs2 = Buffer.Buffer<Nat>(v.size()); 
      for (i in Iter.range(0, v.size() - 1)) {

        let myindex = Array.indexOf<Nat>(i, rs, Nat.equal);
        switch(myindex) {
          case null rs2.add(i);
          case (_) {};
        };
      };
      let v2 = rowsVector(Buffer.toArray(rs2), v);
      return v2;
    };

    public func cols<T>(cs : [Nat], m : [[T]]) : [[T]] {
      let ret = Array.tabulate<[T]>(m.size(), func r {
        Array.tabulate<T>(cs.size(), func c { m[r][cs[c]] }) });
      return ret;
    };

    public func ncols<T>(m : [[T]]) : Nat {
      // TODO: check all rows habve same number of elements
      m[0].size();
    };

    public func nrows<T>(m : [[T]]) : Nat {
      m.size();  
    };

    public func transpose<T>(m : [[T]]) : [[T]] {
      let myncols = ncols(m);
      let trans = Buffer.Buffer<[T]>(myncols); 
      for (i in Iter.range(0, myncols - 1)) {
        let ys = cols([i], m);
        let ys2 = Array.flatten(ys);
        trans.add(ys2);
      };
      Buffer.toArray(trans); 
    };
  
    public func linspace(xs_min: Float, xs_max: Float, num: Nat): [Float] {
      let ret = Buffer.Buffer<Float>(num);
      let A: Float = (xs_max-xs_min)/Float.fromInt(num);
      for (i in Iter.range(0, num - 1)) {
        ret.add(xs_min + Float.fromInt(i)*A)
      }; 
      Buffer.toArray(ret);
    };
    
    public func min(rs: [Float]) : Float {
      let aux = Array.sort(rs, Float.compare);
      aux[0];
    };

    public func minNat(rs: [Nat]) : Nat {
      let aux = Array.sort(rs, Nat.compare);
      aux[0];
    };

    public func max(rs: [Float]) : Float {
      let aux = Array.sort(rs, Float.compare);
      aux[rs.size()-1];
    };

    public func maxNat(rs: [Nat]) : Nat {
      let aux = Array.sort(rs, Nat.compare);
      aux[rs.size()-1];
    };

    public func sumTrues(rs: [Bool]) : Nat {
      let sum = Array.foldLeft<Bool, Nat>(rs, 0, func(sumSoFar, x) = switch x {case true sumSoFar + 1; case false sumSoFar + 0});
      sum;
    };

    public func sumFalses(rs: [Bool]) : Nat {
      let sum = Array.foldLeft<Bool, Nat>(rs, 0, func(sumSoFar, x) = switch x {case true sumSoFar + 0; case false sumSoFar + 1});
      sum;
    };

    public func mean(rs: [Float]) : Float {
      let sum = Array.foldLeft<Float, Float>(rs, 0, func(sumSoFar, x) = sumSoFar + x);
      let ret : Float = sum/Float.fromInt(rs.size());
      ret;
    };

    public func median(rs: [Float]) : Float {
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

    public func uniquesText(rs: [Text]): [Text] {
      let myset = TrieSet.fromArray<Text>(rs, Text.hash, Text.equal);
      let uniques = TrieSet.toArray(myset);
      return uniques;
    };

    public func log2(n: Float): Float {
      Float.log(n)/Float.log(2);
    };

    public func entropy(rs: [Text], y_uniques: [Text]): Float { 
      //let y_uniques = uniquesText(rs);
      var h_total: Float = 0.0;
      for (i in Iter.range(0,y_uniques.size()-1)) {
        let ys_y =  Array.filter<Text>(rs, func x = x == y_uniques[i]);
        let p_y = Float.fromInt(ys_y.size()) / Float.fromInt(rs.size()); 
        let h_y = p_y * log2(p_y);
        h_total := h_total + h_y;
      };
      -h_total;
    };

};