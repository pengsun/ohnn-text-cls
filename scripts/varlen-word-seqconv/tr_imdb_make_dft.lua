-- run train.lua
require 'pl.path'
local timenow = require'util.misc'.get_current_time_str()

local maxEp = 30
local function make_lrEpCheckpoint_small()
  local baseRate, factor = 2e-3, 0.97
  local r = {}
  for i = 1, 10 do
    r[i] = baseRate
  end
  for i = 11, 30 do
    r[i] = r[i - 1] * factor
  end
  return r
end

local dataname = 'imdb-varlen-word'
local numClasses = 2
local trsize = 25*1000

local netname = 'seqconv-max-o'
local HU = 100
local KH = 3

local envSavePath = path.join('cv', dataname..'-'..netname)
local envSavePrefix =
        'HU' .. HU .. '-' ..
        'KH' .. KH
local logSavePath = path.join(envSavePath,
  envSavePrefix ..'_' .. timenow .. '.log'
)

local batSize = 250
local itPerEp = math.floor(trsize / batSize)
local printFreq = math.ceil(0.061 * itPerEp)
local evalFreq = 30 * itPerEp -- every #epoches

dofile('train.lua').main{
  mdPath = path.join('net', netname .. '.lua'),
  criPath = path.join('net', 'cri-nll-one' .. '.lua'),

  dataPath = path.join('data', dataname .. '.lua'),
  dataMask = { tr = true, val = true, te = false },

  envSavePath = envSavePath,
  envSavePrefix = envSavePrefix,
  logSavePath = logSavePath,

  V = 30000 + 1, -- vocab + oov(null)
  HU = HU,
  KH = KH,
  numClasses = numClasses,
  seqconvHasBias = true,

  batSize = batSize,
  maxEp = maxEp,
  paramInitBound = 0.01,

  printFreq = printFreq,
  evalFreq = evalFreq, -- every #epoches
  showEpTime = true,
  showIterTime = false,

  lrEpCheckpoint = make_lrEpCheckpoint_small(),
  optimMethod = require'optim'.rmsprop,
  optimState = {
    learningRate = 2e-3,
    alpha = 0.95, -- decay rate
  },
}