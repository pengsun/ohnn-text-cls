# Run Scripts for Training and Evaluating

**First, Prepare the Data**. 
See the instruction [here](data-prep.md). After you've done data preparation, you move to next steps:

**For the big datasets described in [1]**. 
Take the dataset `yelp-review-polarity` for example. cd to to code folder (something look like `~/code/ohnn-text-cls`) and run the command
```sh
th scripts/varlen-word-seqconv/tr_yelprevpol.lua
```
to do the training and evaluating, or
```sh
CUDA_VISIBLE_DEVICES=3 th scripts/varlen-word-seqconv/tr_yelprevpol.lua
```
in case your have multiple GPUs and want to specify the GPU id (= 3 in this example).

In file `scripts/varlen-word-seqconv/tr_yelprevpol.lua`, 
you could change the options, where the variable names should be self-explanatory. 
Some important options:
```lua
local maxEp = 30 -- maximum #epochs for training
local netname = 'seqconv-max-o' -- network architecture name
local HU = 500 -- #hidden units
local KH = 3 -- convolution kernel size
local batSize = 100 -- batch size: #documents per batch
local evalFreq = 1 * itPerEp -- evaluate and save the models every #epoches
```

**For the datasets described in [2]**. 
Everything is similar. E.g., for the dataset `imdb` run command:
```
th scripts/varlen-word-seqconv/tr_imdb.lua
```


## Remarks
**Validating vs Testing**. Note that in [1] no separate validation set is made. So we intentionally let the testing set be the validation set during the training,
see `data/yelprevpol-varlen-word.lua`, where we let the data loader for validation set be created over the testing set.
Therefore, the validation error rate is exactly the testing error rate we show in the table in README.md. 

**Saving Frequency**. By default, the scripts save model every epoch, which consumes a lot of storages.
Lower it down if you like (e.g., every 10 epochs by `local evalFreq = 10 * itPerEp`). 

**GPU Memory**. The scripts have been tested on GTX Titan X GPU. 
In case you encounter the "out-of-memory" error on your machine, 
lower down the `batSize` and make sure it is divisible by the training/testing data size (or residual will be abandoned). 

**GPU id**. As the code uses only a single GPU, you could specify the GPU id by an additional environment variable, e.g.,
```sh
CUDA_VISIBLE_DEVICES=0 th scripts/varlen-word-seqconv/tr_yelprevpol.lua
```


## References
[1] Xiang Zhang, Junbo Zhao, Yann LeCun. Character-level Convolutional Networks for Text Classification. Advances in Neural Information Processing Systems 28 (NIPS 2015)

[2] Rie Johnson and Tong Zhang. Effective use of word order for text categorization with convolutional neural networks. NAACL-HLT 2015. 