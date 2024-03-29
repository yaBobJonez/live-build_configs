# Еррата

Тут зазначений перелік фіч чи програм, які Ви хотіли, але я не зміг встановити чи налаштувати через зазначені причини. Для деяких вказані можливі альтернативи (рішення).

## Календар

Зараз дефолтний календар від KDE Kalendar у процесі розділення на три програми [Merkuro](https://www.reddit.com/r/kde/comments/1604ik6/a_small_explainer_graphic_about_kalendar_merkuro/?rdt=52976): Mail, Calendar, Contacts. На Debian в репозиторії є поки лише стара версія, _яка вже знову працює_, проте _повільна і важка_. Ця версія образу не включає Kalendar, а новий [Merkuro Calendar](https://invent.kde.org/pim/merkuro) напевно буде доступний з _Березня 2024_ (після виходу KDE Plasma 6 у Лютому).

**Можливі рішення:**

- Дочекатися виходу нового календаря
- Використовувати образ зі старим (або встановити його — `kalendar`, `kdepim-addons`)
- Використовувати інші календарі типу Calindori

## Відбитки пальців

Як я зазначав у Формі, сканери відбитків пальців (особливо такі, що не проводити, а просто торкатись) є поки болючою темою на Лінуксі. Виробники самих сканерів рідко роблять драйвери, тому є проєкт волонтерів-програмістів fprint, але фізично вони не можуть встигати підтримувати тисячі різних сканерів.

На даний момент, у Серпні 2023 виявився "критичний" баг в libfprint'і, тому Debian мейнтейнери видалили _тимчасово_ (доки не пофіксять) його з нових версій. Наразі підтримка відбитків пальців на Debian Trixie _офіційно_ неможливо.

Якщо бажаєте **ризикнути**, можна спробувати встановити версію fprintd/libfprint з "нестабільного" релізу Debian: https://wiki.debian.org/DebianUnstable#Can_I_use_Sid_packages_on_.22testing.22.3F

**UPD:** з 2023-12-23 нова версія fprintd [чекає на реліз](https://tracker.debian.org/pkg/fprintd). Поки не вдається скомпілювати її на ppc64el, і немає результатів мінімальних тестів, але якщо вже це пофіксять, то мабуть скоро повернеться підтримка відбитків пальців.
