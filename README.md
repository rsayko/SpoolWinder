# SpoolWinder v2.5  
3d print wire winder and connect two spools of used plastic  
**NEW** Додав коннектори для старлінк. Файл StarLink.scad  
![startlink](https://github.com/rsayko/SpoolWinder/assets/33004022/777c5e76-3cb0-4835-b4d7-b9f4f6db629d)  

**З'єднай дві пусті катушки від пластику та надрукуй тримачку для кабелю. Треба дві однакові катушки від пластику. Зроблено спеціально для ДрукАрмії.** https://drukarmy.org.ua/  
![image](https://github.com/rsayko/SpoolWinder/assets/33004022/825e9118-9ffa-4563-9c80-87d6ea52dae9)  
![render](https://github.com/rsayko/SpoolWinder/assets/33004022/d21030c8-96f8-4e6a-a57f-7b73a93c5a7f)  
![cover2](https://github.com/rsayko/SpoolWinder/assets/33004022/87491fe4-a555-45b0-994e-f09e5aa76bc3)





![cover](https://github.com/rsayko/SpoolWinder/assets/33004022/f381b260-6627-48bb-9219-fec0f092bd63)  


Надихнувся цим проектом, різниця в тому що завдяки OpenScad можна використовувати будь які катушки.  
![image](https://github.com/rsayko/SpoolWinder/assets/33004022/f3c3b2ca-ada6-4ce1-86a3-4d1e30293ba1)  
## Короткий FAQ

 
Q: **Які параметри друку?**  
A: Стантартні, 3 стінки, 20% заповнення. Для гвинтів раджу збільшити заповнення. Може якщо катушка на 3кг то заповнення більше, треба тестувати.   
Q: **Чого б не використовувати пусті катушки на 3кг?**  
A: Не у всіх є такі катушки, також це хороший спосіб утилізувати їх на щось корисне, а ще з ручкою буде зручніше намотувати кабель.  
Q: **Чи треба допомога?**  
A: Так, вітається будь яка допомога з наіменуванням параметрів або інструкцією. Також потрібно покращити майже всі функції і оптимізувати код.  
*більше в кінці по мірі надходження питань*

## Що буде в наступній версії  
1. Вмонтовані гнізда для кабелів StarLink Done!  
2. Можливість використовувати катушки різних розмірів  

## Коротка інструкція
1. Завантажуєш OpenScad https://openscad.org/downloads.html  
2. Скачуєш проект SpoolWinder https://github.com/rsayko/SpoolWinder  
3. Відкриваєш файл SpoolWireWinder2.scad (файл threads.scad має бути в тій самій папці де і SpoolWinder2.scad)
4. Вводиш параметри на панелі зправа. Поміряй все у міліметрах

   ![basic](https://github.com/rsayko/SpoolWinder/assets/33004022/467836b5-1f86-4d10-9fe8-25d6e68f0451)
6. Натискаєш кнопку кубика з пісочним годинником
   ![image](https://github.com/rsayko/SpoolWinder/assets/33004022/5eea4650-0ed0-4a29-9956-277f74490303)


7. Чекаєш декілька хвилин (може бути таке що ОпенСкад виключиться, таке буває, спробуй ще)
8. Натискаєш кнопку STL
![image](https://github.com/rsayko/SpoolWinder/assets/33004022/b8eb0504-e6ab-4317-9dd3-973eb66b6019)

9. Відкриваєш у слайсері
10. Якщо слайсей не підтримує розєднання обєкту то скористайся плагіном, наприклад для Cura є плагін MeshTools  

## Збірка та постобробка  
![image](https://github.com/rsayko/SpoolWinder/assets/33004022/81b84dfa-db19-46e0-a35a-00c850ee4597)  

Якщо надрукована розділена версія то зняти підтримки і склеїти дві частини. На відео нище показан весь процес.  
_для зручності показав на зменшеній моделі_  

https://www.youtube.com/watch?v=EH7lqZbjNUA

[![SpoolWinder asembly](http://img.youtube.com/vi/EH7lqZbjNUA/0.jpg)](http://www.youtube.com/watch?v=EH7lqZbjNUA)

## Параметри - Детальна інструкція  
### Main
Основні параметри це **spool diameter**, **hole diameter** та **spool width**. Міряєш і вводиш ці параметри на панелі зправа.  
До речі, **spool diameter** краще ввести на мілліметр-два більше, так дві катушки точно помістяться на основу.  
![main](https://github.com/rsayko/SpoolWinder/assets/33004022/8bee8533-e11f-4f4f-a78e-b274435169b9)


При швидкому рендері ![image](https://github.com/rsayko/SpoolWinder/assets/33004022/cc82cee9-20a7-40d7-8ec4-ccdd9d083aff) будуть артефакти, нічого страшного, при фінальному ![image](https://github.com/rsayko/SpoolWinder/assets/33004022/d7eeab8e-e63c-4231-8353-298401666b9b)
 їх не буде.  


#### plate height  
Це рамка або додатковий матеріал який буде тримати катушку  
![plate_height](https://github.com/rsayko/SpoolWinder/assets/33004022/f8c15e56-7763-4c98-9183-7bc893c3e260)  

на розмір **spool diameter**, **hole diameter** та **spool width** це ніяк не впливає, але впливає на товщину стінки самої тримачки, товщина стінки буде plate_height/2 (TBD можливо треба додати параметр handle_base_wall_ratio default 0.5 або handle_base_wall_thickness default plate_height/2)  
![image](https://github.com/rsayko/SpoolWinder/assets/33004022/94bffaad-ce87-4b33-ae3f-89d1b77f8335)

#### hollow_plate  
Параметр зробить дирку в основі, це зекономить час та пластик, але послабить саму структуру  
![hollow_plate](https://github.com/rsayko/SpoolWinder/assets/33004022/7707e0d1-1349-4b1a-afa1-c46d22dd5886)


### Split   
Звісно мало хто має 3д принтер з великою площиною друку, тому був додан цей параметр. Він розділить основу і додасть спеціальні коннектори, вони мають накладатись один на одного, залишаючи трохи місця для клею. Найкращий клей для PLA буде на основі cyanoacrylate (зазвичай супер-клей). Для ABS підходить майже будь який супер або епоксидний клей.
TBD  
#### split base   
TBD  
#### number of connectors  
TBD  
### Holder base  
TBD  
#### hollow base  
TBD  
#### holder top fillet  
TBD  
#### holder bottom fillet  
TBD  
### Handle  
TBD  
#### handle diameter  
TBD  
#### handle distance  
TBD  
#### handle margin  
TBD  
#### handle champfer  
TBD  
#### separate handle  
TBD  
### Other  
TBD  
#### wall thickness  
TBD  
#### render quality  
Якість рендеру. Якщо треба часто змінювати якісь параметри і дивитись на результат то раджу встановити **render quality** на 6 (так не буде лагати), перед тим як робити фiнальний рентер, раджу встановити на 24  

![render quality](https://github.com/rsayko/SpoolWinder/assets/33004022/7829d8d7-6dcb-4f88-81ae-e5b463957a27)

#### nozzle diameter  
TBD  


## Фото  
![photo_5204053491805441663_y](https://github.com/rsayko/SpoolWinder/assets/33004022/8e04ebcb-f4af-4fe6-99bd-2581abcc033b)  
![photo_5206417746747838071_y](https://github.com/rsayko/SpoolWinder/assets/33004022/6295ee37-015e-41c5-9ca6-540c47093b9a)  
![photo_5204053491805441670_y](https://github.com/rsayko/SpoolWinder/assets/33004022/51f0f8fe-52ad-4e21-a860-ad9d419924cd)  

