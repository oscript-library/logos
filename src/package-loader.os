﻿
Процедура ПриЗагрузкеБиблиотеки(Путь, СтандартнаяОбработка, Отказ)
	
	ФайлМанифеста = Новый Файл(Путь + "/lib.config");
	
	Если ФайлМанифеста.Существует() Тогда
		СтандартнаяОбработка = Ложь;
		ОбработатьМанифест(ФайлМанифеста.ПолноеИмя, Путь, Отказ);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработатьМанифест(Знач Файл, Знач Путь, Отказ)
	
	Чтение = Новый ЧтениеXML;
	Чтение.ОткрытьФайл(Файл);
	Чтение.ПерейтиКСодержимому();
	
	Если Чтение.ЛокальноеИмя <> "package-def" Тогда
		Отказ = Истина;
		Чтение.Закрыть();
		Возврат;
	КонецЕсли;
	
	Пока Чтение.Прочитать() и Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента Цикл
		
		Если Чтение.ЛокальноеИмя = "class" Тогда
			ФайлКласса = Новый Файл(Путь + "/" + Чтение.ЗначениеАтрибута("file"));
			Если ФайлКласса.Существует() и ФайлКласса.ЭтоФайл() Тогда
				Идентификатор = Чтение.ЗначениеАтрибута("name");
				Если Не ПустаяСтрока(Идентификатор) Тогда
					ДобавитьКласс(ФайлКласса.ПолноеИмя, Идентификатор);
				КонецЕсли;
			КонецЕсли;
			
			Чтение.Прочитать(); // в конец элемента
		КонецЕсли;

		Если Чтение.ЛокальноеИмя = "module" Тогда
			ФайлКласса = Новый Файл(Путь + "/" + Чтение.ЗначениеАтрибута("file"));
			Если ФайлКласса.Существует() и ФайлКласса.ЭтоФайл() Тогда
				Идентификатор = Чтение.ЗначениеАтрибута("name");
				Если Не ПустаяСтрока(Идентификатор) Тогда
					ДобавитьМодуль(ФайлКласса.ПолноеИмя, Идентификатор);
				КонецЕсли;
			КонецЕсли;
			
			Чтение.Прочитать(); // в конец элемента
		КонецЕсли;
		
	КонецЦикла;
	
	Чтение.Закрыть();
	
КонецПроцедуры
