function fib(n)
  if n < 2 then return n end
  return fib(n - 2) + fib(n - 1)
end

-- Вложенные и анонимные функции являются нормой:
function adder(x)
  -- Возращаемая функция создаётся, когда вызывается функция adder,
  -- и запоминает значение переменной x:
  return function (y) return x + y end
end
a1 = adder(9)
a2 = adder(36)
print(a1(16))  --> 25
print(a2(64))  --> 100