require'nn'

--cudnn.fastest = true

local this = {}

this.main = function(opt)
    print('creating Negative Log-Likelihood Criterion x1')
    return nn.ClassNLLCriterion()
end

return this

