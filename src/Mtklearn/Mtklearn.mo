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
import Result "mo:base/Result";
import Hash "mo:base/Hash";
import Debug "mo:base/Debug";
import Fuzz "mo:fuzz";

module {
           
    public type MotokoLearnError = {
      #notAllYsAreSymbol;
      #sizeMissmatchXY;
      #notAllYsymbols;
      #notExactly2UniqueXSymbols;
      #notAllNumbers;
      #noBestGiniError;
    };

    public type dataMember = {
        #number : Float;
        #symbol : Text; 
    };

    public func symbolVecToTextVec(ys: [dataMember]):  Result.Result<[Text], MotokoLearnError> {
      let aux = ys[0];
      let textBuf = Buffer.Buffer<Text>(ys.size());
      
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
      Debug.print("m rows:"#Nat.toText(m.size()));
      m[0].size();
    };

    public func nrows<T>(m : [[T]]) : Nat {
      m.size();  
    };

    public func transpose<T>(m : [[T]]) : [[T]] {
      let myncols = ncols(m);Debug.print("T1");
      let trans = Buffer.Buffer<[T]>(myncols); Debug.print("T12");
      for (i in Iter.range(0, myncols - 1)) {Debug.print("T131");
        let ys = cols([i], m);Debug.print("T132");
        let ys2 = Array.flatten(ys);Debug.print("T133");
        trans.add(ys2);Debug.print("T134");
      }; Debug.print("T14");
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

    public func randomSample(min_: Nat, max_: Nat, nsamples_: Nat, withRepetition_: Bool, seed: Nat): [Nat] {
      let bufaux = Buffer.Buffer<Nat>(nsamples_);
      let fuzz = Fuzz.fromSeed(seed);
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

    public type leafValue = {#number: Float;
                             #symbol: [Float]}; 
    public type BinTree = ?(?Nat, ?Float, leafValue, BinTree, BinTree); 
    public func nilTree() : BinTree = null;
    public func isTreeNil(bintree : BinTree) : Bool {
      switch bintree {
        case null { true };
        case _ { false }
      }
    };

    public func setLeftRightBranch(var_id : ?Nat,         // can be null when leaf
                            th : ?Float,           // can be null when leaf
                            value : leafValue,
                            leftTree : BinTree, 
                            rightTree : BinTree) : BinTree {
      ?(var_id, th, value, leftTree, rightTree);
    };

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

    public func gini(y: [Text], y_uniques: [Text]): (Float) {
      var g_total: Float = 0.0;
      for (i in Iter.range(0,y_uniques.size()-1)) {
        let ys_y =  Array.filter<Text>(y, func x = x == y_uniques[i]);
        let p_y = Float.fromInt(ys_y.size()) / Float.fromInt(y.size()); 
        let g_y = p_y * (1 - p_y);
        g_total := g_total + g_y;
      };
      return g_total;
    };

    public func mse(y: [Float]): (Float) {
      let mymean: Float = mean(y);
      var g_total: Float = 0.0;
      for (i in Iter.range(0,y.size()-1)) {
        let aux: Float =  (y[i]-mymean)**2;
        g_total := g_total + aux;
      };
      return g_total;
    };
  
    public func rmse(yhat: Float, y: Float): (Float) {
      let ret: Float =  Float.sqrt((yhat-y)**2);
      return ret;
    };

    public let NUM_CHECKS_GINI : Nat = 10;
    public let MAX_FEATURE_VALIDATIONS : Nat = 20;
    public let X_UNIQUES : [Text] = ["0","1"];

    func computeFeatureGini(xcol: [dataMember],y:[Text],y_uniques:[Text]): Result.Result<(Float,Float), MotokoLearnError> {
      // check whether this a nueric or a symbolic feature
      let aux: dataMember = xcol[0];
      switch(aux) {
        case (#number(num)) {
          let xs = dataMemberVectorToFloatVector(xcol);
          switch (xs) {
            case (#ok(xs_num)) {
              let xs_min = min(xs_num);
              let xs_max = max(xs_num);
              let th_vec: [Float] = linspace(xs_min,xs_max,NUM_CHECKS_GINI);// NUM_CHECKS_GINI : Nat = 10; it should be a private constant of the future module
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
              let bestgini = min(Buffer.toArray(ginis));
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
              let ginis = Buffer.Buffer<Float>(2);
              let weigths = Buffer.Buffer<Float>(2);
              for (i in Iter.range(0, 2 - 1)) {
                let ret_xi = Array.mapEntries<Text, Bool>(xs_text, func (xx, ii) = Text.equal(xx,X_UNIQUES[i]));
                let ret_xi_size: Nat = Array.filter<Bool>(ret_xi, func xx = xx == true).size();
                let ret_yi = Buffer.Buffer<Text>(ret_xi_size);
                if (ret_xi_size > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    if (ret_xi[j]) {
                      ret_yi.add(y[j]);
                    }
                  };
                  let gini_aux: Float = gini(Buffer.toArray(ret_yi), y_uniques);
                  ginis.add(gini_aux);
                  weigths.add(Float.fromInt(Buffer.toArray(ret_yi).size())/Float.fromInt(y.size()));
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
    
    func computeFeatureMSE(xcol: [dataMember],y:[Float]): Result.Result<(Float,Float), MotokoLearnError> {
      // check whether this a nueric or a symbolic feature
      let aux: dataMember = xcol[0];
      switch(aux) {
        case (#number(num)) {
          let xs = dataMemberVectorToFloatVector(xcol);
          switch (xs) {
            case (#ok(xs_num)) {
              let xs_min = min(xs_num);
              let xs_max = max(xs_num);
              let th_vec: [Float] = linspace(xs_min,xs_max,NUM_CHECKS_GINI); // NUM_CHECKS_GINI : Nat = 10; it should be a private constant of the future module
              let ginis = Buffer.Buffer<Float>(th_vec.size());
              for (i in Iter.range(0, th_vec.size() - 1)) {
                let th = th_vec[i];
                let ret_xi = Array.mapEntries<Float, Bool>(xs_num, func (xx, ii) = (xx <= th));
                let ret_xi_size: Nat = Array.filter<Bool>(ret_xi, func xx = xx == true).size();
                let ret_yi_l = Buffer.Buffer<Float>(ret_xi_size);
                let ret_yi_r = Buffer.Buffer<Float>(ret_xi.size()-ret_xi_size);
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
                  gini_l := mse(Buffer.toArray(ret_yi_l));
                  weight_l := Float.fromInt(Buffer.toArray(ret_yi_l).size())/Float.fromInt(y.size());
                };
                if ( (ret_xi.size()-ret_xi_size) > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    if (ret_xi[j]==false) {
                      ret_yi_r.add(y[j]);
                    }
                  };
                  gini_r := mse(Buffer.toArray(ret_yi_r));
                  weight_r := Float.fromInt(Buffer.toArray(ret_yi_r).size())/Float.fromInt(y.size());
                };
                ginis.add(weight_l*gini_l+weight_r*gini_r);
              }; 
              let bestgini = min(Buffer.toArray(ginis));
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
              let ginis = Buffer.Buffer<Float>(2);
              let weigths = Buffer.Buffer<Float>(2);
              for (i in Iter.range(0, 2 - 1)) {
                let ret_xi = Array.mapEntries<Text, Bool>(xs_text, func (xx, ii) = Text.equal(xx,X_UNIQUES[i]));
                let ret_xi_size: Nat = Array.filter<Bool>(ret_xi, func xx = xx == true).size();
                let ret_yi = Buffer.Buffer<Float>(ret_xi_size);
                if (ret_xi_size > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    if (ret_xi[j]) {
                      ret_yi.add(y[j]);
                    }
                  };
                  
                  let gini_aux: Float = mse(Buffer.toArray(ret_yi));
                  ginis.add(gini_aux);
                  weigths.add(Float.fromInt(Buffer.toArray(ret_yi).size())/Float.fromInt(y.size()));
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

    public func computeThLeftRightNumeric(x: [dataMember], bestth: Float): ([Nat], [Nat]) {
      let xs = dataMemberVectorToFloatVector(x);
      switch (xs) {
        case (#ok(xs_num)) {
          let ret_xi: [Bool]= Array.mapEntries<Float, Bool>(xs_num, func (xx, ii) = (xx <= bestth));
          let sumtrues = sumTrues(ret_xi);
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

    public func computeLeftRightSymbolic(x: [dataMember]): ([Nat], [Nat]) {
      let xs = dataMemberVectorToTextVector(x);
      switch (xs) {
        case (#ok(xs_sym)) {
          let ret_xi: [Bool] = Array.mapEntries<Text, Bool>(xs_sym, func (xx, ii) = Text.equal(xx,X_UNIQUES[0]));
          let sumtrues = sumTrues(ret_xi);
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

    public func dataMemberVectorToTextVector(y: [dataMember]): Result.Result<[Text], MotokoLearnError> {
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

    public func dataMemberVectorToFloatVector(y: [dataMember]): Result.Result<[Float], MotokoLearnError> {
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

    public func fitClassification(x : [[dataMember]], 
                           y : [Text], 
                           current_depth : Nat, 
                           y_uniques: [Text], 
                           max_depth: Nat, 
                           min_node_data_size: Nat,
                           col_ids: [Nat],
                           seed: Nat): Result.Result<BinTree, MotokoLearnError> {
      // check size of x is at least the minimum size and we are not at the deepest level allowed
      let probs = Buffer.Buffer<Float>(y_uniques.size());Debug.print("1");
      for (i in Iter.range(0, y_uniques.size() - 1)) { Debug.print("2");
          let num_ys: Nat = Array.filter<Text>(y, func x = x == y_uniques[i]).size();
          let prob = Float.fromInt(num_ys) / Float.fromInt(y.size());
          probs.add(prob);
        };
     
      let node_entropy = entropy(y, y_uniques);Debug.print("13");
      
      if (x.size() <= min_node_data_size or current_depth >= max_depth or node_entropy==0) {
        let leafNode: BinTree  = setLeftRightBranch(null, null, #symbol(Buffer.toArray(probs)), nilTree(), nilTree());Debug.print("15");
        return #ok(leafNode);
      };
      let x_ncols = transpose(x).size();Debug.print("14");
      if (x_ncols == 1) {
        let leafNode: BinTree  = setLeftRightBranch(null, null, #symbol(Buffer.toArray(probs)), nilTree(), nilTree());Debug.print("15b");
        return #ok(leafNode);
      };

      // create node  
      // for all features
      let xt = transpose(x);
      let ginis = Buffer.Buffer<Float>(xt.size());
      let ths = Buffer.Buffer<Float>(xt.size());Debug.print("16");
      
      let num_features = Nat.min(MAX_FEATURE_VALIDATIONS, xt.size());
      let pos_vector: [Nat] = randomSample(0, xt.size()-1, num_features, false, seed);Debug.print("17");

      for (i in Iter.fromArray(pos_vector)) {
        let xcol = xt[i];Debug.print("18");
        let gini = computeFeatureGini(xcol,y,y_uniques);
        switch (gini) {
          case (#ok(gini_float, th_float)) {
            ginis.add(gini_float);
            ths.add(th_float);
          };
          case (#err(err)) {
            return #err(err);
          };
        }; 
      };

      // compute gini index of the
      let ginis_array = Buffer.toArray(ginis);
      let ths_array: [Float] = Buffer.toArray(ths);
      let bestgini = min(ginis_array);
      let bestcol: ?Nat = Array.indexOf<Float>(bestgini, ginis_array, Float.equal);
      if (bestcol==null) {
        return #err(#noBestGiniError);
      };
      let xbestcol : Nat = switch bestcol {
        case null 0;
        case (?Nat) Nat;
      };
      let bestth = ths_array[xbestcol];
      
      // recursive call left and right and connect to node and return 
      let myx = transpose(cols<dataMember>([pos_vector[xbestcol]], x))[0]; Debug.print("19");// redirection because real feature index is inside pos_vector

      let (left_rows,right_rows) = switch (myx[0]) {
        case (#number(num)) computeThLeftRightNumeric(myx, bestth);
        case (#symbol(sym)) computeLeftRightSymbolic(myx);
      };
      let x2 = removeRows([pos_vector[xbestcol]], x);
      
      // pick the true col_id from col_ids
      let true_colid: Nat = col_ids[pos_vector[xbestcol]];Debug.print("10");
 
      let next_col_ids: [Nat] = removeRowsVector([pos_vector[xbestcol]], col_ids);Debug.print("111");
 
      let next_x: [[dataMember]] = transpose(removeRows([pos_vector[xbestcol]], transpose(x))); Debug.print("112");

      let x_left = rows(left_rows,next_x);
      let y_left = rowsVector(left_rows,y);
      let x_right = rows(right_rows,next_x);
      let y_right = rowsVector(right_rows,y);

      let leftNode_aux  = fitClassification(x_left, y_left, current_depth + 1, y_uniques, max_depth, min_node_data_size, next_col_ids,seed+1);Debug.print("113");
      let rightNode_aux  = fitClassification(x_right, y_right, current_depth + 1, y_uniques, max_depth, min_node_data_size, next_col_ids,seed+2);Debug.print("114");
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

    public func fitClassification_OLD(x : [[dataMember]], 
                           y : [Text], 
                           current_depth : Nat, 
                           y_uniques: [Text], 
                           max_depth: Nat, 
                           min_node_data_size: Nat,
                           col_ids: [Nat]): Result.Result<BinTree, MotokoLearnError> {
      // check size of x is at least the minimum size and we are not at the deepest level allowed
      let probs = Buffer.Buffer<Float>(y_uniques.size());
      for (i in Iter.range(0, y_uniques.size() - 1)) { 
          let num_ys: Nat = Array.filter<Text>(y, func x = x == y_uniques[i]).size();
          let prob = Float.fromInt(num_ys) / Float.fromInt(y.size());
          probs.add(prob);
        };Debug.print("f11");
     
      let node_entropy = entropy(y, y_uniques);Debug.print("f12");
      let x_ncols = transpose(x).size(); Debug.print("f13");  // if we only have 1 feature, we finish branch 
     
      if (x.size() <= min_node_data_size or current_depth >= max_depth or node_entropy==0 or x_ncols == 1) {
        let leafNode: BinTree  = setLeftRightBranch(null, null, #symbol(Buffer.toArray(probs)), nilTree(), nilTree());
        return #ok(leafNode);
      };Debug.print("f14");
      // create node  
      // for all features
      let xt = transpose(x);Debug.print("f141");
      let ginis = Buffer.Buffer<Float>(xt.size());Debug.print("f142");
      let ths = Buffer.Buffer<Float>(xt.size());Debug.print("f143");
      for (i in Iter.range(0, xt.size() - 1)) {
        let xcol = xt[i];Debug.print("f144"#Nat.toText(i));
        let gini = computeFeatureGini(xcol,y,y_uniques);Debug.print("f144"#Nat.toText(i)#"b");
        switch (gini) {
          case (#ok(gini_float, th_float)) {
            ginis.add(gini_float);
            ths.add(th_float);
          };
          case (#err(err)) {
            return #err(err);
          };
        }; 
      }; Debug.print("f15");
      // compute gini index of the
      let ginis_array = Buffer.toArray(ginis);
      let ths_array: [Float] = Buffer.toArray(ths);
      let bestgini = min(ginis_array);
      let bestcol: ?Nat = Array.indexOf<Float>(bestgini, ginis_array, Float.equal);
      if (bestcol==null) {
        return #err(#noBestGiniError);
      };Debug.print("f16");
      let xbestcol : Nat = switch bestcol {
        case null 0;
        case (?Nat) Nat;
      };Debug.print("f17");
      let bestth = ths_array[xbestcol];
      
      // recursive call left and right and connect to node and return 
      let myx = transpose(cols<dataMember>([xbestcol], x))[0];

      let (left_rows,right_rows) = switch (myx[0]) {
        case (#number(num)) computeThLeftRightNumeric(myx, bestth);
        case (#symbol(sym)) computeLeftRightSymbolic(myx);
      };
      Debug.print("f1");
      let x2 = removeRows([xbestcol], x);
      
      // pick the true col_id from col_ids
      let true_colid: Nat = col_ids[xbestcol];
      
      // remove "true_colid" from col_ids before passing recursively
      let next_col_ids: [Nat] = removeRowsVector([xbestcol], col_ids);
 
      let next_x: [[dataMember]] = transpose(removeRows([xbestcol], transpose(x))); 

      let x_left = rows(left_rows,next_x);
      let y_left = rowsVector(left_rows,y);
      let x_right = rows(right_rows,next_x);
      let y_right = rowsVector(right_rows,y);

      let leftNode_aux  = fitClassification_OLD(x_left, y_left, current_depth + 1, y_uniques, max_depth, min_node_data_size, next_col_ids);Debug.print("f18");
      let rightNode_aux  = fitClassification_OLD(x_right, y_right, current_depth + 1, y_uniques, max_depth, min_node_data_size, next_col_ids);Debug.print("f19");
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

    public func fitRegression(x : [[dataMember]], 
                           y : [Float], 
                           current_depth : Nat,  
                           max_depth: Nat, 
                           min_node_data_size: Nat,
                           col_ids: [Nat],
                           seed: Nat): Result.Result<BinTree, MotokoLearnError> {

      // For regression predictive modeling problems the cost function that is minimized to choose split points is the sum squared error 
      //     across all training samples that fall within the rectangle: sum(y – prediction)^2
     
      let y_mean: Float = mean(y); 

      let x_ncols = transpose(x).size();
      if (x.size() <= min_node_data_size or current_depth >= max_depth or x_ncols == 1) {
         let leafNode: BinTree  = setLeftRightBranch(null, null, #number(y_mean), nilTree(), nilTree());
         return #ok(leafNode);
      }; 
      // create node  
      // for all features

      let xt = transpose(x);
      let mses = Buffer.Buffer<Float>(xt.size());
      let ths = Buffer.Buffer<Float>(xt.size());
      //<---------IMHERE  
      let num_features = Nat.min(MAX_FEATURE_VALIDATIONS, xt.size());
      let pos_vector: [Nat] = randomSample(0, xt.size()-1, num_features, false, seed);

      for (i in Iter.fromArray(pos_vector)) {
        let xcol = xt[i];
        let mse = computeFeatureMSE(xcol,y); 
        switch (mse) {
          case (#ok(gini_float, th_float)) {
            mses.add(gini_float);
            ths.add(th_float);
          };
          case (#err(err)) {
            return #err(err);
          };
        }; 
      }; 
      // // compute gini index of the
      let mses_array = Buffer.toArray(mses);
      let ths_array: [Float] = Buffer.toArray(ths);
      let bestgini = min(mses_array);
      let bestcol: ?Nat = Array.indexOf<Float>(bestgini, mses_array, Float.equal);
      if (bestcol==null) {
         return #err(#noBestGiniError);
      };
      let xbestcol : Nat = switch bestcol {
         case null 0;
         case (?Nat) Nat;
      };
      let bestth = ths_array[xbestcol];
      
      // recursive call left and right and connect to node and return 
      let myx = transpose(cols<dataMember>([pos_vector[xbestcol]], x))[0];
      //let myx = transpose(cols<dataMember>([xbestcol], x))[0];
      
      let (left_rows,right_rows) = switch (myx[0]) {
         case (#number(num)) computeThLeftRightNumeric(myx, bestth);
         case (#symbol(sym)) computeLeftRightSymbolic(myx);
      };

      //let x2 = removeRows([xbestcol], x); 
      let x2 = removeRows([pos_vector[xbestcol]], x); 

      // pick the true col_id from col_ids
      //let true_colid: Nat = col_ids[xbestcol];
      let true_colid: Nat = col_ids[pos_vector[xbestcol]];

      // remove "true_colid" from col_ids before passing recursively
      let next_col_ids: [Nat] = removeRowsVector([pos_vector[xbestcol]], col_ids);
  
      let next_x: [[dataMember]] = transpose(removeRows([pos_vector[xbestcol]], transpose(x)));

      let x_left = rows(left_rows,next_x);
      let y_left = rowsVector(left_rows,y);
      let x_right = rows(right_rows,next_x);
      let y_right = rowsVector(right_rows,y);

      let lsize_zero:Bool = Nat.equal(x_left.size(),0);
      let leftNode_aux  = switch (lsize_zero) {
        case (true) #ok(nilTree());
        case (false) fitRegression(x_left, y_left, current_depth + 1, max_depth, min_node_data_size, next_col_ids, seed+1);
      };
      let rsize_zero:Bool = Nat.equal(x_right.size(),0);
      let rightNode_aux  = switch (rsize_zero) {
        case (true) #ok(nilTree());
        case _ fitRegression(x_right, y_right, current_depth + 1, max_depth, min_node_data_size, next_col_ids, seed+2);
      };
      
      let leftNode = switch leftNode_aux {
         case (#ok(leftNode)) leftNode;
         case (#err(err)) return leftNode_aux;
      };
      let rightNode = switch rightNode_aux {
         case (#ok(rightNode)) rightNode;
         case (#err(err)) return rightNode_aux;
      };

      let thisNode: BinTree = setLeftRightBranch(?true_colid, ?bestth, #number(y_mean), leftNode, rightNode);
      return #ok(thisNode);
    };   

    public func fitRegressionOLD(x : [[dataMember]], 
                           y : [Float], 
                           current_depth : Nat,  
                           max_depth: Nat, 
                           min_node_data_size: Nat,
                           col_ids: [Nat]): Result.Result<BinTree, MotokoLearnError> {

      // For regression predictive modeling problems the cost function that is minimized to choose split points is the sum squared error 
      //     across all training samples that fall within the rectangle: sum(y – prediction)^2
     
      let y_mean: Float = mean(y); 

      let x_ncols = transpose(x).size();
      if (x.size() <= min_node_data_size or current_depth >= max_depth or x_ncols == 1) {
         let leafNode: BinTree  = setLeftRightBranch(null, null, #number(y_mean), nilTree(), nilTree());
         return #ok(leafNode);
      }; 
      // create node  
      // for all features
      let xt = transpose(x);
      let mses = Buffer.Buffer<Float>(xt.size());
      let ths = Buffer.Buffer<Float>(xt.size());
      for (i in Iter.range(0, xt.size() - 1)) {
        let xcol = xt[i];
        let mse = computeFeatureMSE(xcol,y); 
        switch (mse) {
          case (#ok(gini_float, th_float)) {
            mses.add(gini_float);
            ths.add(th_float);
          };
          case (#err(err)) {
            return #err(err);
          };
        }; 
      }; 
      // // compute gini index of the
      let mses_array = Buffer.toArray(mses);
      let ths_array: [Float] = Buffer.toArray(ths);
      let bestgini = min(mses_array);
      let bestcol: ?Nat = Array.indexOf<Float>(bestgini, mses_array, Float.equal);
      if (bestcol==null) {
         return #err(#noBestGiniError);
      };
      let xbestcol : Nat = switch bestcol {
         case null 0;
         case (?Nat) Nat;
      };
      let bestth = ths_array[xbestcol];
      
      // recursive call left and right and connect to node and return 
      let myx = transpose(cols<dataMember>([xbestcol], x))[0];
      
      let (left_rows,right_rows) = switch (myx[0]) {
         case (#number(num)) computeThLeftRightNumeric(myx, bestth);
         case (#symbol(sym)) computeLeftRightSymbolic(myx);
      };

      let x2 = removeRows([xbestcol], x);      
      // pick the true col_id from col_ids
      let true_colid: Nat = col_ids[xbestcol];
      // remove "true_colid" from col_ids before passing recursively
      let next_col_ids: [Nat] = removeRowsVector([xbestcol], col_ids);
  
      let next_x: [[dataMember]] = transpose(removeRows([xbestcol], transpose(x)));

      let x_left = rows(left_rows,next_x);
      let y_left = rowsVector(left_rows,y);
      let x_right = rows(right_rows,next_x);
      let y_right = rowsVector(right_rows,y);

      let lsize_zero:Bool = Nat.equal(x_left.size(),0);
      let leftNode_aux  = switch (lsize_zero) {
        case (true) #ok(nilTree());
        case (false) fitRegressionOLD(x_left, y_left, current_depth + 1, max_depth, min_node_data_size, next_col_ids);
      };
      let rsize_zero:Bool = Nat.equal(x_right.size(),0);
      let rightNode_aux  = switch (rsize_zero) {
        case (true) #ok(nilTree());
        case _ fitRegressionOLD(x_right, y_right, current_depth + 1, max_depth, min_node_data_size, next_col_ids);
      };
      
      let leftNode = switch leftNode_aux {
         case (#ok(leftNode)) leftNode;
         case (#err(err)) return leftNode_aux;
      };
      let rightNode = switch rightNode_aux {
         case (#ok(rightNode)) rightNode;
         case (#err(err)) return rightNode_aux;
      };

      let thisNode: BinTree = setLeftRightBranch(?true_colid, ?bestth, #number(y_mean), leftNode, rightNode);
      return #ok(thisNode);
    };   

    // 
    // Inference code
    //

    public func isLeftNode(feature_: dataMember, th_: Float): (Bool) { 
      switch feature_ {
        case (#number(num)) {
          if (num <= th_) {
            return true;
          }
          else {
            return false;
          };
        };
        case (#symbol(txt)) {
          if (Text.equal(txt, "0")) {
            return true;
          }
          else {
            return false;
          }
        };
      };
    };

    public func predictTreeClassification(x : [dataMember], bintree : BinTree) : ([Float]) {       
      switch bintree {
        case null {
          Debug.print("UNEXPECTED: we should not get here");
          return [0,0,0];
        };
        case (?(xvar_id,xth,xvalue,bl,br)) {
          let isNL = isTreeNil(bl);
          let isNR = isTreeNil(br);
          switch (isNL, isNR) {
            case (true, true) {
              switch xvalue {
                case (#symbol(vec)) {
                  return vec;
                };
                case (#number(num)) {
                  return [num];
                };
              };
            };
            case (true, false) {
              let vec = predictTreeClassification(x, br);
              return vec;
            };
            case (false, true) {
              let vec = predictTreeClassification(x, bl);
              return vec;
            };
            case (false, false) {
              let var_id : Nat = switch xvar_id {
                case null 0;
                case (?Nat) Nat;
              };
              let feature: dataMember = x[var_id]; 
              let th : Float = switch xth {
                  case null 0;
                  case (?Float) Float;
              };
              if (isLeftNode(feature, th)) {
                 let vec = predictTreeClassification(x, bl);
                 return vec;
               }
              else {
                 let vec = predictTreeClassification(x, br);
                 return vec;
              };
            }; 
          };
        };
      };
    };

    public func predictTreeRegression(x : [dataMember], bintree : BinTree) : ([Float]) {        
      switch bintree {
        case null {
          Debug.print("UNEXPECTED: we should never get here");
          return [0,0,0];
        };
        case (?(xvar_id,xth,xvalue,bl,br)) {
          let isNL = isTreeNil(bl);
          let isNR = isTreeNil(br);
          switch (isNL,isNR) {
            case (true, true) {
              switch xvalue {
                case (#symbol(vec)) {
                   return vec;
                };
                case (#number(num)) {
                  return [num];
                };
              };
            };
            case (true, false) {
              predictTreeRegression(x, br);
            };
            case (false, true) {
              predictTreeRegression(x, bl);
            };
            case (false, false) {
              let var_id : Nat = switch xvar_id {
                case null 0;
                case (?Nat) Nat;
              };
              let feature: dataMember = x[var_id]; 
              let th : Float = switch xth {
                  case null 0;
                  case (?Float) Float;
              };
              if (isLeftNode(feature, th)) {
                 predictTreeRegression(x, bl);
               }
              else {
                 predictTreeRegression(x, br);
              };
            }; 
          }; 
        };
      };
    };

    public func fitClassificationAsync(x : [[dataMember]], 
                                        y : [Text], 
                                        current_depth : Nat, 
                                        y_uniques: [Text], 
                                        max_depth: Nat, 
                                        min_node_data_size: Nat,
                                        col_ids: [Nat],
                                        seed: Nat): async (Result.Result<BinTree, MotokoLearnError>) {

      let fitclas_return = fitClassification(x,
                                             y,
                                             current_depth,
                                             y_uniques,
                                             max_depth,
                                             min_node_data_size,
                                             col_ids,
                                             seed); 
      return fitclas_return;//#ok(nilTree());
    };

    public func fitRandomForestClassifier(x : [[dataMember]], 
                                          y : [Text],
                                          y_uniques: [Text], 
                                          ntrees : Nat, 
                                          current_depth : Nat,  
                                          max_depth: Nat, 
                                          min_node_data_size: Nat,
                                          col_ids: [Nat],
                                          seed: Nat): async (Result.Result<[BinTree], MotokoLearnError>) {  

      // iterate ntree times and return a vector of classifier trees
      let ret = Buffer.Buffer<BinTree>(ntrees);
      for (i in Iter.range(0, ntrees-1)) {
        let fitclas_return = await fitClassificationAsync(x,
                                                          y,
                                                          current_depth,
                                                          y_uniques,
                                                          max_depth,
                                                          min_node_data_size,
                                                          col_ids,
                                                          seed+i); 
        switch(fitclas_return) {
          case (#ok(mytree)) {
            Debug.print("adding tree");
            ret.add(mytree);
            Debug.print("Tree added");
          };
          case (#err(err)) {
            Debug.print("There is an error");
            return #err(err);
          };
        };
      }; 

      return #ok(Buffer.toArray(ret));
    };

    // public func f2() : async ([Nat]) {  
    //   let ret = Buffer.Buffer<Nat>(10);
    //   for (i in Iter.range(0, 10)) { 
    //     let f1_async_nat: async Nat = f1(i);
    //     let f1_nat : Nat = await f1_async_nat;
    //     ret.add(f1_nat);
    //   };
    //   return Buffer.toArray(ret);
    // };
};