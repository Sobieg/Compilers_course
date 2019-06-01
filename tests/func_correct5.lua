function bar(n)
	return 1, 2
end
x, y = bar('zaphod')  --> выводит "zaphod  nil nil"
-- Теперь x = 4, y = 8, а значения 15..42 отбрасываются.

-- Функции могут быть локальными и глобальными. Эти строки делают одно и то же:
function f(x) return x * x end
f = function (x) return x * x end