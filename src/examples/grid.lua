local Plotter = require 'plotter'

local termw,termh = term.getSize()
local winPlot = window.create(term.current(), 1, 1, termw, termh, true)

local plotter = Plotter(winPlot)

local plotData = {}
local gridOffsetX = 0
local gridGapX = 20
local value = 0

-- preload chart with blank data
for i = 1, plotter.box.width do
    table.insert(plotData, plotter.NAN)
end

while true do
    value = value + math.random(-90,100)
    
    -- push new value to end, remove first value
    table.insert(plotData, type(value) ~= 'nil' and value or plotter.NAN)
    table.remove(plotData, 1)

    gridOffsetX = (gridOffsetX - 1) % gridGapX

    plotter:clear(colors.black)

    local min, max = plotter:chartLineAuto(plotData, colors.white)

    -- chart grid with specified offset and styles
    plotter:chartGrid(#plotData, min, max, gridOffsetX, colors.white, {
        -- integer >= 1
        xGap = gridGapX,

        -- number >= 1
        yLinesMin = 3,

        -- integer >= 2
        yLinesFactor = 2

        -- effective yLinesMax: yLinesMin * yLinesFactor
    })

    winPlot.setVisible(false)
    plotter:render()
    winPlot.setVisible(true)

    sleep(0.1)
end