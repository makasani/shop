# Internet Shop
## Учебный проект

Использует фреймворк [https://symfony.com] версии 4.4

## Развернуть проект 

Склонироварть репозторий 
``` 
git clone git@github.com:makasani/shop.git
```
Перейти в папку с проектом и выполнить 
```
/bin/bash bin/build-project.sh
```
Установить composer зависимости
```
composer install
```
Установить npm зависимости
```
npm install
```
Запустить webpack для компиляции ресурсов
```
npm run build
```



Проект будет доступен по адресу [http://shop]

## Инициализация базы данных

Настроить подключение к БД

Для того чтобы на основании существующих сущностей получить структуру базы данных, необходимо выполнить команду описанную ниже:

``` 
php ./bin/console doctrine:schema:update
```
Флаги команды:
- `--dump_sql` узнать запросы которые будут выполнены;
- `--force` выполнить запросы

## Развёртывание базы данных

Для того чтобы развернуть данные в БД можно:

Воспользоваться файлом "testdb.sql" и выполнить команду описанную ниже ("db_name" - наименование БД):

``` 
mysql -u root -p db_name < testdb.sql
```

Или импортировать данные с помощью phpmyadmin, dbeaver или иным ПО для СУБД.

## Маршруты (routes)

Команда выводящая все маршруты (routes) в проекте:

``` 
symfony console debug:route
```

## Устранение ошибок

В случае получения ошибки 
```
When using date/time fields in EasyAdmin backends, you must install and enable the PHP Intl extension, which is used to format date/time values.
```

- установить `php-intl` командой 

    ```
    sudo apt install php-intl
    ```

- активировать модуль `intl` в `php.ini` командами
    ```
    sed "/intl/ s/^/;/" /etc/php/7.4/fpm/php.ini
    ```
    ```
    sudo phpenmod intl
    ```