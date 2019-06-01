setmetatable(f1, metafraction)
setmetatable(f2, metafraction)

s = f1 + f2  -- вызвать __add(f1, f2) на метатаблице от f1

-- f1, f2 не имеют ключа для своих метатаблиц в отличии от прототипов в js,
-- нужно получить его через getmetatable(f1). Метатаблица - обычная таблица
-- поэтому с ключами, известными для Lua (например, __add).

-- Но следущая строка будет ошибочной т.к в s нет метатаблицы:
-- t = s + s
-- Похожий на классы подход, приведенный ниже, поможет это исправить.

-- __index перегружает в метатаблице просмотр через точку:
defaultFavs = {animal = 'gru', food = 'donuts'}
myFavs = {food = 'pizza'}
setmetatable(myFavs, {__index = defaultFavs})
eatenBy = myFavs.animal  -- работает! спасибо, мета-таблица.