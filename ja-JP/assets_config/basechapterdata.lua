-- params : ...
-- function num : 0 , upvalues : _ENV
BaseChapterData = {
[51100000] = {id = 51100000, type = 1, stages = "52100001:52100002", open_condition = "72501001:0:1", pre = 0, next = "0", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "0", story_times = "0"}
, 
[51100001] = {id = 51100001, name = (PUtil.get)(85110000, (PUtil.get)(86400001), (PUtil.get)(85110001)), type = 1, stages = "52100101:52100102:52100103:52100104:52100105", open_condition = "72501001:0:1", pre = 0, next = "51100002", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75001521", story_times = "101"}
, 
[51100002] = {id = 51100002, name = (PUtil.get)(85110000, (PUtil.get)(86400002), (PUtil.get)(85110002)), type = 1, stages = "52100201:52100202:52100203:52100204:52100205", open_condition = "72501001:0:1,72504111:52100105:1", pre = 51100001, next = "51100003", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", unlock_id = 11100001, unlock_des = "86400002:85170001", story_id = "75002111:75002521", story_times = "100:101"}
, 
[51100003] = {id = 51100003, name = (PUtil.get)(85110000, (PUtil.get)(86400003), (PUtil.get)(85110003)), type = 1, stages = "52100301:52100302:52100303:52100304:52100305", open_condition = "72501001:0:1,72504111:52100205:1", pre = 51100002, next = "51100004", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", unlock_id = 11100004, unlock_des = "86400003:85170002", story_id = "75003111", story_times = "100"}
, 
[51100004] = {id = 51100004, name = (PUtil.get)(85110000, (PUtil.get)(86400004), (PUtil.get)(85110004)), type = 1, stages = "52100401:52100402:52100403:52100404:52100405", open_condition = "72501001:0:1,72504111:52100305:1", pre = 51100003, next = "51100005", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75004111:75004521:75004522", story_times = "100:101:101"}
, 
[51100005] = {id = 51100005, name = (PUtil.get)(85110000, (PUtil.get)(86400005), (PUtil.get)(85110005)), type = 1, stages = "52100501:52100502:52100503:52100504:52100505", open_condition = "72501001:0:1,72504111:52100405:1", pre = 51100004, next = "51100006", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon003", story_id = "75005111", story_times = "100"}
, 
[51100006] = {id = 51100006, name = (PUtil.get)(85110000, (PUtil.get)(86400006), (PUtil.get)(85110006)), type = 1, stages = "52100601:52100602:52100603:52100604:52100605", open_condition = "72501001:0:10,72504111:52100505:1", pre = 51100005, next = "51100007", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75006111:75006521", story_times = "100:101"}
, 
[51100007] = {id = 51100007, name = (PUtil.get)(85110000, (PUtil.get)(86400007), (PUtil.get)(85110007)), type = 1, stages = "52100701:52100702:52100703:52100704:52100705", open_condition = "72501001:0:10,72504111:52100605:1", pre = 51100006, next = "51100008", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon004", story_id = "75007111", story_times = "100"}
, 
[51100008] = {id = 51100008, name = (PUtil.get)(85110000, (PUtil.get)(86400008), (PUtil.get)(85110008)), type = 1, stages = "52100801:52100802:52100803:52100804:52100805", open_condition = "72501001:0:16,72504111:52100705:1", pre = 51100007, next = "51100009", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75008111:75008112", story_times = "100:100"}
, 
[51100009] = {id = 51100009, name = (PUtil.get)(85110000, (PUtil.get)(86400009), (PUtil.get)(85110009)), type = 1, stages = "52100901:52100902:52100903:52100904:52100905", open_condition = "72501001:0:18,72504111:52100805:1", pre = 51100008, next = "51100010", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75009111", story_times = "100"}
, 
[51100010] = {id = 51100010, name = (PUtil.get)(85110000, (PUtil.get)(86400010), (PUtil.get)(85110010)), type = 1, stages = "52101001:52101002:52101003:52101004:52101005", open_condition = "72501001:0:20,72504111:52100905:1", pre = 51100009, next = "51100011", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon004", story_id = "75010111:75010521", story_times = "100:101"}
, 
[51100011] = {id = 51100011, name = (PUtil.get)(85110000, (PUtil.get)(86400011), (PUtil.get)(85110011)), type = 1, stages = "52101101:52101102:52101103:52101104:52101105", open_condition = "72501001:0:22,72504111:52101005:1", pre = 51100010, next = "51100012", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75011111", story_times = "100"}
, 
[51100012] = {id = 51100012, name = (PUtil.get)(85110000, (PUtil.get)(86400012), (PUtil.get)(85110012)), type = 1, stages = "52101201:52101202:52101203:52101204:52101205", open_condition = "72501001:0:24,72504111:52101105:1", pre = 51100011, next = "51100013", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75012111:75012521", story_times = "100:101"}
, 
[51100013] = {id = 51100013, name = (PUtil.get)(85110000, (PUtil.get)(86400013), (PUtil.get)(85110013)), type = 1, stages = "52101301:52101302:52101303:52101304:52101305", open_condition = "72501001:0:26,72504111:52101205:1", pre = 51100012, next = "51100014", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", story_id = "75013111", story_times = "100"}
, 
[51100014] = {id = 51100014, name = (PUtil.get)(85110000, (PUtil.get)(86400014), (PUtil.get)(85110014)), type = 1, stages = "52101401:52101402:52101403:52101404:52101405", open_condition = "72501001:0:28,72504111:52101305:1", pre = 51100013, next = "51100015", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon004", story_id = "75014111:75014521", story_times = "100:101"}
, 
[51100015] = {id = 51100015, name = (PUtil.get)(85110000, (PUtil.get)(86400015), (PUtil.get)(85110015)), type = 1, stages = "52101501:52101502:52101503:52101504:52101505", open_condition = "72501001:0:30,72504111:52101405:1", pre = 51100014, next = "51100016", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon003", story_id = "75015111", story_times = "100"}
, 
[51100016] = {id = 51100016, name = (PUtil.get)(85110000, (PUtil.get)(86400016), (PUtil.get)(85110016)), type = 1, stages = "52101601:52101602:52101603:52101604:52101605", open_condition = "72501001:0:33,72504111:52101505:1", pre = 51100015, next = "51100017", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75016111:75016521", story_times = "100:101"}
, 
[51100017] = {id = 51100017, name = (PUtil.get)(85110000, (PUtil.get)(86400017), (PUtil.get)(85110017)), type = 1, stages = "52101701:52101702:52101703:52101704:52101705", open_condition = "72501001:0:35,72504111:52101605:1", pre = 51100016, next = "51100018", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75017111", story_times = "100"}
, 
[51100018] = {id = 51100018, name = (PUtil.get)(85110000, (PUtil.get)(86400018), (PUtil.get)(85110018)), type = 1, stages = "52101801:52101802:52101803:52101804:52101805", open_condition = "72501001:0:38,72504111:52101705:1", pre = 51100017, next = "51100019", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75018111", story_times = "100"}
, 
[51100019] = {id = 51100019, name = (PUtil.get)(85110000, (PUtil.get)(86400019), (PUtil.get)(85110019)), type = 1, stages = "52101901:52101902:52101903:52101904:52101905", open_condition = "72501001:0:40,72504111:52101805:1", pre = 51100018, next = "51100020", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75019111", story_times = "100"}
, 
[51100020] = {id = 51100020, name = (PUtil.get)(85110000, (PUtil.get)(86400020), (PUtil.get)(85110020)), type = 1, stages = "52102001:52102002:52102003:52102004:52102005", open_condition = "72501001:0:43,72504111:52101905:1", pre = 51100019, next = "51100021", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", story_id = "75020111:75020521", story_times = "100:101"}
, 
[51100021] = {id = 51100021, name = (PUtil.get)(85110000, (PUtil.get)(86400021), (PUtil.get)(85110021)), type = 1, stages = "52102101:52102102:52102103:52102104:52102105", open_condition = "72501001:0:45,72504111:52102005:1", pre = 51100020, next = "51100022", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon003", story_id = "75021111", story_times = "100"}
, 
[51100022] = {id = 51100022, name = (PUtil.get)(85110000, (PUtil.get)(86400022), (PUtil.get)(85110022)), type = 1, stages = "52102201:52102202:52102203:52102204:52102205", open_condition = "72501001:0:48,72504111:52102105:1", pre = 51100021, next = "51100023", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75022111:75022521:75022522", story_times = "100:101:101"}
, 
[51100023] = {id = 51100023, name = (PUtil.get)(85110000, (PUtil.get)(86400023), (PUtil.get)(85110023)), type = 1, stages = "52102301:52102302:52102303:52102304:52102305", open_condition = "72501001:0:50,72504111:52102205:1", pre = 51100022, next = "51100024", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", story_id = "75023111", story_times = "100"}
, 
[51100024] = {id = 51100024, name = (PUtil.get)(85110000, (PUtil.get)(86400024), (PUtil.get)(85110024)), type = 1, stages = "52102401:52102402:52102403:52102404:52102405", open_condition = "72501001:0:52,72504111:52102305:1", pre = 51100023, next = "51100025", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75024111:75024521:75024522", story_times = "100:101:101"}
, 
[51100025] = {id = 51100025, name = (PUtil.get)(85110000, (PUtil.get)(86400025), (PUtil.get)(85110025)), type = 1, stages = "52102501:52102502:52102503:52102504:52102505", open_condition = "72501001:0:55,72504111:52102405:1", pre = 51100024, next = "51100026", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75025111:75025521", story_times = "100:101"}
, 
[51100026] = {id = 51100026, name = (PUtil.get)(85110000, (PUtil.get)(86400026), (PUtil.get)(85110026)), type = 1, stages = "52102601:52102602:52102603:52102604:52102605", open_condition = "72501001:0:56,72504111:52102505:1", pre = 51100025, next = "51100027", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon004", story_id = "75026111", story_times = "100"}
, 
[51100027] = {id = 51100027, name = (PUtil.get)(85110000, (PUtil.get)(86400027), (PUtil.get)(85110027)), type = 1, stages = "52102701:52102702:52102703:52102704:52102705", open_condition = "72501001:0:57,72504111:52102605:1", pre = 51100026, next = "51100028", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75027111", story_times = "100"}
, 
[51100028] = {id = 51100028, name = (PUtil.get)(85110000, (PUtil.get)(86400028), (PUtil.get)(85110028)), type = 1, stages = "52102801:52102802:52102803:52102804:52102805", open_condition = "72501001:0:58,72504111:52102705:1", pre = 51100027, next = "51100029", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75028111", story_times = "100"}
, 
[51100029] = {id = 51100029, name = (PUtil.get)(85110000, (PUtil.get)(86400029), (PUtil.get)(85110029)), type = 1, stages = "52102901:52102902:52102903:52102904:52102905", open_condition = "72501001:0:59,72504111:52102805:1", pre = 51100028, next = "51100030", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75029111", story_times = "100"}
, 
[51100030] = {id = 51100030, name = (PUtil.get)(85110000, (PUtil.get)(86400030), (PUtil.get)(85110030)), type = 1, stages = "52103001:52103002:52103003:52103004:52103005", open_condition = "72501001:0:60,72504111:52102905:1", pre = 51100029, next = "51100031", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75030111:75030521", story_times = "100:101"}
, 
[51100031] = {id = 51100031, name = (PUtil.get)(85110000, (PUtil.get)(86400031), (PUtil.get)(85110031)), type = 1, stages = "52103101:52103102:52103103:52103104:52103105", open_condition = "72501001:0:61,72504111:52103005:1", pre = 51100030, next = "51100032", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", story_id = "75031111", story_times = "100"}
, 
[51100032] = {id = 51100032, name = (PUtil.get)(85110000, (PUtil.get)(86400032), (PUtil.get)(85110032)), type = 1, stages = "52103201:52103202:52103203:52103204:52103205", open_condition = "72501001:0:62,72504111:52103105:1", pre = 51100031, next = "51100033", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75032111:75032521", story_times = "100:101"}
, 
[51100033] = {id = 51100033, name = (PUtil.get)(85110000, (PUtil.get)(86400033), (PUtil.get)(85110033)), type = 1, stages = "52103301:52103302:52103303:52103304:52103305", open_condition = "72501001:0:63,72504111:52103205:1", pre = 51100032, next = "51100034", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon003", story_id = "75033111:75033521", story_times = "100:101"}
, 
[51100034] = {id = 51100034, name = (PUtil.get)(85110000, (PUtil.get)(86400034), (PUtil.get)(85110034)), type = 1, stages = "52103401:52103402:52103403:52103404:52103405", open_condition = "72501001:0:64,72504111:52103305:1", pre = 51100033, next = "51100035", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon004", story_id = "75034111:75034521", story_times = "100:101"}
, 
[51100035] = {id = 51100035, name = (PUtil.get)(85110000, (PUtil.get)(86400035), (PUtil.get)(85110035)), type = 1, stages = "52103501:52103502:52103503:52103504:52103505", open_condition = "72501001:0:65,72504111:52103405:1", pre = 51100034, next = "51100036", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", story_id = "75035111", story_times = "100"}
, 
[51100036] = {id = 51100036, name = (PUtil.get)(85110000, (PUtil.get)(86400036), (PUtil.get)(85110036)), type = 1, stages = "52103601:52103602:52103603:52103604:52103605", open_condition = "72501001:0:66,72504111:52103505:1", pre = 51100035, next = "51100037", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75036111:75036521", story_times = "100:101"}
, 
[51100037] = {id = 51100037, name = (PUtil.get)(85110000, (PUtil.get)(86400037), (PUtil.get)(85110037)), type = 1, stages = "52103701:52103702:52103703:52103704:52103705", open_condition = "72501001:0:67,72504111:52103605:1", pre = 51100036, next = "51100038", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75037111", story_times = "100"}
, 
[51100038] = {id = 51100038, name = (PUtil.get)(85110000, (PUtil.get)(86400038), (PUtil.get)(85110038)), type = 1, stages = "52103801:52103802:52103803:52103804:52103805", open_condition = "72501001:0:68,72504111:52103705:1", pre = 51100037, next = "51100039", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75038111:75038521", story_times = "100:101"}
, 
[51100039] = {id = 51100039, name = (PUtil.get)(85110000, (PUtil.get)(86400039), (PUtil.get)(85110039)), type = 1, stages = "52103901:52103902:52103903:52103904:52103905", open_condition = "72501001:0:69,72504111:52103805:1", pre = 51100038, next = "51100040", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon003", story_id = "75039111", story_times = "100"}
, 
[51100040] = {id = 51100040, name = (PUtil.get)(85110000, (PUtil.get)(86400040), (PUtil.get)(85110040)), type = 1, stages = "52104001:52104002:52104003:52104004:52104005", open_condition = "72501001:0:70,72504111:52103905:1", pre = 51100039, next = "51100041", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75040111:75040521", story_times = "100:101"}
, 
[51100041] = {id = 51100041, name = (PUtil.get)(85110000, (PUtil.get)(86400041), (PUtil.get)(85110041)), type = 1, stages = "52104101:52104102:52104103:52104104:52104105", open_condition = "72501001:0:71,72504111:52104005:1", pre = 51100040, next = "51100042", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75041111", story_times = "100"}
, 
[51100042] = {id = 51100042, name = (PUtil.get)(85110000, (PUtil.get)(86400042), (PUtil.get)(85110042)), type = 1, stages = "52104201:52104202:52104203:52104204:52104205", open_condition = "72501001:0:72,72504111:52104105:1", pre = 51100041, next = "51100043", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75042111:75042521", story_times = "100:101"}
, 
[51100043] = {id = 51100043, name = (PUtil.get)(85110000, (PUtil.get)(86400043), (PUtil.get)(85110043)), type = 1, stages = "52104301:52104302:52104303:52104304:52104305", open_condition = "72501001:0:73,72504111:52104205:1", pre = 51100042, next = "51100044", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75043111", story_times = "100"}
, 
[51100044] = {id = 51100044, name = (PUtil.get)(85110000, (PUtil.get)(86400044), (PUtil.get)(85110044)), type = 1, stages = "52104401:52104402:52104403:52104404:52104405", open_condition = "72501001:0:74,72504111:52104305:1", pre = 51100043, next = "51100045", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75044111", story_times = "100"}
, 
[51100045] = {id = 51100045, name = (PUtil.get)(85110000, (PUtil.get)(86400045), (PUtil.get)(85110045)), type = 1, stages = "52104501:52104502:52104503:52104504:52104505", open_condition = "72501001:0:75,72504111:52104405:1", pre = 51100044, next = "51100046", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75045111", story_times = "100"}
, 
[51100046] = {id = 51100046, name = (PUtil.get)(85110000, (PUtil.get)(86400046), (PUtil.get)(85119046)), type = 1, stages = "52104601:52104602:52104603:52104604:52104605", open_condition = "72501001:0:76,72504111:52104505:1", pre = 51100045, next = "51100047", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon003", story_id = "75046111", story_times = "100"}
, 
[51100047] = {id = 51100047, name = (PUtil.get)(85110000, (PUtil.get)(86400047), (PUtil.get)(85110047)), type = 1, stages = "52104701:52104702:52104703:52104704:52104705", open_condition = "72501001:0:77,72504111:52104605:1", pre = 51100046, next = "51100048", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon004", story_id = "75047111", story_times = "100"}
, 
[51100048] = {id = 51100048, name = (PUtil.get)(85110000, (PUtil.get)(86400048), (PUtil.get)(85110048)), type = 1, stages = "52104801:52104802:52104803:52104804:52104805", open_condition = "72501001:0:77,72504111:52104705:1", pre = 51100047, next = "0", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75048111", story_times = "100"}
, 
[51200001] = {id = 51200001, name = (PUtil.get)(85120001), type = 2, stages = "52200101:52200102:52200103:52200104:52200105:52200106:52200107:52200108:52200109:52200110", open_condition = "72501001:0:9", pre = 0, next = "51200002", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap001", book_show = "plot_book001", book_monter_show = "CardSpine_11202001", story_id = "0", story_times = "0"}
, 
[51200002] = {id = 51200002, name = (PUtil.get)(85120002), type = 2, stages = "52200201:52200202:52200203:52200204:52200205:52200206:52200207:52200208:52200209:52200210:52200211:52200212:52200213:52200214:52200215:52200216:52200217:52200218", open_condition = "72501001:0:20,72504211:52200110:1", pre = 51200001, next = "51200003", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap002", book_show = "plot_book002", book_monter_show = "Cardspine_11300007", story_id = "0", story_times = "0"}
, 
[51200003] = {id = 51200003, name = (PUtil.get)(85120003), type = 2, stages = "52200301:52200302:52200303:52200304:52200305:52200306:52200307:52200308:52200309:52200310:52200311:52200312:52200313:52200314:52200315:52200316:52200317:52200318:52200319:52200320:52200321:52200322:52200323:52200324:52200325:52200326:52200327:52200328:52200329:52200330", open_condition = "72501001:0:32,72504211:52200218:1", pre = 51200002, next = "51200004", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap003", book_show = "plot_book003", book_monter_show = "Cardspine_11300005", story_id = "0", story_times = "0"}
, 
[51200004] = {id = 51200004, name = (PUtil.get)(85120004), type = 2, stages = "52200401:52200402:52200403:52200404:52200405:52200406:52200407:52200408:52200409:52200410:52200411:52200412:52200413:52200414:52200415:52200416:52200417:52200418:52200419:52200420:52200421:52200422:52200423:52200424:52200425:52200426:52200427", open_condition = "72501001:0:51,72504211:52200330:1", pre = 51200003, next = "51200005", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap004", book_show = "plot_book001", book_monter_show = "CardSpine_11300002", story_id = "0", story_times = "0"}
, 
[51200005] = {id = 51200005, name = (PUtil.get)(85120005), type = 2, stages = "52200501:52200502:52200503:52200504:52200505:52200506:52200507:52200508:52200509:52200510:52200511:52200512:52200513:52200514:52200515:52200516:52200517:52200518:52200519:52200520:52200521", open_condition = "72501001:0:64,72504211:52200427:1", pre = 51200004, next = "51200006", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap005", book_show = "plot_book002", book_monter_show = "CardSpine_11300004", story_id = "0", story_times = "0"}
, 
[51200006] = {id = 51200006, name = (PUtil.get)(85120006), type = 2, stages = "52200601:52200602:52200603:52200604:52200605:52200606:52200607:52200608:52200609:52200610:52200611:52200612:52200613:52200614:52200615:52200616:52200617:52200618:52200619:52200620:52200621:52200622:52200623:52200624", open_condition = "72501001:0:70,72504211:52200521:1", pre = 51200005, next = "51200007", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap006", book_show = "plot_book002", book_monter_show = "CardSpine_11301005", story_id = "0", story_times = "0"}
, 
[51200007] = {id = 51200007, name = (PUtil.get)(85120007), type = 2, stages = "52200701:52200702:52200703:52200704:52200705:52200706:52200707:52200708:52200709:52200710:52200711:52200712:52200713:52200714:52200715:52200716:52200717:52200718:52200719:52200720:52200721:52200722:52200723:52200724:52200725", open_condition = "72501001:0:74,72504211:52200624:1", pre = 51200006, next = "0", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap007", book_show = "plot_book002", book_monter_show = "CardSpine_11202003", story_id = "0", story_times = "0"}
, 
[51410001] = {id = 51410001, name = (PUtil.get)(85110001), type = 101, stages = "52500101:52500102:52500103:52500104:52500105:52500106:52500107:52500108:52500109:52500110:52500111:52500112:52500113:52500114:52500115", open_condition = "72501001:0:1", pre = 0, next = "51420001", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420001] = {id = 51420001, name = (PUtil.get)(85120001), type = 101, stages = "52510101:52510102:52510103:52510104:52510105:52510106", open_condition = "72501001:0:1,72504611:52500115:1", pre = 51410001, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51410002] = {id = 51410002, name = (PUtil.get)(85180200), type = 101, stages = "52500201:52500202:52500203:52500204:52500205:52500206:52500207:52500208:52500209:52500210:52500211:52500212:52500213:52500214:52500215", open_condition = "72501001:0:1", pre = 0, next = "51420002", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420002] = {id = 51420002, name = (PUtil.get)(85180200), type = 101, stages = "52510201:52510202:52510203:52510204:52510205:52510206", open_condition = "72501001:0:1,72504611:52500215:1", pre = 51410002, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51410003] = {id = 51410003, name = (PUtil.get)(85180300), type = 101, stages = "52500301:52500302:52500303:52500304:52500305:52500306:52500307:52500308:52500309:52500310:52500311:52500312:52500313:52500314:52500315", open_condition = "72501001:0:1", pre = 0, next = "51420003", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420003] = {id = 51420003, name = (PUtil.get)(85180300), type = 101, stages = "52510301:52510302:52510303:52510304:52510305:52510306", open_condition = "72501001:0:1,72504611:52500315:1", pre = 51410003, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51410004] = {id = 51410004, name = (PUtil.get)(85180400), type = 101, stages = "52500401:52500402:52500403:52500404:52500405:52500406:52500407:52500408:52500409:52500410:52500411:52500412:52500413:52500414:52500415", open_condition = "72501001:0:1", pre = 0, next = "51420004", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420004] = {id = 51420004, name = (PUtil.get)(85180400), type = 101, stages = "52510401:52510402:52510403:52510404:52510405:52510406", open_condition = "72501001:0:1,72504611:52500415:1", pre = 51410004, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51410005] = {id = 51410005, name = (PUtil.get)(85180500), type = 101, stages = "52500501:52500502:52500503:52500504:52500505:52500506:52500507:52500508:52500509:52500510:52500511:52500512:52500513:52500514:52500515", open_condition = "72501001:0:1", pre = 0, next = "51420005", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420005] = {id = 51420005, name = (PUtil.get)(85180500), type = 101, stages = "52510501:52510502:52510503:52510504:52510505:52510506", open_condition = "72501001:0:1,72504611:52500515:1", pre = 51410005, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51410006] = {id = 51410006, name = (PUtil.get)(85180600), type = 101, stages = "52500601:52500602:52500603:52500604:52500605:52500606:52500607:52500608:52500609:52500610:52500611:52500612:52500613:52500614:52500615", open_condition = "72501001:0:1", pre = 0, next = "51420006", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420006] = {id = 51420006, name = (PUtil.get)(85180600), type = 101, stages = "52510601:52510602:52510603:52510604:52510605:52510606", open_condition = "72501001:0:1,72504611:52500615:1", pre = 51410006, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51510001] = {id = 51510001, name = (PUtil.get)(85110001), type = 20, stages = "52600101:52610101:52610102:52610103:52610104:52610105:52610106:52610107:52610108:52610109:52610110:52610111:52610112:52610113:52610114:52610115:52620101:52620102:52620103", open_condition = "72501001:0:60", pre = 0, next = "0", activity_id = 33001101, bg_res = "Relic:LayerBuildMap", story_id = "0", story_times = "0"}
, 
[51410007] = {id = 51410007, name = (PUtil.get)(85180700), type = 101, stages = "52500701:52500702:52500703:52500704:52500705:52500706:52500707:52500708:52500709:52500710:52500711:52500712:52500713:52500714:52500715", open_condition = "72501001:0:1", pre = 0, next = "51420007", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420007] = {id = 51420007, name = (PUtil.get)(85180700), type = 101, stages = "52510701:52510702:52510703:52510704:52510705:52510706", open_condition = "72501001:0:1,72504611:52500715:1", pre = 51410007, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51410008] = {id = 51410008, name = (PUtil.get)(85180800), type = 101, stages = "52500801:52500802:52500803:52500804:52500805:52500806:52500807:52500808:52500809:52500810:52500811:52500812:52500813:52500814:52500815", open_condition = "72501001:0:1", pre = 0, next = "51420008", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420008] = {id = 51420008, name = (PUtil.get)(85180800), type = 101, stages = "52510801:52510802:52510803:52510804:52510805:52510806", open_condition = "72501001:0:1,72504611:52500815:1", pre = 51410008, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51410009] = {id = 51410009, name = (PUtil.get)(85180900), type = 101, stages = "52500901:52500902:52500903:52500904:52500905:52500906:52500907:52500908:52500909:52500910:52500911:52500912:52500913:52500914:52500915", open_condition = "72501001:0:1", pre = 0, next = "51420009", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420009] = {id = 51420009, name = (PUtil.get)(85180900), type = 101, stages = "52510901:52510902:52510903:52510904:52510905:52510906", open_condition = "72501001:0:1,72504611:52500915:1", pre = 51410009, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51410010] = {id = 51410010, name = (PUtil.get)(85181000), type = 101, stages = "52501001:52501002:52501003:52501004:52501005:52501006:52501007:52501008:52501009:52501010:52501011:52501012:52501013:52501014:52501015", open_condition = "72501001:0:1", pre = 0, next = "51420010", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420010] = {id = 51420010, name = (PUtil.get)(85181000), type = 101, stages = "52511001:52511002:52511003:52511004:52511005:52511006", open_condition = "72501001:0:1,72504611:52501015:1", pre = 51410010, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51410011] = {id = 51410011, name = (PUtil.get)(85181100), type = 101, stages = "52501101:52501102:52501103:52501104:52501105:52501106:52501107:52501108:52501109:52501110:52501111:52501112:52501113:52501114:52501115", open_condition = "72501001:0:1", pre = 0, next = "51420011", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420011] = {id = 51420011, name = (PUtil.get)(85181100), type = 101, stages = "52511101:52511102:52511103:52511104:52511105:52511106", open_condition = "72501001:0:1,72504611:52501115:1", pre = 51410011, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51610001] = {id = 51610001, name = (PUtil.get)(85181200), type = 201, stages = "52700101:52700102:52700103:52700104:52700105", open_condition = "72501001:0:1", pre = 0, next = "51610002", activity_id = 33001401, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51610002] = {id = 51610002, name = (PUtil.get)(85181200), type = 201, stages = "52700106:52700107:52700108:52700109", open_condition = "72501001:0:1", pre = 51610001, next = "51610003", activity_id = 33001401, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51610003] = {id = 51610003, name = (PUtil.get)(85181200), type = 201, stages = "52700110:52700111:52700112:52700113:52700114", open_condition = "72501001:0:1", pre = 51610002, next = "0", activity_id = 33001401, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
}
return BaseChapterData

