local E, L = unpack(ElvUI)
local oUF = E.oUF
local NP = E:GetModule('NamePlates')
local elementAdded = false
local _G = _G
local math = _G.math
local UnitCanAttack = _G.UnitCanAttack
local UnitIsPlayer = _G.UnitIsPlayer
local UnitGUID = _G.UnitGUID
local UnitClassification = _G.UnitClassification
local hooksecurefunc = _G.hooksecurefunc

--based on blinkii's idea
local bossIDs = {

	-------Classic-------

	--stratholme
	["10813"] = true, --balnazzar
	["10436"] = true, --baroness-anastari
	["11121"] = true, --black-guard-swordsmith
	["11032"] = true, --commander-malor
	["11058"] = true, --ezra-grimm
	["10558"] = true, --hearthsinger-forresten
	["10811"] = true, --instructor-galford
	["45412"] = true, --lord-aurius-rivendare
	["10435"] = true, --magistrate-barthilas
	["10438"] = true, --maleki-the-pallid
	["10437"] = true, --nerubenkan
	["11143"] = true, --postmaster-malown
	["10439"] = true, --ramstein-the-gorger
	["11120"] = true, --risen-hammersmith
	["10393"] = true, --skul
	["10809"] = true, --stonespine
	["11082"] = true, --stratholme-courier
	["10516"] = true, --the-unforgiven
	["10808"] = true, --timmy-the-cruel
	["10997"] = true, --willey-hopebreaker

	--blackrock-depths
	["9156"] = true, --ambassador-flamelash
	["9031"] = true, --anubshiah
	["9016"] = true, --baelgar
	["9438"] = true, --dark-keeper-bethek
	["9442"] = true, --dark-keeper-ofgut
	["9443"] = true, --dark-keeper-pelver
	["9439"] = true, --dark-keeper-uggel
	["9437"] = true, --dark-keeper-vorfalk
	["9441"] = true, --dark-keeper-zimrel
	["9039"] = true, --doomrel
	["9019"] = true, --emperor-dagran-thaurissan
	["9029"] = true, --eviscerator
	["9056"] = true, --fineous-darkvire
	["9033"] = true, --general-angerforge
	["8983"] = true, --golem-lord-argelmach
	["9027"] = true, --gorosh-the-dervish
	["9028"] = true, --grizzle
	["9032"] = true, --hedrum-the-creeper
	["9018"] = true, --high-interrogator-gerstahn
	["143607"] = true, --high-justice-grimstone
	["10076"] = true, --high-priestess-of-thaurissan
	["9319"] = true, --houndmaster-grebmar
	["9537"] = true, --hurley-blackbreath
	["9017"] = true, --lord-incendius
	["9025"] = true, --lord-roccor
	["9938"] = true, --magmus
	["9030"] = true, --okthor-the-breaker
	["8923"] = true, --panzor-the-invincible
	["9502"] = true, --phalanx
	["9499"] = true, --plugger-spazzring
	["8929"] = true, --princess-moira-bronzebeard
	["9024"] = true, --pyromancer-loregrain
	["9543"] = true, --ribbly-screwspigot
	["16059"] = true, --theldren
	["9042"] = true, --verek
	["9041"] = true, --warder-stilgiss
	["9476"] = true, --watchman-doomgrip

	--classic world bosses
	["6109"] = true, --azuregos
	["15205"] = true, --baron-kazum
	["15305"] = true, --lord-skwol
	["15204"] = true, --high-marshal-whirlaxis
	["15203"] = true, --prince-skaldrenox
	["14890"] = true, --taerar
	["14887"] = true, --ysondre
	["15491"] = true, --eranikus-tyrant-of-the-dream
	["12397"] = true, --lord-kazzak
	["15571"] = true, --maws
	["15818"] = true, --lieutenant-general-nokhor
	["7846"] = true, --teremus-the-devourer
	["15625"] = true, --twilight-corrupter
	["18338"] = true, --highlord-kruul
	["14889"] = true, --emeriss
	["14888"] = true, --lethon

	--sunken-temple
	["8443"] = true, --avatar-of-hakkar
	["5721"] = true, --dreamscythe
	["5722"] = true, --hazzas
	["5710"] = true, --jammalan-the-prophet
	["5711"] = true, --ogom-the-wretched
	["5719"] = true, --morphaz
	["5709"] = true, --shade-of-eranikus
	["5720"] = true, --weaver

	--the-deadmines
	["47739"] = true, --captain-cookie
	["47626"] = true, --admiral-ripsnarl
	["596"] = true, --brainwashed-noble
	["87407"] = true, --cookie
	["42697"] = true, --edwin-vancleef
	["43778"] = true, --foe-reaper-5000
	["47162"] = true, --glubtok
	["47296"] = true, --helix-gearbreaker
	["599"] = true, --marisa-dupaige
	["3586"] = true, --miner-johnson
	["65014"] = true, --mr-smite
	["49541"] = true, --vanessa-vancleef
	["644"] = true, --rhahkzor
	["642"] = true, --sneeds-shredder
	["1763"] = true, --gilnid
	["647"] = true, --captain-greenskin
	["639"] = true, --edwin-vancleef
	["645"] = true, --cookie

	--blackrock-spire
	["9596"] = true, --bannok-grimaxe
	["10263"] = true, --burning-felguard
	["10376"] = true, --crystal-fang
	["9718"] = true, --ghok-bashguud
	["10268"] = true, --gizrul-the-slavener
	["10220"] = true, --halycon
	["9196"] = true, --highlord-omokk
	["16080"] = true, --mor-grayhoof
	["10596"] = true, --mother-smolderweb
	["9568"] = true, --overlord-wyrmthalak
	["9736"] = true, --quartermaster-zigris
	["9236"] = true, --shadow-hunter-voshgajin
	["9218"] = true, --spirestone-battle-lord
	["9219"] = true, --spirestone-butcher
	["10584"] = true, --urok-doomhowl
	["9237"] = true, --war-master-voone

	--ragefire-chasm
	["61408"] = true, --adarogg
	["61412"] = true, --dark-shaman-koranthal
	["61528"] = true, --lava-guard-gordoth
	["61463"] = true, --slagmaw

	--dire-maul
	["11492"] = true, --alzzin-the-wildshaper
	["14325"] = true, --captain-kromcrush
	["14324"] = true, --chorush-the-observer
	["14308"] = true, --ferra
	["14321"] = true, --guard-fengus
	["14326"] = true, --guard-moldar
	["14323"] = true, --guard-slipkik
	["13280"] = true, --hydrospawn
	["11488"] = true, --illyanna-ravenoak
	["11496"] = true, --immolthar
	["16097"] = true, --isalien
	["11501"] = true, --king-gordok
	["14327"] = true, --lethtendris
	["14506"] = true, --lord-helnurath
	["11487"] = true, --magister-kalendris
	["14349"] = true, --pimgib
	["11486"] = true, --prince-tortheldrin
	["14354"] = true, --pusillin
	["14322"] = true, --stomper-kreeg
	["11489"] = true, --tendris-warpwood
	["11467"] = true, --tsuzee
	["11490"] = true, --zevrim-thornhoof

	--wailing-caverns
	["5912"] = true, --deviate-faerie-dragon
	["3653"] = true, --kresh
	["3671"] = true, --lady-anacondra
	["3670"] = true, --lord-pythas
	["3669"] = true, --lord-cobrahn
	["3673"] = true, --lord-serpentis
	["3655"] = true, --mad-magglish
	["3654"] = true, --mutanus-the-devourer
	["3674"] = true, --skum
	["5775"] = true, --verdan-the-everliving

	--scholomance
	["14861"] = true, --blood-steward-of-kirtonos
	["1853"] = true, --darkmaster-gandling
	["11261"] = true, --doctor-theolen-krastinov
	["10503"] = true, --jandice-barov
	["10506"] = true, --kirtonos-the-herald
	["11622"] = true, --rattlegore
	["10433"] = true, --marduk-blackpool
	["10432"] = true, --vectus
	["10508"] = true, --ras-frostwhisper
	["10505"] = true, --instructor-malicia
	["10901"] = true, --lorekeeper-polkelt
	["10507"] = true, --the-ravenian
	["10504"] = true, --lord-alexei-barov
	["10502"] = true, --lady-illucia-barov

	--razorfen-downs
	["74412"] = true, --aarux
	["74434"] = true, --amnennar-the-coldbringer
	["74875"] = true, --death-speaker-blackthorn
	["74347"] = true, --mordresh-fire-eye
	["74435"] = true, --mushlump

	--shadowfang-keep
	["46962"] = true, --baron-ashbury
	["3887"] = true, --baron-silverlaine
	["4278"] = true, --commander-springvale
	["3872"] = true, --deathsworn-captain
	["46964"] = true, --lord-godfrey
	["235150"] = true, --lord-walden
	["4275"] = true, --archmage-arugal
	["4274"] = true, --fenrus-the-devourer
	["4279"] = true, --odo-the-blindwatcher
	["3886"] = true, --razorclaw-the-butcher
	["3914"] = true, --rethilgore
	["3927"] = true, --wolf-master-nandos

	--blackfathom-deeps
	["75408"] = true, --akumai
	["74476"] = true, --domina
	["74988"] = true, --executioner-gore
	["75410"] = true, --guardian-of-the-deep
	["74565"] = true, --subjugator-korul
	["74505"] = true, --thruk
	["74728"] = true, --twilight-lord-bathiel
	["74446"] = true, --ghamoo-ra
	["74458"] = true, --ghamoo-ra
	["4831"] = true, --lady-sarevess
	["6243"] = true, --gelihast
	["12902"] = true, --lorgus-jett
	["12876"] = true, --baron-aquanis
	["4830"] = true, --old-serrakis
	["75155"] = true, --akumai-the-devourer

	--blackfathom (sod version)
	["202699"] = true, --baron-aquanis
	["201722"] = true, --ghamoo-ra
	["204068"] = true, --lady-sarevess
	["204921"] = true, --gelihast
	["207356"] = true, --lorgus-jett
	["209678"] = true, --twilight-lord-kelris
	["213334"] = true, --akumai

	--the-stockade
	["46383"] = true, --randolph-moloch
	["46264"] = true, --lord-overheat
	["46254"] = true, --hogger
	["1696"] = true, --targorr-the-dread
	["1666"] = true, --kam-deepfury
	["1717"] = true, --hamhock
	["1663"] = true, --dextren-ward
	["1716"] = true, --bazil-thredd
	["1720"] = true, --bruegal-ironknuckle

	--razorfen-kraul
	["6168"] = true, --roogug
	["4424"] = true, --aggem-thorncurse
	["4428"] = true, --death-speaker-jargba
	["4420"] = true, --overlord-ramtusk
	["4422"] = true, --agathelos-the-raging
	["4421"] = true, --charlga-razorflank

	--scarlet-monastery
	["3983"] = true, --interrogator-vishas
	["4543"] = true, --bloodmage-thalnos
	["3974"] = true, --houndmaster-loksey
	["6487"] = true, --arcanist-doan
	["3975"] = true, --herod
	["4542"] = true, --high-inquisitor-fairbanks
	["209254"] = true, --high-inquisitor-whitemane
	["16062"] = true, --highlord-mograine
	["3977"] = true, --high-inquisitor-whitemane
	["3976"] = true, --scarlet-commander-mograine
	["6489"] = true, --ironspine
	["6488"] = true, --fallen-champion
	["6490"] = true, --azshir-the-sleepless
	["59223"] = true, --brother-korloff
	["60040"] = true, --commander-durand
	["59789"] = true, --thalnos-the-soulrender

	--zulfarrak
	["8127"] = true, --antusul
	["7267"] = true, --chief-ukorz-sandscalp
	["10081"] = true, --dustwraith
	["7273"] = true, --gahzrilla
	["7795"] = true, --hydromancer-velratha
	["7796"] = true, --nekrum-gutchewer
	["7797"] = true, --ruuzlu
	["7274"] = true, --sandfury-executioner
	["10080"] = true, --sandarr-dunereaver
	["7275"] = true, --shadowpriest-sezzziz
	["7272"] = true, --theka-the-martyr
	["10082"] = true, --zerillis
	["7271"] = true, --witch-doctor-zumrah

	--maraudon
	["13282"] = true, --noxxion
	["12258"] = true, --razorlash
	["13601"] = true, --tinkerer-gizlock
	["12236"] = true, --lord-vyletongue
	["12225"] = true, --celebras-the-cursed
	["12203"] = true, --landslide
	["13596"] = true, --rotgrip
	["12201"] = true, --princess-theradras

	--uldaman
	["6910"] = true, --revelosh
	["6906"] = true, --baelog
	["7228"] = true, --ironaya
	["7023"] = true, --obsidian-sentinel
	["7206"] = true, --ancient-stone-keeper
	["7291"] = true, --galgann-firehammer
	["4854"] = true, --grimlok
	["2748"] = true, --archaedas

	---gnomeregan
	["7361"] = true, --grubbis
	["7079"] = true, --viscous-fallout
	["6235"] = true, --electrocutioner-6000
	["6229"] = true, --crowd-pummeler-9-60
	["6228"] = true, --dark-iron-ambassador
	["7800"] = true, --mekgineer-thermaplugg
	["6231"] = true, --techbot

	--zulgurub
	["14507"] = true, --high-priest-venoxis
	["14517"] = true, --high-priestess-jeklik
	["14510"] = true, --high-priestess-marli
	["14509"] = true, --high-priest-thekal
	["14515"] = true, --high-priestess-arlokk
	["14834"] = true, --hakkar
	["11382"] = true, --bloodlord-mandokir
	["14988"] = true, --ohgan
	["15083"] = true, --edge-of-madness
	["15114"] = true, --gahzranka
	["11380"] = true, --jindo-the-hexxer

	--blackwing-lair
	["12435"] = true, --razorgore-the-untamed
	["13020"] = true, --vaelastrasz-the-corrupt
	["12017"] = true, --broodlord-lashlayer
	["11983"] = true, --firemaw
	["14601"] = true, --ebonroc
	["11981"] = true, --flamegor
	["14020"] = true, --chromaggus
	["11583"] = true, --nefarian

	--ruins-of-ahnqiraj
	["15348"] = true, --kurinnaxx
	["15341"] = true, --general-rajaxx
	["15340"] = true, --moam
	["15370"] = true, --buru-the-gorger
	["15369"] = true, --ayamiss-the-hunter
	["15339"] = true, --ossirian-the-unscarred

	--molten-core
	["12118"] = true, --lucifron
	["11982"] = true, --magmadar
	["12259"] = true, --gehennas
	["12057"] = true, --garr
	["12264"] = true, --shazzrah
	["12056"] = true, --baron-geddon
	["11988"] = true, --golemagg-the-incinerator
	["12098"] = true, --sulfuron-harbinger
	["12018"] = true, --majordomo-executus
	["11502"] = true, --ragnaros
	["228429"] = true, --lucifron
	["228430"] = true, --magmadar
	["228431"] = true, --gehennas
	["228432"] = true, --garr
	["228433"] = true, --baron-geddon
	["228434"] = true, --shazzrah
	["228435"] = true, --golemagg-the-incinerator
	["228436"] = true, --sulfuron-harbinger
	["228437"] = true, --majordomo-executus
	["228438"] = true, --ragnaros

	--naxxramas
	["15956"] = true, --anubrekhan
	["15953"] = true, --grand-widow-faerlina
	["15952"] = true, --maexxna
	["15954"] = true, --noth-the-plaguebringer
	["15936"] = true, --heigan-the-unclean
	["16011"] = true, --loatheb
	["16061"] = true, --instructor-razuvious
	["16060"] = true, --gothik-the-harvester
	["16063"] = true, --sir-zeliek
	["16065"] = true, --lady-blaumeux
	["16064"] = true, --thane-korthazz
	["16028"] = true, --patchwerk
	["15931"] = true, --grobbulus
	["15932"] = true, --gluth
	["15928"] = true, --thaddius
	["15989"] = true, --sapphiron
	["15990"] = true, --kelthuzad

	--ahnqiraj
	["15263"] = true, --the-prophet-skeram
	["15516"] = true, --battleguard-sartura
	["15510"] = true, --fankriss-the-unyielding
	["15509"] = true, --princess-huhuran
	["15276"] = true, --veklor
	["15275"] = true, --veknilash
	["15727"] = true, --cthun
	["15543"] = true, --yauj
	["15544"] = true, --vem
	["15511"] = true, --kri
	["15299"] = true, --viscidus
	["15517"] = true, --ouro

	--scarlet-enclave (sod raid)
	["240811"] = true, --balnazzar
	["242563"] = true, --beatrix
	["243269"] = true, --solistrasza
	["241906"] = true, --sir-dornel
	["240794"] = true, --alexei-the-beastlord
	["241021"] = true, --mason-the-echo
	["240795"] = true, --herod
	["240810"] = true, --doan
	["240809"] = true, --vishas
	["243021"] = true, --lilian-voss
	["243005"] = true, --putress
	["241006"] = true, --grand-crusader-caldoran

	--sod event bosses
	["212804"] = true, --centrius
	["212707"] = true, --larodar
	["212803"] = true, --ceredwyn
	["212801"] = true, --jubei
	["212730"] = true, --tojara
	["212802"] = true, --moogul-the-sly
	["218690"] = true, --khadamu

	-------The Burning Crusade-------

	--sethekk-halls
	["23035"] = true, --anzu
	["18472"] = true, --darkweaver-syth
	["18473"] = true, --talon-king-ikiss

	--magisters-terrace
	["24664"] = true, --kaelthas-sunstrider
	["24560"] = true, --priestess-delrissa
	["24723"] = true, --selin-fireheart
	["24744"] = true, --vexallus

	--the-slave-pens
	["17941"] = true, --mennu-the-betrayer
	["17942"] = true, --quagmirran
	["17991"] = true, --rokmar-the-crackler

	--the-shattered-halls
	["20923"] = true, --blood-guard-porung
	["16807"] = true, --grand-warlock-nethekurse
	["16809"] = true, --warbringer-omrogg
	["16808"] = true, --warchief-kargath-bladefist

	--hellfire-ramparts
	["17308"] = true, --omor-the-unscarred
	["17537"] = true, --vazruden
	["17307"] = true, --vazruden-the-herald
	["17306"] = true, --watchkeeper-gargolmar

	--the-steamvault
	["17797"] = true, --hydromancer-thespia
	["17796"] = true, --mekgineer-steamrigger
	["17798"] = true, --warlord-kalithresh

	--the-black-morass
	["17881"] = true, --aeonus
	["17879"] = true, --chrono-lord-deja
	["17880"] = true, --temporus

	--the-underbog
	["18105"] = true, --ghazan
	["17770"] = true, --hungarfen
	["17826"] = true, --swamplord-muselek
	["17882"] = true, --the-black-stalker

	--mana-tombs
	["18344"] = true, --nexus-prince-shaffar
	["18341"] = true, --pandemonius
	["18343"] = true, --tavarok
	["22930"] = true, --yor

	--old-hillsbrad-foothills
	["17862"] = true, --captain-skarloc
	["18096"] = true, --epoch-hunter
	["17848"] = true, --lieutenant-drake

	--the-arcatraz
	["20885"] = true, --dalliah-the-doomsayer
	["20912"] = true, --harbinger-skyriss
	["20904"] = true, --warden-mellichar
	["20886"] = true, --wrath-scryer-soccothrates
	["20870"] = true, --zereketh-the-unbound

	--the-blood-furnace
	["17380"] = true, --broggok
	["17377"] = true, --kelidan-the-breaker
	["17381"] = true, --the-maker

	--the-botanica
	["17976"] = true, --commander-sarannis
	["17975"] = true, --high-botanist-freywinn
	["17980"] = true, --laj
	["17978"] = true, --thorngrin-the-tender
	["17977"] = true, --warp-splinter

	--shadow-labyrinth
	["18731"] = true, --ambassador-hellmaw
	["18667"] = true, --blackheart-the-inciter
	["18732"] = true, --grandmaster-vorpil
	["18708"] = true, --murmur

	--auchenai-crypts
	["18373"] = true, --exarch-maladaar
	["18371"] = true, --shirrak-the-dead-watcher

	--the-mechanar
	["19218"] = true, --gatewatcher-gyro-kill
	["19710"] = true, --gatewatcher-iron-hand
	["19219"] = true, --mechano-lord-capacitus
	["19221"] = true, --nethermancer-sepethrea
	["19220"] = true, --pathaleon-the-calculator

	--karazhan
	["16181"] = true, --rokad-the-ravager
	["16152"] = true, --attumen-the-huntsman
	["16151"] = true, --midnight
	["15687"] = true, --moroes
	["16457"] = true, --maiden-of-virtue
	["17521"] = true, --the-big-bad-wolf
	["16179"] = true, --hyakiss-the-lurker
	["17534"] = true, --julianne
	["17546"] = true, --roar
	["17535"] = true, --dorothee
	["17533"] = true, --romulo
	["16180"] = true, --shadikith-the-glider
	["17547"] = true, --tinhead
	["17548"] = true, --tito
	["18168"] = true, --the-crone
	["17543"] = true, --strawman
	["15691"] = true, --the-curator
	["16524"] = true, --shade-of-aran
	["15688"] = true, --terestian-illhoof
	["15689"] = true, --netherspite
	["16816"] = true, --echo-of-medivh
	["15690"] = true, --prince-malchezaar

	--the eye
	["19514"] = true, --alar
	["19516"] = true, --void-reaver
	["18805"] = true, --high-astromancer-solarian
	["19622"] = true, --kaelthas-sunstrider

	--black-temple
	["22887"] = true, --high-warlord-najentus
	["22898"] = true, --supremus
	["22841"] = true, --shade-of-akama
	["22871"] = true, --teron-gorefiend
	["22948"] = true, --gurtogg-bloodboil
	["23418"] = true, --essence-of-suffering
	["23420"] = true, --essence-of-anger
	["23419"] = true, --essence-of-desire
	["22947"] = true, --mother-shahraz
	["22949"] = true, --gathios-the-shatterer
	["22951"] = true, --lady-malande
	["22952"] = true, --veras-darkshadow
	["22950"] = true, --high-nethermancer-zerevor
	["22917"] = true, --illidan-stormrage

	--sunwell-plateau
	["24850"] = true, --kalecgos
	["24882"] = true, --brutallus
	["25038"] = true, --felmyst
	["25840"] = true, --entropius
	["25166"] = true, --grand-warlock-alythess
	["25165"] = true, --lady-sacrolash
	["25741"] = true, --muru
	["25315"] = true, --kiljaeden

	--serpentshrine-cavern
	["21216"] = true, --hydross-the-unstable
	["21217"] = true, --the-lurker-below
	["21215"] = true, --leotheras-the-blind
	["21214"] = true, --fathom-lord-karathress
	["21213"] = true, --morogrim-tidewalker
	["21212"] = true, --lady-vashj

	--gruuls-lair
	["18831"] = true, --high-king-maulgar
	["19044"] = true, --gruul-the-dragonkiller

	--hyjal-summit
	["17767"] = true, --rage-winterchill
	["17808"] = true, --anetheron
	["17888"] = true, --kazrogal
	["17842"] = true, --azgalor
	["17968"] = true, --archimonde

	--magtheridons-lair
	["17257"] = true, --magtheridon

	--tbc world bosses
	["18728"] = true, --doom-lord-kazzak
	["17711"] = true, --doomwalker

	-------Wrath of the Lich King-------

	--utgarde-pinnacle
	["26687"] = true, --gortok-palehoof
	["26861"] = true, --king-ymiron
	["26693"] = true, --skadi-the-ruthless
	["26668"] = true, --svala-sorrowgrave

	--the-culling-of-stratholme
	["26532"] = true, --chrono-lord-epoch
	["32273"] = true, --infinite-corruptor
	["26533"] = true, --malganis
	["26529"] = true, --meathook
	["26530"] = true, --salramm-the-fleshcrafter

	--trial-of-the-champion
	["34702"] = true, --ambrose-boltspark
	["34928"] = true, --argent-confessor-paletress
	["34701"] = true, --colosos
	["35617"] = true, --deathstalker-visceri
	["35119"] = true, --eadric-the-pure
	["34657"] = true, --jaelyne-evensong
	["34703"] = true, --lana-stouthammer
	["34705"] = true, --marshal-jacob-alerius
	["35572"] = true, --mokra-the-skullcrusher
	["35571"] = true, --runok-wildmane
	["35451"] = true, --the-black-knight
	["35570"] = true, --zultore

	--halls-of-reflection
	["38112"] = true, --falric
	["38113"] = true, --marwyn
	["36954"] = true, --the-lich-king
	["37226"] = true, --the-lich-king

	--the-forge-of-souls
	["36497"] = true, --bronjahm
	["36502"] = true, --devourer-of-souls

	--ahnkahet-the-old-kingdom
	["30258"] = true, --amanitar
	["29309"] = true, --elder-nadox
	["29311"] = true, --herald-volazj
	["29310"] = true, --jedoga-shadowseeker
	["29308"] = true, --prince-taldaram

	--halls-of-stone
	["27977"] = true, --krystallus
	["27975"] = true, --maiden-of-grief
	["27978"] = true, --sjonnir-the-ironshaper

	--the-oculus
	["27654"] = true, --drakos-the-interrogator
	["27656"] = true, --ley-guardian-eregos
	["27655"] = true, --mage-lord-urom
	["27447"] = true, --varos-cloudstrider

	--azjol-nerub
	["29120"] = true, --anubarak
	["28921"] = true, --hadronox
	["28684"] = true, --krikthir-the-gatewatcher

	--utgarde-keep
	["24201"] = true, --dalronn-the-controller
	["23954"] = true, --ingvar-the-plunderer
	["23953"] = true, --prince-keleseth
	["24200"] = true, --skarvald-the-constructor

	--halls-of-lightning
	["28586"] = true, --general-bjarngrim
	["28546"] = true, --ionar
	["28923"] = true, --loken
	["28587"] = true, --volkhan

	--pit-of-saron
	["36494"] = true, --forgemaster-garfrost
	["36476"] = true, --ick
	["36477"] = true, --krick
	["36658"] = true, --scourgelord-tyrannus

	--gundrak
	["29307"] = true, --drakkari-colossus
	["29932"] = true, --eck-the-ferocious
	["29306"] = true, --galdarah
	["29305"] = true, --moorabi
	["29304"] = true, --sladran

	--draktharon-keep
	["27483"] = true, --king-dred
	["26631"] = true, --novos-the-summoner
	["26632"] = true, --the-prophet-tharonja
	["26630"] = true, --trollgore

	--the-nexus
	["26763"] = true, --anomalus
	["26798"] = true, --commander-kolurg
	["26796"] = true, --commander-stoutbeard
	["26731"] = true, --grand-magus-telestra
	["26723"] = true, --keristrasza
	["26794"] = true, --ormorok-the-tree-shaper

	--the-violet-hold
	["31134"] = true, --cyanigosa
	["29315"] = true, --erekem
	["29313"] = true, --ichoron
	["29312"] = true, --lavanthor
	["29316"] = true, --moragg
	["29266"] = true, --xevozz
	["29314"] = true, --zuramat-the-obliterator

	--onyxias-lair
	["10184"] = true, --onyxia

	--the-obsidian-sanctum
	["28860"] = true, --sartharion

	--the-eye-of-eternity
	["28859"] = true, --malygos

	--vault-of-archavon
	["31125"] = true, --archavon-the-stone-watcher
	["33993"] = true, --emalon-the-storm-watcher
	["35013"] = true, --koralon-the-flame-watcher
	["38433"] = true, --toravon-the-ice-watcher

	--ulduar
	["33113"] = true, --flame-leviathan
	["33118"] = true, --ignis-the-furnace-master
	["33186"] = true, --razorscale
	["33293"] = true, --xt-002-deconstructor
	["32867"] = true, --steelbreaker
	["32930"] = true, --kologarn
	["33515"] = true, --auriaya
	["32845"] = true, --hodir
	["32865"] = true, --thorim
	["32906"] = true, --freya
	["33350"] = true, --mimiron
	["33271"] = true, --general-vezax
	["33288"] = true, --yogg-saron
	["32871"] = true, --algalon-the-observer

	--trial-of-the-crusader
	["34796"] = true, --gormok-the-impaler
	["35144"] = true, --acidmaw
	["34780"] = true, --lord-jaraxxus
	["34467"] = true, --alyssia-moonstalker
	["34451"] = true, --birana-stormhoof
	["34497"] = true, --fjola-lightbane
	["34564"] = true, --anubarak
	["34466"] = true, --anthar-forgemender
	["34471"] = true, --baelnor-lightbearer
	["34473"] = true, --brienna-nightfell
	["34455"] = true, --broln-stouthorn
	["34447"] = true, --caiphus-the-stern
	["34799"] = true, --dreadscale
	["34459"] = true, --erin-misthoof
	["34496"] = true, --eydis-darkbane
	["34449"] = true, --ginselle-blightslinger
	["34458"] = true, --gorgrim-shadowcleave
	["34450"] = true, --harkzog
	["34797"] = true, --icehowl
	["34472"] = true, --irieth-shadowstep
	["34460"] = true, --kavina-grovesong
	["34445"] = true, --liandra-suncaller
	["34456"] = true, --malithas-brightblade
	["34454"] = true, --mazdinah
	["34469"] = true, --melador-valestrider
	["34453"] = true, --narrhok-steelbreaker
	["34468"] = true, --noozle-whizzlestick
	["34448"] = true, --rujkah
	["34470"] = true, --saamul
	["34474"] = true, --serissa-grimdabbler
	["34463"] = true, --shaabad
	["34475"] = true, --shocuul
	["34444"] = true, --thrakgar
	["34461"] = true, --tyrius-duskblade
	["34465"] = true, --velanaa
	["34441"] = true, --vivienne-blackwhisper

	--icecrown-citadel
	["36612"] = true, --lord-marrowgar
	["36855"] = true, --lady-deathwhisper
	["36939"] = true, --high-overlord-saurfang
	["36948"] = true, --muradin-bronzebeard
	["37813"] = true, --deathbringer-saurfang
	["36626"] = true, --festergut
	["36627"] = true, --rotface
	["36678"] = true, --professor-putricide
	["37970"] = true, --prince-valanar
	["37955"] = true, --blood-queen-lanathel
	["36789"] = true, --valithria-dreamwalker
	["36853"] = true, --sindragosa
	["36597"] = true, --the-lich-king

	--the-ruby-sanctum
	["39863"] = true, --halion

	-------Cataclysm-------

	-- Vortex Pinnacle
	["43878"] = true,
	["43873"] = true,
	["43875"] = true,

	--grim-batol
	["40319"] = true, --drahga-shadowburner
	["40484"] = true, --erudax
	["40177"] = true, --forgemaster-throngus
	["39625"] = true, --general-umbriss
	["40320"] = true,

	--Throne of the Tides
	["40788"] = true, --mindbender-ghursha
	["40765"] = true, --commander-ulthok
	["40586"] = true, --lady-nazjar
	["44566"] = true, --ozumat
	["40825"] = true, --erunak-stonespeaker
	["213770"] = true, --Ink of Ozumat

	--zulgurub
	["52151"] = true, --bloodlord-mandokir
	["52258"] = true, --grilek
	["52271"] = true, --hazzarah
	["52155"] = true, --high-priest-venoxis
	["52059"] = true, --high-priestess-kilnara
	["52148"] = true, --jindo-the-godbreaker
	["52269"] = true, --renataki
	["52286"] = true, --wushoolay
	["52053"] = true, --zanzil

	--the-stonecore
	["43438"] = true, --corborus
	["42333"] = true, --high-priestess-azil
	["42188"] = true, --ozruk
	["43214"] = true, --slabhide

	--zulaman
	["23574"] = true, --akilzon
	["23863"] = true, --daakara
	["23577"] = true, --halazzi
	["24239"] = true, --hex-lord-malacrass
	["23578"] = true, --janalai
	["23576"] = true, --nalorakk

	--lost-city-of-the-tolvir
	["49045"] = true, --augh
	["44577"] = true, --general-husam
	["43612"] = true, --high-prophet-barim
	["43614"] = true, --lockmaw
	["44819"] = true, --siamat

	--blackrock-caverns
	["39705"] = true, --ascendant-lord-obsidius
	["39700"] = true, --beauty
	["39679"] = true, --corla-herald-of-twilight
	["39698"] = true, --karsh-steelbender
	["39665"] = true, --romogg-bonecrusher

	--well-of-eternity
	["55419"] = true, --captain-varothen
	["54969"] = true, --mannoroth
	["55085"] = true, --perotharn
	["54853"] = true, --queen-azshara

	--hour-of-twilight
	["54938"] = true, --archbishop-benedictus
	["54590"] = true, --arcurion
	["54968"] = true, --asira-dawnslayer

	--end-time
	["54431"] = true, --echo-of-baine
	["54445"] = true, --echo-of-jaina
	["54123"] = true, --echo-of-sylvanas
	["54544"] = true, --echo-of-tyrande
	["54432"] = true, --murozond

	--halls-of-origination
	["39731"] = true, --ammunae
	["39788"] = true, --anraphet
	["39428"] = true, --earthrager-ptah
	["39587"] = true, --isiset
	["39378"] = true, --rajh
	["39732"] = true, --setesh
	["39425"] = true, --temple-guardian-anhuur

	--baradin-hold
	["55869"] = true, --alizabal
	["47120"] = true, --argaloth
	["52363"] = true, --occuthar

	--throne-of-the-four-winds
	["46753"] = true, --alakir
	["45870"] = true, --anshal
	["45871"] = true, --nezir
	["45872"] = true, --rohash

	--the-bastion-of-twilight
	["43688"] = true, --arion
	["43324"] = true, --chogall
	["43735"] = true, --elementium-monstrosity
	["43687"] = true, --feludius
	["44600"] = true, --halfus-wyrmbreaker
	["43686"] = true, --ignacious
	["45213"] = true, --sinestra
	["43689"] = true, --terrastra
	["45993"] = true, --theralion
	["45992"] = true, --valiona

	--blackwing-descent
	["42166"] = true, --arcanotron
	["41442"] = true, --atramedes
	["43296"] = true, --chimaeron
	["42179"] = true, --electron
	["42178"] = true, --magmatron
	["41570"] = true, --magmaw
	["41378"] = true, --maloriak
	["41376"] = true, --nefarian
	["41270"] = true, --onyxia
	["42180"] = true, --toxitron

	--firelands
	["52498"] = true, --bethtilac
	["52558"] = true, --lord-rhyolith
	["52530"] = true, --alysrazor
	["53691"] = true, --shannox
	["53494"] = true, --baleroc
	["52571"] = true, --majordomo-staghelm
	["52409"] = true, --ragnaros

	--dragon-soul
	["55265"] = true, --morchok
	["55308"] = true, --warlord-zonozz
	["55312"] = true, --yorsahj-the-unsleeping
	["55689"] = true, --hagara-the-stormbinder
	["55294"] = true, --ultraxion
	["56427"] = true, --warmaster-blackhorn
	["53879"] = true, --deathwing
	["56173"] = true, --deathwing

	--cataclysm world bosses
	["50063"] = true, --akmahat
	["50056"] = true, --garr
	["50089"] = true, --julak-doom
	["50009"] = true, --mobus
	["40728"] = true, --whale-shark
	["50061"] = true, --xariona

	-------Mists of Pandaria-------

	-- Temple of the Jade Serpent
	["56448"] = true,
	["59051"] = true,
	["59726"] = true,
	["56732"] = true,
	["56439"] = true,

	--scholomance
	["59080"] = true, --darkmaster-gandling
	["59369"] = true, --doctor-theolen-krastinov
	["58633"] = true, --instructor-chillheart
	["59184"] = true, --jandice-barov
	["59200"] = true, --lilian-voss
	["59153"] = true, --rattlegore

	--stormstout-brewery
	["56717"] = true, --hoptallus
	["56637"] = true, --ook-ook
	["59479"] = true, --yan-zhu-the-uncasked

	--scarlet-halls
	["58632"] = true, --armsmaster-harlan
	["59150"] = true, --flameweaver-koegler
	["59303"] = true, --houndmaster-braun

	--mogushan-palace
	["61243"] = true, --gekkan
	["61445"] = true, --haiyan-the-unstoppable
	["61442"] = true, --kuai-the-brute
	["61444"] = true, --ming-the-cunning
	["61398"] = true, --xin-the-weaponmaster

	--gate-of-the-setting-sun
	["56636"] = true, --commander-rimok
	["56877"] = true, --raigonn
	["56906"] = true, --saboteur-kiptilak
	["56589"] = true, --striker-gadok

	--shado-pan-monastery
	["56747"] = true, --gu-cloudstrike
	["56541"] = true, --master-snowdrift
	["56719"] = true, --sha-of-violence
	["56884"] = true, --taran-zhu

	--siege-of-niuzao-temple
	["61634"] = true, --commander-vojak
	["61485"] = true, --general-pavalak
	["61567"] = true, --vizier-jinbak
	["62205"] = true, --wing-leader-neronok

	--mogushan-vaults
	["60047"] = true, --amethyst-guardian
	["60051"] = true, --cobalt-guardian
	["60410"] = true, --elegon
	["60009"] = true, --feng-the-accursed
	["60143"] = true, --garajal-the-spiritbinder
	["60043"] = true, --jade-guardian
	["60400"] = true, --jan-xi
	["59915"] = true, --jasper-guardian
	["60708"] = true, --meng-the-demented
	["60709"] = true, --qiang-the-merciless
	["60399"] = true, --qin-xi
	["60710"] = true, --subetai-the-swift
	["60701"] = true, --zian-of-the-endless-shadow

	--terrace-of-endless-spring
	["60586"] = true, --elder-asani
	["60585"] = true, --elder-regail
	["62983"] = true, --lei-shi
	["60583"] = true, --protector-kaolan
	["60999"] = true, --sha-of-fear
	["62442"] = true, --tsulong

	--heart-of-fear
	["62511"] = true, --amber-shaper-unsok
	["62543"] = true, --blade-lord-tayak
	["62164"] = true, --garalon
	["62837"] = true, --grand-empress-shekzeer
	["62980"] = true, --imperial-vizier-zorlok
	["62397"] = true, --wind-lord-meljarak

	--throne-of-thunder
	["69465"] = true, --jinrokh-the-breaker
	["69427"] = true, --dark-animus
	["68036"] = true, --durumu-the-forgotten
	["70212"] = true, --flaming-head
	["69131"] = true, --frost-king-malakk
	["70235"] = true, --frozen-head
	["69132"] = true, --high-priestess-marli
	["68476"] = true, --horridon
	["68078"] = true, --iron-qon
	["69712"] = true, --ji-kun
	["69134"] = true, --kazrajin
	["68397"] = true, --lei-shen
	["68905"] = true, --lulin
	["69017"] = true, --primordius
	["69473"] = true, --ra-den
	["68904"] = true, --suen
	["69078"] = true, --sul-the-sandcrawler
	["67977"] = true, --tortos
	["70247"] = true, --venomous-head
	["70248"] = true, --arcane-head

	--siege-of-orgrimmar
	["72276"] = true, --amalgam-of-corruption
	["71859"] = true, --earthbreaker-haromm
	["72249"] = true, --galakras
	["71865"] = true, --garrosh-hellscream
	["71515"] = true, --general-nazgrim
	["71479"] = true, --he-softfoot
	["71153"] = true, --hisek-the-swarmkeeper
	["71543"] = true, --immerseus
	["71466"] = true, --iron-juggernaut
	["71160"] = true, --iyyokuk-the-lucid
	["71154"] = true, --karoz-the-locust
	["71156"] = true, --kaztik-the-manipulator
	["71161"] = true, --kilruk-the-wind-reaver
	["71155"] = true, --korven-the-prime
	["71454"] = true, --malkorok
	["153325"] = true, --norushen
	["71158"] = true, --rikkal-the-dissector
	["71475"] = true, --rook-stonetoe
	["71889"] = true, --secured-stockpile-of-pandaren-spoils
	["71734"] = true, --sha-of-pride
	["71504"] = true, --siegecrafter-blackfuse
	["71152"] = true, --skeer-the-bloodseeker
	["71480"] = true, --sun-tenderheart
	["71529"] = true, --thok-the-bloodthirsty
	["71858"] = true, --wavebinder-kardris
	["71157"] = true, --xaril-the-poisoned-mind

	--mop world bosses
	["60491"] = true, --sha-of-anger
	["62346"] = true, --galleon
	["69099"] = true, --nalak
	["69161"] = true, --oondasta
	["72057"] = true, --ordos
	["71952"] = true, --chi-ji
	["71954"] = true, --niuzao
	["71953"] = true, --xuen
	["71955"] = true, --yulon

	-------Warlords of Draenor-------

	-- Shadowmoon Burial Grounds
	["76407"] = true, --nerzhul
	["75452"] = true, --bonemaw
	["75509"] = true, --sadana-bloodfury
	["75829"] = true, --nhallish

	--The Everbloom
	["83846"] = true, --yalnu
	["81522"] = true, --witherbark
	["82682"] = true, --archmage-sol
	["83894"] = true, --dulhu
	["83892"] = true, --life-warden-gola
	["83893"] = true, --earthshaper-telu
	["84550"] = true, --xeritac

	--iron-docks
	["80816"] = true, --ahriok-dugru
	["81305"] = true, --fleshrender-nokgar
	["79852"] = true, --oshir
	["83612"] = true, --skulloc

	--upper-blackrock-spire
	["79912"] = true, --commander-tharbek
	["76021"] = true, --kyrak
	["76413"] = true, --orebender-gorashan
	["76585"] = true, --ragewing-the-untamed
	["77120"] = true, --warlord-zaela

	--auchindoun
	["75927"] = true, --azzakel
	["76177"] = true, --soulbinder-nyami
	["77734"] = true, --terongor
	["75839"] = true, --vigilant-kaathar

	--skyreach
	["76141"] = true, --araknath
	["76266"] = true, --high-sage-viryx
	["75964"] = true, --ranjit
	["76379"] = true, --rukhran

	--grimrail-depot
	["77816"] = true, --borka-the-brute
	["79545"] = true, --nitrogg-thundertower
	["77803"] = true, --railmaster-rocketspark
	["80005"] = true, --skylord-tovra

	--bloodmaul-slag-mines
	["74366"] = true, --forgemaster-gogduh
	["74790"] = true, --gugrokk
	["75786"] = true, --roltall
	["74787"] = true, --slave-watcher-crushto

	--highmaul
	["78491"] = true, --brackenspore
	["77428"] = true, --imperator-margok
	["78714"] = true, --kargath-bladefist
	["79015"] = true, --koragh
	["78237"] = true, --phemos
	["78238"] = true, --pol
	["78948"] = true, --tectus
	["77404"] = true, --the-butcher

	--blackrock-foundry
	["77557"] = true, --admiral-garan
	["76865"] = true, --beastlord-darmac
	["77325"] = true, --blackhand
	["77231"] = true, --enforcer-sorka
	["76814"] = true, --flamebender-kagraz
	["76809"] = true, --foreman-feldspar
	["76974"] = true, --franzok
	["76877"] = true, --gruul
	["76973"] = true, --hansgar
	["76806"] = true, --heart-of-the-mountain
	["77692"] = true, --kromog
	["77477"] = true, --marak-the-blooded
	["76906"] = true, --operator-thogar
	["77182"] = true, --oregorger

	--hellfire-citadel
	["91331"] = true, --archimonde
	["92142"] = true, --blademaster-jubeithos
	["92144"] = true, --dia-darkwhisper
	["89890"] = true, --fel-lord-zakuun
	["91809"] = true, --gorefiend
	["92146"] = true, --gurtogg-bloodboil
	["90284"] = true, --iron-reaver
	["90378"] = true, --kilrogg-deadeye
	["90776"] = true, --kormrok
	["91349"] = true, --mannoroth
	["92919"] = true, --residual-energy
	["90316"] = true, --shadow-lord-iskar
	["95068"] = true, --siegemaster-martak
	["90296"] = true, --soulbound-construct
	["93439"] = true, --tyrant-velhari
	["93068"] = true, --xhulhorac

	--wod world bosses
	["81252"] = true, --drov-the-ruiner
	["81535"] = true, --tarlna-the-ageless
	["83746"] = true, --rukhmar
	["94015"] = true, --supreme-lord-kazzak

	-------Legion-------

	-- Halls of Valor
	["95674"] = true,
	["99868"] = true,
	["94960"] = true,
	["95833"] = true,
	["95675"] = true,
	["95676"] = true,

	-- Court of Stars
	["104218"] = true,
	["104217"] = true,
	["104215"] = true,

	-- Neltharion's Lair
	["91007"] = true,
	["91005"] = true,
	["91003"] = true,
	["91004"] = true,

	--Darkheart Thicket
	["103344"] = true, --oakheart
	["99192"] = true, --shade-of-xavius
	["96512"] = true, --archdruid-glaidalis
	["99200"] = true, --dresaron

	--Black Rook Hold
	["94923"] = true, --lord-kurtalos-ravencrest
	["98542"] = true, --amalgam-of-souls
	["98696"] = true, --illysanna-ravencrest
	["98949"] = true, --smashspite-the-hateful
	["98965"] = true,
	["98970"] = true,

	--return-to-karazhan
	["114262"] = true, --attumen-the-huntsman
	["114328"] = true, --coggleston
	["114284"] = true, --elfyra
	["114251"] = true, --galindre
	["113971"] = true, --maiden-of-virtue
	["114252"] = true, --mana-devourer
	["115831"] = true, --mana-devourer
	["116494"] = true, --mana-devourer
	["114264"] = true, --midnight
	["114312"] = true, --moroes
	["114260"] = true, --mrrgria
	["114895"] = true, --nightbane
	["114350"] = true, --shade-of-medivh
	["114247"] = true, --the-curator
	["114261"] = true, --toe-knee
	["114790"] = true, --vizaduum-the-watcher

	--vault-of-the-wardens
	["95886"] = true, --ashgolm
	["99865"] = true, --glazer
	["96015"] = true, --inquisitor-tormentorum
	["95885"] = true, --tirathon-saltheril

	--eye-of-azshara
	["91797"] = true, --king-deepbeard
	["91789"] = true, --lady-hatecoil
	["91808"] = true, --serpentrix
	["91784"] = true, --warlord-parjesh
	["96028"] = true, --wrath-of-azshara

	--cathedral-of-eternal-night
	["117193"] = true, --agronox
	["119542"] = true, --domatrax
	["120793"] = true, --mephistroth

	--the-seat-of-the-triumvirate
	["214650"] = true, --lura
	["122316"] = true, --saprish
	["124309"] = true, --viceroy-nezhar
	["122313"] = true, --zuraal-the-ascended

	--the-arcway
	["98208"] = true, --advisor-vandros
	["98205"] = true, --corstilax
	["98206"] = true, --general-xakal
	["98203"] = true, --ivanyr
	["98207"] = true, --naltira

	--violet-hold
	["102246"] = true, --anubesset
	["102431"] = true, --blood-princess-thalena
	["102446"] = true, --fel-lord-betrug
	["101995"] = true, --festerface
	["101976"] = true, --millificent-manastorm
	["101950"] = true, --mindflayer-kaahrj
	["102387"] = true, --saelorn
	["101951"] = true, --shivermaw

	--maw-of-souls
	["96754"] = true, --harbaron
	["96759"] = true, --helya
	["96756"] = true, --ymiron-the-fallen-king

	--the-emerald-nightmare
	["104636"] = true, --cenarius
	["106087"] = true, --elerethe-renferal
	["105906"] = true, --eye-of-ilgynoth
	["105393"] = true, --ilgynoth
	["102672"] = true, --nythendra
	["100497"] = true, --ursoc
	["103769"] = true, --xavius
	["102679"] = true, --ysondre
	["102683"] = true, --emeriss
	["102682"] = true, --lethon
	["102681"] = true, --taerar

	--the-nighthold
	["104415"] = true, --chronomatic-anomaly
	["211664"] = true, --elisande
	["104154"] = true, --guldan
	["104528"] = true, --high-botanist-telarn
	["101002"] = true, --krosus
	["102263"] = true, --skorpyron
	["107699"] = true, --spellblade-aluriel
	["103758"] = true, --star-augur-etraeus
	["103685"] = true, --tichondrius
	["104288"] = true, --trilliax

	--trial-of-valor
	["114344"] = true, --guarm
	["114537"] = true, --helya
	["114263"] = true, --odyn

	--tomb-of-sargeras
	["120996"] = true, --atrigan
	["118460"] = true, --engine-of-souls
	["120436"] = true, --fallen-avatar
	["115844"] = true, --goroth
	["116407"] = true, --harjatan
	["118523"] = true, --huntress-kasparian
	["117269"] = true, --kiljaeden
	["118289"] = true, --maiden-of-vigilance
	["115767"] = true, --mistress-sasszine

	--antorus-the-burning-throne
	["122367"] = true, --admiral-svirax
	["121975"] = true, --aggramar
	["124828"] = true, --argus-the-unmaker
	["131561"] = true, --essence-of-eonar
	["126916"] = true, --fharg
	["123371"] = true, --garothi-worldbreaker
	["125055"] = true, --imonar-the-soulhunter
	["125050"] = true, --kingaroth
	["122468"] = true, --noura-mother-of-flames
	["124393"] = true, --portal-keeper-hasabel
	["125075"] = true, --varimathras
	["122467"] = true, --asara-mother-of-night
	["122469"] = true, --diima-mother-of-gloom
	["125436"] = true, --thuraya-mother-of-the-cosmos

	--legion world bosses
	["109943"] = true, --ana-mouz
	["121124"] = true, --apocron
	["117239"] = true, --brutallus
	["109331"] = true, --calamir
	["110378"] = true, --drugon-the-frostblood
	["99929"] = true, --flotsam
	["108879"] = true, --humongris
	["108829"] = true, --levantus
	["117303"] = true, --malificus
	["110321"] = true, --nazak-the-fiend
	["107544"] = true, --nithogg
	["108678"] = true, --sharthos
	["117470"] = true, --sivash
	["106981"] = true, --captain-hring
	["106984"] = true, --soultrapper-mevra
	["106982"] = true, --reaver-jdorn
	["112350"] = true, --withered-jim

	-------Battle for Azeroth-------

	-- Freehold
	["129431"] = true,
	["129432"] = true,
	["126847"] = true,
	["129440"] = true,
	["129732"] = true,
	["126983"] = true,
	["126969"] = true,
	["126848"] = true,
	["126845"] = true,
	["126832"] = true,

	-- Underrot
	["131817"] = true,
	["131318"] = true,
	["131383"] = true,
	["133007"] = true,

	--siege-of-boralus
	["144160"] = true, --chopper-redhook
	["129208"] = true, --dread-captain-lockwood
	["130836"] = true, --hadal-darkfathom
	["144158"] = true, --sergeant-bainbridge
	["128652"] = true, --viqgoth
	["137614"] = true,
	["137405"] = true,
	["128651"] = true,

	-- Waycrest Manor
	["131527"] = true, --lord-waycrest
	["131667"] = true, --soulbound-goliath
	["131863"] = true, --raal-the-gluttonous
	["144324"] = true, --gorak-tul
	["135360"] = true, --sister-briar
	["131864"] = true,
	["131823"] = true,
	["131824"] = true,
	["131825"] = true,
	["131545"] = true,

	--Atal'Dazar
	["143577"] = true, --rezan
	["129399"] = true, --volkaal
	["129412"] = true, --yazma
	["129614"] = true, --priestess-alunza
	["122963"] = true,
	["122965"] = true,
	["122967"] = true,
	["122968"] = true,

	--kings-rest
	["135470"] = true, --akaali-the-conqueror
	["136160"] = true, --king-dazar
	["134993"] = true, --mchimba-the-embalmer
	["135322"] = true, --the-golden-serpent

	--the-motherlode
	["129227"] = true, --azerokk
	["139904"] = true, --coin-operated-crowd-pummeler
	["131227"] = true, --mogul-razdunk
	["139273"] = true, --rixxa-fluxflame

	--operation-mechagon
	["150222"] = true, --gunker
	["144248"] = true, --head-machinist-sparkflux
	["155157"] = true, --hk-8-aerial-oppression-unit
	["150190"] = true, --hk-8-aerial-oppression-unit
	["144246"] = true, --k-u-j-0
	["150159"] = true, --king-gobbamak
	["152619"] = true, --king-mechagon
	["144244"] = true, --the-platinum-pummeler
	["145185"] = true, --gnomercy-4-u
	["155407"] = true, --trixie-tazer
	["150712"] = true, --trixie-tazer
	["153755"] = true, --naeno-megacrash
	["150396"] = true, --aerial-unit-r-21-x
	["144249"] = true, --omega-buster

	--shrine-of-the-storm
	["134056"] = true, --aqusirr
	["134063"] = true, --brother-ironhull
	["139737"] = true, --lord-stormsong
	["134069"] = true, --volzith-the-whisperer

	--tol-dagor
	["127484"] = true, --jes-howlis
	["130646"] = true, --knight-captain-valyri
	["127503"] = true, --overseer-korgus
	["134927"] = true, --the-sand-queen

	--temple-of-sethraliss
	["133379"] = true, --adderis
	["133392"] = true, --avatar-of-sethraliss
	["133389"] = true, --galvazzt
	["133384"] = true, --merektha

	--uldir
	["133298"] = true, --fetid-devourer
	["163405"] = true, --ghuun
	["132998"] = true, --ghuun
	["140853"] = true, --mother
	["135452"] = true, --mother
	["136383"] = true, --mythrax-the-unraveler
	["134546"] = true, --mythrax-the-unraveler
	["137119"] = true, --taloc
	["134442"] = true, --vectis
	["134445"] = true, --zekvoz
	["138967"] = true, --zul

	--battle-of-dazaralor
	["144680"] = true, --frida-ironbellows
	["148117"] = true, --grong
	["144638"] = true, --grong-the-revenant
	["144796"] = true, --high-tinker-mekkatorque
	["145616"] = true, --king-rastakhan
	["218287"] = true, --lady-jaina-proudmoore
	["146256"] = true, --laminaria
	["148238"] = true, --mara-grimfang
	["146099"] = true, --manceroy-flamefist
	["145261"] = true, --opulence
	["144747"] = true, --pakus-aspect
	["144683"] = true, --rawani-kanae

	--crucible-of-storms
	["145371"] = true, --uunat
	["146497"] = true, --zaxasj-the-speaker
	["144755"] = true, --zaxasj-the-speaker
	["144754"] = true, --fathul-the-feared

	--the-eternal-palace
	["155144"] = true, --abyssal-commander-sivara
	["154986"] = true, --blackwater-behemoth
	["153142"] = true, --lady-ashvane
	["152128"] = true, --orgozoa
	["155126"] = true, --queen-azshara
	["152364"] = true, --radiance-of-azshara
	["152853"] = true, --silivaz-the-zealous
	["150859"] = true, --zaqul

	--nyalotha-the-waking-city
	["156575"] = true, --dark-inquisitor-xanesh
	["157602"] = true, --drestagath
	["157439"] = true, --fury-of-nzoth
	["158328"] = true, --ilgynoth
	["156523"] = true, --maut
	["158041"] = true, --nzoth-the-corruptor
	["161901"] = true, --prophet-skitra
	["156866"] = true, --ra-den
	["157231"] = true, --shadhar-the-insatiable
	["157254"] = true, --tekris
	["157354"] = true, --vexiona
	["156818"] = true, --wrathion

	--bfa world bosses
	["154638"] = true, --grand-empress-shekzara
	["160970"] = true, --vuklaz-the-earthbreaker
	["152671"] = true, --wekemara
	["152697"] = true, --ulmath
	["148295"] = true, --ivus-the-decayed
	["144946"] = true, --ivus-the-forest-lord
	["138122"] = true, --dooms-howl
	["137374"] = true, --the-lions-roar
	["132701"] = true, --tzane
	["132253"] = true, --jiarak
	["138794"] = true, --dunegorger-kraulok
	["140252"] = true, --hailstone-construct
	["136385"] = true, --azurethos
	["140163"] = true, --warbringer-yenajz

	-------Shadowlands-------

	--mists-of-tirna-scithe
	["164567"] = true, --ingra-maloch
	["170217"] = true, --mistcaller
	["164517"] = true, --tredova
	["164501"] = true, --mistcaller
	["164804"] = true, --droman-oulfarran

	--the-necrotic-wake
	["162691"] = true, --blightbone
	["166945"] = true, --nalthor-the-rimebinder
	["166882"] = true, --surgeon-stitchflesh
	["162689"] = true,
	["162693"] = true,
	["163157"] = true,

	--tazavesh-the-veiled-market
	["176556"] = true, --alcruux
	["175663"] = true, --hylbrande
	["175646"] = true, --p-o-s-t-master
	["175806"] = true, --soazmi
	["177269"] = true, --soleah
	["175546"] = true, --timecapn-hooktail
	["176564"] = true, --zogron
	["175616"] = true, --zophex
	["176705"] = true, --venza-goldfuse
	["179334"] = true, --portalmancer-zohonn
	["180486"] = true, --dirtwhistle
	["180399"] = true, --evaile
	["180485"] = true, --hips
	["180470"] = true, --verethian
	["180484"] = true, --vilt
	["176555"] = true, --achillite

	--halls-of-atonement
	["156827"] = true, --echelon
	["165408"] = true, --halkias
	["165410"] = true, --high-adjudicator-aleez
	["164218"] = true, --lord-chamberlain

	--theater-of-pain
	["164451"] = true, --dessia-the-decapitator
	["162317"] = true, --gorechop
	["162309"] = true, --kultharok
	["162329"] = true, --xav-the-unfallen

	--plaguefall
	["164967"] = true, --doctor-ickus
	["164266"] = true, --domina-venomblade
	["164255"] = true, --globgrog
	["164267"] = true, --margrave-stradama

	--de-other-side
	["166473"] = true, --hakkar-the-soulflayer
	--["101976"] = true, --millificent-manastorm --already added from violet hold
	["169769"] = true, --muehzala

	--sanguine-depths
	["162103"] = true, --executor-tarvold
	["162102"] = true, --grand-proctor-beryllia
	["162100"] = true, --kryxis-the-voracious

	--spires-of-ascension
	["163077"] = true, --azules
	["167410"] = true, --devos
	["162060"] = true, --oryphrion
	["162058"] = true, --ventunax

	--castle-nathria
	["166644"] = true, --artificer-xymox
	["166971"] = true, --castellan-niklaus
	["166969"] = true, --baroness-frieda
	["166970"] = true, --lord-stavros
	["165318"] = true, --general-kaal
	["170323"] = true, --general-grashaal
	["164261"] = true, --hungering-destroyer
	["165066"] = true, --huntsman-altimor
	["165067"] = true, --margore
	["169457"] = true, --bargast
	["169458"] = true, --hecutis
	["165759"] = true, --kaelthas-sunstrider
	["167517"] = true, --lady-inerva-darkvein
	["172145"] = true, --shriekwing
	["168938"] = true, --sire-denathrius
	["174733"] = true, --sludgefist

	--sanctum-of-domination
	["180018"] = true, --eye-of-the-jailer
	["179390"] = true, --fatescribe-roh-kalo
	["175731"] = true, --guardian-of-the-first-ones
	["175559"] = true, --kelthuzad
	["178738"] = true, --kyra
	["177096"] = true, --agatha
	["177097"] = true, --annhylde
	["177100"] = true, --aradne
	["177098"] = true, --arthura
	["177101"] = true, --brynja
	["177099"] = true, --daschla
	["177094"] = true, --signe
	["175726"] = true, --skyja
	["176523"] = true, --painsmith-raznal
	["175729"] = true, --remnant-of-nerzhul
	["175727"] = true, --soulrender-dormazain
	["175732"] = true, --sylvanas-windrunner
	["152253"] = true, --the-tarragrue

	--sepulcher-of-the-first-ones
	["181954"] = true, --anduin-wrynn
	["183501"] = true, --artificer-xymox
	["181224"] = true, --dausegne
	["184915"] = true, --halondrus
	["182169"] = true, --lihuvim
	["181398"] = true, --malganis
	["181399"] = true, --kintessa
	["181549"] = true, --prototype-of-war
	["181548"] = true, --prototype-of-absolution
	["181551"] = true, --prototype-of-duty
	["181546"] = true, --prototype-of-renewal
	["182777"] = true, --rygelon
	["183937"] = true, --skolex
	["180990"] = true, --the-jailer
	["180773"] = true, --vigilant-guardian

	--shadowlands world bosses
	["167524"] = true, --valinor
	["182466"] = true, --antros
	["178958"] = true, --morgeth
	["167525"] = true, --mortanis
	["167527"] = true, --oranomonos-the-everbranching
	["167526"] = true, --nurgash-muckformed
	["169035"] = true, --nathanos-blightcaller

	-------Dragonflight-------

	-- Algeth'ar Academy
	["194181"] = true,
	["191736"] = true,
	["196482"] = true,
	["190609"] = true,

	-- Brackenhide Hollow
	["186122"] = true,
	["186124"] = true,
	["186125"] = true,
	["186120"] = true,
	["186121"] = true,
	["186116"] = true,

	-- Halls of Infusion
	["189719"] = true,
	["189729"] = true,
	["189722"] = true,
	["189727"] = true,

	-- Neltharus
	["189901"] = true,
	["189478"] = true,
	["181861"] = true,
	["189340"] = true,

	-- Ruby Life Pools
	["188252"] = true,
	["189232"] = true,
	["190485"] = true,
	["190484"] = true,

	-- The Azure Vault
	["186738"] = true,
	["186644"] = true,
	["186739"] = true,
	["199614"] = true,

	-- The Nokhud Offensive
	["186615"] = true,
	["195723"] = true,
	["186338"] = true,
	["186151"] = true,
	["186616"] = true,
	["186339"] = true,

	-- Uldaman: Legacy of Tyr
	["184125"] = true,
	["184124"] = true,
	["184018"] = true,
	["184422"] = true,
	["184582"] = true,
	["184581"] = true,
	["184580"] = true,

	-- Dawn of the Infinite
	["198933"] = true,
	["198995"] = true,
	["198996"] = true,
	["198997"] = true,
	["198998"] = true,
	["198999"] = true,
	["199000"] = true,
	["201788"] = true,
	["201790"] = true,
	["201792"] = true,
	["209207"] = true,
	["209208"] = true,
	["203679"] = true,
	["203678"] = true,
	["203861"] = true,
	["204206"] = true,
	["204449"] = true,
	["208193"] = true,

	-- Vault of the Incarnates
	["190245"] = true, --Broodkeeper-Diurna
	["184972"] = true, --Eranog
	["189492"] = true, --Raszageth
	["189813"] = true, --Dathea-Ascended
	["184986"] = true, --Kurog-Grimtotem
	["187967"] = true, --Sennarth
	["190496"] = true, --Terros
	["187771"] = true, --Kadros-Icewrath
	["187768"] = true, --Dathea-Stormlash
	["187772"] = true, --Opalfang
	["187767"] = true, --Embar-Firepath

	-- Aberrus, the Shadowed Crucible
	["200913"] = true, --Thadrion
	["200918"] = true, --Rionthus
	["199659"] = true, --Warlord Kagni
	["201320"] = true, --Rashok
	["202637"] = true, --Zskarn
	["201579"] = true, --Magmorax
	["204223"] = true, --Neltharion
	["205319"] = true, --Scalecommander Sarkareth
	["201261"] = true, --Kazzara, the Hellforged
	["201773"] = true, --Eternal Blaze
	["201774"] = true, --Essence of Shadow
	["201934"] = true, --Shadowflame Amalgamation
	["200912"] = true, --Neldris

	--Amirdrassil, the Dream's Hope
	["209333"] = true, -- Gnarlroot
	["200926"] = true, -- Igira the Cruel
	["208478"] = true, -- Volcoross
	["208363"] = true, -- Council of Dreams
	["208365"] = true, -- Council of Dreams
	["208367"] = true, -- Council of Dreams
	["208445"] = true, -- Larodar, the Keeper of the Flame
	["206172"] = true, -- Nymue, Weaver of the Cycle
	["200927"] = true, -- Smolderon
	["209090"] = true, -- Tindral Sageswift, Seer of the Flame
	["204931"] = true, -- Fyrakk the Blazing

	-- The Primalist Future (storm fury bosses)
	["199502"] = true, --glakis-winters-wrath
	["199667"] = true, --nimbulatus-storms-wrath
	["199664"] = true, --seismodor-earths-wrath

	--dragonflight world bosses
	["193534"] = true, --strunraan
	["193532"] = true, --bazual
	["193535"] = true, --basrikron
	["193533"] = true, --liskanoth
	["203220"] = true, --Vakan
	["199853"] = true, --Gholna
	["209574"] = true, --Aurostor

	-------Events-------

	--wow anniversary
	["121820"] = true, --azuregos
	["121913"] = true, --emeriss
	["121821"] = true, --lethon
	["121911"] = true, --taerar
	["121912"] = true, --ysondre
	["121818"] = true, --lord-kazzak
	["167749"] = true, --doomwalker

	--darkmoon
	["58336"] = true, --darkmoon-rabbit
	["71992"] = true, --moonfang
	["15467"] = true, --omen

	--Love is in the Air
	["36296"] = true, --Apothecary Hummel <Crown Chemical Co.>
	["36565"] = true, --Apothecary Baxter <Crown Chemical Co.>
	["36272"] = true, --Apothecary Frye <Crown Chemical Co.>

	--darkmaul-citadel (new player experience dungeon)
	["157300"] = true, --tunk
	["156814"] = true, --gorgroth

	-------The War Within-------

	--the-rookery
	["209230"] = true, --kyrioss
	["207205"] = true, --stormguard-gorren
	["207207"] = true, --voidstone-monstrosity

	--priory-of-the-sacred-flame
	["207939"] = true, --baron-braunpyke
	["207946"] = true, --captain-dailcry
	["211290"] = true, --elaena-emberlanz
	["207940"] = true, --prioress-murrpray

	--ara-kara-city-of-echoes
	["215405"] = true, --anubzekt
	["213179"] = true, --avanoxx
	["215407"] = true, --kikatal-the-harvester
	["220599"] = true,

	--the-stonevault
	["219440"] = true, --high-speaker-eirich
	["213119"] = true, --high-speaker-eirich
	["210156"] = true, --skarmorak
	["221586"] = true, --speaker-dorlita
	["213216"] = true, --speaker-dorlita
	["213217"] = true, --speaker-brokk]
	["210108"] = true, --e-d-n-a]

	--cinderbrew-meadery
	["218000"] = true, --benk-buzzbee
	["218002"] = true, --benk-buzzbee
	["210271"] = true, --brew-master-aldryr
	["218523"] = true, --goldie-baronbottom
	["214661"] = true, --goldie-baronbottom
	["210267"] = true, --ipa

	--city-of-threads
	["216658"] = true, --izo-the-grand-splicer
	["216648"] = true, --nx
	["216649"] = true, --vx
	["216619"] = true, --orator-krixvizk
	["216320"] = true, --the-coaglamation

	--darkflame-cleft
	["208743"] = true, --blazikon
	["210149"] = true, --ol-waxbeard
	["210153"] = true, --ol-waxbeard
	["222096"] = true, --the-candle-king
	["208745"] = true, --the-candle-king
	["210797"] = true, --the-darkness

	--the dawnbreaker
	["211089"] = true, --anubikkaj
	["211087"] = true, --speaker-shadowcrown
	["213937"] = true, --rashanan
	["224552"] = true, --rashanan

	--nerub-ar-palace
	["223779"] = true, --anubarash
	["214506"] = true, --broodtwister-ovinax
	["228470"] = true, --nexus-princess-kyveza
	["227323"] = true, --queen-ansurek
	["219853"] = true, --sikran
	["214502"] = true, --the-bloodbound-horror
	["228713"] = true, --ulgrax-the-devourer
	["214504"] = true, --rashanan
	["217748"] = true, --nexus-princess-kyveza
	["219778"] = true, --queen-ansurek

	--operation-floodgate
	["226398"] = true, --big-m-o-m-m-a
	["242255"] = true, --geezle-gigazap
	["226403"] = true, --keeza-quickfuse
	["226396"] = true, --swampface

	--eco-dome-aldani
	["234893"] = true, --azhiccar
	["237514"] = true, --awazj
	["234933"] = true, --taahbat
	["247283"] = true, --soul-scribe
	["234935"] = true, --soul-scribe

	--liberation-of-undermine
	["231075"] = true, --chrome-king-gallywix
	["229181"] = true, --flarendo
	["229177"] = true, --torq
	["229953"] = true, --mugzee
	["228458"] = true, --one-armed-bandit
	["228648"] = true, --rik-reverb
	["230583"] = true, --sprocketmonger-lockenstock
	["230322"] = true, --stix-bunkjunker
	["225821"] = true, --the-geargrinder

	--manaforge-omega
	["237661"] = true, --adarus-duskblaze
	["233824"] = true, --dimensius
	["247989"] = true, --forgeweaver-araz
	["237861"] = true, --fractillus
	["233815"] = true, --loomithar
	["237763"] = true, --nexus-king-salhadaar
	["233814"] = true, --plexus-sentinel
	["233816"] = true, --soulbinder-naazindhri

	--war within world bosses
	["221084"] = true, --kordac
	["229334"] = true, --kordac 2?
	["220999"] = true, --aggregation-of-horrors
	["221224"] = true, --shurrai
	["221067"] = true, --orta
	["231821"] = true, --the-gobfather
	["238319"] = true, --reshanor
}

local textureDB = {
	["TYPE1"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star.tga",
	["TYPE2"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star2.tga",
	["TYPE3"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star3.tga",
	["TYPE4"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star4.tga",
	["TYPE5"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star5.tga",
	["TYPE6"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star6.tga",
	["TYPE7"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star7.tga",
	["TYPE8"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\dragon.tga",
	["TYPE9"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\dragon2.tga",
	["TYPE10"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\treasure.tga",
	["TYPE11"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull.tga",
	["TYPE12"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull2.tga",
	["TYPE13"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull3.tga",
	["TYPE14"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull4.tga",
	["TYPE15"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull5.tga",
	["TYPE16"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull6.tga",
	["TYPE17"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull7.tga",
	["TYPE18"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull8.tga",
	["TYPE19"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull9.tga",
	["TYPE20"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\reaper.tga",
	["TYPE21"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\reaper2.tga",
	["TYPE22"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull10.tga",
	["TYPE23"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull11.tga",
	["TYPE24"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull12.tga",
	["TYPE25"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull13.tga",
}

local textureDB64 = {
	["TYPE1"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star.tga",
	["TYPE2"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star2.tga",
	["TYPE3"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star3.tga",
	["TYPE4"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star4.tga",
	["TYPE5"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star5.tga",
	["TYPE6"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star6.tga",
	["TYPE7"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star7.tga",
	["TYPE8"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\dragon.tga",
	["TYPE9"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\dragon2.tga",
	["TYPE10"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\treasure.tga",
	["TYPE11"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull.tga",
	["TYPE12"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull2.tga",
	["TYPE13"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull3.tga",
	["TYPE14"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull4.tga",
	["TYPE15"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull5.tga",
	["TYPE16"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull6.tga",
	["TYPE17"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull7.tga",
	["TYPE18"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull8.tga",
	["TYPE19"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull9.tga",
	["TYPE20"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\reaper.tga",
	["TYPE21"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\reaper2.tga",
	["TYPE22"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull10.tga",
	["TYPE23"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull11.tga",
	["TYPE24"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull12.tga",
	["TYPE25"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull13.tga",
}

function ElvUI_EltreumUI:GetBossIconTextureAndID(textureType,isbossID,bossID,resolution)
	if textureType then
		if resolution then
			return textureDB64[textureType]
		else
			return textureDB[textureType]
		end
	elseif isbossID then
		if bossIDs[bossID] then
			return true
		else
			return false
		end
	end
end

local function Update(self)
	local element = self.EltruismClassificationIndicator

	if element.PreUpdate then
		element:PreUpdate()
	end

	local classification = self.classification
	local frameType = self.frameType
	if frameType then
	--if frameType and frameType == 'ENEMY_NPC' then
		if classification == 'worldboss' or bossIDs[self.npcID] then
			if E.db.ElvUI_EltreumUI.nameplates.classification.icontypeboss == "CUSTOM" then
				element:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customboss)
			else
				element:SetTexture(textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontypeboss])
			end
			-- color
			element:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.bossR, E.db.ElvUI_EltreumUI.nameplates.classification.bossG, E.db.ElvUI_EltreumUI.nameplates.classification.bossB, 1)
			element:Show()
		elseif classification == 'elite' then
			if E.db.ElvUI_EltreumUI.nameplates.classification.icontypeelite == "CUSTOM" then
				element:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customelite)
			else
				element:SetTexture(textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontypeelite])
			end
			-- color
			element:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.eliteR, E.db.ElvUI_EltreumUI.nameplates.classification.eliteG, E.db.ElvUI_EltreumUI.nameplates.classification.eliteB, 1)
			element:Show()
		elseif classification == 'rareelite' then
			if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite == "CUSTOM" then
				element:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customrareelite)
			else
				element:SetTexture(textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite])
			end
			element:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteR, E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteG, E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteB, 1)
			--element:SetAtlas('nameplates-icon-elite-silver')
			element:Show()
		elseif classification == 'rare' then
			if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperare == "CUSTOM" then
				element:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customrare)
			else
				element:SetTexture(textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontyperare])
			end

			element:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.rareR, E.db.ElvUI_EltreumUI.nameplates.classification.rareG, E.db.ElvUI_EltreumUI.nameplates.classification.rareB, 1)
			element:Show()
		else
			element:Hide()
		end
	else
		element:Hide()
	end

	if E.db.ElvUI_EltreumUI.dev then
		ElvUI_EltreumUI:Print("npcID: "..self.npcID..","..classification..","..frameType)
	end

	if element.PostUpdate then
		return element:PostUpdate(classification)
	end
end

local function Path(self, ...)
	return (self.EltruismClassificationIndicator.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self)
	local element = self.EltruismClassificationIndicator
	if element then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		if element:IsObjectType('Texture') and not element:GetTexture() then
			element:SetTexture([[Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo]])
		end

		self:RegisterEvent('UNIT_CLASSIFICATION_CHANGED', Path)

		return true
	end
end

local function Disable(self)
	local element = self.EltruismClassificationIndicator
	if element then
		element:Hide()

		self:UnregisterEvent('UNIT_CLASSIFICATION_CHANGED', Path)
	end
end

local function Construct_ClassificationIndicator(nameplate)
	return nameplate:CreateTexture(nameplate:GetName() .. 'EltruismClassificationIndicator', 'OVERLAY')
end

local function Update_ClassificationIndicator(_, nameplate)
	local plateDB = NP:PlateDB(nameplate)

	 -- add your settings here
	local db = plateDB.eliteIcon
	if db and db.enable and (nameplate.frameType == 'FRIENDLY_NPC' or nameplate.frameType == 'ENEMY_NPC') then
	--if db and (nameplate.frameType == 'ENEMY_NPC') then
		if not nameplate:IsElementEnabled('EltruismClassificationIndicator') then
			nameplate:EnableElement('EltruismClassificationIndicator')
		end
		if nameplate.EltruismClassificationIndicator and nameplate:IsElementEnabled('ClassificationIndicator') then
			nameplate.EltruismClassificationIndicator:Show()
			nameplate.EltruismClassificationIndicator:ClearAllPoints()
			nameplate.EltruismClassificationIndicator:Size(db.size, db.size)
			nameplate.EltruismClassificationIndicator:Point(E.InversePoints[db.position], nameplate, db.position, db.xOffset, db.yOffset)
		end

		if nameplate:IsElementEnabled('ClassificationIndicator') then --hide elvui's icon if eltruism's is enabled
			if nameplate.ClassificationIndicator then
				nameplate.ClassificationIndicator:SetAlpha(0)
			end
		end

	elseif nameplate:IsElementEnabled('EltruismClassificationIndicator') then
		nameplate:DisableElement('EltruismClassificationIndicator')
		if nameplate.EltruismClassificationIndicator then
			nameplate.EltruismClassificationIndicator:Hide()
		end
	end
end

local function StylePlate(_, nameplate)
	nameplate.EltruismClassificationIndicator = Construct_ClassificationIndicator(nameplate.RaisedElement)
end

function ElvUI_EltreumUI:NPClassificatioNIcon()
	if E.db.ElvUI_EltreumUI.nameplates.classification.enable then
		-- hook to create the icon
		hooksecurefunc(NP, "Update_ClassificationIndicator", Update_ClassificationIndicator)
		hooksecurefunc(NP, "StylePlate", StylePlate)

		-- add it to ouf
		if not elementAdded then
			oUF:AddElement('EltruismClassificationIndicator', Path, Enable, Disable)
			elementAdded = true
		end
	end
end

--Difficulty Icon for npcs
local unitisnotboss = {
	["worldboss"] = true,
	["elite"] = true,
	["rareelite"] = true,
	["rare"] = true,
}
E:AddTag('eltruism:classification', 'UNIT_NAME_UPDATE', function(unit)
	local red,green,blue
	local icon
	if not ElvUI_EltreumUI:IsThisASafeSecret() then return end
	local classification = UnitClassification(unit) -- "worldboss", "rareelite", "elite", "rare", "normal", "trivial", or "minus"
	if unitisnotboss[classification] then
		if not UnitIsPlayer(unit) and UnitCanAttack("player", unit) then
			if classification == 'worldboss' then
				red = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.bossR*255)
				blue = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.bossB*255)
				green = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.bossG*255)
				if E.db.ElvUI_EltreumUI.nameplates.classification.icontypeboss == "CUSTOM" then
					icon = "|T"..[[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customboss..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				else
					icon = "|T"..textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontypeboss]..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				end
			elseif classification == 'elite' then
				red = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.eliteR*255)
				blue = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.eliteB*255)
				green = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.eliteG*255)
				if E.db.ElvUI_EltreumUI.nameplates.classification.icontypeelite == "CUSTOM" then
					icon = "|T"..[[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customelite..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				else
					icon = "|T"..textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontypeelite]..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				end
			elseif classification == 'rareelite' then
				red = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteR*255)
				blue = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteB*255)
				green = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteG*255)
				if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite == "CUSTOM" then
					icon = "|T"..[[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customrareelite..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				else
					icon = "|T"..textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite]..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				end
			elseif classification == 'rare' then
				red = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareR*255)
				blue = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareB*255)
				green = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareG*255)
				if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperare == "CUSTOM" then
					icon = "|T"..[[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customrare..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				else
					icon = "|T"..textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontyperare]..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				end
			end
		end
	elseif not E.Retail then
		if UnitGUID(unit) and not UnitIsPlayer(unit) and UnitCanAttack("player", unit) then
			local unitID = select(6, _G.strsplit('-', UnitGUID(unit)))
			if bossIDs[unitID] then
				red = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.bossR*255)
				blue = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.bossB*255)
				green = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.bossG*255)
				if E.db.ElvUI_EltreumUI.nameplates.classification.icontypeboss == "CUSTOM" then
					icon = "|T"..[[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customboss..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				else
					icon = "|T"..textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontypeboss]..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				end
			end
		end
	end
end)
E:AddTagInfo('eltruism:classification', ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows an Icon for the classification of the unit"])
