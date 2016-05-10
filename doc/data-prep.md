# Data Preprocessing/Preparation

**Before you start** 

Make a folder named `data-raw` in the code folder. E.g., the path should look like `~/code/ohnn-text-cls/data-raw` after you are done. 
This folder will store the datasets for later use. 
It is recommended that you make `data-raw` a link pointing to another place (e.g., a fast and big SSD).

**Make datasets described in [1]**

Take the dataset `yelp-review-polarity` for example. Follow the steps below:

* Donwload the CSV raw text files. See [1] for the links.
* Extract the the two files `train.csv`, `test.csv` to the folder `data-raw/yelp-review-polarity`
* From code folder (the path should look like `~/code/ohnn-text-cls`), run command
```
th data-prep/scritpts/gen_yelp-review-polarity.lua
```

Done! This will do a pipeline of converting CSV to plain text files, tokenization, 
extracting vocabulary and finally converting to Torch 7 tensors (in *.t7 files), 
which are put in the folder `data-raw/yelp-review-polarity/word-t7` used by data loader.

**Make datasets described in [2]**

The pipeline is similar. Take `imdb` for example:

* Download the four files `imdb-train.txt.tok`, `imdb-train.cat`, `imdb-test.txt.tok`, `imdb-text.cat`, 
which should come with the source code provided by [2]. (e.g., for ConText2.0, they should be 
in the path `conText-v2.00a/test/data`)
* Put the four files in `data-raw/imdb`
* Run command
```
th data-prep/scritpts2/gen_imdb.lua
```

**LuaJIT Memory Limitation**

The data preparation script uses lua Table to extract vocabulary. 
Due to the LuaJIT [2GB memory limitation](https://github.com/torch/torch7/wiki/Cheatsheet#luajit-limitations-gotchas-and-assumptions) for native lua data structure, the script might crash on big dataset like "amazon-review-polarity".
Therefore, it is recommended that you install Torch 7 with lua 5.2, not with luajit. 
For how, see the official Torch 7 doc [link](http://torch.ch/docs/getting-started.html), this line: "If you want to install torch with Lua 5.2 instead of LuaJIT, simply run...". 
This way you can safely run all data preparation scripts.

## Folder layout of data-prep/
`scripts/`, `scripts2`: a folder of scripts for per dataset generation/preparation

`csv2txtcat.lua`: convert dataset in CSV format provided by [1] to dataset in text and category format (both are plain txt files, defined in [2]).
A naive implementation.

`csv2txtcat-rie.lua`: convert dataset in CSV format provided by [1] to dataset in text and category format (both are plain txt files, defined in [2]). 
Call the perl scripts `convert.pl` or `convert-multifields.pl` provided by Rie Johnson.

`txt2tok.lua`: convert text to tokens. 
Call the perl script `to_tokens.pl` with the registered-word file `registered-tokens.txt`, both borrowed from [2].

`extract_vocab.lua`: extract vocabulary from token file.

`tokcat2wordtensor.lua`: convert tokens and categories to Torch 7 tensors.

## References
[1] https://github.com/zhangxiangxiao/Crepe

[2] http://riejohnson.com/cnn_download.html