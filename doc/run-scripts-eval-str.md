# Run Scripts to Evaluate Free Strings

To get a quick impression, download the default model and vocabulary from our [shared google drive](https://drive.google.com/open?id=0B_8XCW538vWvV1pqSHdPSk1Vb0U) 
and place the two files in `cv/` folder (i.e., `cv/model_dft.t7` and `cv/vocab_dft.t7`). 
The model and vocabulary are obtained from the "imdb dataset" (Movie Review, binary classification).

Then, run the script
```lua
th script/ev_luaString.lua
```
and see whether the prediction makes sense to you.

You could change the string to be evaluated in script `scripts/ev_luaString.lua`. E.g., with
```
local str = "It's a Masterpiece ! I like this movie !"
```
the script will print:
```
Prediction: class 2
```

In contrast, with
```
local str = "It's so disappointed , worst movie ever seen ..."
```
the script will print:
```
Prediction: class 1
```

## Remarks
**Use Your Own**. The default model is just for demonstration purpose, 
where the model is very small, not trained sufficiently and inaccurate.
Use your own well trained models and vocabulary by changing the options in `scripts/ev_luaString.lua`.

**Make Default Models Manually**. If you unfortunately have difficulties to access the link for default model and vocabulary, or your Torch 7 was not built with Lua5.2, make them manually. 
First the model. Run
```
th scripts/varlen-word-seqconv/tr_imdb_make_dft.lua
```
and copy and rename the `*.t7` file. 
Then the vocabulary, just copy and rename the file `data-raw/imdb/word-t7/vocab.t7` after you run the data preparation script.



