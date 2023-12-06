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

### Random forest classifier

### Random forest regression

## Model inference

### CART classifier tree

### CART regression tree

### Random forest classifier

### Random forest regression

## Data 

### Uploading dataset using dfx

### Copy/paste a custom dataset from your device to your cnister code 



