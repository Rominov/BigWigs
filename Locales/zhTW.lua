local L = BigWigsAPI:NewLocale("BigWigs", "zhTW")
if not L then return end

L.getNewRelease = "你的 BigWigs 已過期（/bwv）但是可以使用 Twitch 客戶端簡單升級。另外，也可以從 curseforge.com 或 wowinterface.com 手動升級。"
L.warnTwoReleases = "你的 BigWigs 已過期2個發行版！你的版本可能有錯誤，功能缺失或不正確的計時器。所以強烈建議你升級。"
L.warnSeveralReleases = "|cffff0000你的 BigWigs 已過期%d發行版！！我們「強烈」建議你更新，以防止把問題同步給其他玩家！|r"

L.gitHubDesc = "BigWigs 是一個在 GitHub 上的開源軟體。我們一直在尋找新的朋友幫助我們和歡迎任何人檢測我們的代碼，做出貢獻和提交錯誤報告。BigWigs 今天的偉大很大程度上一部分因為偉大的魔獸世界社區幫助我們。"

L.options = "選項"
L.raidBosses = "團隊首領"
L.dungeonBosses = "地城首領"

L.infobox = "訊息盒"
L.infobox_desc = "顯示當前戰鬥相關的訊息。"
L.INFOBOX = L.infobox
L.INFOBOX_desc = L.infobox_desc

L.disabledAddOn = "你的 |cFF436EEE%s|r 插件已禁用，計時器將不被顯示。"
L.alternativeName = "%s（|cFF436EEE%s|r）"

L.activeBossModules = "啟動首領模組："
L.advanced = "進階選項"
L.alphaRelease = "你所使用的 BigWigs %s 為“α測試版”（%s）"
L.already_registered = "|cffff0000警告：|r |cff00ff00%s|r（|cffffff00%s|r）在 BigWigs 中已經存在模組，但存在模組仍試圖重新註冊。可能由於更新失敗的原因，通常表示您有兩份模組拷貝在您的插件資料夾中。建議刪除所有 BigWigs 資料夾並重新安裝。"
L.altpower = "顯示替代能量"
L.ALTPOWER = "顯示替代能量"
L.altpower_desc = "顯示替代能量視窗，顯示團隊成員的替代能量值。"
L.ALTPOWER_desc = "玩家在一些首領戰鬥中會使用替代能量機制。替代能量視窗讓玩家快速查看團隊中誰有最少或最多替代能量，對特定戰術或分配會有幫助。"
L.back = "<< 返回"
L.BAR = "計時條"
L.BAR_desc = "在適當時會為首領技能顯示計時條。如果你想隱藏此技能的計時條，停用此選項。"
L.berserk = "狂暴"
L.berserk_desc = "為首領狂暴顯示計時條及警報。"
L.best = "最快："
L.chatMessages = "聊天框體訊息"
L.chatMessagesDesc = "除了顯示設定，輸出所有 BigWigs 訊息到預設聊天框體。"
L.colors = "顏色"
L.configure = "配置"
L.COUNTDOWN = "倒數"
L.COUNTDOWN_desc = "啟用後，倒數最後五秒會顯示聲音及文字。想像有人在你的畫面中央以巨大的數字倒數 \"5... 4... 3... 2... 1...\"。"
L.dbmFaker = "假裝我是使用 DBM"
L.dbmFakerDesc = "如果一個 DBM 使用者作版本檢查以確認哪些人用了 DBM 的時候，他們會看到你在名單之上。當你的公會強制要求使用DBM，這是很有用的。"
L.dbmUsers = "使用 DBM："
L.DISPEL = "只對驅散和打斷"
L.DISPEL_desc = "如果你希望在你不能打斷或驅散的情況下仍然警報此技能，停用此選項。"
L.dispeller = "|cFFFF0000只警報驅散和打斷。|r"
L.EMPHASIZE = "強調"
L.EMPHASIZE_desc = "啟用後會強調所有與此技能相關的訊息，使它們更大和更容易看到。你可於選項\"訊息\"調整強調訊息的字型及大小。"
L.FLASH = "閃爍"
L.FLASH_desc = "有些技能可能比其他的更重要。如果你希望此技能施放時閃爍螢幕，啟用此選項。"
L.flashScreen = "螢幕閃爍"
L.flashScreenDesc = "某些技能極其重要到需要充分被重視。當這些能力對你造成影響時 BigWigs 可以使螢幕閃爍。"
L.healer = "|cFFFF0000只警報治療。|r"
L.HEALER = "只對治療"
L.HEALER_desc = "有些技能只對治療重要。如果想無視你的職業一律看到此技能警報，停用此選項。"
L.heroic = "英雄模式"
L.ICON = "標記"
L.ICON_desc = "BigWigs 可以根據技能用圖示標記人物。這將使他們更容易被辨認。"
L.introduction = "歡迎使用 BigWigs 戲弄各個首領。請繫好安全帶，吃吃花生並享受這次旅行。它不會吃了你的孩子，但會協助你的團隊與新的首領進行戰鬥就如同享受饕餮大餐一樣。"
L.kills = "擊殺："
L.lfr = "隨機團隊"
L.listAbilities = "列出技能到團隊聊天"
L.ME_ONLY = "只對自身"
L.ME_ONLY_desc = "當啟用此選項時只有對你有影響的技能訊息才會被顯示。比如，“炸彈：玩家”將只會在你是炸彈時顯示。"
L.MESSAGE = "訊息"
L.MESSAGE_desc = "大多數首領技能會有一條或多條訊息被 BigWigs 顯示在螢幕上。如停用此選項，若此技能有訊息也不會顯示。"
L.minimapIcon = "小地圖圖示"
L.minimapToggle = "打開或關閉小地圖圖示。"
L.missingAddOn = "請注意這個區域需要此 |cFF436EEE%s|r 計時器掛件才能顯示。"
L.mythic = "傳奇"
L.noBossMod = "沒有首領模組："
L.normal = "普通模式"
L.officialRelease = "你所使用的 BigWigs %s 為官方正式版（%s）"
L.offline = "離線"
L.oldVersionsInGroup = "在你隊伍裡使用舊版本或沒有使用 BigWigs。你可以用 /bwv 獲得詳細內容。"
L.outOfDate = "過期："
L.PROXIMITY = "玩家雷達"
L.PROXIMITY_desc = "有些技能有時會要求團隊散開。玩家雷達為此技能獨立顯示一個視窗告訴你誰離你過近是並且是不安全的。"
L.PULSE = "脈衝"
L.PULSE_desc = "除了螢幕閃爍之外，也可以使特定技能的圖示隨之顯示在你的螢幕上，以提高注意力。"
L.removeAddon = "請移除“|cFF436EEE%s|r”，其已被“|cFF436EEE%s|r”所替代。"
L.resetPositions = "重置位置"
L.SAY = "說"
L.SAY_desc = "對話泡泡容易被看見。BigWigs 將以白頻訊息通知附近的人你中了什麼技能。"
L.selectEncounter = "選擇戰鬥"
L.slashDescBreak = "|cFFFED000/break:|r 發送休息時間到團隊。"
L.slashDescConfig = "|cFFFED000/bw:|r 開啟 BigWigs 配置。"
L.slashDescLocalBar = "|cFFFED000/localbar:|r 創建一個只有自身可見的自訂計時條。"
L.slashDescPull = "|cFFFED000/pull:|r 發送拉怪倒數提示到團隊。"
L.slashDescRaidBar = "|cFFFED000/raidbar:|r 發送自訂計時條到團隊。"
L.slashDescRange = "|cFFFED000/range:|r 開啟範圍偵測。"
L.slashDescTitle = "|cFFFED000命令行：|r"
L.slashDescVersion = "|cFFFED000/bwv:|r 進行 BigWigs 版本檢測。"
L.sound = "音效"
L.sourceCheckout = "你所使用的 BigWigs %s 為從源直接檢出的。"
L.stages = "階段"
L.stages_desc = "對應首領的不同階段啟用相關功能，如玩家雷達、計時條等。"
L.statistics = "統計"
L.tank = "|cFFFF0000只警報坦克。|r"
L.TANK = "只對坦克"
L.TANK_desc = "有些技能只對坦克重要。如果想無視職業看到這些技能警報，停用此選項。"
L.tankhealer = "|cFFFF0000只警報坦克&治療。|r"
L.TANK_HEALER = "只對坦克和治療"
L.TANK_HEALER_desc = "有些技能只對坦克和治療重要。如果想無視職業看到這些技能警報，停用此選項。"
L.test = "測試"
L.testBarsBtn = "創建測試計時條"
L.testBarsBtn_desc = "創建一個測試計時條以測試當前顯示設定。"
L.toggleAnchorsBtn = "切換錨點"
L.toggleAnchorsBtn_desc = "切換顯示或隱藏全部錨點。"
L.tooltipHint = "|cffeda55f右擊|r打開選項。"
L.upToDate = "已更新："
L.VOICE = "語音"
L.VOICE_desc = "如果安裝了語音插件，此選項可以開啟並播放警報音效文件。"
L.warmup = "預備"
L.warmup_desc = "首領戰鬥之前的預備時間。"
L.wipes = "團滅："
L.zoneMessages = "顯示區域訊息"
L.zoneMessagesDesc = "此選項於進入區域時提示可安裝的 BigWigs 模組。建議啟用此選項，因為當我們為一個新區域建立 BigWigs 模組，這將會是唯一的提示安裝訊息。"

L.SOUND = "音效"
L.SOUND_desc = "首領技能通常會播放音效來提醒你，如果不想附加音效，請禁用此選項。"
L.CASTBAR = "施法條"
L.CASTBAR_desc = "施法條會在某些首領戰場合出現，通常用來提醒即將到來的重要技能。如果想隱藏施法條，請禁用此選項。"
L.SAY_COUNTDOWN = "倒數報數"
L.SAY_COUNTDOWN_desc = "聊天泡泡十分醒目，利用此特性，BigWigs 以倒數計時的說話消息來提醒附近的人技能即將到期。"
L.ME_ONLY_EMPHASIZE = "強調 (只有我)"
L.ME_ONLY_EMPHASIZE_desc = "啟用後會強調所有只施放在你的技能相關的訊息，使它們更大和更容易看到。"
-- L.NAMEPLATEBAR = "Nameplate Bars"
-- L.NAMEPLATEBAR_desc = "Bars are sometimes attached to nameplates when more than one mob casts the same spell. If this ability is accompanied by a nameplate bar that you want to hide, disable this option."

-- Media.lua
L.Beware = "當心（艾爾加隆）"
L.FlagTaken = "奪旗（PvP）"
L.Destruction = "毀滅（基爾加丹）"
L.RunAway = "快逃啊小女孩，快逃……（大野狼）"
