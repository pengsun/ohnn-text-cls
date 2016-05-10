require'pl.stringx'
local tt = require'data-prep.tokcat2wordtensor'

local str2tensor = function(str, vocab)
    -- to tensor (with naive tokenization strategy...)
    local input, numOOV = tt.line_to_tensor(str, vocab)
    return input:resize(1, input:nElement()), numOOV
end

local eval = function(input, md)
    -- ensure input: 1, M
    assert(input:dim()==2 and input:size(1)==1)

    -- get output: 1, K
    md:evaluate()
    local output = md:forward(input)
    assert(output:dim()==2 and output:size(1)==1)

    -- prediction
    local predScore, predCls = output:max(2)
    predScore = predScore:view(-1)[1]
    predCls = predCls:view(-1)[1]
    return {score = predScore, cls = predCls}
end

-- expose
local this = {}

this.main = function(str, opt)
    local fnMd = opt.fnModel or 'cv/model_dft.t7'
    print('loading model: '..fnMd)
    local env = torch.load(fnMd)
    local md = env.md

    local fnVocab = opt.fnVocab or 'cv/vocab_dft.t7'
    print('loading vocab: '..fnVocab)
    local vocab = torch.load(fnVocab)

    print'converting string to tensor...'
    local input = str2tensor(str, vocab)

    print'making prediction...'
    local pred = eval(input, md)

    print('')
    print('Input string:')
    print(str)
    print('Prediction: class ' .. pred.cls)
end

return this