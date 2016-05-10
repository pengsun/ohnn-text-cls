# Documentation

The code follows the Torch 7 "data-model-train-evaluate" idiom. 
(See, e.g., [this link](http://torch.ch/blog/2015/07/30/cifar.html) for explanation and instance of the idiom.)

In this project, "data" correspond to dataset source files in folder `data`, 
"model" means network architecture and criterion/cost function stored in folder `net`, 
"train" and "evaluate" correspond to main logic implemented in files `train.lua` and `eval.lua`. 

Run the scripts (which can be viewed as config files) in folder `scripts` for the per-dataset training/evaluating.
 
## Folder Layout:

`data-prep/`: data pre-processing (tokenization, extracting vocabulary, saving to Torch 7 tensors, etc).

`data-raw/`: for storing raw datasets (can be a link to another place, e.g., a fast and big SSD)

`data/`: for dataset source (in lua file). Will return data loader/provider for specific dataset.

`net/`: for various network architectures.

`train.lua`: for training.

`eval.lua`: for evaluating.

`eval_str.lua`: for evaluating over (lua) string that you type in.

`plot_loss.lua`: plot and compare losses/error rates for saved models.
 
`Loader*.lua`: various data loader/provider classes.

## Explanation of Data Loader
Running the data source lua file in folder `data/` will return the corresponding data loader(a.k.a. provider) on the specific dataset. For example:
```lua
r = require'data.yelprevpol-varlen-word'
```
will return a variable-length data loader on the dataset "yelp-review-polarity". 

A data source lua file is much like a class factory.

A data loader acts like a forward-iterator and always implements the `next_batch()` method, which returns the data/label for next mini batch.
We provide various types of data loader:

* `LoaderTCVarLenWord`: Variable length loader. The documents are sorted by length and each mini-batch is a (non-overlapped) "segment" of the sorted documents. 
Shorter documents will be elongated by filling special tokens (which can be specified as dummy so that it is equivalent to zero word vector).
* `LoaderTCFixTailWord`: Fixed length loader. It truncates the document that is shorted than the pre-specified length.

## Run Scripts
In folder `scripts/` are lua scripts (which can be viewed as config files) for concrete tasks:

To run the training/evaluating code for research purpose, see [here](run-scripts-train-eval.md).

To run the code for a comparison between variable-length and fix-length, see [here](run-scripts-var-vs-fix.md)

To run the code for only the text classification with string you type in, see [here](run-scripts-eval-str.md).

**Disclaimer**: run the script from the code folder (not any of its sub-folder). 