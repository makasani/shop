# Internet Shop
## Учебный проект

Использует фреймворк [https://symfony.com] версии 5.4

## Развернуть проект 

Склонироварть репозторий 
``` 
git clone git@github.com:makasani/shop.git
```
Перейти в папку с проектом и выполнить 
```
/bin/bash bin/build-project.sh
```
Настроить Webpack установить npm
```
npm install
```
И запустить
```
npm run build
```



Проект будет доступен по адресу [http://shop]

## Инициализация базы данных

Настроить подключение к БД

Для того чтобы на основании существующих сущностей получить структуру базы данных, необходимо выполнить команду описанную ниже:

``` 
symfony console doctrine:schema:update
```
или
``` 
php ./bin/console doctrine:schema:update
```
Флаги команды:
- `--dump_sql` узнать запросы которые будут выполнены;
- `--force` выполнить запросы

## Маршруты (routes)

Команда выводящая все маршруты (routes) в проекте:

``` 
symfony console debug:route
```
