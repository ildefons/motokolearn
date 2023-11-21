import Nat "mo:base/Nat";
import Nat64 "mo:base/Nat64";
import Float "mo:base/Float";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
import Comp "mo:base/ExperimentalInternetComputer";
import Result "mo:base/Result";

import mtkl "../Mtklearn/Mtklearn";
import data "../Mtklearn/Datasets";


actor {

  var actor_data: [[mtkl.dataMember]] = [[#number(1), #number(3), #symbol("1")],
                                    [#number(2), #number(2), #symbol("2")],
                                    [#number(3), #number(3), #symbol("3")],
                                    [#number(4), #number(2), #symbol("4")]];
  
  public func setTrainingData(data: [[mtkl.dataMember]]) : async () {
    actor_data := data;
  };
  
  public func doClassificationComp() : async (Nat64) {

    let seed = 123456789; Debug.print("1");
    let nsamples: Nat = 1000;Debug.print("11");
    let alldata = data.digit_data;Debug.print("12");
    let pos_vec = mtkl.randomSample(0, alldata.size()-1, nsamples, false, seed);Debug.print("13");

    let train = mtkl.rows(pos_vec, alldata); Debug.print("14");
    let test = mtkl.removeRows(pos_vec, alldata); Debug.print("15");
    
    let xcols = Iter.toArray(Iter.range(0, mtkl.transpose(train).size()-2));Debug.print("16");
    let ycol = mtkl.transpose(train).size()-1;Debug.print("17");
    let xtrain = mtkl.cols(xcols, train);Debug.print("18");
    let yaux = mtkl.transpose(mtkl.cols([ycol], train))[0];Debug.print("19");
    let ytrain = mtkl.dataMemberVectorToTextVector(yaux);Debug.print("110");
    let xtest = mtkl.cols(xcols, test);Debug.print("1");
    let yauxtest = mtkl.transpose(mtkl.cols([ycol], test))[0];Debug.print("111");
    let ytest = mtkl.dataMemberVectorToTextVector(yauxtest);Debug.print("112");
   
    switch(ytrain) {
      case (#ok(yvec)) {
        let y_uniques = mtkl.uniquesText(yvec);Debug.print("113");
        let myiter = Iter.range(0, xcols.size()-1);Debug.print("114");
        let col_ids = Iter.toArray(myiter);Debug.print("115");
        var ret_tree: mtkl.BinTree = mtkl.nilTree(); Debug.print("116");
        let ninst = Comp.countInstructions (
          func r {
            
            let aux = mtkl.fitClassification(xtrain, yvec, 0, y_uniques, 5, 10, col_ids, seed+1);Debug.print("117"); // seed+1

            switch(aux) {
              case (#ok(mytree)) {
                ret_tree := mytree;
              };
              case (_) {
                //TBD
              };
            };
          }
        );
        Debug.print("Tree created: "#Nat64.toText(ninst));
        switch(ytest) {
          case (#ok(yvectest)) {
            var ncorrect: Nat = 0; 
            for (i in Iter.range(0, xtest.size() - 1)) {
              //return mytree;
              let sample: [mtkl.dataMember] = xtest[i]; 
              let vec = mtkl.predictTreeClassification(sample, ret_tree);
              let myindex = Array.indexOf<Float>(mtkl.max(vec), vec, Float.equal);
              let xindex: Nat = switch(myindex) {
                case (?Nat) Nat; 
                case _ 10;
              };
              let text_sample = mtkl.printSample(sample);
              //Debug.print("sample: " # text_sample);
              if (Text.equal(y_uniques[xindex], yvectest[i])) {
                //Debug.print("correct");
                ncorrect := ncorrect + 1;  
              }
              else {
                //Debug.print("wrong"#y_uniques[xindex]#":"#yvectest[i]); 
              };
            };
            Debug.print("Percentage correct predictions:"#Float.toText(100*Float.fromInt(ncorrect)/Float.fromInt(yvectest.size())));
            return ninst;
          };
          case (_) {
            return 0;
            //TBD
          };
        };
      };
      case (_) {
        return 0;
        //TBD
      };
    };
  };

  public func doClassification() : async () {

    let seed = 123456789;
    let nsamples: Nat = 50;
    let alldata = mtkl.iris_data;
    let pos_vec = mtkl.randomSample(0, alldata.size()-1, nsamples, false, seed);

    let train = mtkl.rows(pos_vec, alldata); 
    let test = mtkl.removeRows(pos_vec, alldata); 
    
    let xcols = Iter.toArray(Iter.range(0, mtkl.transpose(train).size()-2));
    let ycol = mtkl.transpose(train).size()-1;
    let xtrain = mtkl.cols(xcols, train);
    let yaux = mtkl.transpose(mtkl.cols([ycol], train))[0];
    let ytrain = mtkl.dataMemberVectorToTextVector(yaux);
    let xtest = mtkl.cols(xcols, test);
    let yauxtest = mtkl.transpose(mtkl.cols([ycol], test))[0];
    let ytest = mtkl.dataMemberVectorToTextVector(yauxtest);
   
    switch(ytrain) {
      case (#ok(yvec)) {
        let y_uniques = mtkl.uniquesText(yvec);
        let myiter = Iter.range(0, xcols.size()-1);
        let col_ids = Iter.toArray(myiter);
        let ret_tree = mtkl.fitClassification_OLD(xtrain, yvec, 0, y_uniques, 3, 10, col_ids);
        Debug.print("Tree created");
        switch(ret_tree) {
          case (#ok(mytree)) {
            switch(ytest) {
              case (#ok(yvectest)) {
                var ncorrect: Nat = 0; 
                for (i in Iter.range(0, xtest.size() - 1)) {
                  //return mytree;
                  let sample: [mtkl.dataMember] = xtest[i]; 
                  let vec = mtkl.predictTreeClassification(sample, mytree);
                  let myindex = Array.indexOf<Float>(mtkl.max(vec), vec, Float.equal);
                  let xindex: Nat = switch(myindex) {
                    case (?Nat) Nat; 
                    case _ 10;
                  };
                  let text_sample = mtkl.printSample(sample);
                  //Debug.print("sample: " # text_sample);
                  if (Text.equal(y_uniques[xindex], yvectest[i])) {
                    //Debug.print("correct");
                    ncorrect := ncorrect + 1;  
                  }
                  else {
                    //Debug.print("wrong"#y_uniques[xindex]#":"#yvectest[i]); 
                  };
                };
                Debug.print("Percentage correct predictions:"#Float.toText(100*Float.fromInt(ncorrect)/Float.fromInt(yvectest.size())));
              };
              case (_) {
                //TBD
              }
            };
            //
          };
          case (_) {
            //
          };
        }
      };
      case (_) {
        //
      };
    };
  };

  public func doRegression() : async () {

    let seed = 123456789;
    let nsamples: Nat = 50;
    let max_depth: Nat = 7;
    let min_num_samples: Nat = 5;
    let alldata = mtkl.diabetes_data;
    let pos_vec = mtkl.randomSample(0, alldata.size()-1, nsamples, false, seed);

    let train = mtkl.rows(pos_vec, alldata); 
    let test = mtkl.removeRows(pos_vec, alldata); 
    let xcols = Iter.toArray(Iter.range(0, mtkl.transpose(train).size()-2));
    let ycol = mtkl.transpose(train).size()-1;
    let xtrain = mtkl.cols(xcols, train);
    let yaux = mtkl.transpose(mtkl.cols([ycol], train))[0];
    let ytrain = mtkl.dataMemberVectorToFloatVector(yaux);
    let xtest = mtkl.cols(xcols, test);
    let yauxtest = mtkl.transpose(mtkl.cols([ycol], test))[0];
    let ytest = mtkl.dataMemberVectorToFloatVector(yauxtest);
   
    switch(ytrain) {
      case (#ok(yvec)) {
        let myiter = Iter.range(0, xcols.size()-1);
        let col_ids = Iter.toArray(myiter);
        let ret_tree = mtkl.fitRegression(xtrain, yvec, 0, max_depth, min_num_samples, col_ids);
        Debug.print("Tree created");
        switch(ret_tree) {
          case (#ok(mytree)) {
            switch(ytest) {
              case (#ok(yvectest)) {
                var total_rmse: Float = 0; 
                for (i in Iter.range(0, xtest.size() - 1)) {
                  //return mytree;
                  let sample: [mtkl.dataMember] = xtest[i]; 
                  let y_hat = mtkl.predictTreeRegression(sample, mytree)[0];
                  let sample_error = mtkl.rmse(y_hat, yvectest[i]);
                  total_rmse := total_rmse + sample_error;
                  //Debug.print("sample error: " # Float.toText(sample_error));
                };
                Debug.print("Total RMSE:"#Float.toText(total_rmse/Float.fromInt(xtest.size())));
              };
              case (_) {
                //TBD
              }
            };
            //
          };
          case (_) {
            //r
          };
        }
      };
      case (_) {
        //
      };
    };
  };

    // How to create a classifiation tree manually
    // let LeftLeftTree: mtkl.BinTree  = mtkl.setLeftRightBranch(null, null, #symbol([1,0]), mtkl.nilTree(), mtkl.nilTree());
    // let LeftRightTree: mtkl.BinTree = mtkl.setLeftRightBranch(null, null, #symbol([0,1]), mtkl.nilTree(), mtkl.nilTree());
    // let LeftTopTree: mtkl.BinTree   = mtkl.setLeftRightBranch(?1, ?(3.5), #symbol([0.5,0.5]), LeftLeftTree, LeftRightTree);
    // let RightLeftTree: mtkl.BinTree  = mtkl.setLeftRightBranch(null, null, #symbol([0,1]), mtkl.nilTree(), mtkl.nilTree());
    // let RightRightTree: mtkl.BinTree = mtkl.setLeftRightBranch(null, null, #symbol([1,0]), mtkl.nilTree(), mtkl.nilTree());
    // let RightTopTree: mtkl.BinTree   = mtkl.setLeftRightBranch(?1, ?(3.5), #symbol([0.5,0.5]), RightLeftTree, RightRightTree);
    // let TopTree: mtkl.BinTree   = mtkl.setLeftRightBranch(?0, ?(2.5), #symbol([0.5,0.5]), LeftTopTree, RightTopTree);  


};