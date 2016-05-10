-- function for evaluating
require'optim'
require'xlua'

local this = {}

this.eval_dataset = function(loader, md, cri, numClasses)
    loader:reset_batch_pointer()
    local lossTotal = 0
    local conf = optim.ConfusionMatrix(numClasses) -- confusion matrix

    print('evaluate on the dataset')
    local nb = loader:num_batches()
    local numEval = 0
    for ibat = 1, nb do
        -- data batch
        local inputs, targets = loader:next_batch()

        -- fprop
        md:evaluate()
        local outputs = md:forward(inputs)
        local loss = cri:forward(outputs, targets)

        -- update loss
        numEval = numEval + targets:numel()
        lossTotal = lossTotal + loss * targets:numel()

        -- update error
        local predictions = outputs
        if type(outputs) == 'table' then -- last one as the predictions
        predictions = outputs[#outputs]
        end
        conf:batchAdd(predictions, targets)

        xlua.progress(ibat, nb)
    end
    local lossAvg = lossTotal / numEval
    print('evaluation average loss = ' .. lossAvg)

    conf:updateValids()
    print('evaluation error rate = ' .. 1 - conf.totalValid)

    md:training() -- restore
    return lossAvg, 1 - conf.totalValid
end

return this