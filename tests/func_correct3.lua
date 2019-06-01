-- Эти тоже:
local function g(x) return math.sin(x) end
local g = function(x) return math.sin(x) end
-- Эквивалентно для local function g(x)..., однако ссылки на g
-- в теле функции не будут работать, как ожидалось.
local g; g  = function (x) return math.sin(x) end
-- 'local g' будет прототипом функции.