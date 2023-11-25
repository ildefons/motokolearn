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

    let seed = 123456789; 
    let nsamples: Nat = 1000;
    let alldata = data.digit_data;
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
        var ret_tree: mtkl.BinTree = mtkl.nilTree(); 
        let ninst = Comp.countInstructions (
          func r {
            
            let aux = mtkl.fitClassification(xtrain, yvec, 0, y_uniques, 5, 10, col_ids, seed+1);

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
    let alldata = data.iris_data;
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
    let nsamples: Nat = 300;
    let max_depth: Nat = 10;
    let min_num_samples: Nat = 5;
    let alldata = data.diabetes_data;
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
        let ret_tree = mtkl.fitRegressionOLD(xtrain, yvec, 0, max_depth, min_num_samples, col_ids);
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

  var rf_classifier_vec: [mtkl.BinTree] = [mtkl.nilTree()];
  var rf_regression_vec: [mtkl.BinTree] = [mtkl.nilTree()];

  public func doPredictRFClassifier() : () {

    let seed = 123456789; 
    let ntrees = 10;
    let max_depth: Nat = 10;
    let min_num_samples: Nat = 5;
    let nsamples: Nat = 1000;
    let alldata = data.digit_data;
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
    
    switch(ytest) {
      case (#ok(yvectest)) {
        var ncorrect: Nat = 0; 
        let mytree: mtkl.BinTree = rf_classifier_vec[0];
        var y_uniques: [Text] = [];
        switch(ytrain) {
          case (#ok(yvec)) {
            y_uniques := mtkl.uniquesText(yvec);
          };
          case (_) {
            //
          };
        };
        for (i in Iter.range(0, xtest.size() - 1)) {
          //return mytree;
          let sample: [mtkl.dataMember] = xtest[i];
          let vec = mtkl.predictRFClassification(sample,rf_classifier_vec);
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
  };

  public func doRFClassifier() : async () {

    let seed = 123456789; 
    let ntrees = 10;
    let max_depth: Nat = 10;
    let min_num_samples: Nat = 5;
    let pct_train: Float = 0.9;
    let nsamples: Nat = 1000;
    let alldata = data.digit_data;
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
        var ret_tree: mtkl.BinTree = mtkl.nilTree(); 
        
        let rfreturn = await mtkl.fitRandomForestClassifier(xtrain, 
                                                            yvec, 
                                                            y_uniques, 
                                                            ntrees, 
                                                            0, 
                                                            min_num_samples, 
                                                            max_depth, 
                                                            col_ids, 
                                                            pct_train,
                                                            seed+1);
        switch(rfreturn) {
          case (#ok(tree_vec)) {
            rf_classifier_vec := tree_vec;
          };
          case (_) {
            //
          };
        };
      }; 
      case (_) {
        //return 0;
        //TBD
      };
    };
  };

  public func doPredictRFRegression() : () {

    let seed = 123456789; 
    let nsamples: Nat = 300;
    let alldata = data.diabetes_data;
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
    
    switch(ytest) {
      case (#ok(yvectest)) {
        var total_rmse: Float = 0; 
        for (i in Iter.range(0, xtest.size() - 1)) {
          //return mytree;
          //Debug.print(Nat.toText(i));
          let sample: [mtkl.dataMember] = xtest[i]; 
          let y_hat = mtkl.predictRFRegression(sample, rf_regression_vec)[0];
          let sample_error = mtkl.rmse(y_hat, yvectest[i]);
          total_rmse := total_rmse + sample_error;
          //Debug.print(Nat.toText(i)#":sample error: " # Float.toText(sample_error));
        };
        Debug.print("Total RMSE:"#Float.toText(total_rmse/Float.fromInt(xtest.size())));
      };
      case (_) {
        //TBD
      };
    };
  };

  public func doRFRegression() : async () {

    let seed = 123456789; 
    let ntrees = 100;
    let max_depth: Nat = 10;
    let min_num_samples: Nat = 5;
    let nsamples: Nat = 300;
    let alldata = data.diabetes_data;
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
        var ret_tree: mtkl.BinTree = mtkl.nilTree(); 
        
        let rfreturn = await mtkl.fitRandomForestRegression(xtrain, 
                                                            yvec, 
                                                            ntrees, 
                                                            0, 
                                                            min_num_samples, 
                                                            max_depth, 
                                                            col_ids, 
                                                            seed+1);
        switch(rfreturn) {
          case (#ok(tree_vec)) {
            rf_regression_vec := tree_vec;
          };
          case (_) {
            //
          };
        };
      }; 
      case (_) {
        //return 0;
        //TBD
      };
    };
  };

  public func test1() : async () {
    let vec: [Nat] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
    let aux = mtkl.randomShuffle(vec,123);
    for (i in Iter.range(0, aux.size() - 1)) {
      Debug.print(Nat.toText(aux[i]));
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