#!/bin/bash

set -e
case "$1" in
  "list")
    data=$(sed '0,/^__DATA__$/d' "$0")
    echo "$data"
    ;;
  "copy")
    input=$(tee)
    if [ ! -z "$input" ]; then
      emoji=${input: -1}
      echo -n "$emoji" | xclip -selection c
      command -v notify-send > /dev/null && notify-send -t 200 "$emoji copied!"
    fi
    ;;
  "")
    bash $0 list | dmenu -l 20 -p 'emoji' | bash $0 copy
    ;;
esac

exit

__DATA__
grinning face                                   😀
smiling face with open mouth                    😃
smiling face with open mouth & smiling eyes     😄
grinning face with smiling eyes                 😁
smiling face with open mouth & closed eyes      😆
smiling face with open mouth & cold sweat       😅
face with tears of joy                          😂
rolling on the floor laughing                   🤣
smiling face                                   ☺️
smiling face with smiling eyes                  😊
smiling face with halo                          😇
slightly smiling face                           🙂
upside-down face                                🙃
winking face                                    😉
relieved face                                   😌
smiling face with heart-eyes                    😍
face blowing a kiss                             😘
kissing face                                    😗
kissing face with smiling eyes                  😙
kissing face with closed eyes                   😚
face savouring delicious food                   😋
face with stuck-out tongue & winking eye        😜
face with stuck-out tongue & closed eyes        😝
face with stuck-out tongue                      😛
money-mouth face                                🤑
hugging face                                    🤗
nerd face                                       🤓
smiling face with sunglasses                    😎
clown face                                      🤡
cowboy hat face                                 🤠
smirking face                                   😏
unamused face                                   😒
disappointed face                               😞
pensive face                                    😔
worried face                                    😟
confused face                                   😕
slightly frowning face                          🙁
frowning face                                  ☹️
persevering face                                😣
confounded face                                 😖
tired face                                      😫
weary face                                      😩
face with steam from nose                       😤
angry face                                      😠
pouting face                                    😡
face without mouth                              😶
neutral face                                    😐
expressionless face                             😑
hushed face                                     😯
frowning face with open mouth                   😦
anguished face                                  😧
face with open mouth                            😮
astonished face                                 😲
dizzy face                                      😵
flushed face                                    😳
face screaming in fear                          😱
fearful face                                    😨
face with open mouth & cold sweat               😰
crying face                                     😢
disappointed but relieved face                  😥
drooling face                                   🤤
loudly crying face                              😭
face with cold sweat                            😓
sleepy face                                     😪
sleeping face                                   😴
face with rolling eyes                          🙄
thinking face                                   🤔
lying face                                      🤥
grimacing face                                  😬
zipper-mouth face                               🤐
nauseated face                                  🤢
sneezing face                                   🤧
face with medical mask                          😷
face with thermometer                           🤒
face with head-bandage                          🤕
smiling face with horns                         😈
angry face with horns                           👿
ogre                                            👹
goblin                                          👺
pile of poo                                     💩
ghost                                           👻
skull                                           💀
skull and crossbones                           ☠️
alien                                           👽
alien monster                                   👾
robot face                                      🤖
jack-o-lantern                                  🎃
smiling cat face with open mouth                😺
grinning cat face with smiling eyes             😸
cat face with tears of joy                      😹
smiling cat face with heart-eyes                😻
cat face with wry smile                         😼
kissing cat face with closed eyes               😽
weary cat face                                  🙀
crying cat face                                 😿
pouting cat face                                😾
open hands                                      👐
raising hands                                   🙌
clapping hands                                  👏
folded hands                                    🙏
handshake                                       🤝
thumbs up                                       👍
thumbs down                                     👎
oncoming fist                                   👊
raised fist                                     ✊
left-facing fist                                🤛
right-facing fist                               🤜
crossed fingers                                 🤞
victory hand                                   ✌️
sign of the horns                               🤘
OK hand                                         👌
backhand index pointing left                    👈
backhand index pointing right                   👉
backhand index pointing up                      👆
backhand index pointing down                    👇
index pointing up                              ☝️
raised hand                                     ✋
raised back of hand                             🤚
raised hand with fingers splayed                🖐
vulcan salute                                   🖖
waving hand                                     👋
call me hand                                    🤙
flexed biceps                                   💪
middle finger                                   🖕
writing hand                                   ✍️
selfie                                          🤳
nail polish                                     💅
ring                                            💍
lipstick                                        💄
kiss mark                                       💋
mouth                                           👄
tongue                                          👅
ear                                             👂
nose                                            👃
footprints                                      👣
eye                                             👁
eyes                                            👀
speaking head                                   🗣
bust in silhouette                              👤
busts in silhouette                             👥
baby                                            👶
boy                                             👦
girl                                            👧
man                                             👨
woman                                           👩
blond-haired woman                            👱‍♀
blond-haired person                             👱
old man                                         👴
old woman                                       👵
man with Chinese cap                            👲
woman wearing turban                          👳‍♀
person wearing turban                           👳
woman police officer                          👮‍♀
police officer                                  👮
woman construction worker                     👷‍♀
construction worker                             👷
woman guard                                   💂‍♀
guard                                           💂
woman detective                             🕵️‍♀️
detective                                       🕵
woman health worker                           👩‍⚕
man health worker                             👨‍⚕
woman farmer                                  👩‍🌾
man farmer                                    👨‍🌾
woman cook                                    👩‍🍳
man cook                                      👨‍🍳
woman student                                 👩‍🎓
man student                                   👨‍🎓
woman singer                                  👩‍🎤
man singer                                    👨‍🎤
woman teacher                                 👩‍🏫
man teacher                                   👨‍🏫
woman factory worker                          👩‍🏭
man factory worker                            👨‍🏭
woman technologist                            👩‍💻
man technologist                              👨‍💻
woman office worker                           👩‍💼
man office worker                             👨‍💼
woman mechanic                                👩‍🔧
man mechanic                                  👨‍🔧
woman scientist                               👩‍🔬
man scientist                                 👨‍🔬
woman artist                                  👩‍🎨
man artist                                    👨‍🎨
woman firefighter                             👩‍🚒
man firefighter                               👨‍🚒
woman pilot                                   👩‍✈
man pilot                                     👨‍✈
woman astronaut                               👩‍🚀
man astronaut                                 👨‍🚀
woman judge                                   👩‍⚖
man judge                                     👨‍⚖
Mrs. Claus                                      🤶
Santa Claus                                     🎅
princess                                        👸
prince                                          🤴
bride with veil                                 👰
man in tuxedo                                   🤵
baby angel                                      👼
pregnant woman                                  🤰
woman bowing                                  🙇‍♀
person bowing                                   🙇
person tipping hand                             💁
man tipping hand                              💁‍♂
person gesturing NO                             🙅
man gesturing NO                              🙅‍♂
person gesturing OK                             🙆
man gesturing OK                              🙆‍♂
person raising hand                             🙋
man raising hand                              🙋‍♂
woman facepalming                             🤦‍♀
man facepalming                               🤦‍♂
woman shrugging                               🤷‍♀
man shrugging                                 🤷‍♂
person pouting                                  🙎
man pouting                                   🙎‍♂
person frowning                                 🙍
man frowning                                  🙍‍♂
person getting haircut                          💇
man getting haircut                           💇‍♂
person getting massage                          💆
man getting massage                           💆‍♂
man in business suit levitating                 🕴
woman dancing                                   💃
man dancing                                     🕺
people with bunny ears partying                 👯
men with bunny ears partying                  👯‍♂
woman walking                                 🚶‍♀
person walking                                  🚶
woman running                                 🏃‍♀
person running                                  🏃
man and woman holding hands                     👫
two women holding hands                         👭
two men holding hands                           👬
couple with heart                               💑
woman’s clothes                                 👚
t-shirt                                         👕
jeans                                           👖
necktie                                         👔
dress                                           👗
bikini                                          👙
kimono                                          👘
high-heeled shoe                                👠
woman’s sandal                                  👡
woman’s boot                                    👢
man’s shoe                                      👞
running shoe                                    👟
woman’s hat                                     👒
top hat                                         🎩
graduation cap                                  🎓
crown                                           👑
rescue worker’s helmet                          ⛑
school backpack                                 🎒
clutch bag                                      👝
purse                                           👛
handbag                                         👜
briefcase                                       💼
glasses                                         👓
sunglasses                                      🕶
closed umbrella                                 🌂
umbrella                                       ☂️
dog face                                        🐶
cat face                                        🐱
mouse face                                      🐭
hamster face                                    🐹
rabbit face                                     🐰
fox face                                        🦊
bear face                                       🐻
panda face                                      🐼
koala                                           🐨
tiger face                                      🐯
lion face                                       🦁
cow face                                        🐮
pig face                                        🐷
pig nose                                        🐽
frog face                                       🐸
monkey face                                     🐵
see-no-evil monkey                              🙈
hear-no-evil monkey                             🙉
speak-no-evil monkey                            🙊
monkey                                          🐒
chicken                                         🐔
penguin                                         🐧
bird                                            🐦
baby chick                                      🐤
hatching chick                                  🐣
front-facing baby chick                         🐥
duck                                            🦆
eagle                                           🦅
owl                                             🦉
bat                                             🦇
wolf face                                       🐺
boar                                            🐗
horse face                                      🐴
unicorn face                                    🦄
honeybee                                        🐝
bug                                             🐛
butterfly                                       🦋
snail                                           🐌
spiral shell                                    🐚
lady beetle                                     🐞
ant                                             🐜
spider                                          🕷
spider web                                      🕸
turtle                                          🐢
snake                                           🐍
lizard                                          🦎
scorpion                                        🦂
crab                                            🦀
squid                                           🦑
octopus                                         🐙
shrimp                                          🦐
tropical fish                                   🐠
fish                                            🐟
blowfish                                        🐡
dolphin                                         🐬
shark                                           🦈
spouting whale                                  🐳
whale                                           🐋
crocodile                                       🐊
leopard                                         🐆
tiger                                           🐅
water buffalo                                   🐃
ox                                              🐂
cow                                             🐄
deer                                            🦌
camel                                           🐪
two-hump camel                                  🐫
elephant                                        🐘
rhinoceros                                      🦏
gorilla                                         🦍
horse                                           🐎
pig                                             🐖
goat                                            🐐
ram                                             🐏
sheep                                           🐑
dog                                             🐕
poodle                                          🐩
cat                                             🐈
rooster                                         🐓
turkey                                          🦃
dove                                            🕊
rabbit                                          🐇
mouse                                           🐁
rat                                             🐀
chipmunk                                        🐿
paw prints                                      🐾
dragon                                          🐉
dragon face                                     🐲
cactus                                          🌵
Christmas tree                                  🎄
evergreen tree                                  🌲
deciduous tree                                  🌳
palm tree                                       🌴
seedling                                        🌱
herb                                            🌿
shamrock                                       ☘️
four leaf clover                                🍀
pine decoration                                 🎍
tanabata tree                                   🎋
leaf fluttering in wind                         🍃
fallen leaf                                     🍂
maple leaf                                      🍁
mushroom                                        🍄
sheaf of rice                                   🌾
bouquet                                         💐
tulip                                           🌷
rose                                            🌹
wilted flower                                   🥀
sunflower                                       🌻
blossom                                         🌼
cherry blossom                                  🌸
hibiscus                                        🌺
globe showing Americas                          🌎
globe showing Europe-Africa                     🌍
globe showing Asia-Australia                    🌏
full moon                                       🌕
waning gibbous moon                             🌖
last quarter moon                               🌗
waning crescent moon                            🌘
new moon                                        🌑
waxing crescent moon                            🌒
first quarter moon                              🌓
waxing gibbous moon                             🌔
new moon face                                   🌚
full moon with face                             🌝
sun with face                                   🌞
first quarter moon with face                    🌛
last quarter moon with face                     🌜
crescent moon                                   🌙
dizzy                                           💫
white medium star                              ⭐️
glowing star                                    🌟
sparkles                                        ✨
high voltage                                   ⚡️
fire                                            🔥
collision                                       💥
comet                                           ☄
sun                                            ☀️
sun behind small cloud                          🌤
sun behind cloud                               ⛅️
sun behind large cloud                          🌥
sun behind rain cloud                           🌦
rainbow                                         🌈
cloud                                          ☁️
cloud with rain                                 🌧
cloud with lightning and rain                   ⛈
cloud with lightning                            🌩
cloud with snow                                 🌨
snowman                                        ☃️
snowman without snow                           ⛄️
snowflake                                      ❄️
wind face                                       🌬
dashing away                                    💨
tornado                                         🌪
fog                                             🌫
water wave                                      🌊
droplet                                         💧
sweat droplets                                  💦
umbrella with rain drops                       ☔️
green apple                                     🍏
red apple                                       🍎
pear                                            🍐
tangerine                                       🍊
lemon                                           🍋
banana                                          🍌
watermelon                                      🍉
grapes                                          🍇
strawberry                                      🍓
melon                                           🍈
cherries                                        🍒
peach                                           🍑
pineapple                                       🍍
kiwi fruit                                      🥝
avocado                                         🥑
tomato                                          🍅
eggplant                                        🍆
cucumber                                        🥒
carrot                                          🥕
ear of corn                                     🌽
hot pepper                                      🌶
potato                                          🥔
roasted sweet potato                            🍠
chestnut                                        🌰
peanuts                                         🥜
honey pot                                       🍯
croissant                                       🥐
bread                                           🍞
baguette bread                                  🥖
cheese wedge                                    🧀
egg                                             🥚
cooking                                         🍳
bacon                                           🥓
pancakes                                        🥞
fried shrimp                                    🍤
poultry leg                                     🍗
meat on bone                                    🍖
pizza                                           🍕
hot dog                                         🌭
hamburger                                       🍔
french fries                                    🍟
stuffed flatbread                               🥙
taco                                            🌮
burrito                                         🌯
green salad                                     🥗
shallow pan of food                             🥘
spaghetti                                       🍝
steaming bowl                                   🍜
pot of food                                     🍲
fish cake with swirl                            🍥
sushi                                           🍣
bento box                                       🍱
curry rice                                      🍛
cooked rice                                     🍚
rice ball                                       🍙
rice cracker                                    🍘
oden                                            🍢
dango                                           🍡
shaved ice                                      🍧
ice cream                                       🍨
soft ice cream                                  🍦
shortcake                                       🍰
birthday cake                                   🎂
custard                                         🍮
lollipop                                        🍭
candy                                           🍬
chocolate bar                                   🍫
popcorn                                         🍿
doughnut                                        🍩
cookie                                          🍪
glass of milk                                   🥛
baby bottle                                     🍼
hot beverage                                   ☕️
teacup without handle                           🍵
sake                                            🍶
beer mug                                        🍺
clinking beer mugs                              🍻
clinking glasses                                🥂
wine glass                                      🍷
tumbler glass                                   🥃
cocktail glass                                  🍸
tropical drink                                  🍹
bottle with popping cork                        🍾
spoon                                           🥄
fork and knife                                  🍴
fork and knife with plate                       🍽
soccer ball                                    ⚽️
basketball                                      🏀
american football                               🏈
baseball                                       ⚾️
tennis                                          🎾
volleyball                                      🏐
rugby football                                  🏉
pool 8 ball                                     🎱
ping pong                                       🏓
badminton                                       🏸
goal net                                        🥅
ice hockey                                      🏒
field hockey                                    🏑
cricket                                         🏏
flag in hole                                   ⛳️
bow and arrow                                   🏹
fishing pole                                    🎣
boxing glove                                    🥊
martial arts uniform                            🥋
ice skate                                       ⛸
skis                                            🎿
skier                                           ⛷
snowboarder                                     🏂
woman lifting weights                       🏋️‍♀️
person lifting weights                          🏋
person fencing                                  🤺
women wrestling                               🤼‍♀
men wrestling                                 🤼‍♂
woman cartwheeling                            🤸‍♀
man cartwheeling                              🤸‍♂
woman bouncing ball                         ⛹️‍♀️
person bouncing ball                            ⛹
woman playing handball                        🤾‍♀
man playing handball                          🤾‍♂
woman golfing                               🏌️‍♀️
person golfing                                  🏌
woman surfing                                 🏄‍♀
person surfing                                  🏄
woman swimming                                🏊‍♀
person swimming                                 🏊
woman playing water polo                      🤽‍♀
man playing water polo                        🤽‍♂
woman rowing boat                             🚣‍♀
person rowing boat                              🚣
horse racing                                    🏇
woman biking                                  🚴‍♀
person biking                                   🚴
woman mountain biking                         🚵‍♀
person mountain biking                          🚵
running shirt                                   🎽
sports medal                                    🏅
military medal                                  🎖
1st place medal                                 🥇
2nd place medal                                 🥈
3rd place medal                                 🥉
trophy                                          🏆
rosette                                         🏵
reminder ribbon                                 🎗
ticket                                          🎫
admission tickets                               🎟
circus tent                                     🎪
woman juggling                                🤹‍♀
man juggling                                  🤹‍♂
performing arts                                 🎭
artist palette                                  🎨
clapper board                                   🎬
microphone                                      🎤
headphone                                       🎧
musical score                                   🎼
musical keyboard                                🎹
drum                                            🥁
saxophone                                       🎷
trumpet                                         🎺
guitar                                          🎸
violin                                          🎻
game die                                        🎲
direct hit                                      🎯
bowling                                         🎳
video game                                      🎮
slot machine                                    🎰
automobile                                      🚗
taxi                                            🚕
sport utility vehicle                           🚙
bus                                             🚌
trolleybus                                      🚎
racing car                                      🏎
police car                                      🚓
ambulance                                       🚑
fire engine                                     🚒
minibus                                         🚐
delivery truck                                  🚚
articulated lorry                               🚛
tractor                                         🚜
kick scooter                                    🛴
bicycle                                         🚲
motor scooter                                   🛵
motorcycle                                      🏍
police car light                                🚨
oncoming police car                             🚔
oncoming bus                                    🚍
oncoming automobile                             🚘
oncoming taxi                                   🚖
aerial tramway                                  🚡
mountain cableway                               🚠
suspension railway                              🚟
railway car                                     🚃
tram car                                        🚋
mountain railway                                🚞
monorail                                        🚝
high-speed train                                🚄
high-speed train with bullet nose               🚅
light rail                                      🚈
locomotive                                      🚂
train                                           🚆
metro                                           🚇
tram                                            🚊
station                                         🚉
helicopter                                      🚁
small airplane                                  🛩
airplane                                       ✈️
airplane departure                              🛫
airplane arrival                                🛬
rocket                                          🚀
satellite                                       🛰
seat                                            💺
canoe                                           🛶
sailboat                                       ⛵️
motor boat                                      🛥
speedboat                                       🚤
passenger ship                                  🛳
ferry                                           ⛴
ship                                            🚢
anchor                                         ⚓️
construction                                    🚧
fuel pump                                      ⛽️
bus stop                                        🚏
vertical traffic light                          🚦
horizontal traffic light                        🚥
world map                                       🗺
moai                                            🗿
Statue of Liberty                               🗽
fountain                                       ⛲️
Tokyo tower                                     🗼
castle                                          🏰
Japanese castle                                 🏯
stadium                                         🏟
ferris wheel                                    🎡
roller coaster                                  🎢
carousel horse                                  🎠
umbrella on ground                              ⛱
beach with umbrella                             🏖
desert island                                   🏝
mountain                                        ⛰
snow-capped mountain                            🏔
mount fuji                                      🗻
volcano                                         🌋
desert                                          🏜
camping                                         🏕
tent                                           ⛺️
railway track                                   🛤
motorway                                        🛣
building construction                           🏗
factory                                         🏭
house                                           🏠
house with garden                               🏡
house                                           🏘
derelict house                                  🏚
office building                                 🏢
department store                                🏬
Japanese post office                            🏣
post office                                     🏤
hospital                                        🏥
bank                                            🏦
hotel                                           🏨
convenience store                               🏪
school                                          🏫
love hotel                                      🏩
wedding                                         💒
classical building                              🏛
church                                         ⛪️
mosque                                          🕌
synagogue                                       🕍
kaaba                                           🕋
shinto shrine                                   ⛩
map of Japan                                    🗾
moon viewing ceremony                           🎑
national park                                   🏞
sunrise                                         🌅
sunrise over mountains                          🌄
shooting star                                   🌠
sparkler                                        🎇
fireworks                                       🎆
sunset                                          🌇
cityscape at dusk                               🌆
cityscape                                       🏙
night with stars                                🌃
milky way                                       🌌
bridge at night                                 🌉
foggy                                           🌁
watch                                          ⌚️
mobile phone                                    📱
mobile phone with arrow                         📲
laptop computer                                 💻
keyboard                                       ⌨️
desktop computer                                🖥
printer                                         🖨
computer mouse                                  🖱
trackball                                       🖲
joystick                                        🕹
clamp                                           🗜
computer disk                                   💽
floppy disk                                     💾
optical disk                                    💿
dvd                                             📀
videocassette                                   📼
camera                                          📷
camera with flash                               📸
video camera                                    📹
movie camera                                    🎥
film projector                                  📽
film frames                                     🎞
telephone receiver                              📞
telephone                                      ☎️
pager                                           📟
fax machine                                     📠
television                                      📺
radio                                           📻
studio microphone                               🎙
level slider                                    🎚
control knobs                                   🎛
stopwatch                                       ⏱
timer clock                                     ⏲
alarm clock                                     ⏰
mantelpiece clock                               🕰
hourglass                                      ⌛️
hourglass with flowing sand                     ⏳
satellite antenna                               📡
battery                                         🔋
electric plug                                   🔌
light bulb                                      💡
flashlight                                      🔦
candle                                          🕯
wastebasket                                     🗑
oil drum                                        🛢
money with wings                                💸
dollar banknote                                 💵
yen banknote                                    💴
euro banknote                                   💶
pound banknote                                  💷
money bag                                       💰
credit card                                     💳
gem stone                                       💎
balance scale                                  ⚖️
wrench                                          🔧
hammer                                          🔨
hammer and pick                                 ⚒
hammer and wrench                               🛠
pick                                            ⛏
nut and bolt                                    🔩
gear                                           ⚙️
chains                                          ⛓
pistol                                          🔫
bomb                                            💣
kitchen knife                                   🔪
dagger                                          🗡
crossed swords                                 ⚔️
shield                                          🛡
cigarette                                       🚬
coffin                                         ⚰️
funeral urn                                    ⚱️
amphora                                         🏺
crystal ball                                    🔮
prayer beads                                    📿
barber pole                                     💈
alembic                                        ⚗️
telescope                                       🔭
microscope                                      🔬
hole                                            🕳
pill                                            💊
syringe                                         💉
thermometer                                     🌡
toilet                                          🚽
potable water                                   🚰
shower                                          🚿
bathtub                                         🛁
person taking bath                              🛀
bellhop bell                                    🛎
key                                             🔑
old key                                         🗝
door                                            🚪
couch and lamp                                  🛋
bed                                             🛏
person in bed                                   🛌
framed picture                                  🖼
shopping bags                                   🛍
shopping cart                                   🛒
wrapped gift                                    🎁
balloon                                         🎈
carp streamer                                   🎏
ribbon                                          🎀
confetti ball                                   🎊
party popper                                    🎉
Japanese dolls                                  🎎
red paper lantern                               🏮
wind chime                                      🎐
envelope                                       ✉️
envelope with arrow                             📩
incoming envelope                               📨
e-mail                                          📧
love letter                                     💌
inbox tray                                      📥
outbox tray                                     📤
package                                         📦
label                                           🏷
closed mailbox with lowered flag                📪
closed mailbox with raised flag                 📫
open mailbox with raised flag                   📬
open mailbox with lowered flag                  📭
postbox                                         📮
postal horn                                     📯
scroll                                          📜
page with curl                                  📃
page facing up                                  📄
bookmark tabs                                   📑
bar chart                                       📊
chart increasing                                📈
chart decreasing                                📉
spiral notepad                                  🗒
spiral calendar                                 🗓
tear-off calendar                               📆
calendar                                        📅
card index                                      📇
card file box                                   🗃
ballot box with ballot                          🗳
file cabinet                                    🗄
clipboard                                       📋
file folder                                     📁
open file folder                                📂
card index dividers                             🗂
rolled-up newspaper                             🗞
newspaper                                       📰
notebook                                        📓
notebook with decorative cover                  📔
ledger                                          📒
closed book                                     📕
green book                                      📗
blue book                                       📘
orange book                                     📙
books                                           📚
open book                                       📖
bookmark                                        🔖
link                                            🔗
paperclip                                       📎
linked paperclips                               🖇
triangular ruler                                📐
straight ruler                                  📏
pushpin                                         📌
round pushpin                                   📍
scissors                                       ✂️
pen                                             🖊
fountain pen                                    🖋
black nib                                      ✒️
paintbrush                                      🖌
crayon                                          🖍
memo                                            📝
pencil                                         ✏️
left-pointing magnifying glass                  🔍
right-pointing magnifying glass                 🔎
locked with pen                                 🔏
locked with key                                 🔐
locked                                          🔒
unlocked                                        🔓
red heart                                      ❤️
yellow heart                                    💛
green heart                                     💚
blue heart                                      💙
purple heart                                    💜
black heart                                     🖤
broken heart                                    💔
heavy heart exclamation                        ❣️
two hearts                                      💕
revolving hearts                                💞
beating heart                                   💓
growing heart                                   💗
sparkling heart                                 💖
heart with arrow                                💘
heart with ribbon                               💝
heart decoration                                💟
peace symbol                                   ☮️
latin cross                                    ✝️
star and crescent                              ☪️
om                                              🕉
wheel of dharma                                ☸️
star of David                                  ✡️
dotted six-pointed star                         🔯
menorah                                         🕎
yin yang                                       ☯️
orthodox cross                                 ☦️
place of worship                                🛐
Ophiuchus                                       ⛎
Aries                                          ♈️
Taurus                                         ♉️
Gemini                                         ♊️
Cancer                                         ♋️
Leo                                            ♌️
Virgo                                          ♍️
Libra                                          ♎️
Scorpius                                       ♏️
Sagittarius                                    ♐️
Capricorn                                      ♑️
Aquarius                                       ♒️
Pisces                                         ♓️
ID button                                       🆔
atom symbol                                    ⚛️
Japanese “acceptable” button                    🉑
radioactive                                    ☢️
biohazard                                      ☣️
mobile phone off                                📴
vibration mode                                  📳
Japanese “not free of charge” button            🈶
Japanese “free of charge” button               🈚️
Japanese “application” button                   🈸
Japanese “open for business” button             🈺
Japanese “monthly amount” button               🈷️
eight-pointed star                             ✴️
VS button                                       🆚
white flower                                    💮
Japanese “bargain” button                       🉐
Japanese “secret” button                       ㊙️
Japanese “congratulations” button              ㊗️
Japanese “passing grade” button                 🈴
Japanese “no vacancy” button                    🈵
Japanese “discount” button                      🈹
Japanese “prohibited” button                    🈲
A button (blood type)                          🅰️
B button (blood type)                          🅱️
AB button (blood type)                          🆎
CL button                                       🆑
O button (blood type)                          🅾️
SOS button                                      🆘
cross mark                                      ❌
heavy large circle                             ⭕️
stop sign                                       🛑
no entry                                       ⛔️
name badge                                      📛
prohibited                                      🚫
hundred points                                  💯
anger symbol                                    💢
hot springs                                    ♨️
no pedestrians                                  🚷
no littering                                    🚯
no bicycles                                     🚳
non-potable water                               🚱
no one under eighteen                           🔞
no mobile phones                                📵
no smoking                                      🚭
exclamation mark                               ❗️
white exclamation mark                          ❕
question mark                                   ❓
white question mark                             ❔
double exclamation mark                        ‼️
exclamation question mark                      ⁉️
dim button                                      🔅
bright button                                   🔆
part alternation mark                          〽️
warning                                        ⚠️
children crossing                               🚸
trident emblem                                  🔱
fleur-de-lis                                   ⚜️
Japanese symbol for beginner                    🔰
recycling symbol                               ♻️
white heavy check mark                          ✅
Japanese “reserved” button                     🈯️
chart increasing with yen                       💹
sparkle                                        ❇️
eight-spoked asterisk                          ✳️
cross mark button                               ❎
globe with meridians                            🌐
diamond with a dot                              💠
circled M                                      Ⓜ️
cyclone                                         🌀
zzz                                             💤
ATM sign                                        🏧
water closet                                    🚾
wheelchair symbol                              ♿️
P button                                       🅿️
Japanese “vacancy” button                       🈳
Japanese “service charge” button               🈂️
passport control                                🛂
customs                                         🛃
baggage claim                                   🛄
left luggage                                    🛅
men’s room                                      🚹
women’s room                                    🚺
baby symbol                                     🚼
restroom                                        🚻
litter in bin sign                              🚮
cinema                                          🎦
antenna bars                                    📶
Japanese “here” button                          🈁
input symbols                                   🔣
information                                    ℹ️
input latin letters                             🔤
input latin lowercase                           🔡
input latin uppercase                           🔠
NG button                                       🆖
OK button                                       🆗
UP! button                                      🆙
COOL button                                     🆒
NEW button                                      🆕
FREE button                                     🆓
keycap: 0                                     0️⃣
keycap: 1                                     1️⃣
keycap: 2                                     2️⃣
keycap: 3                                     3️⃣
keycap: 4                                     4️⃣
keycap: 5                                     5️⃣
keycap: 6                                     6️⃣
keycap: 7                                     7️⃣
keycap: 8                                     8️⃣
keycap: 9                                     9️⃣
keycap 10                                       🔟
input numbers                                   🔢
keycap: #                                     #️⃣
keycap: *                                     *️⃣
play button                                    ▶️
pause button                                    ⏸
play or pause button                            ⏯
stop button                                     ⏹
record button                                   ⏺
next track button                               ⏭
last track button                               ⏮
fast-forward button                             ⏩
fast reverse button                             ⏪
fast up button                                  ⏫
fast down button                                ⏬
reverse button                                 ◀️
up button                                       🔼
down button                                     🔽
right arrow                                    ➡️
left arrow                                     ⬅️
up arrow                                       ⬆️
down arrow                                     ⬇️
up-right arrow                                 ↗️
down-right arrow                               ↘️
down-left arrow                                ↙️
up-left arrow                                  ↖️
up-down arrow                                  ↕️
left-right arrow                               ↔️
left arrow curving right                       ↪️
right arrow curving left                       ↩️
right arrow curving up                         ⤴️
right arrow curving down                       ⤵️
shuffle tracks button                           🔀
repeat button                                   🔁
repeat single button                            🔂
anticlockwise arrows button                     🔄
clockwise vertical arrows                       🔃
musical note                                    🎵
musical notes                                   🎶
heavy plus sign                                 ➕
heavy minus sign                                ➖
heavy division sign                             ➗
heavy multiplication x                         ✖️
heavy dollar sign                               💲
currency exchange                               💱
trade mark                                     ™️
copyright                                      ©️
registered                                     ®️
wavy dash                                      〰️
curly loop                                      ➰
double curly loop                               ➿
END arrow                                       🔚
BACK arrow                                      🔙
ON! arrow                                       🔛
TOP arrow                                       🔝
SOON arrow                                      🔜
heavy check mark                               ✔️
ballot box with check                          ☑️
radio button                                    🔘
white circle                                   ⚪️
black circle                                   ⚫️
red circle                                      🔴
blue circle                                     🔵
red triangle pointed up                         🔺
red triangle pointed down                       🔻
small orange diamond                            🔸
small blue diamond                              🔹
large orange diamond                            🔶
large blue diamond                              🔷
white square button                             🔳
black square button                             🔲
black small square                             ▪️
white small square                             ▫️
black medium-small square                      ◾️
white medium-small square                      ◽️
black medium square                            ◼️
white medium square                            ◻️
black large square                             ⬛️
white large square                             ⬜️
speaker low volume                              🔈
muted speaker                                   🔇
speaker medium volume                           🔉
speaker high volume                             🔊
bell                                            🔔
bell with slash                                 🔕
megaphone                                       📣
loudspeaker                                     📢
eye in speech bubble                          👁‍🗨
speech balloon                                  💬
thought balloon                                 💭
right anger bubble                              🗯
spade suit                                     ♠️
club suit                                      ♣️
heart suit                                     ♥️
diamond suit                                   ♦️
joker                                           🃏
flower playing cards                            🎴
mahjong red dragon                             🀄️
one o’clock                                     🕐
two o’clock                                     🕑
three o’clock                                   🕒
four o’clock                                    🕓
five o’clock                                    🕔
six o’clock                                     🕕
seven o’clock                                   🕖
eight o’clock                                   🕗
nine o’clock                                    🕘
ten o’clock                                     🕙
eleven o’clock                                  🕚
twelve o’clock                                  🕛
one-thirty                                      🕜
two-thirty                                      🕝
three-thirty                                    🕞
four-thirty                                     🕟
five-thirty                                     🕠
six-thirty                                      🕡
seven-thirty                                    🕢
eight-thirty                                    🕣
nine-thirty                                     🕤
ten-thirty                                      🕥
eleven-thirty                                   🕦
twelve-thirty                                   🕧
white flag                                     🏳️
black flag                                      🏴
chequered flag                                  🏁
triangular flag                                 🚩
rainbow flag                                 🏳️‍🌈
ad                                               
address-book                                     
address-card                                     
adjust                                           
air-freshener                                    
align-center                                     
align-justify                                    
align-left                                       
align-right                                      
allergies                                        
ambulance                                        
american-sign-language-interpreting              
anchor                                           
angle-double-down                                
angle-double-left                                
angle-double-right                               
angle-double-up                                  
angle-down                                       
angle-left                                       
angle-right                                      
angle-up                                         
angry                                            
ankh                                             
apple-alt                                        
archive                                          
archway                                          
arrow-alt-circle-down                            
arrow-alt-circle-left                            
arrow-alt-circle-right                           
arrow-alt-circle-up                              
arrow-circle-down                                
arrow-circle-left                                
arrow-circle-right                               
arrow-circle-up                                  
arrow-down                                       
arrow-left                                       
arrow-right                                      
arrow-up                                         
arrows-alt                                       
arrows-alt-h                                     
arrows-alt-v                                     
assistive-listening-systems                      
asterisk                                         
at                                               
atlas                                            
atom                                             
audio-description                                
award                                            
baby                                             
baby-carriage                                    
backspace                                        
backward                                         
bacon                                            
bacteria                                         
bacterium                                        
bahai                                            
balance-scale                                    
balance-scale-left                               
balance-scale-right                              
ban                                              
band-aid                                         
barcode                                          
bars                                             
baseball-ball                                    
basketball-ball                                  
bath                                             
battery-empty                                    
battery-full                                     
battery-half                                     
battery-quarter                                  
battery-three-quarters                           
bed                                              
beer                                             
bell                                             
bell-slash                                       
bezier-curve                                     
bible                                            
bicycle                                          
biking                                           
binoculars                                       
biohazard                                        
birthday-cake                                    
blender                                          
blender-phone                                    
blind                                            
blog                                             
bold                                             
bolt                                             
bomb                                             
bone                                             
bong                                             
book                                             
book-dead                                        
book-medical                                     
book-open                                        
book-reader                                      
bookmark                                         
border-all                                       
border-none                                      
border-style                                     
bowling-ball                                     
box                                              
box-open                                         
box-tissue                                       
boxes                                            
braille                                          
brain                                            
bread-slice                                      
briefcase                                        
briefcase-medical                                
broadcast-tower                                  
broom                                            
brush                                            
bug                                              
building                                         
bullhorn                                         
bullseye                                         
burn                                             
bus                                              
bus-alt                                          
business-time                                    
calculator                                       
calendar                                         
calendar-alt                                     
calendar-check                                   
calendar-day                                     
calendar-minus                                   
calendar-plus                                    
calendar-times                                   
calendar-week                                    
camera                                           
camera-retro                                     
campground                                       
candy-cane                                       
cannabis                                         
capsules                                         
car                                              
car-alt                                          
car-battery                                      
car-crash                                        
car-side                                         
caravan                                          
caret-down                                       
caret-left                                       
caret-right                                      
caret-square-down                                
caret-square-left                                
caret-square-right                               
caret-square-up                                  
caret-up                                         
carrot                                           
cart-arrow-down                                  
cart-plus                                        
cash-register                                    
cat                                              
certificate                                      
chair                                            
chalkboard                                       
chalkboard-teacher                               
charging-station                                 
chart-area                                       
chart-bar                                        
chart-line                                       
chart-pie                                        
check                                            
check-circle                                     
check-double                                     
check-square                                     
cheese                                           
chess                                            
chess-bishop                                     
chess-board                                      
chess-king                                       
chess-knight                                     
chess-pawn                                       
chess-queen                                      
chess-rook                                       
chevron-circle-down                              
chevron-circle-left                              
chevron-circle-right                             
chevron-circle-up                                
chevron-down                                     
chevron-left                                     
chevron-right                                    
chevron-up                                       
child                                            
church                                           
circle                                           
circle-notch                                     
city                                             
clinic-medical                                   
clipboard                                        
clipboard-check                                  
clipboard-list                                   
clock                                            
clone                                            
closed-captioning                                
cloud                                            
cloud-download-alt                               
cloud-meatball                                   
cloud-moon                                       
cloud-moon-rain                                  
cloud-rain                                       
cloud-showers-heavy                              
cloud-sun                                        
cloud-sun-rain                                   
cloud-upload-alt                                 
cocktail                                         
code                                             
code-branch                                      
coffee                                           
cog                                              
cogs                                             
coins                                            
columns                                          
comment                                          
comment-alt                                      
comment-dollar                                   
comment-dots                                     
comment-medical                                  
comment-slash                                    
comments                                         
comments-dollar                                  
compact-disc                                     
compass                                          
compress                                         
compress-alt                                     
compress-arrows-alt                              
concierge-bell                                   
cookie                                           
cookie-bite                                      
copy                                             
copyright                                        
couch                                            
credit-card                                      
crop                                             
crop-alt                                         
cross                                            
crosshairs                                       
crow                                             
crown                                            
crutch                                           
cube                                             
cubes                                            
cut                                              
database                                         
deaf                                             
democrat                                         
desktop                                          
dharmachakra                                     
diagnoses                                        
dice                                             
dice-d20                                         
dice-d6                                          
dice-five                                        
dice-four                                        
dice-one                                         
dice-six                                         
dice-three                                       
dice-two                                         
digital-tachograph                               
directions                                       
disease                                          
divide                                           
dizzy                                            
dna                                              
dog                                              
dollar-sign                                      
dolly                                            
dolly-flatbed                                    
donate                                           
door-closed                                      
door-open                                        
dot-circle                                       
dove                                             
download                                         
drafting-compass                                 
dragon                                           
draw-polygon                                     
drum                                             
drum-steelpan                                    
drumstick-bite                                   
dumbbell                                         
dumpster                                         
dumpster-fire                                    
dungeon                                          
edit                                             
egg                                              
eject                                            
ellipsis-h                                       
ellipsis-v                                       
envelope                                         
envelope-open                                    
envelope-open-text                               
envelope-square                                  
equals                                           
eraser                                           
ethernet                                         
euro-sign                                        
exchange-alt                                     
exclamation                                      
exclamation-circle                               
exclamation-triangle                             
expand                                           
expand-alt                                       
expand-arrows-alt                                
external-link-alt                                
external-link-square-alt                         
eye                                              
eye-dropper                                      
eye-slash                                        
fan                                              
fast-backward                                    
fast-forward                                     
faucet                                           
fax                                              
feather                                          
feather-alt                                      
female                                           
fighter-jet                                      
file                                             
file-alt                                         
file-archive                                     
file-audio                                       
file-code                                        
file-contract                                    
file-csv                                         
file-download                                    
file-excel                                       
file-export                                      
file-image                                       
file-import                                      
file-invoice                                     
file-invoice-dollar                              
file-medical                                     
file-medical-alt                                 
file-pdf                                         
file-powerpoint                                  
file-prescription                                
file-signature                                   
file-upload                                      
file-video                                       
file-word                                        
fill                                             
fill-drip                                        
film                                             
filter                                           
fingerprint                                      
fire                                             
fire-alt                                         
fire-extinguisher                                
first-aid                                        
fish                                             
fist-raised                                      
flag                                             
flag-checkered                                   
flag-usa                                         
flask                                            
flushed                                          
folder                                           
folder-minus                                     
folder-open                                      
folder-plus                                      
font                                             
football-ball                                    
forward                                          
frog                                             
frown                                            
frown-open                                       
funnel-dollar                                    
futbol                                           
gamepad                                          
gas-pump                                         
gavel                                            
gem                                              
genderless                                       
ghost                                            
gift                                             
gifts                                            
glass-cheers                                     
glass-martini                                    
glass-martini-alt                                
glass-whiskey                                    
glasses                                          
globe                                            
globe-africa                                     
globe-americas                                   
globe-asia                                       
globe-europe                                     
golf-ball                                        
gopuram                                          
graduation-cap                                   
greater-than                                     
greater-than-equal                               
grimace                                          
grin                                             
grin-alt                                         
grin-beam                                        
grin-beam-sweat                                  
grin-hearts                                      
grin-squint                                      
grin-squint-tears                                
grin-stars                                       
grin-tears                                       
grin-tongue                                      
grin-tongue-squint                               
grin-tongue-wink                                 
grin-wink                                        
grip-horizontal                                  
grip-lines                                       
grip-lines-vertical                              
grip-vertical                                    
guitar                                           
h-square                                         
hamburger                                        
hammer                                           
hamsa                                            
hand-holding                                     
hand-holding-heart                               
hand-holding-medical                             
hand-holding-usd                                 
hand-holding-water                               
hand-lizard                                      
hand-middle-finger                               
hand-paper                                       
hand-peace                                       
hand-point-down                                  
hand-point-left                                  
hand-point-right                                 
hand-point-up                                    
hand-pointer                                     
hand-rock                                        
hand-scissors                                    
hand-sparkles                                    
hand-spock                                       
hands                                            
hands-helping                                    
hands-wash                                       
handshake                                        
handshake-alt-slash                              
handshake-slash                                  
hanukiah                                         
hard-hat                                         
hashtag                                          
hat-cowboy                                       
hat-cowboy-side                                  
hat-wizard                                       
hdd                                              
head-side-cough                                  
head-side-cough-slash                            
head-side-mask                                   
head-side-virus                                  
heading                                          
headphones                                       
headphones-alt                                   
headset                                          
heart                                            
heart-broken                                     
heartbeat                                        
helicopter                                       
highlighter                                      
hiking                                           
hippo                                            
history                                          
hockey-puck                                      
holly-berry                                      
home                                             
horse                                            
horse-head                                       
hospital                                         
hospital-alt                                     
hospital-symbol                                  
hospital-user                                    
hot-tub                                          
hotdog                                           
hotel                                            
hourglass                                        
hourglass-end                                    
hourglass-half                                   
hourglass-start                                  
house-damage                                     
house-user                                       
hryvnia                                          
i-cursor                                         
ice-cream                                        
icicles                                          
icons                                            
id-badge                                         
id-card                                          
id-card-alt                                      
igloo                                            
image                                            
images                                           
inbox                                            
indent                                           
industry                                         
infinity                                         
info                                             
info-circle                                      
italic                                           
jedi                                             
joint                                            
journal-whills                                   
kaaba                                            
key                                              
keyboard                                         
khanda                                           
kiss                                             
kiss-beam                                        
kiss-wink-heart                                  
kiwi-bird                                        
landmark                                         
language                                         
laptop                                           
laptop-code                                      
laptop-house                                     
laptop-medical                                   
laugh                                            
laugh-beam                                       
laugh-squint                                     
laugh-wink                                       
layer-group                                      
leaf                                             
lemon                                            
less-than                                        
less-than-equal                                  
level-down-alt                                   
level-up-alt                                     
life-ring                                        
lightbulb                                        
link                                             
lira-sign                                        
list                                             
list-alt                                         
list-ol                                          
list-ul                                          
location-arrow                                   
lock                                             
lock-open                                        
long-arrow-alt-down                              
long-arrow-alt-left                              
long-arrow-alt-right                             
long-arrow-alt-up                                
low-vision                                       
luggage-cart                                     
lungs                                            
lungs-virus                                      
magic                                            
magnet                                           
mail-bulk                                        
male                                             
map                                              
map-marked                                       
map-marked-alt                                   
map-marker                                       
map-marker-alt                                   
map-pin                                          
map-signs                                        
marker                                           
mars                                             
mars-double                                      
mars-stroke                                      
mars-stroke-h                                    
mars-stroke-v                                    
mask                                             
medal                                            
medkit                                           
meh                                              
meh-blank                                        
meh-rolling-eyes                                 
memory                                           
menorah                                          
mercury                                          
meteor                                           
microchip                                        
microphone                                       
microphone-alt                                   
microphone-alt-slash                             
microphone-slash                                 
microscope                                       
minus                                            
minus-circle                                     
minus-square                                     
mitten                                           
mobile                                           
mobile-alt                                       
money-bill                                       
money-bill-alt                                   
money-bill-wave                                  
money-bill-wave-alt                              
money-check                                      
money-check-alt                                  
monument                                         
moon                                             
mortar-pestle                                    
mosque                                           
motorcycle                                       
mountain                                         
mouse                                            
mouse-pointer                                    
mug-hot                                          
music                                            
network-wired                                    
neuter                                           
newspaper                                        
not-equal                                        
notes-medical                                    
object-group                                     
object-ungroup                                   
oil-can                                          
om                                               
otter                                            
outdent                                          
pager                                            
paint-brush                                      
paint-roller                                     
palette                                          
pallet                                           
paper-plane                                      
paperclip                                        
parachute-box                                    
paragraph                                        
parking                                          
passport                                         
pastafarianism                                   
paste                                            
pause                                            
pause-circle                                     
paw                                              
peace                                            
pen                                              
pen-alt                                          
pen-fancy                                        
pen-nib                                          
pen-square                                       
pencil-alt                                       
pencil-ruler                                     
people-arrows                                    
people-carry                                     
pepper-hot                                       
percent                                          
percentage                                       
person-booth                                     
phone                                            
phone-alt                                        
phone-slash                                      
phone-square                                     
phone-square-alt                                 
phone-volume                                     
photo-video                                      
piggy-bank                                       
pills                                            
pizza-slice                                      
place-of-worship                                 
plane                                            
plane-arrival                                    
plane-departure                                  
plane-slash                                      
play                                             
play-circle                                      
plug                                             
plus                                             
plus-circle                                      
plus-square                                      
podcast                                          
poll                                             
poll-h                                           
poo                                              
poo-storm                                        
poop                                             
portrait                                         
pound-sign                                       
power-off                                        
pray                                             
praying-hands                                    
prescription                                     
prescription-bottle                              
prescription-bottle-alt                          
print                                            
procedures                                       
project-diagram                                  
pump-medical                                     
puzzle-piece                                     
qrcode                                           
question                                         
question-circle                                  
quidditch                                        
quote-left                                       
quote-right                                      
quran                                            
radiation                                        
radiation-alt                                    
rainbow                                          
random                                           
receipt                                          
record-vinyl                                     
recycle                                          
redo                                             
redo-alt                                         
registered                                       
remove-format                                    
reply                                            
reply-all                                        
republican                                       
restroom                                         
retweet                                          
ribbon                                           
ring                                             
road                                             
robot                                            
rocket                                           
route                                            
rss                                              
rss-square                                       
ruble-sign                                       
ruler                                            
ruler-combined                                   
ruler-horizontal                                 
ruler-vertical                                   
running                                          
rupee-sign                                       
sad-cry                                          
sad-tear                                         
satellite                                        
satellite-dish                                   
save                                             
school                                           
screwdriver                                      
scroll                                           
sd-card                                          
search                                           
search-dollar                                    
search-location                                  
search-minus                                     
search-plus                                      
seedling                                         
server                                           
shapes                                           
share                                            
share-alt                                        
share-alt-square                                 
share-square                                     
shekel-sign                                      
shield-alt                                       
shield-virus                                     
ship                                             
shipping-fast                                    
shoe-prints                                      
shopping-bag                                     
shopping-basket                                  
shopping-cart                                    
shower                                           
shuttle-van                                      
sign                                             
sign-in-alt                                      
sign-language                                    
sign-out-alt                                     
signal                                           
signature                                        
sim-card                                         
sink                                             
sitemap                                          
skating                                          
skiing                                           
skiing-nordic                                    
skull                                            
skull-crossbones                                 
slash                                            
sleigh                                           
sliders-h                                        
smile                                            
smile-beam                                       
smile-wink                                       
smog                                             
smoking                                          
smoking-ban                                      
sms                                              
snowboarding                                     
snowflake                                        
snowman                                          
snowplow                                         
soap                                             
socks                                            
solar-panel                                      
sort                                             
sort-alpha-down                                  
sort-alpha-down-alt                              
sort-alpha-up                                    
sort-alpha-up-alt                                
sort-amount-down                                 
sort-amount-down-alt                             
sort-amount-up                                   
sort-amount-up-alt                               
sort-down                                        
sort-numeric-down                                
sort-numeric-down-alt                            
sort-numeric-up                                  
sort-numeric-up-alt                              
sort-up                                          
spa                                              
space-shuttle                                    
spell-check                                      
spider                                           
spinner                                          
splotch                                          
spray-can                                        
square                                           
square-full                                      
square-root-alt                                  
stamp                                            
star                                             
star-and-crescent                                
star-half                                        
star-half-alt                                    
star-of-david                                    
star-of-life                                     
step-backward                                    
step-forward                                     
stethoscope                                      
sticky-note                                      
stop                                             
stop-circle                                      
stopwatch                                        
stopwatch-20                                     
store                                            
store-alt                                        
store-alt-slash                                  
store-slash                                      
stream                                           
street-view                                      
strikethrough                                    
stroopwafel                                      
subscript                                        
subway                                           
suitcase                                         
suitcase-rolling                                 
sun                                              
superscript                                      
surprise                                         
swatchbook                                       
swimmer                                          
swimming-pool                                    
synagogue                                        
sync                                             
sync-alt                                         
syringe                                          
table                                            
table-tennis                                     
tablet                                           
tablet-alt                                       
tablets                                          
tachometer-alt                                   
tag                                              
tags                                             
tape                                             
tasks                                            
taxi                                             
teeth                                            
teeth-open                                       
temperature-high                                 
temperature-low                                  
tenge                                            
terminal                                         
text-height                                      
text-width                                       
th                                               
th-large                                         
th-list                                          
theater-masks                                    
thermometer                                      
thermometer-empty                                
thermometer-full                                 
thermometer-half                                 
thermometer-quarter                              
thermometer-three-quarters                       
thumbs-down                                      
thumbs-up                                        
thumbtack                                        
ticket-alt                                       
times                                            
times-circle                                     
tint                                             
tint-slash                                       
tired                                            
toggle-off                                       
toggle-on                                        
toilet                                           
toilet-paper                                     
toilet-paper-slash                               
toolbox                                          
tools                                            
tooth                                            
torah                                            
torii-gate                                       
tractor                                          
trademark                                        
traffic-light                                    
trailer                                          
train                                            
tram                                             
transgender                                      
transgender-alt                                  
trash                                            
trash-alt                                        
trash-restore                                    
trash-restore-alt                                
tree                                             
trophy                                           
truck                                            
truck-loading                                    
truck-monster                                    
truck-moving                                     
truck-pickup                                     
tshirt                                           
tty                                              
tv                                               
umbrella                                         
umbrella-beach                                   
underline                                        
undo                                             
undo-alt                                         
universal-access                                 
university                                       
unlink                                           
unlock                                           
unlock-alt                                       
upload                                           
user                                             
user-alt                                         
user-alt-slash                                   
user-astronaut                                   
user-check                                       
user-circle                                      
user-clock                                       
user-cog                                         
user-edit                                        
user-graduate                                    
user-injured                                     
user-lock                                        
user-md                                          
user-minus                                       
user-ninja                                       
user-nurse                                       
user-plus                                        
user-secret                                      
user-shield                                      
user-slash                                       
user-tag                                         
user-tie                                         
user-times                                       
users                                            
users-cog                                        
users-slash                                      
utensil-spoon                                    
utensils                                         
vector-square                                    
venus                                            
venus-double                                     
venus-mars                                       
vest                                             
vest-patches                                     
vial                                             
vials                                            
video                                            
video-slash                                      
vihara                                           
virus                                            
virus-slash                                      
viruses                                          
voicemail                                        
volleyball-ball                                  
volume-down                                      
volume-mute                                      
volume-off                                       
volume-up                                        
vote-yea                                         
vr-cardboard                                     
walking                                          
wallet                                           
warehouse                                        
water                                            
wave-square                                      
weight                                           
weight-hanging                                   
wheelchair                                       
wifi                                             
wind                                             
window-close                                     
window-maximize                                  
window-minimize                                  
window-restore                                   
wine-bottle                                      
wine-glass                                       
wine-glass-alt                                   
won-sign                                         
wrench                                           
x-ray                                            
yen-sign                                         
yin-yang                                         
