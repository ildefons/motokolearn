import Nat "mo:base/Nat";
import Float "mo:base/Float";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";

import mtkl "../Mtklearn/Mtklearn";


actor {

  var actor_data: [[mtkl.dataMember]] = [[#number(1), #number(3), #symbol("1")],
                                    [#number(2), #number(2), #symbol("2")],
                                    [#number(3), #number(3), #symbol("3")],
                                    [#number(4), #number(2), #symbol("4")]];
  
  public func setTrainingData(data: [[mtkl.dataMember]]) : async () {
    actor_data := data;
    // identify classification vs regression aaf of last column type
    // 
  };
  
  public query func doClassification(name : Text) : async () {

 
    // let LeftLeftTree: mtkl.BinTree  = mtkl.setLeftRightBranch(null, null, #symbol([1,0]), mtkl.nilTree(), mtkl.nilTree());
    // let LeftRightTree: mtkl.BinTree = mtkl.setLeftRightBranch(null, null, #symbol([0,1]), mtkl.nilTree(), mtkl.nilTree());
    // let LeftTopTree: mtkl.BinTree   = mtkl.setLeftRightBranch(?1, ?(3.5), #symbol([0.5,0.5]), LeftLeftTree, LeftRightTree);
    // let RightLeftTree: mtkl.BinTree  = mtkl.setLeftRightBranch(null, null, #symbol([0,1]), mtkl.nilTree(), mtkl.nilTree());
    // let RightRightTree: mtkl.BinTree = mtkl.setLeftRightBranch(null, null, #symbol([1,0]), mtkl.nilTree(), mtkl.nilTree());
    // let RightTopTree: mtkl.BinTree   = mtkl.setLeftRightBranch(?1, ?(3.5), #symbol([0.5,0.5]), RightLeftTree, RightRightTree);
    // let TopTree: mtkl.BinTree   = mtkl.setLeftRightBranch(?0, ?(2.5), #symbol([0.5,0.5]), LeftTopTree, RightTopTree);  

    let seed = 123456789;
    let nsamples: Nat = 100;Debug.print("10");
    let alldata = mtkl.wine_data;Debug.print("11");
    let pos_vec = mtkl.randomSample(0, alldata.size()-1, nsamples, false, seed);Debug.print("1");

    let train = mtkl.rows(pos_vec, alldata); Debug.print("11");
    let test = mtkl.removeRows(pos_vec, alldata); Debug.print("11");
    let xcols = Iter.toArray(Iter.range(0, mtkl.transpose(train).size()-2));
    let ycol = mtkl.transpose(train).size()-1;
    let xtrain = mtkl.cols(xcols, train);Debug.print("12"#":"#Nat.toText(mtkl.transpose(train).size()));
    let yaux = mtkl.transpose(mtkl.cols([ycol], train))[0];Debug.print("13");
    let ytrain = mtkl.dataMemberVectorToTextVector(yaux);Debug.print("14");
    let xtest = mtkl.cols(xcols, test);Debug.print("141");
    let yauxtest = mtkl.transpose(mtkl.cols([ycol], test))[0];Debug.print("142");
    let ytest = mtkl.dataMemberVectorToTextVector(yauxtest);Debug.print("143");
   
    switch(ytrain) {
      case (#ok(yvec)) {
        let y_uniques = mtkl.uniquesText(yvec);Debug.print("15");
        let myiter = Iter.range(0, xcols.size()-1);Debug.print("16");
        let col_ids = Iter.toArray(myiter);Debug.print("17");
        let ret_tree = mtkl.fitClassification(xtrain, yvec, 0, y_uniques, 3, 10, col_ids); Debug.print("18");
        Debug.print("Tree created");
        switch(ret_tree) {
          case (#ok(mytree)) {
            switch(ytest) {
              case (#ok(yvectest)) {
                var ncorrect: Nat = 0; 
                for (i in Iter.range(0, xtest.size() - 1)) {
                  //return mytree;
                  Debug.print(Nat.toText(i));
                  let sample: [mtkl.dataMember] = xtest[i]; // Debug.print("11");
                  let vec = mtkl.predictTree(sample, mytree);// Debug.print("12");
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
            //return mytree;
          };
          case (_) {
            //return TopTree;
          };
        }
      };
      case (_) {
        //return TopTree;
      };
    };
  };


  public query func doRegression(name : Text) : async () {

 
    // let LeftLeftTree: mtkl.BinTree  = mtkl.setLeftRightBranch(null, null, #symbol([1,0]), mtkl.nilTree(), mtkl.nilTree());
    // let LeftRightTree: mtkl.BinTree = mtkl.setLeftRightBranch(null, null, #symbol([0,1]), mtkl.nilTree(), mtkl.nilTree());
    // let LeftTopTree: mtkl.BinTree   = mtkl.setLeftRightBranch(?1, ?(3.5), #symbol([0.5,0.5]), LeftLeftTree, LeftRightTree);
    // let RightLeftTree: mtkl.BinTree  = mtkl.setLeftRightBranch(null, null, #symbol([0,1]), mtkl.nilTree(), mtkl.nilTree());
    // let RightRightTree: mtkl.BinTree = mtkl.setLeftRightBranch(null, null, #symbol([1,0]), mtkl.nilTree(), mtkl.nilTree());
    // let RightTopTree: mtkl.BinTree   = mtkl.setLeftRightBranch(?1, ?(3.5), #symbol([0.5,0.5]), RightLeftTree, RightRightTree);
    // let TopTree: mtkl.BinTree   = mtkl.setLeftRightBranch(?0, ?(2.5), #symbol([0.5,0.5]), LeftTopTree, RightTopTree);  

    let seed = 123456789;
    let nsamples: Nat = 300;Debug.print("10");
    let alldata = mtkl.diabetes_data;Debug.print("11");
    let pos_vec = mtkl.randomSample(0, alldata.size()-1, nsamples, false, seed);Debug.print("1");

    let train = mtkl.rows(pos_vec, alldata); Debug.print("11");
    let test = mtkl.removeRows(pos_vec, alldata); Debug.print("11");
    let xcols = Iter.toArray(Iter.range(0, mtkl.transpose(train).size()-2));
    let ycol = mtkl.transpose(train).size()-1;
    let xtrain = mtkl.cols(xcols, train);Debug.print("12"#":"#Nat.toText(mtkl.transpose(train).size()));
    let yaux = mtkl.transpose(mtkl.cols([ycol], train))[0];Debug.print("13");
    let ytrain = mtkl.dataMemberVectorToFloatVector(yaux);Debug.print("14");
    let xtest = mtkl.cols(xcols, test);Debug.print("141");
    let yauxtest = mtkl.transpose(mtkl.cols([ycol], test))[0];Debug.print("142");
    let ytest = mtkl.dataMemberVectorToFloatVector(yauxtest);Debug.print("143");
   
    switch(ytrain) {
      case (#ok(yvec)) {
        //let y_uniques = mtkl.uniquesText(yvec);Debug.print("15");
        let myiter = Iter.range(0, xcols.size()-1);Debug.print("16");
        let col_ids = Iter.toArray(myiter);Debug.print("17");
        let ret_tree = mtkl.fitRegression(xtrain, yvec, 0, 7, 5, col_ids); Debug.print("18");
        Debug.print("Tree created");
        switch(ret_tree) {
          case (#ok(mytree)) {
            switch(ytest) {
              case (#ok(yvectest)) {
                var total_rmse: Float = 0; 
                for (i in Iter.range(0, xtest.size() - 1)) {
                  //return mytree;
                  Debug.print(Nat.toText(i));
                  let sample: [mtkl.dataMember] = xtest[i]; // Debug.print("11");
                  let y_hat = mtkl.predictTree(sample, mytree)[0];// Debug.print("12");
                  let sample_error = mtkl.rmse(y_hat, yvectest[i]);
                  total_rmse := total_rmse + sample_error;
                  Debug.print("sample error: " # Float.toText(sample_error));
                };
                Debug.print("Total RMSE:"#Float.toText(total_rmse/Float.fromInt(xtest.size())));
              };
              case (_) {
                //TBD
              }
            };
            //return mytree;
          };
          case (_) {
            //return TopTree;
          };
        }
      };
      case (_) {
        //return TopTree;
      };
    };
  };

};