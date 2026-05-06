"""
Hookah Mix Master — Seed data generator.

Генерує JSON-файл з ~100 топових табаками з 8 брендів.
Використовує canonical schema придатну для прямого імпорту у Firestore.
"""
import json
from datetime import datetime, timezone
from pathlib import Path


def now_iso():
    return datetime.now(timezone.utc).isoformat()


# ============================================================================
# BRANDS
# ============================================================================
BRANDS = [
    {
        "id": "al_fakher",
        "name": "Al Fakher",
        "country": "AE",
        "countryName": {"en": "United Arab Emirates", "uk": "ОАЕ"},
        "leafType": "blonde",
        "foundedYear": 1999,
        "description": {
            "en": "Premium UAE-based brand, world's #1 shisha. Mild Virginia blonde leaf, ~0.05% nicotine. Ideal for beginners and intermediate smokers.",
            "uk": "Преміальний бренд з ОАЕ, №1 у світі. М'який Virginia blonde, ~0.05% нікотину. Ідеально для початківців та середнього рівня.",
        },
        "popularity": 100,
    },
    {
        "id": "adalya",
        "name": "Adalya",
        "country": "TR",
        "countryName": {"en": "Turkey", "uk": "Туреччина"},
        "leafType": "blonde",
        "foundedYear": 2003,
        "description": {
            "en": "Largest Turkish shisha producer, second largest globally. Golden Virginia blonde leaf with rich, juicy flavors. EU-compliant standards.",
            "uk": "Найбільший турецький виробник, другий у світі. Золотий Virginia blonde з насиченими соковитими смаками. Стандарти EU.",
        },
        "popularity": 95,
    },
    {
        "id": "fumari",
        "name": "Fumari",
        "country": "US",
        "countryName": {"en": "USA", "uk": "США"},
        "leafType": "blonde",
        "foundedYear": 1997,
        "description": {
            "en": "California-based premium brand, blonde Virginia leaf. Known for resealable packaging, true-to-taste flavors and small-batch quality.",
            "uk": "Каліфорнійський преміум-бренд, blonde Virginia. Відомий упаковкою з застібкою, точними смаками та малими партіями.",
        },
        "popularity": 88,
    },
    {
        "id": "tangiers",
        "name": "Tangiers",
        "country": "US",
        "countryName": {"en": "USA", "uk": "США"},
        "leafType": "dark",
        "foundedYear": 2005,
        "description": {
            "en": "Cult dark-leaf brand with intense flavors and high nicotine. Requires experienced packing technique. Long sessions, deep clouds.",
            "uk": "Культовий бренд темного листа, інтенсивні смаки та високий нікотин. Потребує досвідченого пакування. Довгі сесії, густі хмари.",
        },
        "popularity": 75,
    },
    {
        "id": "starbuzz",
        "name": "Starbuzz",
        "country": "US",
        "countryName": {"en": "USA", "uk": "США"},
        "leafType": "blonde",
        "foundedYear": 2005,
        "description": {
            "en": "California premium brand, famous for Blue Mist. Sweet, candy-forward flavor profiles, blonde leaf with smooth burn.",
            "uk": "Каліфорнійський преміум-бренд, славиться Blue Mist. Солодкі, цукеркові профілі смаків, blonde leaf з рівним нагрівом.",
        },
        "popularity": 80,
    },
    {
        "id": "mazaya",
        "name": "Mazaya",
        "country": "JO",
        "countryName": {"en": "Jordan", "uk": "Йорданія"},
        "leafType": "blonde",
        "foundedYear": 2006,
        "description": {
            "en": "Jordanian brand offering excellent quality at affordable price. Fine-cut blonde leaf, juicy and beginner-friendly.",
            "uk": "Йорданський бренд з хорошою якістю за доступною ціною. Дрібно нарізаний blonde leaf, соковитий, для початківців.",
        },
        "popularity": 70,
    },
    {
        "id": "nakhla",
        "name": "Nakhla",
        "country": "EG",
        "countryName": {"en": "Egypt", "uk": "Єгипет"},
        "leafType": "dark",
        "foundedYear": 1913,
        "description": {
            "en": "Oldest hookah tobacco brand in the world. Classic Egyptian dark leaf with traditional flavors. Higher nicotine, authentic experience.",
            "uk": "Найстаріший бренд у світі. Класичний єгипетський темний лист з традиційними смаками. Вищий нікотин, автентичний досвід.",
        },
        "popularity": 78,
    },
    {
        "id": "trifecta",
        "name": "Trifecta",
        "country": "US",
        "countryName": {"en": "USA", "uk": "США"},
        "leafType": "blonde",  # also offers dark
        "foundedYear": 2017,
        "description": {
            "en": "Modern US brand offering both blonde and dark leaf. Innovative flavor profiles including dessert and complex blends.",
            "uk": "Сучасний американський бренд з blonde та dark leaf. Інноваційні профілі смаків включаючи десертні та складні блєнди.",
        },
        "popularity": 72,
    },
]

# ============================================================================
# TASTE NOTES & CATEGORIES (canonical taxonomy)
# ============================================================================
# flavorCategories: high-level (для фільтрації UI)
#   fruity, citrus, mint, sweet, dessert, spice, floral, herbal, beverage, tobacco
#
# tasteNotes: granular tags (для алгоритму матчингу міксів)
#   apple, watermelon, mint, lemon, ... — конкретні інгредієнти
#
# tasteProfile: 0-5 scale на 6 осях для smart matching
#   sweet, sour, fresh (cooling), spicy, bitter, floral

def tobacco(
    brand_id,
    name_en,
    name_uk,
    flavor_categories,
    taste_notes,
    taste_profile,
    strength,
    description_en,
    description_uk=None,
    popularity=50,
    leaf_type=None,
):
    """Helper to build a tobacco record with sensible defaults."""
    brand = next(b for b in BRANDS if b["id"] == brand_id)
    safe_id = name_en.lower().replace(" ", "_").replace("'", "").replace("-", "_")
    return {
        "id": f"{brand_id}__{safe_id}",
        "brand": {
            "id": brand["id"],
            "name": brand["name"],
            "country": brand["country"],
        },
        "name": {
            "en": name_en,
            "uk": name_uk,
            "original": name_en,
        },
        "leafType": leaf_type or brand["leafType"],
        "strength": strength,  # 1-5
        "flavorCategories": flavor_categories,
        "tasteNotes": taste_notes,
        "tasteProfile": taste_profile,  # {sweet, sour, fresh, spicy, bitter, floral}: 0-5
        "description": {
            "en": description_en,
            "uk": description_uk or description_en,
        },
        "imageUrl": None,  # to be filled later via Firebase Storage
        "popularity": popularity,  # 0-100
        "availability": {
            "ua": {
                "available": None,  # to be filled via UA shop scrapers in v1.1
                "shops": [],
                "lastChecked": None,
            },
        },
        "sources": [
            {"name": "manual_seed_v1", "verified": True},
        ],
        "createdAt": now_iso(),
        "updatedAt": now_iso(),
    }


def profile(sweet=0, sour=0, fresh=0, spicy=0, bitter=0, floral=0):
    return {
        "sweet": sweet,
        "sour": sour,
        "fresh": fresh,  # cooling/menthol
        "spicy": spicy,
        "bitter": bitter,
        "floral": floral,
    }


# ============================================================================
# AL FAKHER (~25 flavors)
# ============================================================================
AL_FAKHER = [
    tobacco("al_fakher", "Double Apple", "Подвійне яблуко",
            ["fruity", "spice"], ["apple", "anise", "licorice"],
            profile(sweet=4, sour=1, spicy=2),
            strength=2,
            description_en="Classic anise-infused apple flavor. The flagship of hookah world — sweet apple with herbal licorice undertone.",
            description_uk="Класичний смак яблука з анісом. Флагман кальянного світу — солодке яблуко з нотами лакриці.",
            popularity=98),

    tobacco("al_fakher", "Mint", "М'ята",
            ["mint"], ["mint", "menthol"],
            profile(fresh=5),
            strength=2,
            description_en="Pure intense mint, the universal mixer. Cool, refreshing, pairs with everything.",
            description_uk="Чиста інтенсивна м'ята, універсальний міксер. Прохолодна, свіжа, поєднується з усім.",
            popularity=95),

    tobacco("al_fakher", "Two Apples", "Два яблука",
            ["fruity"], ["apple", "green_apple"],
            profile(sweet=3, sour=2),
            strength=2,
            description_en="Sweet red and tart green apples blend without anise. Cleaner apple profile than Double Apple.",
            description_uk="Суміш солодкого червоного та кислого зеленого яблук без анісу. Чистіший яблучний профіль ніж Double Apple.",
            popularity=85),

    tobacco("al_fakher", "Peach", "Персик",
            ["fruity"], ["peach"],
            profile(sweet=4, sour=1),
            strength=2,
            description_en="Authentic ripe peach with smooth juicy finish. One of best-selling fruit flavors.",
            description_uk="Автентичний стиглий персик з соковитим післясмаком. Один з топ-продажів фруктових смаків.",
            popularity=92),

    tobacco("al_fakher", "Grape with Mint", "Виноград з м'ятою",
            ["fruity", "mint"], ["grape", "mint"],
            profile(sweet=3, fresh=3),
            strength=2,
            description_en="Sweet grape balanced with cool mint — perfect summer session.",
            description_uk="Солодкий виноград з прохолодною м'ятою — ідеальна літня сесія.",
            popularity=88),

    tobacco("al_fakher", "Lemon with Mint", "Лимон з м'ятою",
            ["citrus", "mint"], ["lemon", "mint"],
            profile(sour=4, fresh=3),
            strength=2,
            description_en="Zesty lemon with cooling mint finish. Crisp and refreshing.",
            description_uk="Цитрусовий лимон з прохолодним фінішем м'яти. Свіжий та бадьорий.",
            popularity=86),

    tobacco("al_fakher", "Watermelon with Mint", "Кавун з м'ятою",
            ["fruity", "mint"], ["watermelon", "mint"],
            profile(sweet=3, fresh=3),
            strength=2,
            description_en="Juicy summer watermelon with refreshing cool finish.",
            description_uk="Соковитий літній кавун з прохолодним фінішем.",
            popularity=84),

    tobacco("al_fakher", "Blueberry with Mint", "Чорниця з м'ятою",
            ["fruity", "mint"], ["blueberry", "mint"],
            profile(sweet=3, fresh=3),
            strength=2,
            description_en="Sweet blueberries with cool mint and a slight citrus brightness.",
            description_uk="Солодка чорниця з холодною м'ятою та легкою цитрусовою свіжістю.",
            popularity=80),

    tobacco("al_fakher", "Magic Love", "Меджик Лав",
            ["fruity", "mint"], ["melon", "passionfruit", "mint", "spice"],
            profile(sweet=4, sour=1, fresh=2, spicy=1),
            strength=2,
            description_en="Sweet melon, fresh mint, tangy passionfruit and a hint of secret spices. Iconic.",
            description_uk="Солодка диня, свіжа м'ята, кислий маракуйя та натяк секретних спецій. Легендарний.",
            popularity=90),

    tobacco("al_fakher", "Diamond Dust", "Даймонд Даст",
            ["fruity", "citrus"], ["orange", "raspberry", "pineapple", "lime"],
            profile(sweet=3, sour=3),
            strength=2,
            description_en="Sparkling exotic blend of orange, raspberry, pineapple and lime.",
            description_uk="Іскристий екзотичний бленд апельсина, малини, ананаса та лайма.",
            popularity=82),

    tobacco("al_fakher", "Cappuccino", "Капучино",
            ["dessert", "beverage"], ["coffee", "cream"],
            profile(sweet=3, bitter=2),
            strength=2,
            description_en="Refined coffee blend with creamy aromatic notes. Perfect for evening sessions.",
            description_uk="Витончений кавовий бленд з вершково-ароматичними нотами. Ідеально для вечірніх сесій.",
            popularity=70),

    tobacco("al_fakher", "Mango", "Манго",
            ["fruity"], ["mango"],
            profile(sweet=4),
            strength=2,
            description_en="Rich, ripe mango with a creamy tropical finish.",
            description_uk="Насичене стигле манго з кремовим тропічним післясмаком.",
            popularity=78),

    tobacco("al_fakher", "Guava", "Гуава",
            ["fruity"], ["guava"],
            profile(sweet=3, sour=1),
            strength=2,
            description_en="Tropical guava blend with earthy and woody undertones.",
            description_uk="Тропічна гуава з земляними та деревними нотами.",
            popularity=68),

    tobacco("al_fakher", "Hubbly Bubble Gum", "Бабл Гам",
            ["sweet"], ["bubblegum"],
            profile(sweet=5),
            strength=2,
            description_en="Classic sweet bubble gum flavor — childhood nostalgia in clouds.",
            description_uk="Класична жуйка — дитяча ностальгія у хмарах.",
            popularity=72),

    tobacco("al_fakher", "Cherry with Mint", "Вишня з м'ятою",
            ["fruity", "mint"], ["cherry", "mint"],
            profile(sweet=3, sour=1, fresh=3),
            strength=2,
            description_en="Bold cherry flavor with subtle refreshing mint coolness.",
            description_uk="Соковита вишня з прохолодою м'яти.",
            popularity=75),

    tobacco("al_fakher", "Orange with Mint", "Апельсин з м'ятою",
            ["citrus", "mint"], ["orange", "mint"],
            profile(sweet=2, sour=2, fresh=3),
            strength=2,
            description_en="Zesty orange paired with cooling mint for a refreshing citrus session.",
            description_uk="Цитрусовий апельсин з прохолодною м'ятою для свіжої сесії.",
            popularity=76),

    tobacco("al_fakher", "Grapefruit with Mint", "Грейпфрут з м'ятою",
            ["citrus", "mint"], ["grapefruit", "mint"],
            profile(sour=4, fresh=3, bitter=1),
            strength=2,
            description_en="Tart grapefruit with sharp refreshing mint. Energizing and crisp.",
            description_uk="Терпкий грейпфрут з гострою м'ятою. Бадьорить та освіжає.",
            popularity=74),

    tobacco("al_fakher", "Mint with Cream", "М'ята з вершками",
            ["mint", "dessert"], ["mint", "cream"],
            profile(sweet=2, fresh=4),
            strength=2,
            description_en="Cool mint blended with rich cream for a unique dessert-like minty session.",
            description_uk="Прохолодна м'ята з насиченими вершками — десертна м'ятна сесія.",
            popularity=68),

    tobacco("al_fakher", "Cinnamon", "Кориця",
            ["spice"], ["cinnamon"],
            profile(sweet=2, spicy=4),
            strength=2,
            description_en="Sweet warming cinnamon, perfect for autumn-winter mixing.",
            description_uk="Солодка зігріваюча кориця, ідеальна для осінньо-зимових міксів.",
            popularity=60),

    tobacco("al_fakher", "Vanilla", "Ваніль",
            ["dessert"], ["vanilla"],
            profile(sweet=4),
            strength=2,
            description_en="Smooth, creamy vanilla — versatile mixer for dessert blends.",
            description_uk="М'яка кремова ваніль — універсальний міксер для десертних блендів.",
            popularity=65),

    tobacco("al_fakher", "Berry", "Ягоди",
            ["fruity"], ["berry", "raspberry", "blackberry"],
            profile(sweet=3, sour=2),
            strength=2,
            description_en="Rich intense flavors of mixed berries with tart aftertaste.",
            description_uk="Насичений смак суміші ягід з терпким післясмаком.",
            popularity=70),

    tobacco("al_fakher", "Coconut", "Кокос",
            ["dessert"], ["coconut"],
            profile(sweet=3),
            strength=2,
            description_en="Cool creamy coconut, a tropical mixer for fruit blends.",
            description_uk="Прохолодний кремовий кокос, тропічний міксер для фруктів.",
            popularity=58),

    tobacco("al_fakher", "Pineapple", "Ананас",
            ["fruity"], ["pineapple"],
            profile(sweet=3, sour=2),
            strength=2,
            description_en="Bright juicy pineapple with tropical sweetness.",
            description_uk="Яскравий соковитий ананас з тропічною солодкістю.",
            popularity=72),

    tobacco("al_fakher", "Lucid Dream", "Lucid Dream",
            ["fruity", "mint"], ["blueberry", "lemon", "mint"],
            profile(sweet=3, sour=2, fresh=3),
            strength=2,
            description_en="Sweet blueberry with minty lemon — vivid and refreshing.",
            description_uk="Солодка чорниця з м'ятним лимоном — яскравий та свіжий.",
            popularity=74),

    tobacco("al_fakher", "Harvest Moon", "Harvest Moon",
            ["herbal", "citrus"], ["green_tea", "lemon", "lime"],
            profile(sweet=2, sour=3, bitter=1),
            strength=2,
            description_en="Mesmerizing green tea with hints of lemon and lime. Unique and elegant.",
            description_uk="Магнетичний зелений чай з лимоном та лаймом. Унікально та елегантно.",
            popularity=66),
]

# ============================================================================
# ADALYA (~20 flavors)
# ============================================================================
ADALYA = [
    tobacco("adalya", "Love 66", "Лав 66",
            ["fruity", "mint", "floral"], ["watermelon", "passionfruit", "honeydew", "mint"],
            profile(sweet=4, sour=1, fresh=2, floral=2),
            strength=2,
            description_en="Iconic blend of passion fruit, honeydew melon, watermelon and mint with a floral undertone. Adalya's flagship.",
            description_uk="Легендарний бленд маракуйї, медової дині, кавуна та м'яти з квітковими нотами. Флагман Adalya.",
            popularity=98),

    tobacco("adalya", "Lady Killer", "Lady Killer",
            ["fruity", "mint"], ["melon", "mango", "berry", "mint"],
            profile(sweet=4, fresh=2),
            strength=2,
            description_en="Tropical-berry layered profile with melon, mango, forest berries and clean mint finish.",
            description_uk="Тропічно-ягідний профіль з динею, манго, лісовими ягодами та чистим фінішем м'яти.",
            popularity=85),

    tobacco("adalya", "Skyfall", "Скайфолл",
            ["fruity", "mint"], ["watermelon", "peach", "mint"],
            profile(sweet=4, fresh=2),
            strength=2,
            description_en="Watermelon, peach and mint — mellow fruit sweetness with cooling finish.",
            description_uk="Кавун, персик та м'ята — м'яка фруктова солодкість з прохолодою.",
            popularity=83),

    tobacco("adalya", "Mi Amor", "Мі Амор",
            ["fruity", "mint"], ["pineapple", "banana", "mint"],
            profile(sweet=4, sour=1, fresh=2),
            strength=2,
            description_en="Tropical pineapple and ripe banana balanced with cool mint.",
            description_uk="Тропічний ананас та стиглий банан з прохолодною м'ятою.",
            popularity=78),

    tobacco("adalya", "Ice Bonbon", "Айс Бонбон",
            ["mint", "citrus", "sweet"], ["menthol", "lemon", "candy"],
            profile(sweet=3, sour=2, fresh=4),
            strength=2,
            description_en="Refreshing menthol candy with citrus undertones. Energizing and crisp.",
            description_uk="Освіжаюча ментолова цукерка з цитрусом. Бадьорить.",
            popularity=80),

    tobacco("adalya", "Berlin Nights", "Берлін Найтс",
            ["fruity", "mint"], ["peach", "mint"],
            profile(sweet=4, fresh=3),
            strength=2,
            description_en="Juicy peach paired with fresh mint — clean stone-fruit cool.",
            description_uk="Соковитий персик зі свіжою м'ятою — чиста кістянка з прохолодою.",
            popularity=76),

    tobacco("adalya", "Hawaii", "Гаваї",
            ["fruity", "citrus"], ["lemon", "lime", "green_tea"],
            profile(sour=3, bitter=1, fresh=2),
            strength=2,
            description_en="Citrus blend of lemon and lime with green tea base.",
            description_uk="Цитрусовий бленд лимона і лайма з основою зеленого чаю.",
            popularity=72),

    tobacco("adalya", "Angel Lips", "Енджел Ліпс",
            ["fruity", "mint", "floral"], ["melon", "raspberry", "mint"],
            profile(sweet=3, fresh=2, floral=2),
            strength=2,
            description_en="Melon and raspberry with mint and a floral undertone.",
            description_uk="Диня та малина з м'ятою та квітковими нотами.",
            popularity=74),

    tobacco("adalya", "Cactus", "Кактус",
            ["herbal", "fruity"], ["cactus", "tropical"],
            profile(sweet=2, sour=2, floral=1),
            strength=2,
            description_en="Unique grassy cactus notes with smooth sweet-sour transition.",
            description_uk="Унікальні трав'янисті ноти кактуса з м'яким переходом солодко-кисле.",
            popularity=65),

    tobacco("adalya", "Blue Melon", "Блю Мелон",
            ["fruity"], ["honeydew", "blueberry"],
            profile(sweet=4),
            strength=2,
            description_en="Smooth honeydew melon with darker blueberry top notes.",
            description_uk="М'яка медова диня з ягідними нотами чорниці.",
            popularity=70),

    tobacco("adalya", "Mint", "М'ята",
            ["mint"], ["mint"],
            profile(fresh=5),
            strength=2,
            description_en="Clean straightforward mint with crisp finish. Reliable mixer.",
            description_uk="Чиста проста м'ята з виразним фінішем. Надійний міксер.",
            popularity=72),

    tobacco("adalya", "Lemon", "Лимон",
            ["citrus"], ["lemon"],
            profile(sour=4),
            strength=2,
            description_en="Bright zesty lemon — pure citrus profile.",
            description_uk="Яскравий цитрусовий лимон — чистий цитрусовий профіль.",
            popularity=66),

    tobacco("adalya", "Watermelon", "Кавун",
            ["fruity"], ["watermelon"],
            profile(sweet=4),
            strength=2,
            description_en="Sweet juicy watermelon — summer classic.",
            description_uk="Солодкий соковитий кавун — літня класика.",
            popularity=78),

    tobacco("adalya", "Acai", "Асаї",
            ["fruity"], ["acai", "berry"],
            profile(sweet=3, sour=2),
            strength=2,
            description_en="Bright sweet-and-sour acai berries.",
            description_uk="Яскраві солодко-кислі ягоди асаї.",
            popularity=64),

    tobacco("adalya", "Adalya Power", "Адалья Пауер",
            ["beverage"], ["energy_drink"],
            profile(sweet=3, sour=3),
            strength=2,
            description_en="Sweet and sour energy drink flavor.",
            description_uk="Солодко-кислий енергетик.",
            popularity=68),

    tobacco("adalya", "Banana Milk Ice", "Бананове молоко Айс",
            ["dessert", "mint"], ["banana", "milk", "menthol"],
            profile(sweet=4, fresh=3),
            strength=2,
            description_en="Sweet banana with creamy milk and icy menthol.",
            description_uk="Солодкий банан з кремовим молоком та крижаним ментолом.",
            popularity=62),

    tobacco("adalya", "Berryeis", "Беррайс",
            ["fruity", "mint"], ["blackberry", "cranberry", "blueberry", "menthol"],
            profile(sweet=3, sour=2, fresh=3),
            strength=2,
            description_en="Mix of blackberries, cranberries, blueberries with icy finish.",
            description_uk="Суміш ожини, журавлини, чорниці з крижаним фінішем.",
            popularity=70),

    tobacco("adalya", "Black Cherry", "Блек Черрі",
            ["fruity", "beverage"], ["cherry", "soda"],
            profile(sweet=4, sour=1),
            strength=2,
            description_en="Sweet cherry soda with classic candy notes.",
            description_uk="Солодка вишнева газована з нотами цукерок.",
            popularity=66),

    tobacco("adalya", "Lemon Pie", "Лемон Пай",
            ["dessert", "citrus"], ["lemon", "pie", "cream"],
            profile(sweet=3, sour=2),
            strength=2,
            description_en="Sweet lemon pie dessert flavor.",
            description_uk="Солодкий десерт лимонний пиріг.",
            popularity=60),

    tobacco("adalya", "Horchata", "Орчата",
            ["dessert", "spice"], ["cinnamon", "vanilla", "almond"],
            profile(sweet=4, spicy=2),
            strength=2,
            description_en="Creamy dessert blend with cinnamon, vanilla and almond. Memorable and unique.",
            description_uk="Кремовий десерт з корицею, ваніллю та мигдалем. Незабутньо.",
            popularity=58),
]

# ============================================================================
# FUMARI (~12 flavors)
# ============================================================================
FUMARI = [
    tobacco("fumari", "White Gummi Bear", "Білий ведмедик",
            ["sweet"], ["candy", "gummy"],
            profile(sweet=5),
            strength=2,
            description_en="Iconic Fumari classic — sweet white gummy bear candy.",
            description_uk="Іконічна класика Fumari — солодкий білий ведмедик.",
            popularity=92),

    tobacco("fumari", "Ambrosia", "Амброзія",
            ["fruity", "sweet"], ["orange", "vanilla", "tropical"],
            profile(sweet=4, sour=1),
            strength=2,
            description_en="Tropical orange creamsicle blend — Fumari's beloved signature.",
            description_uk="Тропічний апельсиновий бленд з вершками — улюблена класика Fumari.",
            popularity=88),

    tobacco("fumari", "Spiced Chai", "Чай з прянощами",
            ["beverage", "spice"], ["chai", "cinnamon", "cardamom"],
            profile(sweet=2, spicy=4),
            strength=2,
            description_en="Aromatic Indian-style spiced chai with cinnamon and cardamom.",
            description_uk="Ароматний індійський чай з корицею та кардамоном.",
            popularity=72),

    tobacco("fumari", "Lemon Mint", "Лимон-м'ята",
            ["citrus", "mint"], ["lemon", "mint"],
            profile(sour=3, fresh=4),
            strength=2,
            description_en="Bright lemon balanced with crisp mint.",
            description_uk="Яскравий лимон з чистою м'ятою.",
            popularity=80),

    tobacco("fumari", "White Peach", "Білий персик",
            ["fruity"], ["peach"],
            profile(sweet=4),
            strength=2,
            description_en="Delicate white peach with smooth juicy texture.",
            description_uk="Делікатний білий персик з соковитою м'якою текстурою.",
            popularity=78),

    tobacco("fumari", "Strawberry Jam", "Полуничний джем",
            ["fruity", "dessert"], ["strawberry", "jam"],
            profile(sweet=5),
            strength=2,
            description_en="Rich sweet strawberry jam — like grandma's preserves.",
            description_uk="Насичений солодкий полуничний джем.",
            popularity=82),

    tobacco("fumari", "Mint Chocolate Chill", "Мятно-шоколадний",
            ["dessert", "mint"], ["chocolate", "mint"],
            profile(sweet=3, fresh=3, bitter=1),
            strength=2,
            description_en="Mint chocolate chip ice cream in shisha form.",
            description_uk="Шоколадно-м'ятне морозиво у вигляді кальяну.",
            popularity=70),

    tobacco("fumari", "Mint", "М'ята",
            ["mint"], ["mint"],
            profile(fresh=5),
            strength=2,
            description_en="Pure mint, classic clean profile.",
            description_uk="Чиста м'ята, класичний чистий профіль.",
            popularity=74),

    tobacco("fumari", "Red Gummi Bear", "Червоний ведмедик",
            ["fruity", "sweet"], ["candy", "berry"],
            profile(sweet=5, sour=1),
            strength=2,
            description_en="Red berry gummy bear — fruity candy classic.",
            description_uk="Червоний ягідний ведмедик — фруктова цукеркова класика.",
            popularity=78),

    tobacco("fumari", "Prickly Pear", "Опунція",
            ["fruity"], ["cactus_pear", "tropical"],
            profile(sweet=3, sour=2),
            strength=2,
            description_en="Exotic prickly pear with sweet-tart tropical notes.",
            description_uk="Екзотична опунція зі солодко-кислими тропічними нотами.",
            popularity=68),

    tobacco("fumari", "Cucumber Mint", "Огірок-м'ята",
            ["herbal", "mint"], ["cucumber", "mint"],
            profile(fresh=4),
            strength=2,
            description_en="Crisp garden cucumber with cool mint — spa-like fresh.",
            description_uk="Свіжий городній огірок з прохолодною м'ятою — спа-свіжість.",
            popularity=74),

    tobacco("fumari", "Citrus Mint", "Цитрус-м'ята",
            ["citrus", "mint"], ["lemon", "lime", "mint"],
            profile(sour=3, fresh=4),
            strength=2,
            description_en="Mixed citrus zest with refreshing mint.",
            description_uk="Цитрусова цедра з освіжаючою м'ятою.",
            popularity=70),
]

# ============================================================================
# TANGIERS (~10 flavors) — DARK LEAF, strength higher
# ============================================================================
TANGIERS = [
    tobacco("tangiers", "Cane Mint", "Кане Мінт",
            ["mint"], ["mint", "cane_mint"],
            profile(fresh=5),
            strength=4,
            description_en="Intense long-lasting mint, considered the strongest mint in industry.",
            description_uk="Інтенсивна довготривала м'ята, вважається найсильнішою на ринку.",
            popularity=90,
            leaf_type="dark"),

    tobacco("tangiers", "Sour Watermelon", "Кислий кавун",
            ["fruity"], ["watermelon", "sour_candy"],
            profile(sweet=2, sour=4),
            strength=4,
            description_en="Tart sour watermelon with candy-like punch.",
            description_uk="Кислий кавун з цукерковим присмаком.",
            popularity=85,
            leaf_type="dark"),

    tobacco("tangiers", "Kashmir Peach", "Кашмір Персик",
            ["fruity", "spice"], ["peach", "spice"],
            profile(sweet=3, spicy=2),
            strength=4,
            description_en="Spiced peach with exotic Kashmir character.",
            description_uk="Персик зі спеціями та екзотичним характером.",
            popularity=72,
            leaf_type="dark"),

    tobacco("tangiers", "Lucid", "Лусід",
            ["fruity", "citrus"], ["passionfruit", "lemon"],
            profile(sweet=3, sour=3),
            strength=4,
            description_en="Tart passionfruit with bright lemon — Tangiers signature mixer.",
            description_uk="Кисла маракуйя з яскравим лимоном — фірмовий міксер Tangiers.",
            popularity=78,
            leaf_type="dark"),

    tobacco("tangiers", "Static", "Статік",
            ["fruity", "mint"], ["mango", "papaya", "mint"],
            profile(sweet=3, fresh=3),
            strength=4,
            description_en="Tropical mango-papaya with cooling mint.",
            description_uk="Тропічне манго-папайя з прохолодною м'ятою.",
            popularity=72,
            leaf_type="dark"),

    tobacco("tangiers", "Horchata", "Орчата",
            ["dessert", "spice"], ["cinnamon", "vanilla", "rice"],
            profile(sweet=3, spicy=2),
            strength=4,
            description_en="Mexican horchata — cinnamon rice milk dessert.",
            description_uk="Мексиканська орчата — кориця, рисове молоко.",
            popularity=65,
            leaf_type="dark"),

    tobacco("tangiers", "Cocoa", "Какао",
            ["dessert"], ["chocolate", "cocoa"],
            profile(sweet=2, bitter=2),
            strength=4,
            description_en="Pure dark cocoa with rich bittersweet body.",
            description_uk="Чисте темне какао з насиченим гірко-солодким тілом.",
            popularity=60,
            leaf_type="dark"),

    tobacco("tangiers", "Blueberry", "Чорниця",
            ["fruity"], ["blueberry"],
            profile(sweet=3, sour=1),
            strength=4,
            description_en="Authentic blueberry, tart and natural.",
            description_uk="Автентична чорниця, терпка та натуральна.",
            popularity=70,
            leaf_type="dark"),

    tobacco("tangiers", "Cane Mint with Coriander", "М'ята з коріандром",
            ["mint", "spice"], ["mint", "coriander"],
            profile(fresh=5, spicy=1),
            strength=4,
            description_en="Cane mint with herbal coriander twist.",
            description_uk="Класична м'ята з трав'яною ноткою коріандру.",
            popularity=66,
            leaf_type="dark"),

    tobacco("tangiers", "Orange Soda", "Апельсинова содова",
            ["citrus", "beverage"], ["orange", "soda"],
            profile(sweet=3, sour=2),
            strength=4,
            description_en="Fizzy orange soda candy notes.",
            description_uk="Газована апельсинова содова з цукерковими нотами.",
            popularity=68,
            leaf_type="dark"),
]

# ============================================================================
# STARBUZZ (~10 flavors)
# ============================================================================
STARBUZZ = [
    tobacco("starbuzz", "Blue Mist", "Блю Міст",
            ["fruity", "mint"], ["blueberry", "mint"],
            profile(sweet=4, fresh=3),
            strength=2,
            description_en="The legendary Blue Mist — sweet candied blueberries with cool mint.",
            description_uk="Легендарний Blue Mist — солодка цукеркова чорниця з холодною м'ятою.",
            popularity=95),

    tobacco("starbuzz", "Pirates Cave", "Печера піратів",
            ["fruity", "mint"], ["citrus", "tropical", "mint"],
            profile(sweet=3, sour=2, fresh=3),
            strength=2,
            description_en="Tropical citrus blend with cool mint — exotic adventure.",
            description_uk="Тропічно-цитрусовий бленд з прохолодною м'ятою.",
            popularity=78),

    tobacco("starbuzz", "Sex on the Beach", "Секс на пляжі",
            ["fruity"], ["peach", "orange", "cranberry"],
            profile(sweet=3, sour=2),
            strength=2,
            description_en="Cocktail blend of peach, orange and cranberry.",
            description_uk="Коктейльний бленд персика, апельсина і журавлини.",
            popularity=80),

    tobacco("starbuzz", "Code 69", "Код 69",
            ["fruity", "mint"], ["mango", "tropical", "mint"],
            profile(sweet=4, fresh=2),
            strength=2,
            description_en="Mysterious tropical-mango blend with mint hint.",
            description_uk="Загадковий тропічно-манговий бленд з ноткою м'яти.",
            popularity=75),

    tobacco("starbuzz", "Mint", "М'ята",
            ["mint"], ["mint"],
            profile(fresh=5),
            strength=2,
            description_en="Clean strong mint, mixer-friendly.",
            description_uk="Чиста сильна м'ята, добра для міксів.",
            popularity=72),

    tobacco("starbuzz", "Apple", "Яблуко",
            ["fruity"], ["apple"],
            profile(sweet=3, sour=2),
            strength=2,
            description_en="Crisp apple flavor without anise.",
            description_uk="Хрустке яблуко без анісу.",
            popularity=70),

    tobacco("starbuzz", "Watermelon", "Кавун",
            ["fruity"], ["watermelon"],
            profile(sweet=4),
            strength=2,
            description_en="Sweet candy-like watermelon.",
            description_uk="Солодкий цукерковий кавун.",
            popularity=72),

    tobacco("starbuzz", "Geisha", "Гейша",
            ["fruity", "floral"], ["peach", "orange", "floral"],
            profile(sweet=3, sour=1, floral=3),
            strength=2,
            description_en="Floral fruity blend — exotic and elegant.",
            description_uk="Квітково-фруктовий бленд — екзотика та елегантність.",
            popularity=68),

    tobacco("starbuzz", "Blueberry", "Чорниця",
            ["fruity"], ["blueberry"],
            profile(sweet=3, sour=1),
            strength=2,
            description_en="Sweet blueberry without mint — pure berry.",
            description_uk="Солодка чорниця без м'яти — чиста ягода.",
            popularity=68),

    tobacco("starbuzz", "Sour Apple", "Кисле яблуко",
            ["fruity"], ["green_apple"],
            profile(sweet=2, sour=4),
            strength=2,
            description_en="Tart green apple, sour candy notes.",
            description_uk="Терпке зелене яблуко з кислими цукерковими нотами.",
            popularity=66),
]

# ============================================================================
# MAZAYA (~8 flavors)
# ============================================================================
MAZAYA = [
    tobacco("mazaya", "Lemon Mint", "Лимон-м'ята",
            ["citrus", "mint"], ["lemon", "mint"],
            profile(sour=3, fresh=4),
            strength=2,
            description_en="Refreshing citrus with cool finish — Mazaya bestseller.",
            description_uk="Освіжаючий цитрус з прохолодним фінішем — бестселер Mazaya.",
            popularity=85),

    tobacco("mazaya", "Double Apple", "Подвійне яблуко",
            ["fruity", "spice"], ["apple", "anise"],
            profile(sweet=3, spicy=2),
            strength=2,
            description_en="Classic anise-apple at affordable price.",
            description_uk="Класичне яблуко з анісом за доступною ціною.",
            popularity=78),

    tobacco("mazaya", "Double Apples Max", "Дабл Епплс Макс",
            ["fruity", "spice"], ["apple", "anise", "licorice"],
            profile(sweet=3, sour=1, spicy=3),
            strength=2,
            description_en="Bold double apple with anise and licorice — modern edge.",
            description_uk="Сміливе подвійне яблуко з анісом і лакрицею.",
            popularity=72),

    tobacco("mazaya", "Watermelon Mint", "Кавун-м'ята",
            ["fruity", "mint"], ["watermelon", "mint"],
            profile(sweet=3, fresh=3),
            strength=2,
            description_en="Juicy watermelon with cool mint.",
            description_uk="Соковитий кавун із прохолодною м'ятою.",
            popularity=72),

    tobacco("mazaya", "Grape Mint", "Виноград-м'ята",
            ["fruity", "mint"], ["grape", "mint"],
            profile(sweet=3, fresh=3),
            strength=2,
            description_en="Sweet grape with refreshing mint.",
            description_uk="Солодкий виноград із свіжою м'ятою.",
            popularity=70),

    tobacco("mazaya", "Two Apples", "Два яблука",
            ["fruity"], ["apple", "green_apple"],
            profile(sweet=3, sour=2),
            strength=2,
            description_en="Classic two-apples blend without anise.",
            description_uk="Класичні два яблука без анісу.",
            popularity=68),

    tobacco("mazaya", "Mint", "М'ята",
            ["mint"], ["mint"],
            profile(fresh=5),
            strength=2,
            description_en="Affordable clean mint.",
            description_uk="Доступна чиста м'ята.",
            popularity=66),

    tobacco("mazaya", "Peach", "Персик",
            ["fruity"], ["peach"],
            profile(sweet=4),
            strength=2,
            description_en="Sweet juicy peach.",
            description_uk="Солодкий соковитий персик.",
            popularity=68),
]

# ============================================================================
# NAKHLA (~8 flavors) — DARK LEAF, classic Egyptian
# ============================================================================
NAKHLA = [
    tobacco("nakhla", "Two Apples", "Два яблука",
            ["fruity", "spice"], ["apple", "anise"],
            profile(sweet=3, sour=1, spicy=3),
            strength=3,
            description_en="The original double apple — Egyptian classic since 1913.",
            description_uk="Оригінальне подвійне яблуко — єгипетська класика з 1913 року.",
            popularity=85,
            leaf_type="dark"),

    tobacco("nakhla", "Mint", "М'ята",
            ["mint"], ["mint"],
            profile(fresh=4),
            strength=3,
            description_en="Classic Egyptian mint with character.",
            description_uk="Класична єгипетська м'ята з характером.",
            popularity=78,
            leaf_type="dark"),

    tobacco("nakhla", "Cinnamon", "Кориця",
            ["spice"], ["cinnamon"],
            profile(sweet=2, spicy=4),
            strength=3,
            description_en="Bold warm cinnamon — traditional spice.",
            description_uk="Сильна тепла кориця — традиційна спеція.",
            popularity=68,
            leaf_type="dark"),

    tobacco("nakhla", "Lemon", "Лимон",
            ["citrus"], ["lemon"],
            profile(sour=4),
            strength=3,
            description_en="Sharp natural lemon with traditional dark leaf body.",
            description_uk="Гострий натуральний лимон з тілом темного листа.",
            popularity=66,
            leaf_type="dark"),

    tobacco("nakhla", "Strawberry", "Полуниця",
            ["fruity"], ["strawberry"],
            profile(sweet=3, sour=1),
            strength=3,
            description_en="Sweet ripe strawberry, classic profile.",
            description_uk="Солодка стигла полуниця, класичний профіль.",
            popularity=64,
            leaf_type="dark"),

    tobacco("nakhla", "Cola", "Кола",
            ["beverage"], ["cola"],
            profile(sweet=3, sour=1, spicy=1),
            strength=3,
            description_en="Cola soda flavor — nostalgic and bold.",
            description_uk="Смак коли — ностальгійно та яскраво.",
            popularity=60,
            leaf_type="dark"),

    tobacco("nakhla", "Cappuccino", "Капучино",
            ["dessert", "beverage"], ["coffee", "cream"],
            profile(sweet=2, bitter=3),
            strength=3,
            description_en="Coffee-cream blend with bold dark-leaf depth.",
            description_uk="Кавово-вершковий бленд з глибиною темного листа.",
            popularity=58,
            leaf_type="dark"),

    tobacco("nakhla", "Watermelon", "Кавун",
            ["fruity"], ["watermelon"],
            profile(sweet=3),
            strength=3,
            description_en="Authentic watermelon with stronger tobacco character.",
            description_uk="Автентичний кавун з сильним тютюновим характером.",
            popularity=64,
            leaf_type="dark"),
]

# ============================================================================
# TRIFECTA (~7 flavors) — both blonde and dark
# ============================================================================
TRIFECTA = [
    tobacco("trifecta", "Peppermint Shake", "Перцева м'ята",
            ["mint", "dessert"], ["peppermint", "cream", "vanilla"],
            profile(sweet=3, fresh=4),
            strength=2,
            description_en="Minty milkshake with creamy undertone.",
            description_uk="М'ятний коктейль з вершковою основою.",
            popularity=75),

    tobacco("trifecta", "Blonde Lemon Mint", "Блонд Лимон-м'ята",
            ["citrus", "mint"], ["lemon", "mint"],
            profile(sour=3, fresh=4),
            strength=2,
            description_en="Bright lemon with crisp mint, blonde leaf base.",
            description_uk="Яскравий лимон з чистою м'ятою, blonde основа.",
            popularity=72),

    tobacco("trifecta", "Blonde Berry Lemonade", "Ягідний лимонад",
            ["fruity", "citrus"], ["berry", "lemon"],
            profile(sweet=3, sour=3),
            strength=2,
            description_en="Berry lemonade — sweet meets tart.",
            description_uk="Ягідний лимонад — солодке зустрічає кисле.",
            popularity=70),

    tobacco("trifecta", "Dark Cool Mango", "Дарк Куул Манго",
            ["fruity", "mint"], ["mango", "menthol"],
            profile(sweet=3, fresh=4),
            strength=4,
            description_en="Dark leaf mango with icy menthol.",
            description_uk="Дарк-лиф манго з крижаним ментолом.",
            popularity=72,
            leaf_type="dark"),

    tobacco("trifecta", "Mango Lassi", "Манго Ласі",
            ["dessert", "fruity"], ["mango", "yogurt", "cardamom"],
            profile(sweet=4, spicy=1),
            strength=4,
            description_en="Indian mango lassi — creamy yogurt with cardamom.",
            description_uk="Індійське манго ласі — кремовий йогурт з кардамоном.",
            popularity=66,
            leaf_type="dark"),

    tobacco("trifecta", "Dark Apple Mint", "Дарк Яблуко-м'ята",
            ["fruity", "mint"], ["apple", "mint"],
            profile(sweet=3, sour=1, fresh=3),
            strength=4,
            description_en="Dark leaf apple with refreshing mint.",
            description_uk="Дарк-лиф яблуко з освіжаючою м'ятою.",
            popularity=68,
            leaf_type="dark"),

    tobacco("trifecta", "Blonde Rose", "Блонд Троянда",
            ["floral"], ["rose"],
            profile(sweet=2, floral=4),
            strength=2,
            description_en="Elegant rose floral notes — Middle Eastern classic.",
            description_uk="Елегантні квіткові ноти троянди — близькосхідна класика.",
            popularity=58),
]

# ============================================================================
# CURATED MIXES (10 popular mixes for "smart recommender" cold start)
# ============================================================================
def mix(mix_id, name_en, name_uk, components, profile_dict, strength,
        difficulty, description_en, description_uk, target_persona, tags,
        popularity=50):
    """
    components: list of {tobaccoId, percentage}
    profile: expected flavor profile
    target_persona: 'beginner' | 'intermediate' | 'expert'
    """
    return {
        "id": mix_id,
        "name": {"en": name_en, "uk": name_uk},
        "components": components,
        "expectedProfile": profile_dict,
        "strengthLevel": strength,  # computed/manual 1-5
        "difficulty": difficulty,  # 'easy' | 'medium' | 'hard'
        "description": {"en": description_en, "uk": description_uk},
        "targetPersona": target_persona,
        "tags": tags,
        "popularity": popularity,
        "isCurated": True,  # відрізняти від UGC у майбутньому
        "authorId": None,   # null = official
        "createdAt": now_iso(),
        "updatedAt": now_iso(),
    }


CURATED_MIXES = [
    mix("mix_classic_double_apple_mint", "Classic Double Apple Mint", "Класика: подвійне яблуко з м'ятою",
        [{"tobaccoId": "al_fakher__double_apple", "percentage": 70},
         {"tobaccoId": "al_fakher__mint", "percentage": 30}],
        profile(sweet=3, fresh=3, spicy=2), 2, "easy",
        "The most reliable starter mix — sweet apple with refreshing mint. Foolproof for beginners.",
        "Найнадійніший стартовий мікс — солодке яблуко з освіжаючою м'ятою. Безпрограшно для початківців.",
        "beginner", ["sweet", "fresh", "classic", "easy"], 95),

    mix("mix_blue_mist_solo", "Pure Blue Mist", "Чистий Блю Міст",
        [{"tobaccoId": "starbuzz__blue_mist", "percentage": 100}],
        profile(sweet=4, fresh=3), 2, "easy",
        "Iconic Starbuzz Blue Mist on its own — sweet blueberry with cool mint, no need for anything else.",
        "Іконічний Blue Mist соло — солодка чорниця з прохолодою, нічого більше не треба.",
        "beginner", ["sweet", "fresh", "iconic"], 90),

    mix("mix_love66_mint_boost", "Love 66 Mint Boost", "Лав 66 з м'ятним підсиленням",
        [{"tobaccoId": "adalya__love_66", "percentage": 70},
         {"tobaccoId": "adalya__mint", "percentage": 30}],
        profile(sweet=3, fresh=3, floral=2), 2, "easy",
        "Adalya's flagship Love 66 with extra mint kick.",
        "Флагман Adalya Love 66 з додатковим м'ятним ударом.",
        "beginner", ["sweet", "fresh", "fruity"], 85),

    mix("mix_summer_citrus", "Summer Citrus", "Літній цитрус",
        [{"tobaccoId": "al_fakher__lemon_with_mint", "percentage": 50},
         {"tobaccoId": "al_fakher__watermelon_with_mint", "percentage": 30},
         {"tobaccoId": "al_fakher__mint", "percentage": 20}],
        profile(sweet=2, sour=3, fresh=4), 2, "medium",
        "Citrus-watermelon-mint trifecta — the ultimate summer cooler.",
        "Цитрус-кавун-м'ята — найкращий літній освіжувач.",
        "intermediate", ["sour", "fresh", "summer", "citrus"], 80),

    mix("mix_dessert_peaches_cream", "Peaches and Cream", "Персики з вершками",
        [{"tobaccoId": "al_fakher__peach", "percentage": 40},
         {"tobaccoId": "fumari__white_peach", "percentage": 40},
         {"tobaccoId": "al_fakher__vanilla", "percentage": 20}],
        profile(sweet=4), 2, "medium",
        "Sweet creamy peach dessert — like a peach milkshake.",
        "Солодкий вершковий персиковий десерт — як персиковий коктейль.",
        "intermediate", ["sweet", "dessert", "creamy"], 75),

    mix("mix_dark_strong_evening", "Dark Strong Evening", "Темний міцний вечір",
        [{"tobaccoId": "tangiers__cane_mint", "percentage": 50},
         {"tobaccoId": "tangiers__cocoa", "percentage": 50}],
        profile(sweet=2, fresh=3, bitter=2), 4, "hard",
        "For experienced smokers — dark leaf cocoa with intense mint. Long, deep session.",
        "Для досвідчених — темне какао з інтенсивною м'ятою. Довга глибока сесія.",
        "expert", ["strong", "bitter", "fresh", "evening"], 65),

    mix("mix_tropical_paradise", "Tropical Paradise", "Тропічний рай",
        [{"tobaccoId": "al_fakher__mango", "percentage": 40},
         {"tobaccoId": "al_fakher__pineapple", "percentage": 40},
         {"tobaccoId": "al_fakher__coconut", "percentage": 20}],
        profile(sweet=4, sour=1), 2, "medium",
        "Mango, pineapple and coconut — escape to the tropics.",
        "Манго, ананас та кокос — втеча в тропіки.",
        "intermediate", ["sweet", "tropical", "fruity"], 78),

    mix("mix_grape_chill", "Grape Chill", "Виноградна прохолода",
        [{"tobaccoId": "al_fakher__grape_with_mint", "percentage": 70},
         {"tobaccoId": "al_fakher__mint", "percentage": 30}],
        profile(sweet=3, fresh=4), 2, "easy",
        "Sweet grape boosted with extra mint — classic chill mix.",
        "Солодкий виноград з додатковою м'ятою — класична прохолода.",
        "beginner", ["sweet", "fresh", "classic"], 78),

    mix("mix_cocktail_hour", "Cocktail Hour", "Час коктейлів",
        [{"tobaccoId": "starbuzz__sex_on_the_beach", "percentage": 50},
         {"tobaccoId": "al_fakher__lemon_with_mint", "percentage": 30},
         {"tobaccoId": "al_fakher__mint", "percentage": 20}],
        profile(sweet=3, sour=2, fresh=3), 2, "medium",
        "Cocktail-inspired tropical mix — peach, orange, cranberry with citrus mint.",
        "Коктейльний тропічний мікс — персик, апельсин, журавлина з цитрусом.",
        "intermediate", ["sweet", "sour", "cocktail"], 72),

    mix("mix_spicy_warm", "Spicy Warm", "Пряний і теплий",
        [{"tobaccoId": "fumari__spiced_chai", "percentage": 50},
         {"tobaccoId": "al_fakher__cinnamon", "percentage": 30},
         {"tobaccoId": "al_fakher__vanilla", "percentage": 20}],
        profile(sweet=3, spicy=4), 2, "medium",
        "Warm chai with cinnamon and vanilla — autumn evening in a bowl.",
        "Теплий чай з корицею та ваніллю — осінній вечір у чаші.",
        "intermediate", ["spicy", "warm", "autumn"], 60),
]


# ============================================================================
# BUILD & EXPORT
# ============================================================================

def build_dataset():
    all_tobaccos = (
        AL_FAKHER + ADALYA + FUMARI + TANGIERS +
        STARBUZZ + MAZAYA + NAKHLA + TRIFECTA
    )

    # Validate uniqueness
    ids = [t["id"] for t in all_tobaccos]
    duplicates = [x for x in ids if ids.count(x) > 1]
    assert not duplicates, f"Duplicate IDs: {set(duplicates)}"

    # Validate mix references
    valid_ids = set(ids)
    for m in CURATED_MIXES:
        for c in m["components"]:
            assert c["tobaccoId"] in valid_ids, f"Mix {m['id']} references unknown {c['tobaccoId']}"
            assert 1 <= c["percentage"] <= 100, f"Bad percentage in {m['id']}"
        total = sum(c["percentage"] for c in m["components"])
        assert total == 100, f"Mix {m['id']} components sum = {total}, expected 100"

    return {
        "version": "1.0.0",
        "generatedAt": now_iso(),
        "stats": {
            "brands": len(BRANDS),
            "tobaccos": len(all_tobaccos),
            "mixes": len(CURATED_MIXES),
        },
        "brands": BRANDS,
        "tobaccos": all_tobaccos,
        "mixes": CURATED_MIXES,
    }


if __name__ == "__main__":
    dataset = build_dataset()
    output = Path("/home/claude/seed/hookah_seed_v1.json")
    output.write_text(json.dumps(dataset, indent=2, ensure_ascii=False), encoding="utf-8")
    print(f"✅ Generated dataset:")
    print(f"   Brands:   {dataset['stats']['brands']}")
    print(f"   Tobaccos: {dataset['stats']['tobaccos']}")
    print(f"   Mixes:    {dataset['stats']['mixes']}")
    print(f"   File:     {output}")
    print(f"   Size:     {output.stat().st_size / 1024:.1f} KB")
