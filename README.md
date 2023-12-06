# motokolearn

Motokolearn is a Motoko package meant to facilitate on-chain training and inference of machine learning models where having a large GPU powered server farms is not a requirement. 

### Why on-chain training and inference of machine learning models is interesting?​

- Web3 services using these on-chain trained models can inherit security and verification capabilities from the underlying Internet Computer protocol ​

- Overall dapp architecture can be simplified by eeliminate dependencies with external web2 providers and/or avoid using pre-compiled WASM modules of pre-trained machine learning models

### Why do we care about small to mid-sized data problems not requiring a GPU?​

- Small to medium size data problems of heterogenous "tabular" data is often better solved with ensemble of boosted trees​

- From personal experience, 1) many Kaggle challenges (including those I won) are better solved with ensembles of trees; and 2) last year alone, I consulted with three medium sized startups and all projects involved data bases below 100 megabytes and none of them required the use of large neural network nor GPUs.

## Package installation using github

1) Install mops package manager: https://docs.mops.one/quick-start
2) Install the Motoko Base library in your project using mops:
```bash
mops add base
```
3) Install fuzz package:
```bash
mops add fuzz
```
4) Clone this repository in the base of your project:
```
cd <yourproject>
git clone https://github.com/ildefons/motokolearn.git
``` 

## Model training 

### CART (Classification And Regression Tree) classifier tree

```
import mtkl "../motokolearn/src/Mtklearn/Mtklearn";
import data "../motokolearn/src/Mtklearn/Datasets";

actor {
  let seed = 123456789;
  let nsamples: Nat = 100;
  let alldata = data.wine_data;
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
        let ret_tree = mtkl.fitClassification(xtrain, yvec, 0, y_uniques, 3, 10, col_ids, seed);
      };
  };
};

``` 

### CART regression tree

```
import mtkl "../motokolearn/src/Mtklearn/Mtklearn";
import data "../motokolearn/src/Mtklearn/Datasets";

actor {
  let seed = 123456789;
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
  let ytrain = mtkl.dataMemberVectorToTextVector(yaux);
  let xtest = mtkl.cols(xcols, test);
  let yauxtest = mtkl.transpose(mtkl.cols([ycol], test))[0];
  let ytest = mtkl.dataMemberVectorToTextVector(yauxtest);

  switch(ytrain) {
      case (#ok(yvec)) {
        let y_uniques = mtkl.uniquesText(yvec);
        let myiter = Iter.range(0, xcols.size()-1);
        let col_ids = Iter.toArray(myiter);
        let ret_tree = mtkl.fitRegression(xtrain, yvec, 0, y_uniques, min_num_samples, max_depth, col_ids, seed);
      };
  };
};

``` 

### Random forest classifier

```
import mtkl "../motokolearn/src/Mtklearn/Mtklearn";
import data "../motokolearn/src/Mtklearn/Datasets";

actor {

var rf_classifier_vec: [mtkl.BinTree] = [mtkl.nilTree()];

public func doRFClassifier() {
    let seed = 123456789; 
    let ntrees = 100;
    let max_depth: Nat = 10;
    let min_num_samples: Nat = 5;
    let pct_train: Float = 0.99;
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
        //
      };
    };
  };
```

### Random forest regression
```
import mtkl "../motokolearn/src/Mtklearn/Mtklearn";
import data "../motokolearn/src/Mtklearn/Datasets";

actor {

var rf_regression_vec: [mtkl.BinTree] = [mtkl.nilTree()];

public func doRFRegression() : async () {

    let seed = 123456789; 
    let ntrees = 100;
    let max_depth: Nat = 10;
    let min_num_samples: Nat = 5;
    let pct_train = 0.9;
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
                                                            pct_train,
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
        //
      };
    };
  };
```

## Model inference

### CART classifier tree

```
let i = 1;
let sample: [mtkl.dataMember] = xtest[i]; 
let vec = mtkl.predictTreeClassification(sample, mytree);
let myindex = Array.indexOf<Float>(mtkl.max(vec), vec, Float.equal);
let xindex: Nat = switch(myindex) {
  case (?Nat) Nat; 
  case _ 10;
};
if (Text.equal(y_uniques[xindex], yvectest[i])) {
  Debug.print("correct"); 
}
```

### CART regression tree

```
let i = 1;
let sample: [mtkl.dataMember] = xtest[i]; 
let y_hat = mtkl.predictTreeRegression(sample, mytree)[0];
let sample_rmse = mtkl.rmse(y_hat, yvectest[i]);
```

### Random forest classifier

```
let i = 1;
let sample: [mtkl.dataMember] = xtest[i];
let vec = mtkl.predictRFClassification(sample,rf_classifier_vec);
let myindex = Array.indexOf<Float>(mtkl.max(vec), vec, Float.equal);
let xindex: Nat = switch(myindex) {
  case (?Nat) Nat; 
  case _ 10;
};
let text_sample = mtkl.printSample(sample);

if (Text.equal(y_uniques[xindex], yvectest[i])) {
  Debug.print("correct");   
}
```

### Random forest regression

```
let i = 0;
let sample: [mtkl.dataMember] = xtest[i]; 
let y_hat = mtkl.predictRFRegression(sample, rf_regression_vec)[0];
let sample_rmse = mtkl.rmse(y_hat, yvectest[i]);
```

## Data 

### Uploading custom dataset using dfx

1) you need a canister method able to receive data in the right format as well as a canister state variable:

```
  var actor_data: [[mtkl.dataMember]] = [[#number(1), #number(3), #symbol("1")],
                                        [#number(2), #number(2), #symbol("2")],
                                        [#number(3), #number(3), #symbol("3")],
                                        [#number(4), #number(2), #symbol("4")]];
  
  public func setTrainingData(data: [[mtkl.dataMember]]) : async () {
    actor_data := data;
  };
``` 

2) You can now call this method using dfx:
```
dfx canister call motokolearn_backend setTrainingData '(vec { vec {variant {number=1}; variant {number=11}; variant {symbol="1"};}; vec {variant {number=2}; variant {number=21}; variant {symbol="2"};};  vec {variant {number=3}; variant {number=31}; variant {symbol="3"};};})' 
```

### Copy/paste custom dataset from your device to your canister code 

In case you have a large dataset in csv format, you can use the python notebook to read and convert the dataset into a motoko compatible dataset. then you can copy/paste it into your canister code: ```motokolearn/notebooks/sklearn_ds_generation.ipynb```



