if not LoaderTCFixTailWord then
    require'LoaderTCFixTailWord'
end

-- config
local dataPath = "data-raw/imdb/word-t7"

local this = {}
this.main = function (opt)
    -- options
    opt = opt or {}
    opt.batSize = opt.batSize or error('no opt.batSize')
    opt.seqLength = opt.seqLength or error('no opt.seqLength')
    local dataMask = opt.dataMask or {tr=true,val=true,te=true}

    -- vocab
    local vocab = torch.load( path.join(dataPath, 'vocab.t7') )
    local unk = 1 -- vocab index preserved for unknown word
    assert(vocab['<unknown>']==unk)

    -- tr, val, te data loader
    local arg = {wordFill = unk}
    local tr, val, te

    if dataMask.tr == true then
        local fntr = path.join(dataPath, 'tr.t7')
        print('train data loader')
        tr = LoaderTCFixTailWord(fntr, opt.batSize, opt.seqLength, arg)
        tr:set_order_rand()
        print(tr)
    end

    if dataMask.val == true then
        local fnval = path.join(dataPath, 'te.t7')
        print('val data loader')
        val = LoaderTCFixTailWord(fnval, opt.batSize, opt.seqLength, arg)
        val:set_order_natural()
        print(val)
    end

    if dataMask.te == true then
        local fnte = path.join(dataPath, 'te.t7')
        print('test data loader')
        te = LoaderTCFixTailWord(fnte, opt.batSize, opt.seqLength, arg)
        te:set_order_natural()
        print(te)
    end

    return {tr = tr, val = val, te = te, vocab = vocab}
end
return this

