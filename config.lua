--[[
 	      ___      _                          _    _                         
       / _ \    | |                        | |  | |                        
   ___| | | | __| | _____  __    ______    | |__| | __ _ ___  __ _ _ __    
  / __| | | |/ _` |/ _ \ \/ /   |______|   |  __  |/ _` / __|/ _` | '_ \   
 | (__| |_| | (_| |  __/>  <               | |  | | (_| \__ \ (_| | | | |_ 
  \___|\___/ \__,_|\___/_/\_\              |_|  |_|\__,_|___/\__,_|_| |_(_)
                                                                           
]]


Config = {}

Config.ModTusu         = 210        -- Modlar arasında geçiş yapmak için kullanılan tuş. (https://docs.fivem.net/docs/game-references/controls/)
Config.HizMiktari      = 35.0       -- Araç spor moddayken motor hızının kaç kat artacağı. Sonuna .0 koymak zorunlu. Varsayılan değer 25.0
Config.MaxHizMiktari   = 999.0      -- Araç spor modundayken aracın maximum kaç kmde gidebileceği. Sonuna .0 koymak zorunlu. Varsayılan değer 999.0
Config.DokmeSuresi     = 35 * 1000  -- Zx3 maddesinin aracın benzin deposuna kaç saniyede döküleceği. 35'i 60 yaparsanız 60 saniyede döker. Varsayılan değer 35.
Config.CikarmaSuresi   = 35 * 1000  -- Zx3 maddesinin aracın benzin deposundan kaç saniyede çıkartılacağı. 35'i 60 yaparsanız 60 saniyede çıkartır. Varsayılan değer 35.
Config.Cikartilabilir  = true       -- Eğer true yaparsanız spor mode zx3remover itemiyle çıkartılabilir. Eğer false yaparsanız çıkartılamaz. Varsayılan değer true.
Config.BeklemeSuresi   = 5 * 1000   -- Modlar arasında geçiş yaparken bekleme süresi. 5 yerine 15 yazarsanız 15 saniyede bir modlar arası geçiş yapılabilir. Devre dışı bırakmak için 5 yerine 0 yazın. Varsayılan değer 5.
Config.KontrolSuresi   = 35 * 1000  -- Zx3 maddesinin aracın benzin deposunda olup olmadığını kontrol eden sistemin kaç saniyede kontrol edeceği. 35'i 60 yaparsanız 60 saniyede kontrol eder. Varsayılan değer 35.
