﻿#Использовать asserts
#Использовать tempfiles
#Использовать ".."

Перем юТест;
Перем Лог;

Перем мСообщенияЛога;
Перем мСообщенияЛогаПереопределеннойРаскладки;
Перем мПереопределитьВывод;

Функция ПолучитьСписокТестов(Знач ЮнитТестирование) Экспорт

	юТест = ЮнитТестирование;

	МассивТестов = Новый Массив;
	МассивТестов.Добавить("Тест_ДолженСоздатьЛоггерПоУмолчанию");
	МассивТестов.Добавить("Тест_ДолженПроверитьУровниВывода");
	МассивТестов.Добавить("Тест_ДолженПроверитьЧтоЗарегистрированыАппендеры");
	МассивТестов.Добавить("Тест_ДолженПроверитьЧтоУровниВыводаИзменяются");
	МассивТестов.Добавить("Тест_ДолженПроверитьЧтоАппендерУстановлен");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводБолееПриоритетногоСообщения");
	МассивТестов.Добавить("Тест_ДолженПроверитьЧтоНеВыводятсяМенееПриоритетныеСообщения");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводОтладки");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводИнформации");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводПредупреждения");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводОшибки");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводКритичнойОшибки");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводОтладкиЧерезСтрШаблон");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводИнформацииЧерезСтрШаблон");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводПредупрежденияЧерезСтрШаблон");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводОшибкиЧерезСтрШаблон");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводКритичнойОшибкиЧерезСтрШаблон");
	МассивТестов.Добавить("Тест_ДолженПроверитьСозданиеИдентификатораВЛоге");
	МассивТестов.Добавить("Тест_ДолженПроверитьРаскладку");
	МассивТестов.Добавить("Тест_ДолженПроверитьЗакрытиеЛогаПоСчетчикуСсылок");
	МассивТестов.Добавить("Тест_ДолженПрочитатьНастройкиЛогированияИзФайла");

	Возврат МассивТестов;

КонецФункции

Процедура ПередЗапускомТеста() Экспорт
	Лог = Логирование.ПолучитьЛог("logos.internal");
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	Логирование.ЗакрытьЛог(Лог);
	Лог = Неопределено;
	мСообщенияЛога = Неопределено;
	мСообщенияЛогаПереопределеннойРаскладки = Неопределено;
	ВременныеФайлы.Удалить();
КонецПроцедуры

Процедура Тест_ДолженСоздатьЛоггерПоУмолчанию() Экспорт

	Утверждения.ПроверитьРавенство(УровниЛога.Информация, Лог.Уровень());

КонецПроцедуры

Процедура Тест_ДолженПроверитьУровниВывода() Экспорт

	Утверждения.ПроверитьРавенство(0, УровниЛога.Отладка);
	Утверждения.ПроверитьРавенство(1, УровниЛога.Информация);
	Утверждения.ПроверитьРавенство(2, УровниЛога.Предупреждение);
	Утверждения.ПроверитьРавенство(3, УровниЛога.Ошибка);
	Утверждения.ПроверитьРавенство(4, УровниЛога.КритичнаяОшибка);
	Утверждения.ПроверитьРавенство(5, УровниЛога.Отключить);

КонецПроцедуры

Процедура Тест_ДолженПроверитьЧтоЗарегистрированыАппендеры() Экспорт

	// данные типы регистрируются при создании логгера
	ВФайл = Новый ВыводЛогаВФайл();
	Утверждения.ПроверитьРавенство(Тип("ВыводЛогаВФайл"), ТипЗнч(ВФайл));

	Консоль = Новый ВыводЛогаВКонсоль();
	Утверждения.ПроверитьРавенство(Тип("ВыводЛогаВКонсоль"), ТипЗнч(Консоль));

КонецПроцедуры

Процедура Тест_ДолженПроверитьЧтоУровниВыводаИзменяются() Экспорт

	Утверждения.ПроверитьРавенство(УровниЛога.Информация, Лог.Уровень());

	Лог.УстановитьУровень(УровниЛога.Предупреждение);

	Утверждения.ПроверитьРавенство(УровниЛога.Предупреждение, Лог.Уровень());

КонецПроцедуры

Процедура Тест_ДолженПроверитьЧтоАппендерУстановлен() Экспорт
	ДобавитьСебяКакОбработчикаВывода();
	Лог.Информация("Привет");
	Утверждения.ПроверитьРавенство("ИНФОРМАЦИЯ - "+"Привет", мСообщенияЛога[0]);
КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводБолееПриоритетногоСообщения() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.Информация("Привет");
	Лог.Ошибка("Ошибка");
	Утверждения.ПроверитьРавенство(2, мСообщенияЛога.Количество());
	Утверждения.ПроверитьРавенство("ИНФОРМАЦИЯ - "+"Привет", мСообщенияЛога[0]);
	Утверждения.ПроверитьРавенство("ОШИБКА - "+"Ошибка", мСообщенияЛога[1]);

КонецПроцедуры

Процедура Тест_ДолженПроверитьЧтоНеВыводятсяМенееПриоритетныеСообщения() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Ошибка);
	Лог.Информация("Привет");
	Лог.Ошибка("Ошибка");
	Утверждения.ПроверитьРавенство(1, мСообщенияЛога.Количество());
	Утверждения.ПроверитьРавенство("ОШИБКА - "+"Ошибка", мСообщенияЛога[0]);

КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводОтладки() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Отладка);
	Лог.Отладка("Привет");
	Утверждения.ПроверитьРавенство("ОТЛАДКА - "+"Привет", мСообщенияЛога[0]);

КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводИнформации() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Информация);
	Лог.Информация("Привет");
	Утверждения.ПроверитьРавенство("ИНФОРМАЦИЯ - "+"Привет", мСообщенияЛога[0]);

КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводПредупреждения() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Предупреждение);
	Лог.Предупреждение("Привет");
	Утверждения.ПроверитьРавенство("ПРЕДУПРЕЖДЕНИЕ - "+"Привет", мСообщенияЛога[0]);

КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводОшибки() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Ошибка);
	Лог.Ошибка("Привет");
	Утверждения.ПроверитьРавенство("ОШИБКА - "+"Привет", мСообщенияЛога[0]);

КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводКритичнойОшибки() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.КритичнаяОшибка);
	Лог.КритичнаяОшибка("Привет");
	Утверждения.ПроверитьРавенство("КРИТИЧНАЯОШИБКА - "+"Привет", мСообщенияЛога[0]);

КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводОтладкиЧерезСтрШаблон() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Отладка);
	Лог.Отладка("Привет %1,%2", "Первый", "Второй");
	Утверждения.ПроверитьРавенство("ОТЛАДКА - "+"Привет Первый,Второй", мСообщенияЛога[0]);

КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводИнформацииЧерезСтрШаблон() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Информация);
	Лог.Информация("Привет %1,%2", "Первый", "Второй");
	Утверждения.ПроверитьРавенство("ИНФОРМАЦИЯ - "+"Привет Первый,Второй", мСообщенияЛога[0]);

КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводПредупрежденияЧерезСтрШаблон() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Предупреждение);
	Лог.Предупреждение("Привет %1,%2", "Первый", "Второй");
	Утверждения.ПроверитьРавенство("ПРЕДУПРЕЖДЕНИЕ - "+"Привет Первый,Второй", мСообщенияЛога[0]);

КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводОшибкиЧерезСтрШаблон() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Ошибка);
	Лог.Ошибка("Привет %1,%2", "Первый", "Второй");
	Утверждения.ПроверитьРавенство("ОШИБКА - "+"Привет Первый,Второй", мСообщенияЛога[0]);

КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводКритичнойОшибкиЧерезСтрШаблон() Экспорт

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.КритичнаяОшибка);
	Лог.КритичнаяОшибка("Привет %1,%2", "Первый", "Второй");
	Утверждения.ПроверитьРавенство("КРИТИЧНАЯОШИБКА - "+"Привет Первый,Второй", мСообщенияЛога[0]);

КонецПроцедуры

Процедура ДобавитьСебяКакОбработчикаВывода()

	мСообщенияЛога = Новый Массив;
	Лог.ДобавитьСпособВывода(ЭтотОбъект);

КонецПроцедуры

Процедура Тест_ДолженПроверитьСозданиеИдентификатораВЛоге() Экспорт

	ИД = Лог.ПолучитьИдентификатор();
	Сообщить(ИД);
	Утверждения.Проверить(ЗначениеЗаполнено(ИД));

КонецПроцедуры

Процедура Тест_ДолженПроверитьЗакрытиеЛогаПоСчетчикуСсылок() Экспорт
	ДобавитьСебяКакОбработчикаВывода();
	Лог2 = Логирование.ПолучитьЛог("logos.internal");
	Лог2.Информация("ТестовоеСообщение");
	Утверждения.ПроверитьРавенство(1, мСообщенияЛога.Количество());
	Утверждения.ПроверитьРавенство(Лог, Лог2);
	Логирование.ЗакрытьЛог(Лог); // закрываем в неправильном порядке, но sink должен остаться открыт
	Утверждения.ПроверитьРавенство(1, мСообщенияЛога.Количество());
	Логирование.ЗакрытьЛог(Лог2);
	Утверждения.ПроверитьРавенство(Неопределено, мСообщенияЛога);
КонецПроцедуры

Процедура Тест_ДолженПрочитатьНастройкиЛогированияИзФайла() Экспорт
	
	ФайлНастроек = ВременныеФайлы.НовоеИмяФайла("cfg");
	ЗаписьТекста = Новый ЗаписьТекста(ФайлНастроек);

	ЗаписьТекста.ЗаписатьСтроку("logger.errlog=ERROR"); // простая установка уровня
	ЗаписьТекста.ЗаписатьСтроку("logger.debuglog=DEBUG, debugfile"); // уровень + аппендер
	ЗаписьТекста.ЗаписатьСтроку("appender.debugfile=ВыводЛогаВФайл"); // класс аппендера
	ЗаписьТекста.ЗаписатьСтроку("appender.debugfile.file=/tmp/logostestdebug"); // свойство аппендера
	ЗаписьТекста.ЗаписатьСтроку("appender.debugfile.anotherprop=hello world"); // свойство аппендера
	ЗаписьТекста.Закрыть();

	Настройки = Новый НастройкиЛогирования();
	Настройки.Прочитать(ФайлНастроек);

	НастройкиЛогаОшибок  = Настройки.Получить("errlog");
	Ожидаем.Что(НастройкиЛогаОшибок.Уровень).Равно(УровниЛога.Ошибка);
	Ожидаем.Что(НастройкиЛогаОшибок.СпособыВывода).ИмеетДлину(0);

	НастройкиЛогаОтладки = Настройки.Получить("debuglog");
	Ожидаем.Что(НастройкиЛогаОтладки.Уровень).Равно(УровниЛога.Отладка);
	Ожидаем.Что(НастройкиЛогаОтладки.СпособыВывода).ИмеетДлину(1);
	
	ОписаниеАппендера = НастройкиЛогаОтладки.СпособыВывода["debugfile"];
	Ожидаем.Что(ОписаниеАппендера.Класс).Равно("ВыводЛогаВФайл");
	Ожидаем.Что(ОписаниеАппендера.Свойства["file"]).Равно("/tmp/logostestdebug");
	Ожидаем.Что(ОписаниеАппендера.Свойства["anotherprop"]).Равно("hello world");

КонецПроцедуры

Процедура Тест_ДолженПроверитьРаскладку() Экспорт
	
	мПереопределитьВывод = Ложь;
	мСообщенияЛогаПереопределеннойРаскладки = Новый Массив;

	Утверждения.ПроверитьНеРавенство( Лог.ПолучитьРаскладку(), ЭтотОбъект, "Раскладка должна быть стандартная" );
	Лог.УстановитьРаскладку( ЭтотОбъект );	
	Утверждения.ПроверитьРавенство( Лог.ПолучитьРаскладку(), ЭтотОбъект, "Раскладка должна быть переопределена" );

	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Отладка);
	Лог.Отладка("Привет");
	Утверждения.ПроверитьРавенство("ЭтоПрефикс.ОТЛАДКА - "+"Привет", мСообщенияЛога[0]);
	Утверждения.ПроверитьРавенство(мСообщенияЛогаПереопределеннойРаскладки.Количество(), 0);
	Лог.Информация("Привет");
	Утверждения.ПроверитьРавенство("ЭтоПрефикс.ИНФОРМАЦИЯ - "+"Привет", мСообщенияЛога[1]);
	Утверждения.ПроверитьРавенство(мСообщенияЛогаПереопределеннойРаскладки.Количество(), 0);
	Лог.Предупреждение("Привет");
	Утверждения.ПроверитьРавенство("ЭтоПрефикс.ПРЕДУПРЕЖДЕНИЕ - "+"Привет", мСообщенияЛога[2]);
	Утверждения.ПроверитьРавенство(мСообщенияЛогаПереопределеннойРаскладки.Количество(), 0);
	Лог.Ошибка("Привет");
	Утверждения.ПроверитьРавенство("ЭтоПрефикс.ОШИБКА - "+"Привет", мСообщенияЛога[3]);
	Утверждения.ПроверитьРавенство(мСообщенияЛогаПереопределеннойРаскладки.Количество(), 0);
	Лог.КритичнаяОшибка("Привет");
	Утверждения.ПроверитьРавенство("ЭтоПрефикс.КРИТИЧНАЯОШИБКА - "+"Привет", мСообщенияЛога[4]);
	Утверждения.ПроверитьРавенство(мСообщенияЛогаПереопределеннойРаскладки.Количество(), 0);

	мСообщенияЛога.Очистить();
	мПереопределитьВывод = Истина;

	Лог.Отладка("Привет");
	Утверждения.ПроверитьРавенство("ЭтоПрефикс.ОТЛАДКА - "+"Привет", мСообщенияЛогаПереопределеннойРаскладки[0]);
	Утверждения.ПроверитьРавенство(мСообщенияЛога.Количество(), 0);
	Лог.Информация("Привет");
	Утверждения.ПроверитьРавенство("ЭтоПрефикс.ИНФОРМАЦИЯ - "+"Привет", мСообщенияЛогаПереопределеннойРаскладки[1]);
	Утверждения.ПроверитьРавенство(мСообщенияЛога.Количество(), 0);
	Лог.Предупреждение("Привет");
	Утверждения.ПроверитьРавенство("ЭтоПрефикс.ПРЕДУПРЕЖДЕНИЕ - "+"Привет", мСообщенияЛогаПереопределеннойРаскладки[2]);
	Утверждения.ПроверитьРавенство(мСообщенияЛога.Количество(), 0);
	Лог.Ошибка("Привет");
	Утверждения.ПроверитьРавенство("ЭтоПрефикс.ОШИБКА - "+"Привет", мСообщенияЛогаПереопределеннойРаскладки[3]);
	Утверждения.ПроверитьРавенство(мСообщенияЛога.Количество(), 0);
	Лог.КритичнаяОшибка("Привет");
	Утверждения.ПроверитьРавенство("ЭтоПрефикс.КРИТИЧНАЯОШИБКА - "+"Привет", мСообщенияЛогаПереопределеннойРаскладки[4]);
	Утверждения.ПроверитьРавенство(мСообщенияЛога.Количество(), 0);

	мПереопределитьВывод = Ложь;
	мСообщенияЛогаПереопределеннойРаскладки.Очистить();
	Лог.УстановитьРаскладку( Новый ОсновнаяРаскладкаСообщения );

КонецПроцедуры

////////////////////////////
// Методы аппендера

Процедура Вывести(Знач Сообщение) Экспорт
	мСообщенияЛога.Добавить(Сообщение);
КонецПроцедуры

Процедура Закрыть() Экспорт
	мСообщенияЛога = Неопределено;
КонецПроцедуры

////////////////////////////
// Методы раскладки

Функция Форматировать(Знач Уровень, Знач Сообщение, СтандартнаяОбработка) Экспорт
	
	Если Не мПереопределитьВывод Тогда

		// Добавляем префикс для проверки переопределения
		Возврат СтрШаблон("ЭтоПрефикс.%1 - %2", УровниЛога.НаименованиеУровня(Уровень), Сообщение);

	Иначе

		СтандартнаяОбработка = Ложь;

		форматированноеСообщение = СтрШаблон("ЭтоПрефикс.%1 - %2", УровниЛога.НаименованиеУровня(Уровень), Сообщение);
		мСообщенияЛогаПереопределеннойРаскладки.Добавить(форматированноеСообщение);
		
		Возврат "Эта строка не используется и никуда не выводится!!!";

	КонецЕсли;
	
КонецФункции