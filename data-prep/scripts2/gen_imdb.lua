require'pl.path'
local ut = require'util.misc'

-- common opt
local dataPath = 'data-raw/imdb' -- local
local dataPathTokCat = path.join(dataPath, '')
local dataPathWordT7 = path.join(dataPath, 'word-t7')
local numClasses = 2
local vocab_truncate_size = 30000 -- vocabulary control


print'==> [checking path]'
ut.ensure_path(dataPathWordT7)


print'==> [extract vocab: .txt.tok to .vocab]'
require'data-prep.extract_vocab'.main{
    -- input
    fn_tokens = path.join(dataPathTokCat, 'imdb-train.txt.tok'),
    vocab_truncate_size = vocab_truncate_size,
    -- output
    fn_vocab_freq = path.join(dataPathTokCat, 'imdb_trn.vocab'),
    fn_vocab_freq_truncate = path.join(dataPathTokCat, 'imdb_trn-' .. vocab_truncate_size .. '.vocab'),
}


print'==> [converting to tensors: .txt.tok & .cat to .t7]'
require'data-prep.tokcat2wordtensor'.main{
    -- input
    data_path = dataPathTokCat,
    fn_vocab_freq = 'imdb_trn-' .. vocab_truncate_size .. '.vocab',
    fn_tok_train = 'imdb-train.txt.tok',
    fn_cat_train = 'imdb-train.cat',
    fn_tok_test = 'imdb-test.txt.tok',
    fn_cat_test = 'imdb-test.cat',
    vocab_cat = {['pos']=2, ['neg']=1},
    -- output
    data_out = dataPathWordT7,
}
