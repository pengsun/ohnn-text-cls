-- seqconv - maxOverTime - output
require'nn'
require'cudnn'
require'ohnn'

--cudnn.fastest = true

local this = {}

this.main = function(opt)
    local opt = opt or {}
    local K = opt.numClasses or 2 -- #classes
    local B = opt.batSize or 16 -- batch size
    local V = opt.V or 300 -- vocabulary/embedding size
    local HU = opt.HU or 190
    local kH = opt.KH or error('no opt.KH')
    local seqconvHasBias = (opt.seqconvHasBias == true) and true or false

    local mconv = ohnn.OneHotTemporalSeqConvolution(V, HU, kH,
        {hasBias = seqconvHasBias})

    local md = nn.Sequential()
    -- B, M (,V)
    md:add( mconv )
    md:add( cudnn.ReLU(true) )
    -- B, M-kH+1, HU
    md:add( nn.Max(2) )
    md:add( nn.Dropout(0.5, false, true) )
    -- B, HU

    -- B, HU
    md:add( nn.Linear(HU, K) )
    -- B, K
    md:add(cudnn.LogSoftMax())
    -- B, K

    local function reinit_params(md)
        local b = opt.paramInitBound or 0.08
        print( ('reinit params gaussian, var = %4.3f'):format(b) )

        local params, _ = md:getParameters()
        params:normal(0, b)
    end
    reinit_params(md)

    return md
end

return this

