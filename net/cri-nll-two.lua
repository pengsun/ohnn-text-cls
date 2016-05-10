require'nn'

--cudnn.fastest = true

local this = {}

this.main = function(opt)
    local cw = opt.criWeight or error('no opt.criWeight')

    print('creating Negative Log-Likelihood  Criterion x2')
    local repeatTarget = true
    return nn.ParallelCriterion(repeatTarget)
            :add(nn.ClassNLLCriterion(), cw[1])
            :add(nn.ClassNLLCriterion(), cw[2])
end

return this