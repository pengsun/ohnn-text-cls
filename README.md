# Text Classification via One-Hot Convolution
Text classification via the OneHot Temporal Convolutional Neural Network (oh-convnet) described in [1]. 
It directly applies the convolution over the high-dimensional one-hot word vector sequence.
This way, pre-trained word embedding is unnecessary [1], 
although semi-supervised learning with additional un-labeled data can further boost the performance [2, 3].
This is a re-implementation in Torch 7, where the One-Hot convolution is implemented in a separate package `ohnn` [5]. 
See [3] for the pure C++/CUDA C code that comes with the paper [1, 2].

Features/Constraints of this implementation:

* Variable length support. You don't have to truncate the document (e.g., as in [4]) to be classified. We provide data loader that adapts variable length document. 
* On-the-fly convolution. You don't have to generate the stacked-region files beforehand to do the convolution (e.g., as in [3]). 
* `nn` package compatible. The calling convention and input/output data layout is compatible with `nn.LookupTable`.
* MUST work with GPU via CUDA.


## Results on Big Datasets
oh-convnet achieves good results for text classification task [1]. 
Here we report additional results over the big datasets described in [4] and present a comparison with char-convnet [4]. 
See below table for the error rates:

|                        	| oh-convnet 	| char-convnet 	|
|------------------------	|------------	|--------------	|
| dbpedia                	| 1.32       	| 1.55         	|
| yelp-review-polarity   	| 3.67       	| 4.88         	|
| yelp-review-full       	| 34.12      	| 37.95        	|
| yahoo                  	| 26.29      	| 28.80        	|
| amazon-review-full     	| 37.75      	| 40.43        	|
| amazon-review-polarity 	| 4.38       	| 4.93         	|

where "oh-convnet" adopts the same network architecture over different datasets (kernel size p = 3, #hidden units = 500, more details can be found at the script files, see below),
while "char-convnet" indicates the best result among different network architectures over each dataset reported in [4].


## Package Dependency
* Torch 7 full installation with `cudnn` support
* ohnn (available at [5])


## Usage
git clone the code, and read the doc beginning from [here](doc/main.md). 

tl;dr? Quick start: 

Training/evaluating over the big datasets described in [4], see [here](doc/run-scripts-train-eval.md).

A simple comparison between fix-length and variable-length, see [here](doc/run-scripts-var-vs-fix.md) 

Text classification with free string you type in, see [here](doc/run-scripts-eval-str.md).


## Acknowledgement
If you find the code useful in your own research, please cite [1, 2]. 
In `data-prep/impl_`, part of the perl scripts are borrowed from [3] and the other perl scripts are provided by Rie Johnson via private correspondence. 


## Reference
[1] Rie Johnson and Tong Zhang. Effective use of word order for text categorization with convolutional neural networks. NAACL-HLT 2015. 

[2] Rie Johnson and Tong Zhang. Semi-supervised convolutional neural networks for text categorization via region embedding. NIPS 2015.

[3] http://riejohnson.com/cnn_download.html

[4] Xiang Zhang, Junbo Zhao, Yann LeCun. Character-level Convolutional Networks for Text Classification. Advances in Neural Information Processing Systems 28 (NIPS 2015)

[5] https://github.com/pengsun/ohnn