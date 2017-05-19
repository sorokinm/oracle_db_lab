BEGIN
create_client('Вася','Василий','Пупкин','Россия','Иваново','Столичная','4','554564');
END;
/
SELECT *
FROM client
WHERE client.nickname = 'Вася';