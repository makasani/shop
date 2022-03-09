# Internet Shop
## _Учебный проект_

_Использует фреймворк [https://symfony.com/doc/4.4/](https://symfony.com/doc/4.4/) версии 4.4_

[![N|Solid](https://i.ibb.co/JtWxgNg/pngegg-3.png)](https://i.ibb.co/JtWxgNg/pngegg-3.png)

## Развернуть проект 

Склонировать репозиторий 

``` 
git clone git@github.com:makasani/shop.git
```

Перейти в папку с проектом и выполнить 

```
/bin/bash bin/build-project.sh
```

Или установить зависимости composer, webpack и собрать проект webpack используя консоль

```
composer install
npm install
npm run build
```

Проект будет доступен по адресу [http://shop](http://shop)

## Настройка подключения к базе данных

Создаём файл `.env.local` в который копируем  строку с указанием ваших параметров для подключения:

``` 
DATABASE_URL="mysql://user:password@127.0.0.1:3306/dbname?serverVersion=5.7&charset=utf8mb4"
```

## Инициализация базы данных

Для того чтобы на основании существующих сущностей получить структуру базы данных, необходимо выполнить команду описанную ниже:

``` 
php ./bin/console doctrine:schema:update
```
Флаги команды:
- `--dump_sql` узнать запросы которые будут выполнены;
- `--force` выполнить запросы

## Развёртывание базы данных

Для того чтобы развернуть данные в БД можно:

Воспользоваться файлом `testdb.sql` и выполнить команду (где `db_name` - наименование БД):

``` 
mysql -u root -p db_name < testdb.sql
```

Или импортировать данные с помощью [phpmyadmin](https://www.phpmyadmin.net), [dbeaver](https://dbeaver.io) или иным ПО для СУБД.

## Создание нового пользователя

Для получения инструкций по созданию нового пользователя с ролью администратора или обычного пользователя введите следующую команду:

``` 
php ./bin/console app:add-user
```
При исплльзовании `testdb.sql` пользователь `admin@test.loc` пароль `12345` с правами администратора

## Маршруты (routes)

Команда выводящая все маршруты (routes) в проекте:

``` 
symfony console debug:route
```
