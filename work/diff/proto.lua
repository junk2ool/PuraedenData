-- params : ...
-- function num : 0 , upvalues : _ENV
local Proto = {Schema = "syntax = \"proto3\"




//活动基本信息
message BaseActivityInfo
{
	int32		         actId = 1;//活动ID
	int32 				  type = 2;//活动类型
	int64		 	 beginTime = 3;//开始时间
	int64		 	   endTime = 4;//结束时间
	int64		   destroyTime = 5;//销毁时间
	int32		          mark = 6;//活动标记（客户端用）
}

//七天嘉年华
message SevenDayActInfo
{
			 int32		      curGroup = 1;//当前进行任务组
	repeated int32		   openedGroup = 2;//已经开放的任务组
	repeated int32		  expiredGroup = 3;//已经过期的任务组
	repeated TaskObject	      taskList = 4;//任务列表
			 int32		    undoneTask = 5;//未完成任务数
			 int32		        points = 6;//总积分
			 int32		        canGet = 7;//可领取奖励的积分
			 int64		    rewardTime = 8;//报酬剩余可领时间
}

//限时限购礼包
message LimitGiftActInfo
{
	repeated CommonObject           giftList = 1;//礼包列表（礼包ID		购买次数）
}

//每日充值
message DailyPayActInfo
{
	repeated TaskSimpleObject     rewardList = 1;//奖励列表（奖励ID		状态）
			 int32 					    comp = 2;//完成数量
}

//累计充值
message TotalPayActInfo
{
	repeated TaskSimpleObject     rewardList = 1;//奖励列表（奖励ID		状态）
	         int32 					    comp = 2;//完成数量
}

//累计登录
message LoginDayActInfo
{
	repeated TaskSimpleObject     rewardList = 1;//登录奖励列表（奖励ID		状态）
	         bool                   todayGet = 2;//今日登录奖励是否已领取
}

//扭蛋积分
message LotteryIntegralActInfo
{
             int32 					  points = 1;//总积分
	repeated TaskSimpleObject     rewardList = 2;//奖励列表（奖励ID		状态）
}

//神殿遗迹
message TempleActInfo
{
			 int32		      curGroup = 1;//当前进行任务组
	repeated int32		   openedGroup = 2;//已经开放的任务组
	repeated int32		  expiredGroup = 3;//已经过期的任务组
	repeated TaskObject	      taskList = 4;//任务列表
			 int32		    undoneTask = 5;//未完成任务数
}

//回归登录
message ReturnLoginActInfo
{
	repeated TaskSimpleObject     rewardList = 1;//登录奖励列表（奖励ID		状态）
	         bool                   todayGet = 2;//今日登录奖励是否已领取
	repeated TaskSimpleObject      pointList = 3;//积分奖励列表（奖励ID		状态）
			 int32		          totalPoint = 4;//总积分
			 int32                    dayNum = 5;//当前活动进行到第几天
			 int32                 initLevel = 6;//活动开启时玩家等级
}


//1701请求活动列表
message ReqActivityList
{
	
}
//1702返回活动列表
message ResActivityList
{
	repeated int32 actIdList = 1;//活动ID列表
}

//1703请求活动信息
message ReqActivityInfo
{
	int32 actId = 1;//活动ID
	int32  mark = 2;//活动标记（客户端每个活动单独做的，用于区分请求，原封不动返回给客户端）
}
//1704返回活动信息
message ResActivityInfo
{
	BaseActivityInfo 		         baseActivityInfo = 1;//基本活动数据

	SevenDayActInfo 		          SevenDayActInfo = 2;//七天嘉年华
	LimitGiftActInfo 		         LimitGiftActInfo = 3;//限时限购礼包
	DailyPayActInfo 		          DailyPayActInfo = 4;//每日充值
	TotalPayActInfo 		          TotalPayActInfo = 5;//累计充值
	LoginDayActInfo                   loginDayActInfo = 6;//累计登录
	LotteryIntegralActInfo	   lotteryIntegralActInfo = 7;//扭蛋积分
	TempleActInfo                       templeActInfo = 8;//神殿遗迹
	ReturnLoginActInfo             returnLoginActInfo = 9;//回归登录
}

//1705活动过期
message ReqDecActivity
{
	
}
//1706活动过期
message ResDecActivity
{
	int32 actId = 1;//活动ID
}


//==========任务类型活动==========//

//1707请求任务组
message ReqTaskGroup
{
	int32 actId = 1;//活动ID
	int32 group = 2;//任务组
}
//1708返回任务组
message ResTaskGroup
{
			 int32              actId = 1;//活动ID
	         int32              group = 2;//任务组
	repeated TaskObject      taskList = 3;//任务列表
}

//1709请求领取任务奖励
message ReqTaskReward
{
	int32  actId = 1;//活动ID
	int32  group = 2;//任务组
	int32 taskId = 3;//任务ID
}
//1710返回领取任务奖励
message ResTaskReward
{
	int32         actId = 1;//活动ID
	int32         group = 2;//任务组
	int32        taskId = 3;//任务ID
	int32    undoneTask = 4;//未完成任务数
	int32        points = 5;//总积分
	int32        canGet = 6;//可领取奖励的积分
}

//==========普通领奖活动==========//

//1711请求领取积分奖励
message ReqPointReward
{
	int32 actId = 1;//活动ID
	int32 rewId = 2;//奖励ID
}
//1712返回领取积分奖励
message ResPointReward
{
	int32 actId = 1;//活动ID
	int32 rewId = 2;//奖励ID
	bool result	= 3;//状态（true：成功	false：失败）
}

//1713请求领取活动奖励
message ReqGetReward
{
	int32 actId = 1;//活动ID
	int32 rewId = 2;//奖励ID
}
//1714返回领取活动奖励
message ResGetReward
{
	int32 actId = 1;//活动ID
	int32 rewId = 2;//奖励ID
	bool result	= 3;//状态（true：成功	false：失败）
}

//1715请求活动基本信息列表
message ReqActivityInfoList
{
	
}
//1716返回活动基本信息列表
message ResActivityInfoList
{
	repeated BaseActivityInfo 		baseActivityInfo = 1;//活动基本信息列表
}


//Banner活动
//1731请求Banner活动ID列表
message ReqBannerIdList
{

}
//1732返回Banner活动ID列表
message ResBannerIdList
{
	repeated int32 		     bannerId = 1;//banner活动ID列表
}

//1733请求保存Banner活动ID
message ReqSaveBannerId
{
	repeated int32 		     bannerId = 1;//banner活动ID
}
//1734返回保存Banner活动ID
message ResSaveBannerId
{
	repeated int32 		     bannerId = 1;//返回操作成功的banner活动ID
}

//1735请求删除Banner活动ID
message ReqRemoveBannerId
{
	repeated int32 		     bannerId = 1;//banner活动ID
}
//1736返回删除Banner活动ID
message ResRemoveBannerId
{
	repeated int32 		     bannerId = 1;//返回操作成功的banner活动ID
}



// 1401请求大冒险初始化
message ReqAdventureInit{

}

message ResAdventureInit{
	
	int32 mapId          			= 1;//地图id
	
	int32 nodeId            		= 2;//玩家当前位置
	
	int32 wishPoint     		 	= 3;//玩家拥有的许愿点
	
	repeated Event undoneEvent   	= 4;//未完成事件
	
	repeated Building buildings		= 5;//解锁的建筑信息
	repeated int32 passedNode		= 6;//当前地图停留过的格子
	
	//int32 stepToWish				= 7;//还需要投掷多少次触发许愿
	int32 stepToTarot				= 8;//还需要投掷多少次触发塔罗牌
	int32 isTarot                   = 9;//当日是否可以进行塔罗牌抽取 1为可以抽取 2为投掷次数不足,不能抽取 3为今日抽取次数不足
	bool isWish     				= 10;//是否可以许愿
	int32 triggeredTarot			= 11;//当日触发过的塔罗牌次数
	int32 boughtCtrlDice			= 12;//购买过的遥控骰子次数
	int32 tarotId                   = 13;//当日塔罗牌抽取结果
}

//事件
message Event{
	
	int64 id              = 1;//事件唯一id
	
	int32 nodeId        = 2;//节点id
	
	int32 eventId       = 3;//事件id
	
	int32 mapId         = 4;//地图id
	
}

//1403请求摇骰子或者选择下一节点
message ReqPlayDice{
	
	int32  diceNum                 = 1;//固定点数的骰子的点数
	int32 nextNodeId               = 2;//选择下一节点
	int32  diceTime                = 3;//请求要骰子的次数 如果该出有值 那么其余两个值都为0
	repeated int32 chooseNodeIds   = 4;//客户端选择的必出事件的nodeId

}

message ResPlayDice{
	repeated int32 diceNum        	= 1;//骰子点数
	int32 nodeId                  	= 2;//当前节点id(根据骰子点数,移动之后的位置)
	bool chooseNext               	= 3;//是否触发选择下一节点 (分叉路) 该值为true时,客户端需要在请求一次ReqPlayDice 并且nodeId为下一位置 不能触发事件
	int32 wishPoint               	= 4;//玩家拥有的许愿点
    repeated Event undoneEvent   	= 6;//未完成事件
	int32 mapId         			= 7;//地图id
	
	int32 boughtCtrlDice			= 8;//购买过的遥控骰子次数
	bool isWish     				= 9;//是否可以许愿
	repeated NodeReward rewards     = 10;//奖励(只针对奖励格子)
	int32 isTarot                   = 11;//当日是否可以进行塔罗牌抽取 1为可以抽取 2为投掷次数不足,不能抽取 3为今日抽取次数不足
}

//奖励格子
message NodeReward{
	int32   nodeId                = 1;
	repeated GoodsObject rewards  = 2;
}

//1405许愿奖励领取
message ReqWishReward{
	int32 type           = 1;//许愿类型 1塔罗牌许愿、2冒险许愿
	int32 rewardPoolId   = 2;//选择的奖励
}

message ResWishReward{
    int32 type                   = 1;//许愿类型 1塔罗牌许愿、2冒险许愿
	repeated GoodsObject rewards = 2;//奖励
	int32 rewardPoolId           = 3;//奖励id  说明 许愿时,奖励是由客户端发送的.塔罗牌抽取时,奖励是由服务器运算的
      
}

//1407请求建筑信息
message ReqAdventureBuilding{
	int32 type                = 1;//操作类型 1为请求建筑信息 2为请求领取奖励 3为入驻 4为解锁建筑
	CommonObject common       = 2;//type为3时  所需要的卡牌和位置  为4时 id为nodeId value为建筑id
	int32 adventureBuildId    = 3;//建筑id  type为3时需要
	int32 operateType         = 4;//操作类型 1为入驻卡牌 2为下阵卡牌   type为3时需要
	
}

message ResAdventureBuilding{
	repeated Building buildings       = 1;
	bool reqFirst                     = 2;//是否是当日第一次请求
}


//建筑基本信息
message Building{
	int32 buildingId                   = 1;//建筑id
	repeated CommonObject cardIndex    = 2;//建筑入驻卡牌集合id
	repeated GoodsObject totalOutput   = 3;//当前建筑的产出
	repeated GoodsObject upperOutput   = 4;//当前建筑的产出上限
}

//1409大冒险小游戏玩法奖励
message ReqAdventureEventReward{
			int64   id              = 1;//事件唯一id
	//int32 eventId                   = 1;//事件id
	int32 type                      = 2;//事件处理结果,类型 BaseAdventureEvent 表中的type字段
	repeated int32 rewardPoolIds    = 3;//奖励id集合
	bool mustWin                    = 4;//是否必胜 是否点击了猜拳 战斗 答题全胜按钮
	int32 nodeId                    = 5;//格子id
}

message ResAdventureEventReward{
	int32 eventId                   = 1;//事件id
	bool  result                    = 2;//事件结果
	repeated Event undoneEvent      = 3;//未完成事件
}

// 1415初始大冒险化布阵信息
message ReqInitAdventureBattleEmba{
	int64 id             = 1;//事件唯一id
	int32 nodeId         = 2;//
}

//1415初始大冒险化布阵信息
message ResInitAdventureBattleEmba{
	repeated CommonObject myCards      = 1;//玩家卡组
	repeated RivalCardState rivalCards = 2;//敌方卡组
}


//1411 请求进入战斗
message ReqInAdventureBattleEmba{
	//int32 eventId        = 1;
	int64 id             = 1;//唯一id
	bool mustWin         = 2;//必胜
	int32 nodeId         = 3;//
	repeated CommonObject myCards      = 4;//玩家上阵卡牌
}


//进入战斗
message ResInAdventureBattleEmba{
	bool      into                     = 1;//是否可以进入
	repeated GoodsObject goods         = 2;//必胜奖励  mustWin为true时才有值
	//mustWin为false时,下面两个字段一定要有值才能进行布阵
	
}

//1413战斗结算
message ReqSettleAdventureBattle{
	//int32     nodeId                        = 1;//
	BattleCompleteData battleCompleteData   = 2;//战斗数据
}

message ResSettleAdventureBattle{
	bool isSuccess             = 1;//战斗是否胜利
	repeated GoodsObject goods = 2;//奖励
}





//自选道具信息
message DropInfo
{
	int32                  propId = 1;//自选道具ID
	int32                   count = 2;//自选道具数量
}

//301使用道具请求
message ReqUseProp
{
	string	propIndex = 1;//道具流水
	int32	count     = 2;//使用数量
	int32	cardId	  = 3;//给哪个角色使用,若非角色的则为0
	int32	useType	  = 4;//使用场景
	repeated DropInfo    dropInfo = 5;//自选道具列表
}
//302使用道具回复
message ResUseProp
{
	string	propIndex = 1;//道具流水
	int32	propId    = 2;//道具ID
	int32	useCount  = 3;//真实使用了多少个
	int32   cardId    = 4;//给哪个角色使用,若非角色的则为0
	int32	useType	  = 5;//使用场景
	repeated GoodsObject  GainGoods           = 6;//获得的道具
}

//303出售道具
message ReqSellProp
{
	string propIndex = 1;//道具流水
	int32	count    = 2;//数量
}
//304出售道具
message ResSellProp
{
}

//305 穿装备
message ReqPutOnEquip
{
	string	sourceEquipIndex  = 1;//要穿戴的装备的流水号
	int32	sourceCardId      = 2;//要穿戴的装备来自哪个角色(0表示从背包来的)
	int32	cardId            = 3;//要穿在哪个角色身上
}
//306 穿装备
message ResPutOnEquip
{
	string	sourceEquipIndex  = 1;//要穿戴的装备的流水号
	int32	sourceCardId      = 2;//要穿戴的装备来自哪个角色(0表示从背包来的)
	string	replaceEquipIndex = 3;//要替换下的装备流水(如果来源是背包则脱下到背包，如果来源是其它角色则替换到角色身上，如果为空则表示直接穿戴)
	int32	cardId            = 4;//要穿在哪个角色身上
	repeated EquipSetsBuff equipSetsBuff = 5;//套装buff
}

//套装buff
message EquipSetsBuff{
	int32 cardId                 = 1;//角色Id
	repeated int32 equipSetsBuff = 2;//套装buff
}

//307 升级装备
message ReqLevelUpEquip
{
	string	equipIndex   = 1;//装备流水
	int32   cardId       = 2;//角色ID，为0表示在背包里
	int32   num          = 3;//升多少级，0表示升满级
}
//308 升级装备
message ResLevelUpEquip
{
			 string	equipIndex  = 1;//装备流水
			 int32   cardId     = 2;//角色ID，为0表示在背包里
			 int32   level      = 3;//装备当前等级
			 int32   mainAttrId = 4;//主属性ID
	repeated int32 randomAttrId = 5;//新增的附属性
}

//309 分解装备
message ReqDestroyEquip
{
	repeated string	equipIndex   = 1;//装备流水
	int32   cardId               = 2;//角色ID，为0表示在背包里
}
//310 分解装备
message ResDestroyEquip
{
	
}

//311
message ReqLockEquip
{
	string	equipIndex   = 1;//装备流水
	int32   cardId       = 2;//角色ID，为0表示在背包里
	bool    lock         = 3;//true为锁定，false为解锁
}
//312
message ResLockEquip
{
	string	equipIndex   = 1;//装备流水
	int32   cardId       = 2;//角色ID，为0表示在背包里
	bool    lock         = 3;//true为锁定，false为解锁
}

//313兑换碎片
message ReqExchangeDebris
{
	string	goodsIndex = 1;//万能碎片流水号
	int32	count      = 2;//要兑换的数量
	int32	debrisId   = 3;//要兑换的碎片ID
}
//314
message ResExchangeDebris
{
}

//315鉴定装备
message ReqIdentifyEquip
{
	repeated string equipIndex = 1;//
}
//316
message ResIdentifyEquip
{
	repeated EquipObject equipInfo = 1;
}

//称号信息
message TitleInfo
{
	int32                      titleId = 1;//称号ID
	int64                          pov = 2;//有效期（单位秒，-1为永久有效）
}

//317请求称号列表
message ReqTitleList
{
	
}
//318返回称号列表
message ResTitleList
{
	repeated TitleInfo       titleInfo = 1;//称号列表
}

//319请求佩戴称号
message ReqWearTitle
{
	int32                      titleId = 1;//称号ID（请求0即卸下称号）
}
//320返回佩戴称号
message ResWearTitle
{
	int32                      titleId = 1;//称号ID（卸下称号返回0 ，请求什么就返回什么）
}

//321请求皮肤列表
message ReqFashionList
{
	
}
//322返回皮肤列表
message ResFashionList
{
	repeated int32            fashions = 1;//皮肤列表
}




//702初始化战斗数据
message InitBattleData
{
    string battleUid                        = 1;//战斗唯一标示
    int32 stageId                           = 2;//副本id，仅对副本类型生效
    E_BATTLE_TYPE battleType                = 3;//战斗类型，前后端约定
    repeated int32 randomSeedTable1         = 4;//随机数组1;长度为10
    repeated int32 randomSeedTable2         = 5;//随机数组2;长度为10
    repeated int32 randomSeedTable3         = 6;//随机数组3;长度为10
    repeated int32 randomSeedTable4         = 7;//随机数组4;长度为10
    repeated int32 randomSeedTable5         = 8;//随机数组5;长度为10
    repeated PreBattleEvent preBattleEvent  = 9;//战前事件列表
    bool autoBattle                         = 10;//是否是自动战斗，如果是自动战斗，过程中无法操作
    BattleTeamInfo teamInfo                 = 11;//战斗队伍信息
    repeated BattleWave battleProcessData   = 12;//战斗过程详细信息
	int32 nodeId                            = 13;//大冒险战斗对应格子id 
	int64 beginTime                         = 14;//战斗开始时间
	bool test                            = 15;//是否为测试
	string        param1                    = 16;//其他参数  用于各功能点的参数 需要什么类型的数据 各功能点各自转换
	
}

//战斗完成后的数据
//战斗服返给游戏服的数据
//客户端发给游戏服的数据
//游戏服发给战斗服的数据
message BattleCompleteData
{
    bool success                 = 1;//关卡是否挑战成功
    DamageData damageData        = 2;//伤害信息
    InitBattleData battleData    = 3;//战斗数据
    int32 id                     = 4;//副本id
    bool notEnterBattle          = 5;//不进入战斗
    E_CHALLENGE_TYPE challengeType  = 6;//挑战类型
    repeated ChallengeSummarizeData challengeSummarizeData = 7;//战斗中所有参战卡片的伤害统计
	AllBattleTeamCardState allTeamCardState = 8;//卡牌战斗之后的状态
    ExpeditionBattleData expeditionBattleData = 9;//远征的数据
	int32 gameServerId           = 10;//游戏服serverId
	string versionAndPlatform    = 11;//客户端版本号跟平台
}

//远征使用到的数据信息，客户端封装后传给服务器
message ExpeditionBattleData
{
    int32 changeFc                 = 1;//战力改变值
    int32 selfMaxFc                = 2;//玩家战斗力历史最大值
    int32 stageId                  = 3;//远征的关卡
	int32 challengeTimes           = 4;//挑战的次数，用于做属性缩放
}

//战斗结束后,卡组状态
message AllBattleTeamCardState{
	repeated BattleTeamCardState teamA       = 1;
	repeated BattleTeamCardState teamB       = 2;
}

//战斗之后卡牌的状态
message BattleTeamCardState{
	int32 waveNum                   = 1;//当前波数
	repeated CardState cardState    = 2;//状态
}

//战斗结束后 每张卡牌的状态
message CardState{
	int32 id             = 1;
	string uid           = 2;//卡片唯一id
	int32 supHp          = 3;//剩余血量
	int32 supDander      = 4;//剩余怒气
	int32 pos            = 5;//位置
}

//单个卡片伤害数据
message CardSummarizeData
{
    BattleCardData CardData     = 1;//卡片数据
    int64 DamageNum             = 2;//伤害
    int64 HurtNum               = 3;//承受伤害
}

message ChallengeSummarizeData
{
    repeated CardSummarizeData SelfCardData    = 1;//己方单次数据集合
    repeated CardSummarizeData EnemyCardData   = 2;//敌方单次数据集合
    bool isSelfSuccess                  = 3;//是否是己方胜利
}

//战斗队伍信息
message BattleTeamInfo
{
    repeated BattleTeam teamA               = 1;//己方的队伍信息
    repeated BattleTeam teamB               = 2;//敌方的队伍信息
	repeated TalentTreeInfo teamATalent     = 3;//已方天赋
	repeated TalentTreeInfo teamBTalent     = 4;//敌方天赋
	repeated CommonObject   teamAIntimacy   = 5;//已方卡牌亲密度信息
	repeated CommonObject   teamBIntimacy   = 6;//敌方卡牌亲密度信息
	repeated CommonObject   teamACardStar   = 7;//已方卡牌升星信息
	repeated CommonObject   teamBCardStar   = 8;//敌方卡牌升星信息
	repeated int32          teamAFetter     = 9;//已方已激活的羁绊
	repeated int32          teamBFetter     = 10;//敌方已激活的羁绊
	repeated MatrixTreeInfo teamAMatrix     = 11;//已方潜能
	repeated MatrixTreeInfo teamBMatrix     = 12;//敌方潜能
	repeated CardDetail     otherCards      = 13;//其他人的卡片详细信息
    repeated int32          teamATitle      = 14;//已方已激活的称号
    repeated int32          teamBTitle      = 15;//敌方已激活的称号
}

//战斗内队伍
message BattleTeam
{
    int32 waveNum                           = 1;//当前波数
	int32 maxRound                          = 2;//最大回合数0
    repeated BattleCardData teamCard        = 3;//卡片队伍
    int32 monsterGroup                      = 4;//当前的怪物组
}

//战斗内卡片初始化信息
message BattleCardData
{
    string uid                              = 1;//卡片的唯一标示
    int32 posIndex                          = 2;//卡片对应的阵位
    int64 hp                                = 3;//生命
    int32 dander                            = 4;//怒气
    int32 spd                               = 5;//速度

    CardObject cardInfo                     = 6;//卡片的通用属性
}

message PreBattleEvent
{
    int32 eventId                           = 1;//战前事件的id
}

message DamageData{
    int64 totalSelfDamage           = 1;//己方战斗对有效目标造成的总伤害
    int64 totalEnemyHp              = 2;//敌方有效目标的总血量
}

//-----------------------------下面部分为战斗内的数据-----------------------------
//战前事件的数据
message PreBattleEventInfo
{

}

//每一波的数据
message BattleWave
{
    int32 curWave                           = 1;//当前波数（总数）
    int32 selfCurWave                       = 2;//己方当前波数
    int32 enemyCurWave                      = 3;//敌方当前波数
    repeated BattleRound roundData          = 4;//回合数据
    BattleAtkInfo preBattleEventInfo        = 5;//本波战斗开始前的事件的战斗信息
}

//每一个大回合的数据
message BattleRound
{
    int32 round                             = 1;//当前的回合数
    BattleAtkInfo preRoundInfo              = 2;//大回合前的战斗数据变化
    repeated BattleAtkInfo attackInfo       = 3;//大回合内的所有攻击信息
}

//单次攻击信息
message BattleAtkInfo
{
    string atkCardUid                       = 1;//当前攻击者的uid
    int32 atkPos                            = 2;//攻击者的阵位
    int32 skillId                           = 3;//本次攻击的技能id
    int32 skillType                         = 4;//本次攻击的技能类型
    int32 hpAtk                             = 5;//攻击者的血量变化
    int32 danderAtk                         = 6;//攻击者的怒气变化
    bool isAssist                           = 7;//是否是协击
    bool lastAtk                            = 8;//本次攻击最后一个出手信息
    bool isStrike                           = 9;//是否会击飞
    bool targetSelf                         = 10;//目标是否是己方
    bool moveCamera                         = 11;//是否移动摄像机
    bool atkFail                            = 12;//是否是行动失败
    bool isTreatment                        = 13;//是否是治疗
    bool isFall                             = 14;//是否被击落
    bool noAtkAction                        = 15;//纯buff攻击没有其他攻击动作
    repeated BattleAtkInfo assistAtkInfo    = 16;//协击信息
    repeated BattleBuffObject allBuffTable	= 17;//本回合包含的buff数据
    repeated DefendCardInfo defCardsInfo    = 18;//本次攻击的受击方信息
    int32 movePosType                       = 19;//本次攻击的移动位置
    int32 atkIndex                          = 20;//本次出手的序号
    repeated BattleAtkInfo doubleAtkInfo    = 21;//连击信息
    bool isDoubleAttack                     = 22;//本次攻击信息是否是连击
    string copyCardUid                      = 23;//复制技能复制的角色uid
	bool skillAddition                      = 24;//本次技能是否是追加技能
}

message BattleBuffObject
{
	BattleBuff buff 						= 1;//buff的数据
	string type 							= 2;//buff操作的类型（新增、删除、免疫、更新）
}

message BattleBuff
{
    int32 buffId                            = 1;//buff的配置id
    int32 usedShieldHp                      = 2;//已经使用了的护盾值
    int32 shieldHp                          = 3;//所有的护盾值
    repeated BattleBuffEffect effectTable   = 4;//该buff所包含的所有效果
    int32 settleRoundType                   = 5;//buff的挂载回合类型
    int32 deductionRoundType                = 6;//buff的生效扣除次数回合类型
    int32 atkPos                            = 7;//buff的施加者的位置
    int32 curDefPos                         = 8;//buff挂载的卡片位置
    int32 activeCount                       = 9;//当前已经生效的次数
    int32 totalCount                        = 10;//总共可生效的次数
    int32 activeForever                     = 11;//效果是否是永久生效 0 不是永久 1 是永久
    int64 buffTimeStamp                     = 12;//buff挂载的时间戳
    repeated CommonObject summonCards		= 13;//召唤的卡片列表
}

message BattleBuffEffect
{
    int32 effectId                          = 1;//buff效果id
    int32 attributeId                       = 2;//buff效果对应的属性id
    int32 value                             = 3;//buff效果对应的属性变化值
    int32 realValue                         = 4;//buff造成的实际属性变化
    int32 absorbDamage                      = 5;//护盾吸收的伤害
    bool isInvincible                       = 6;//是否无敌
    bool isKeepAlive                        = 7;//是否守护
}

//受击方信息
message DefendCardInfo
{
    string defCardUid                       = 1;//受击方uid
    int32 defPos                            = 2;//受击方位置
    int32 hpDef                             = 3;//受击方血量变化，实际生效
    int32 danderDef                         = 4;//受击方怒气变化
    bool isDodge                            = 5;//是否闪避
    bool isCrit                             = 6;//是否暴击
    bool isBlock                            = 7;//是否格挡
    int32 absorbDamage                      = 8;//护盾吸收的伤害
    bool isInvincible                       = 9;//是否无敌
    bool isKeepAlive                        = 10;//是否守护
    bool isCounter                          = 11;//是否是反伤
    int32 shareDamageCardPos                = 12;//被援护卡片的位置
    bool isSkillTarget                      = 13;//是否是攻击技能直接选址目标
    bool isImmune                           = 14;//是否免疫

}

//请求战斗数据 703
message ReqBattleData{
	
	string battleIndex                  = 1;//战斗的唯一id
	E_BATTLE_TYPE   battleType          = 2;//战斗类型
}

//战斗数据 704
message ResBattleData{
    BattleCompleteData  battleCompleteData = 1;
}

//玩家退出战斗707
message ReqExitBattle{
	string battleUid            = 1;//战斗唯一标识
}
//玩家主动退出战斗708
message ResExitBattle{
	string battleUid                        = 1;//战斗唯一标示

}




//901 抽奖初始化
message ReqLotteryInit
{
	E_LOTTERY_TYPE type = 1;//抽奖类型
}
//902 抽奖初始化
message ResLotteryInit
{
	int32	onceFreeNum    = 1;//单抽剩余免费次数
	int32	onceCdTime     = 2;//单抽剩余CD时间
	int32	moreFreeNum    = 3;//十连抽剩余免费次数
	int32	moreCdTime     = 4;//十连抽剩余CD时间
	bool    dayLottery     = 5;//是否可以每日一抽
	int32   onceSurplusNum = 6;//单抽剩余总次数(目前只有新手扭蛋有)
	int32   moreSurplusNum = 7;//十连抽剩余总次数(目前只有新手扭蛋有)
	int64 beginTime        = 8;//活动开始时间
	int64 endTime          = 9;//活动结束时间
	int32 integral         = 10;//扭蛋积分
	//repeated OtherLottery  otherLottery  = 8;//活动扭蛋 
}

//所有活动扭蛋 931
message ReqActivityLottery
{
	
}

//所有活动扭蛋 932
message ResActivityLottery
{
	repeated OtherLottery otherLottery          = 1;//活动扭蛋 
}

//903 抽奖
message ReqLotteryDraw
{
	int32	lotteryId = 1;//抽奖ID
}
//904
message ResLotteryDraw
{
				int32	      lotteryId = 1;//抽奖ID
	repeated GoodsChangeObject goods    = 2;//资源和卡牌对象(value为负数表示消耗,正数表示获得)
	repeated PropObject  prop           = 3;//道具(count为负数表示消耗,正数表示获得)
	repeated EquipObject equip 			= 4;//获得的装备
			 int32			  cdTime    = 5;//到下次的CD时间
			 int32			  freeNum   = 6;//剩余免费次数
			 int32           integral   = 7;//扭蛋积分
}

//请求扭蛋积分兑换的初始化信息  927
message ReqInitConversion{
	int32	      type = 1;//扭蛋类型
}

//928
message ResInitConversion{
	repeated CommonObject initConversion = 1; //id为角色id  value为兑换次数
	int32    integral                    = 2;//积分 
	int32	      type = 3;//扭蛋类型
}



//活动扭蛋兑换 929 
message ReqLotteryConversion{
	int32	      type = 1;//扭蛋类型
	
	int32         id        = 2;//兑换id 可以是角色和物品的id 
}

//930
message ResLotteryConversion{
	repeated CommonObject initConversion = 1; //id兑换id  value为兑换次数
	int32    integral           = 2;//积分 
	int32	      type     = 3;//扭蛋类型
}

//905
message ReqSignInInit
{
}
//906
message ResSignInInit
{
	int32	signInedDay      = 1;//已签到的天数
	bool    canSignIn        = 2;//当前是否可签到(接着已签到的天数后面第一个就是今天的)
	int32   totalSignInDay   = 3;//累计签到天数
	int32	extraId          = 4;//当前领取奖励轮次ID
	int32   signInId         = 5;//签到轮次ID
	bool    canGetExtra      = 6;//是否可领取奖励
}

//907
message ReqSignIn
{
}
//908
message ResSignIn
{
	int32	signInedDay      = 1;//已签到的天数
	int32   totalSignInDay   = 2;//累计签到天数
	bool    canGetExtra      = 3;//是否可领取奖励
}

//909
message ReqSignInReward
{
}
//910
message ResSignInReward
{
	int32	extraId          = 1;//当前领取奖励轮次ID
	bool    canGet           = 2;//是否可以领取
}

//911
message ReqVitGetInit
{
}
//912
message ResVitGetInit
{
	repeated	int32	canGetId = 1;//当前可以免费领取的
	repeated	int32	extraId  = 2;//需要花钱补领的
	repeated    int32   getedId  = 3;//已经领取的
}

//913
message ReqVitGet
{
	int32	id = 1;//领取的ID
}
//914
message ResVitGet
{
	int32	id = 1;//领取的ID
}



//915 请求登录活动
message ReqLoginAct
{
	
}
//916 返回登录活动
message ResLoginAct
{
	int32              day = 1;//登录天数
	bool            dayGet = 2;//当日奖励是否已领
}

//917 请求领取登录活动奖励
message ReqLoginActGet
{
	int32              day = 1;//登录天数
}
//918 返回领取登录活动奖励
message ResLoginActGet
{
    int32              day = 1;//登录天数
	bool            dayGet = 2;//当天奖励是否已领取
}

//919 请求拉霸数据
message ReqSlotsData
{
	int32             type = 1;//拉霸类型
}
//920 返回拉霸数据
message ResSlotsData
{
	int32             type  = 1;//拉霸类型
	bool              reset = 2;//是否可以重置
	int32             round = 3;//当前轮次
	repeated SlotsData RewardItems = 4;//所有轮次的拉霸数据
	int32             totalRoundNum   = 5;//总轮次
}

//921 重置拉霸轮次
message ReqSlotsReset
{
	int32             type = 1;//拉霸类型
}

//922
message ResSlotsReset
{
	int32             type = 1;//拉霸类型
	int32             round = 2;//当前轮次
}

//923 开始拉霸
message ReqSlotsOperation
{
	int32             type = 1;//拉霸类型
	int32             times = 2;//拉霸次数
}

//924
message ResSlotsOperation
{
	int32             type  = 1;//拉霸类型
	bool              reset = 2;//是否可以重置
	repeated SlotsData RewardItems = 3;//当前轮次拉霸数据
	int32 round             = 4;//轮次
	bool resetRound         = 5;//是否切换轮次
	int32             totalRoundNum   = 6;//总轮次
	repeated ShowSlotsRecord showSlotsRecord        = 7;//奖励池id
}

//拉霸记录显示
message ShowSlotsRecord{
	int32 poolId               = 1;
	repeated GoodsObject goods = 2;
}

message SlotsData
{
	int32          round       = 1;//轮次
	repeated SlotItemData data = 2;//拉霸数据
}

//拉霸数据
message SlotItemData
{
	int32 SlotsPoolId         = 1;//BaseSlotsPool ID
	int32 GetNum              = 2;//已经获得的个数
}

//请求扭蛋记录 925
message ReqLotteryRecord
{
	
}

//926
message ResLotteryRecord
{
	repeated LotterRecord lotteryRecord  =1;
}

//扭蛋记录
message LotterRecord
{
	int32 wordId = 1;
	int64 recordTime	 = 2;
	repeated int32 cardIds = 3;
}

//获取拉霸记录 933
message ReqSlotsRecord{
	int32 type        = 1;//类型
}

//934
message ResSlotsRecord{
	repeated SlotsRecord slotsRecord   = 1;
	int32 type        = 2;//类型
}

message SlotsRecord{
	int64     time              = 1;//拉霸时间
	int32 poolId                = 2;//奖励池id
	repeated GoodsObject goods  = 3 ;//拉霸奖励记录
}




//401卡牌升级请求
message ReqLevelUp
{
	int32	id  = 1;//卡牌ID
	int32   num = 2;//要升几级
}
//402卡牌升级回复
message ResLevelUp
{
	int32 id       = 1;
	int32 level    = 2;//新的等级
	int32 exp      = 3;//新的经验
	int32 totalExp = 4;//实际一共获得多少经验
}

//401卡牌升品请求
message ReqQualityUp
{
	int32	id  = 1;//卡牌ID
	int32   num = 2;//要升几级(0表示升到最大)
}
//404卡牌升品回复
message ResQualityUp
{
	int32 id	  = 1;
	int32 quality = 2;//新的品质
}

//405卡牌技能升级请求
message ReqSkillUp
{
	int32	id 		= 1;//卡牌ID
	int32	skillId = 2;//技能ID(0表示一键升级)
	int32	num		= 3;//升的级数
	repeated CommonObject skillData = 4;//批量升级的技能(value表示要升的级数,不升的不发) 上面的skillId和num是为了兼容老版本，要判断一下如果有值就是单升，如果没值就是批量升级
}
//406卡牌技能升级回复
message ResSkillUp
{
				int32			id		= 1;//卡牌ID
	repeated	CommonObject	skill   = 2;//技能新的等级(value表示新等级)
}

//407卡牌升星请求
message ReqStarUp
{
	int32	id = 1;
}
//408卡牌升星回复
message ResStarUp
{
	int32	id   = 1;
	int32	star = 2;
}

message CardLevelInfo
{
	int32 id       = 1;
	int32 level    = 2;//等级
	int32 exp      = 3;//经验
}

//410更新卡牌信息
message ResUpdateInfo
{
	repeated CardLevelInfo levelInfo = 1;//等级信息
}

//411设置卡牌形象
message ReqSetFashion
{
	int32	cardId    = 1;
	int32	fashionId = 2;
}
//412设置卡牌形象
message ResSetFashion
{
	int32	cardId    = 1;
	int32	fashionId = 2;
}

//413设置手账封面
message ReqSetHandbookCover
{
	int32	cardId    = 1;
}
//414设置手账封面
message ResSetHandbookCover
{
	int32	cardId    = 1;
}

//415设置主页封面
message ReqSetMainCover
{
	int32	fashionId    = 1;
}
//416设置主页封面
message ResSetMainCover
{
	int32	fashionId    = 1;
}

//417激活羁绊
message ReqActivateFetter
{
	int32	id = 1;//羁绊ID
}
//418激活羁绊
message ResActivateFetter
{
	int32	id = 1;//羁绊ID
}

//419请求卡牌生日列表（登录请求）
message ReqBirthdayList
{
	
}
//420返回卡牌生日列表
message ResBirthdayList
{
	repeated int32 cardId = 1;//生日卡牌ID列表
}

//421请求领取卡牌生日奖励
message ReqBirthdayReward
{
	int32          cardId = 1;//请求领取生日奖励的卡牌ID
}
//422返回领取卡牌生日奖励
message ResBirthdayReward
{
	int32          cardId = 1;//成功领取生日奖励的卡牌ID
}


//431请求开启印文
message ReqSealOpen
{
	int32          cardId = 1;//卡牌ID
}
//432返回开启印文
message ResSealOpen
{
	int32          cardId = 1;//卡牌ID
	int32          sealLv = 2;//印文等级
}

//433请求印文数据
message ReqSealData
{
	int32          cardId = 1;//卡牌ID
}
//434返回印文数据
message ResSealData
{
			 int32          	cardId = 1;//卡牌ID
			 int32              sealLv = 2;//印文等级
	repeated CommonObject 	 sealSkill = 3;//印文技能列表（TYPE+LV）
}

//435请求印文升级
message ReqSealUp
{
	int32          cardId = 1;//卡牌ID
}
//436返回印文升级
message ResSealUp
{
	int32          cardId = 1;//卡牌ID
	int32          sealLv = 2;//印文等级
}

//437请求印文技能激活
message ReqSealSkillAc
{
	int32          cardId = 1;//卡牌ID
	int32       skillType = 2;//技能类型
}
//438返回印文技能激活
message ResSealSkillAc
{
	int32          cardId = 1;//卡牌ID
	int32       skillType = 2;//技能类型
	int32         skillLv = 3;//技能等级
}

//439请求印文技能升级
message ReqSealSkillUp
{
	int32          cardId = 1;//卡牌ID
	int32       skillType = 2;//技能类型
}
//440返回印文技能升级
message ResSealSkillUp
{
	int32          cardId = 1;//卡牌ID
	int32       skillType = 2;//技能类型
	int32         skillLv = 3;//技能等级
}






//501剧情副本初始化
message ReqStoryInit
{
	int32 type       =   1;//副本类型
}
//502剧情副本初始化
message ResStoryInit
{
	int32   type          = 1;//副本类型
	repeated ChapterInfo chapterInfo = 2;//章节信息
	repeated CommonObject cardInfo   = 3;//卡牌信息(id为卡的ID,value为位置)
}
//单个章节信息
message ChapterInfo
{
			 int32	   id		 = 1;//章节ID
	repeated StageInfo stageInfo = 2;//关卡信息
	int32    playerActivityFc    = 3;//活动副本玩家战斗力
	int32  activityFirstOpen     = 4;//活动副本章节是否为第一次打开
	
}
//单个关卡信息
message StageInfo
{
	int32	id			   = 1;//关卡ID
	bool	isGeted        = 2;//是否已经获取过奖励
	int32 extraRewardState = 3;//关卡额外奖励状态  1为没有额外奖励  2为有额外奖励尚未领取 3为有额外奖励并且已领取
	int32	surplusNum     = 4;//剩余次数(为0表示不能再挑战或者领奖)
	int32 buyNum           = 5;//购买次数
}

//503领取关卡奖励请求
message ReqStoryReward
{
	int32	stageId   = 1;//关卡ID
	int32 questionNum = 2;//答题关卡答题正确数
}
//504领取关卡奖励回复
message ResStoryReward
{
	int32  stageId           = 1;//关卡ID
	bool success             = 2;//奖励是否领取成功
	repeated StageInfo nextStageInfo  = 3;//下一关卡信息 
}

//505剧情(英雄)扫荡
message ReqStorySweep
{
	int32	      stageId   = 1;//关卡ID
	int32         num       = 2;//扫荡次数
	CommonObject  target    = 3;//需要的任务物品id和数量 外部链接进来做任务需要的数据
}
//506剧情(英雄)扫荡
message ResStorySweep
{
    int32  stageId          = 1;//关卡id
    int32     num           = 2;//最终的扫荡次数
	StageInfo stageInfo          = 3;//扫荡之后更新数据
	repeated GoodsList goodsLists    = 4;//掉落
}

//扫荡掉落集合
message GoodsList{
	int32    num            = 1;//顺序
	repeated GoodsObject goodsObjs   = 2;//掉落
	int32    exp            = 3;//扫荡经验
}

//战斗相关

//507布阵
message ReqEmbattle
{
	int32	type 		                    = 1;//布阵类型      关联到SGCommon的E_EMBATTLE_TYPE枚举
	repeated	CommonObject	cardInfo	= 2;//卡(id为卡的ID,value为位置)
}
//508布阵
message ResEmbattle
{
	int32	type 		                    = 1;//布阵类型      关联到SGCommon的E_EMBATTLE_TYPE枚举
	repeated CommonObject cardInfo          = 2;//卡牌信息(id为卡的ID,value为位置)
	
}

//神殿遗迹初始化 582
message ReqTempleInit{
	
}
 
//583
message ResTempleInit{
	repeated StageInfo stageInfo = 1;//关卡信息
	repeated CardStateExpedition battleCardState = 2;//上阵的卡牌状态
	repeated CardStateExpedition yetCardState    = 3;//使用过的卡牌状态
	repeated StageRivalCardState rivalCardStates = 4;//对手信息
	int32 changeFc                               = 5;//战力改变值
	int32 templeWeakenNum                        = 6;//神殿遗迹精英/boss关卡削弱次数
	int64 templeBeginTime                        = 7;//本次神殿遗迹开启时间
	int64 templeEndTime                          = 8;//本次神殿遗迹结束时间
	repeated TempleCardCommonObject cards        = 9;//角色组信息
}

//请求设置随机怪物 595
message ReqRandomMonsterGroupList{
	int32 stageId          = 1;//关卡id
}

//596
message ResRandomMonsterGroupList{
	int32 randomMosterGroup   = 1;//
}


//神殿遗迹各种副本类型对应的角色组
message TempleCardCommonObject{
	int32   type                                 = 1;//类型
	repeated CommonObject cardInfo	             = 9;//卡组(id为卡的ID,value为位置) 
}

message StageRivalCardState
{
	int32   stageId                   = 1;//关卡id
	repeated RivalCardState rivalCard = 2;//对手信息
}

//509请求进入剧情(英雄)关卡
message ReqInStage{
	int32 id   							    = 1;//关卡ID
	repeated	CommonObject	cardInfo	= 2;//布阵卡组(id为卡的ID,value为位置) 
}

//510响应进入剧情(英雄)关卡
message ResInStage{
	bool into                        = 1;//是否可以进入
	int32 id                         = 2;//进入关卡id
	repeated CommonObject cardInfo   = 3;//卡牌信息(id为卡的ID,value为位置) 布阵
}

//511剧情(英雄)关卡结算
message ReqSettleStage{
	BattleCompleteData battleCompleteData    = 1;//战斗数据
}

//512剧情(英雄)关卡结算
message ResSettleStage{
	StageInfo stageInfo              = 1;//关卡信息
	repeated StageInfo nextStageInfo = 2;//下一关卡信息
	bool isFirst                     = 3;//是否首通
	repeated GoodsObject goodsObjs   = 4;//掉落
	bool     success                 = 5;//挑战是否成功
	int32 exp                        = 6;//经验
	repeated CommonObject cardInfo	 = 7;//卡组(id为卡的ID,value为位置) 
	repeated GoodsObject firstGoods  = 8;//首通奖励
	 
	repeated CardStateExpedition battleCardState = 9;//上阵的卡牌状态 只有神殿遗迹的精英,boss关卡 才有值
	//repeated RivalCardState rivalCard            = 10;//当前关卡对手信息 只有神殿遗迹的boss关卡和精英关卡 才有值  
	repeated StageRivalCardState rivalCardStates = 11;//对手信息
	
}

//513根据类型初始化挑战副本
message ReqTrialInit{
	//int32 type          = 1;//类型
}
//514挑战副本初始化
message ResTrialInit{
	repeated  TrialData data         = 1;//挑战副本列表			 
}

message TrialData{
	Trial     trial     = 1;//挑战副本
	repeated CommonObject cardInfo   = 2;//卡牌信息(id为卡的ID,value为位置)
}

//挑战副本的数据结构
message Trial{
	repeated TrialStage trialStage    = 1;//挑战副本
	int32 type                        = 2;//类型
	int32 num                         = 3;//挑战副本剩余次数

}

//挑战副本关卡信息
message TrialStage{
	int32 id                 = 1;//关卡id	
	bool  isPass             = 2;//是否通关
	int32 schedule           = 3;//关卡进度    该关卡造成的最高伤害/关卡怪物总血量
}
//515进入挑战关卡
message ReqInTrial{
					  int32 	id  = 1;//关卡id
					  bool isSweep  = 2;//是否是扫荡(为true时不进战斗界面 但还是一次一次的扫荡 直接返回挑战关卡结算界面 并且不用发送卡组消息)
	repeated CommonObject cardInfo	= 3;//布阵卡组(id为卡的ID,value为位置) 
}

//516进入挑战关卡
message ResInTrial{
						   bool into = 1;//是否可以进入
						   int32 id  = 2;//进入关卡id
	repeated CommonObject cardInfo   = 3;//卡牌信息(id为卡的ID,value为位置) 布阵
}

//580挑战副本扫荡
message ReqSweepTrial{
	repeated int32 trialId = 1;//副本id
	int32 num              = 2;//次数   
}

//581
message ResSweepTrial{

}


//517挑战关卡结算
message ReqSettleTrial{
	BattleCompleteData battleCompleteData       = 1;//战斗数据
}

//518挑战关卡结算
message ResSettleTrial{
	repeated SettleTrial settleTrial    = 1;
	bool sweep                          = 2;//是否为扫荡
}

//挑战关卡结算消息
message SettleTrial{
    repeated GoodsObject trialDrop    = 1;//挑战副本结算奖励
	//repeated GoodsObject extraDrop   = 2;//额外掉落
			repeated   bool isDraw   = 3;//是否触发抽奖
	repeated bool     success        = 4;//挑战是否成功(是否通关)
	repeated CommonObject cardInfo	 = 5;//卡组(id为卡的ID,value为位置) 
				 Trial     trial     = 6;//刷新关卡信息
	repeated GoodsObject drawDrop    = 7;//抽奖掉落 没有触发抽奖则为空
	//				 int32 drawId    = 8;//抽奖对应的id 没有触发抽奖 则为0
			 DamageData damageData   = 9;//伤害信息
}

//请求竞技场数据 519
message ReqArenaData{

}

//响应竞技场数据 520
message ResArenaData{
	ArenaData arenaData        = 1;
	ArenaRewardTemp temp       = 2;
}

message ArenaData{
						  int32 rank      = 1;//排名
						  int32 surNum    = 2;//剩余挑战次数
	repeated CommonObject guardCardGroups = 3;//防守阵容
	repeated CommonObject arenaCardGroups = 4;//竞技场阵容
	repeated ArenaRival arenRival         = 5;//对手信息
						  int32 score     = 6;//分数
	repeated int32 monthRewards           = 7;//已经领取的奖励  (配合分数 可以展示 未领取的奖励)		
			 int64 lastArenaFightTime     = 8;//上一次竞技场战斗时间
			 int32 season				  = 9;//当前赛季
	repeated int32 dayRewards             = 10;//每日奖励已领取的列表
					bool lastSuccess      = 11;//上一次竞技场是否成功 
				// int64 daySettleBeginTime = 12;//每日结算开始时间
				  //int64 daySettleEndTime  = 13;//每日结算结束时间
				 // int32 seasonSettleDay   = 14;//赛季结算号数(每月几号)
			    ConfigTime  daySettleTime = 13;//每日结算时间
			 ConfigTime  seasonSettleTime = 14;//赛季结算时间
				  int32 buyNum            = 15;//竞技场购买次数
				  int32 seasonMaxRank     = 16;//当前赛季的最高排名,用于客户端判断是否能领取生涯奖励
			          ConfigTime openTime = 17;//竞技场正在开启的时间 或者下一次开启的时间
			  ConfigTime scoreRefreshTime = 18;//积分重置时间
			  ConfigTime settleTime       = 19;//服务器下发的结算时间 包含了赛季结算时间和每日结算时间 客户端显示用

}

//竞技场奖励缓存 只有开启新赛季的时候才有这个数据
message ArenaRewardTemp{
	int32 maxRank                              = 1;//赛季最高排名
	int32 rank                                 = 2;//当前排名
	repeated GoodsObject tempMonthReward       = 3;//生涯奖励累计
	repeated GoodsObject tempMonthCareerReward = 4;//生涯积分奖励累计
	repeated GoodsObject tempDayCareerReward   = 5;//每日积分奖励累计
	bool isOpenPanel                           = 6;//是否打开面板
}

//竞技场对手数据 (玩家的镜像数据 或者 机器人)
message ArenaRival{
	string name        			     = 1;//名称
	int32 fc        			     = 2;//战斗力
	int32 fashionHead                = 3;//头像
	int32 fashionShow                = 4;//时装  机器人么有该字段 机器人的时装通过fashionHead获得
	int32 rank          		     = 5;//排名
	repeated ArenaCard cardGroups    = 6;//卡牌序列
	string playerIndex               = 7;//唯一id
	bool isPlayer                    = 8;//是否为玩家  如果是玩家的话 cardGroups为卡组的详细信息 如果不是玩家 则cardGroups里面的cardGroups只有怪物id
	int32 group                      = 9;//分组,每次请求会返回多组竞技场对手 客户端临时缓存  
	int32 serverId                   = 10;//玩家所在的服务器 如果是机器人 则为0
}


//请求竞技场战斗 521
message ReqArenaFight {
	int32 rank                              = 1;
	bool  isSweep                           = 2;//是否是扫荡
	repeated	CommonObject	cardInfo	= 3;//卡(id为卡的ID,value为位置)

}
 
//竞技场战斗结果 522
message ResArenaFight{
				bool isSuccess      = 1;//战斗是否成功
				ArenaChangeData arenaData = 2;//竞技场数据
				int32 addScore		= 3;//增加的积分
		repeated GoodsObject reward = 4;//战斗奖励
			bool  isSweep           = 5;//是否是扫荡
}
//
message ArenaChangeData
{
		  int32 rank      = 1;//排名
						  int32 surNum    = 2;//剩余挑战次数
	repeated ArenaRival arenRival         = 3;//对手信息
						  int32 score     = 4;//分数
			 int64 lastArenaFightTime     = 5;//上一次竞技场战斗时间
}


//请求竞技场刷新 523  (全部刷新)
message ReqArenaRefresh{
	 
}

//竞技场刷新 524
message ResArenaRefresh{
	repeated  ArenaRival arenRival   = 1;//竞技场对手数据   
						int32 myRank = 2;//我的排名
}

//请求领取奖励 525
message ReqArenaReward{
	int32 rewardId     = 1;//领取奖励id
	int32 operType     = 2;//领取奖励的操作类型 1为领取指定id奖励  2为一键领取
	int32 type         = 3;//领取奖励类型 1为 每日积分奖励 3为生涯奖励(赛季奖励) 2为每日结算奖励(不发请求) 
}

//领取的奖励 526
message ResArenaReward{
	repeated int32 rewardId   = 1;//当次领取的奖励集合
			 int32 type       = 2;//领取奖励的类型
}

//章节关卡触发下一章时发送该消息 534
message ResNextChapterInfo{
	ChapterInfo  chapterInfo = 1;//下一章节信息
}

//领取章节关卡额外奖励 535
message ReqExtraReward{
	int32  stageId   = 1;//关卡
}
//536
message ResExtraReward{
    int32  stageId   = 1;//关卡
	bool success     = 2;//领取是否成功
}


//请求战斗记录 537
message ReqBattleRcord{
	E_BATTLE_TYPE   battleType          = 1;//战斗类型
}

//返回战斗记录 538
message ResBattleRcord{
	repeated BattleDataRcord  records   = 1;//记录数据
	E_BATTLE_TYPE battleType            = 2;//战斗类型
}


//战斗记录
message BattleDataRcord{
	int32 statue					      = 1;//挑战状态,1表示挑战成功,2表示挑战失败，3表示防守成功，4表示防守失败
	int64 timestamp					      = 2;//挑战的时间戳
	string name						      = 3;//名称
	int32 fc					      	  = 4;//战斗力
	int32 fashionHead			          = 5;//头像
	repeated BattleTeam  cardGroups       = 6;//卡牌序列
	string playerIndex                    = 7;//玩家唯一id
	bool isPlayer                         = 8;//是否为玩家  如果是玩家的话 cardGroups为卡组的详细信息 如果不是玩家 则cardGroups里面的cardGroups只有怪物id
	int32 level                           = 9;//对手等级
	string battleindex                    = 10;//战斗唯一id
	int32 fashionFrame                    = 11;//头像框
}

//请求竞技场排名 539
message ReqArenaRank{
	 
}

//返回竞技场排名 540
message ResArenaRank{
	repeated ArenaRankData records	= 1;//记录数据
	int32 bestRank					= 2;//历史最高排名				
}

message ArenaCard
{
	int32	position  = 1;//位置
	int32	id        = 2;//ID
	int32	level     = 3;
	int32	star 	  = 4;
	int32	quality   = 5;
	int32	fashionId = 6;
	int32   speed     = 7;//速度
}

//更新排名
message ResUpdateRank{
	int32 rank                 = 1;//排名
}

message ArenaRankData{
	int32 rank						= 1;//排名
	string name						= 2;//名字
	int32 fc						= 3;//战斗力
	int32 fashionHead				= 4;//头像
	repeated ArenaCard cardGroups     = 5;//卡牌信息
	string playerIndex              = 6;//玩家唯一id
	bool isPlayer                   = 7;//是否为玩家  如果是玩家的话 cardGroups为卡组的详细信息 如果不是玩家 则cardGroups里面的cardGroups只有怪物id
	int32 level                     = 8;//等级
	int32 title                     = 9;//称号
	int32 fashionFrame              = 10;//头像框
}


//543英雄快速扫荡
message ReqFastSweep
{
	repeated int32 stageId    = 1;//关卡
}

//544英雄快速扫荡
message ResFastSweep 
{
	repeated StageInfo stageInfo     = 1;//扫荡之后更新数据
	repeated GoodsList goodsLists    = 2;//掉落
}

//545天之塔初始化
message ReqTowerInit{
	int32 type   =  1;//请求类型 1为天之塔 2为天之塔拓展
}

//546
message ResTowerInit{
	repeated    Tower   tower       = 1;//天之塔
	repeated CommonObject cardInfo  = 2;//卡牌信息(id为卡的ID,value为位置)
	bool  encounter                 = 3;//是否存在天之塔遭遇战数据
	//天之塔拓展相关
	repeated int32 yetUseCardIdList = 4;//已经使用过的角色id
	repeated StageRivalCardState rivalCardStates = 5;//对手信息
	int32 changeFc                               = 6;//战力改变值
	int32 firstOpen                 = 7;//是否是第一次解锁天之塔拓展  1为未解锁 2为第一次(客户端有特效) 3为第二次以及之后的 只有当请求的type为1的时候 才有值
	int32 type                      = 8;//请求类型 1为天之塔 2为天之塔拓展
}

//天之塔
message Tower{
	int32    towerId                = 1;//塔层id
	repeated TowerStage towerSatge  = 2;//关卡列表
}

message TowerStage{
	int32    towerStageId           = 1;//关卡id
	int32    monsterGroupId         = 2;//怪物组id
	bool     isPass                 = 3;//是否通关
	int32 challengeRound            = 4;//天之塔拓展关卡使用次数
}

//547进入天之塔
message ReqInTower{
    int32    towerStageId           = 1;//关卡id
	repeated CommonObject cardInfo  = 2;//卡牌信息(id为卡的ID,value为位置) 布阵
	bool     isSweep                = 3;//是否为扫荡 (为true时,不发送卡组消息 不进入战斗 不返回送战斗数据)
}

//548 
message ResInTower{
	bool into                       = 1;//是否可以进入
	TowerStage    towerStage        = 2;//当前关卡信息
	repeated CommonObject cardInfo  = 3;//卡牌信息(id为卡的ID,value为位置) 布阵
	bool     isSweep                = 4;//是否为扫荡 (为true时,不发送卡组消息 不进入战斗 不返回送战斗数据)
}


//549天之塔结算
message ReqSettleTower{
	BattleCompleteData battleCompleteData   = 1;//战斗数据
}

//550 结算
message ResSettleTower{
    TowerStage towerStage             = 1;//当前关卡信息  
	TowerStage nextTowerStage         = 2;//下一关卡信息
	bool isFirst                      = 3;//是否首通
	repeated GoodsObject basicGoods   = 4;//基础掉落
	bool isSuccess                    = 5;//战斗是否成功 如果为false 则没有其他信息
	repeated GoodsObject firstGoods   = 6;//首通奖励 不一定有
	repeated GoodsObject extGoods     = 7;//额外掉落
	bool triggerEncounter             = 8;//是否触发遭遇战 如果触发了遭遇战 请直接发送ReqEncounterBattleEmba请求
	
	//天之塔拓展相关
	repeated int32 yetUseCardIdList   = 9;//已经使用过的角色id
	repeated StageRivalCardState rivalCardStates = 10;//对手信息
	int32 firstOpen                   = 11;//是否是第一次解锁天之塔拓展  1为未解锁 2为第一次(客户端有特效) 3为第二次以及之后的 只有当TowerConfig的type为1的时候 才有值
}

//551 请求远征数据
message ReqExpedition{


}

//552
message ResExpedition{
	Expedition expedition             = 1;//
	repeated ExpeditionData expeditionData =2;//仅当未选择关卡时，会有该数据
}

//远征数据
message Expedition{
	int32 expeditionId                           = 1;//远征地图id 未设置时为0
	repeated CardStateExpedition battleCardState = 2;//远征上阵的卡牌状态
	int32 cardMaxNum                             = 3;//远征上阵卡牌最大数量
	int32 stageId                                = 4;//远征关卡id
	repeated int32 buffIds                       = 5;//远征buff
	repeated CardStateExpedition yetCardState    = 6;//使用过的卡牌状态
	int32 sweepNum                               = 7;//剩余的扫荡次数  当该值不为0时,关卡只能扫荡
	repeated RivalCardState rivalCard            = 8;//对手信息
	int32 changeFc                               = 9;//战力改变值
	int32 selfMaxFc                              = 10;//玩家战斗力历史最大值
	repeated ExBuyData exBuy                     = 11;//远征购买关卡数据
	int32 sweepDander                            = 12;//扫荡关卡之后 后续关卡需要增加的怒气
}
message ExpeditionData{
	int32 expeditionId							 =1; //只会发已经解锁的ID
	int32 sweepNum								 =2; //该关卡可以扫荡的次数
}
//553 设置(选择)远征地图 ----> 返回552
message ReqSetExpedition{
	int32 expeditionId                = 1;//远征地图id 
}
//卡牌状态
message CardStateExpedition{
	int32   cardId                    = 1;//卡牌id
	int32   cardState                 = 2;//卡牌状态 1为正常 2为疲劳 3为死亡
	int32     supHp                   = 3;//卡牌剩余血量
	int32     supDander               = 4;//卡牌剩余怒气
	int32     pos                     = 5;//如果是上阵卡牌  需要告诉客户端 该卡牌的位置
	int32   type                      = 6;//类型
	
}

//555进入远征关卡  
message ReqInExpedition{
	int32 stageId                     = 1;//关卡id
	repeated CommonObject cardInfo    = 2;//卡组
}

//556
message ResInExpedition{
	bool into                              = 1;//是否可以进入
	repeated CardStateExpedition cardInfo  = 2;//卡牌信息(id为卡的ID,value为位置) 布阵
	int32   stageId                        = 4;//关卡id
	int32 sweepNum					       = 5;//该关卡可以扫荡的次数
}

//设置老套装太之塔副本 527
message ReqOldSetsTower{
	int32          towerId = 1;//塔层id
}	

//528
message ResOldSetsTower{
		Tower tower        = 1;
}

//562远征商人关卡消息
message ResShopExpedition{
	int32   stageId                        = 1;//关卡id
    repeated ExBuyData exBuy               = 3;//远征购买关卡数据
}

//564远征buff关卡
message ResBuffExpedition{
	int32   stageId                        = 1;//关卡id
	repeated CommonObject buffs            = 3;//buff关卡的buff集合  id为buff  value为位置
}

//557 关卡结算
message ReqSettleExpedition{
	BattleCompleteData battleCompleteData   = 1;//战斗数据
	int32 stageId                           = 2;//关卡id
	
}

//558
message ResSettleExpedition{
	bool success                            = 1;//战斗是否成功 不成功时 奖励为空
	repeated GoodsObject   reward           = 2;//关卡奖励
	Expedition expedition                   = 3;//关卡信息
	bool     isSweep                        = 4;//是否为扫荡 (为true时,不发送卡组消息 不进入战斗 不返回送战斗数据)
}

//565领取远征buff
message ReqDrawBuff{
	int32 stageId                           = 1;//关卡id
	ExpeBuff expeBuff                       = 2;//buff关卡时,需要的buffId
	
}

//566
message ResDrawBuff{
	int32 stageId                           = 1;//关卡id
	ExpeBuff expeBuff                       = 2;//buff关卡时,需要的buffId
	Expedition expedition                   = 3;//关卡信息
}

//远征buff
message ExpeBuff{
    int32   buffId                          = 1;//buffId
	int32 cardId                            = 2;//指定的卡牌id 如果卡牌id<=0 则默认为全局buff
}

//559远征商店关卡 购买
message ReqShopExpeditionBuy{
	int32 stageId                         = 1;//关卡id
	int32 shopId                          = 2;//购买id  
}

//560
message ResShopExpeditionBuy{
	repeated GoodsObject goodsObjs        = 1;//购买的物品列表
	ExBuyData exBuy                       = 2;//远征购买关卡数据(只更新购买的那条数据)
}

//远征购买关卡数据
message ExBuyData{
	
	int32 buyNum                      = 1;//已使用的购买次数
	int32 totalNum                    = 2;//可使用的购买总次数
	int32 shopType                    = 3;//对应的类型
	int32 stageId                     = 4;//该购买关卡的id
	
}

//567
message ReqFinishStory
{
	int32 type = 1;//1为完成剧情 2为跳过剧情
	repeated int32 ids   = 2;//StoryChapter的ID
}

//569剧情是否已完成
message ReqCheckStoryFinish
{
	repeated int32 chapterIds   = 2;//StoryChapter的ID
}
//570剧情是否已完成
message ResCheckStoryFinish
{
	repeated StoryData chapters  = 1;
}

//剧情播放情况数据
message StoryData{
	
	int32 chapterId   = 1;//StoryChapter的ID
	bool  result      = 2;//true表示已完成
	
}



// 571 初始化天之塔遭遇战布阵信息
message ReqEncounterBattleEmba{
	
}

// 572初始化天之塔遭遇战布阵信息
message ResEncounterBattleEmba{
	repeated CommonObject myCards      = 1;//玩家卡组
	repeated RivalCardState rivalCards = 2;//敌方卡组
	string rivalName                   = 3;//敌方名字
	int32     rivalFc                  = 4;//敌方战斗力
	int32    rivalFashionShow          = 5;//立绘
}


//573 进入天之塔遭遇战
message ReqInTowerEncounter{
	repeated CommonObject cardInfo  = 1;//卡牌信息(id为卡的ID,value为位置) 布阵
}

//574 进入天之塔遭遇战
message ResInTowerEncounter{
	
}

// 575 结算天之塔遭遇战
message ReqSettleEncounter{
	BattleCompleteData battleCompleteData   = 1;//战斗数据
}

// 576 结算天之塔遭遇战
message ResSettleEncounter{
	bool success                     = 1;//挑战是否成功
	repeated GoodsObject goodsLists  = 2;//掉落
	
}

//577 取消天之塔遭遇战
message ReqCancelEncounter{
	
}

//578取消天之塔遭遇战
message ResCancelEncounter{
	
}

//591 获取阵容方案
message ReqDeckScheme{

}

//592
message ResDeckScheme{
	repeated DeckScheme deckSchemes    = 1;
}

//阵容方案
message DeckScheme{
	int64 id         = 1;//唯一id
	string name      = 2;//名称
	int64 time       = 3;//创建时间 用于排序
	repeated CommonObject deckSchemes = 4;//阵容方案 位置1-6 长度最多为6
}

//593 新增或者修改阵容方案
message ReqAddOrUpdateDeckScheme{
	int32 type            = 1;//1,新增 2,修改 3,删除
	int64 id              = 2;//唯一id
	string name           = 3;//长度最多为7
	repeated CommonObject deckSchemes = 4;//阵容方案 位置1-6 长度最多为6
}

//594
message ResAddOrUpdateDeckScheme{
	int32 type            = 1;//1,新增 2,修改 3,删除
	DeckScheme deckScheme = 2;//阵容方案
}

//关卡次数购买 597
message ReqStageBuyNum{
	int32 stageId        = 1;
}

message ResStageBuyNum{
	int32 stageId        = 1;//
	int32 num            = 2;//购买之后的副本次数
	int32 buyNum         = 3;//该关卡已经购买的次数
}





message BulletScreen
{
	int32 size			= 1;//弹幕字体大小
	int32 speed			= 2;//弹幕移动速度
	int32 color			= 3;//弹幕颜色
}

//发送聊天消息
message ReqSetChat{
	CHAT_TYPE chatType           	= 1;
	CHAT_SUB_TYPE chatSubType    	= 2;
	int32 image                  	= 3; //聊天图片
	string content               	= 4;
	BulletScreen bulletScreenData	= 5;//弹幕数据
	string target                   = 6;//聊天目标  私聊为对方id 频道聊天为频道id 弹幕聊天为指定的功能id 公会聊天为公会id 卡牌评论指定卡牌id
}

message ResSetChat{
	CHAT_TYPE chatType             = 1;
	CHAT_SUB_TYPE chatSubType      = 2;//子类型
	ChatData chatData              = 3;//聊天内容
	
}

//设置接收聊天消息
message ReqSetAccpetChat{
	CHAT_TYPE chatType           = 1;
	CHAT_SUB_TYPE chatSubType    = 2;
	bool isAccpet                = 3;//是否可以接收消息
}

message ResSetAccpetChat{
	CHAT_TYPE chatType        = 1;
	CHAT_SUB_TYPE chatSubType = 2;
	bool isAccpet             = 3;//是否可以接收消息
}

//获取聊天记录
message ReqGetChat{
    CHAT_TYPE chatType           = 1;
	CHAT_SUB_TYPE chatSubType    = 2;
}

message ResGetChat{
    CHAT_TYPE chatType         = 1;
	CHAT_SUB_TYPE chatSubType  = 2;
	repeated ChatData chatData = 3;//聊天内容
}

//获取卡牌评论
message ReqGetCardChat{
	int32   cardId             = 1;
	int32 paging               = 2;//分页 从1开始
}

message ResGetCardChat{
	int32   cardId                  = 1;
	int32 paging                    = 2;//分页 从1开始
	repeated ChatData highChatData = 3;//点赞最高的评论
	repeated ChatData chatData      = 4;//分页评论
}

//卡牌点赞
message ReqClickLike{
	int32  cardId           = 1;//卡牌id
	int64 chatId            = 2;//评论id
}

message ResClickLike{
    int32  cardId           = 1;//卡牌id
	int64 chatId            = 2;//评论id
	ChatData chatData       = 3;
}

//聊天数据
message ChatData{
	string pName              		= 1;//发送者名称
	int32 fashionHead         		= 2;//头像
	int32 guildPost           		= 3;//玩家公会职位(只针对公会聊天)
	string content            		= 4;//聊天内容
	int32 image               		= 5;//聊天图片
	int64 time                		= 6;//聊天时间
	string pId                      = 7;//发送者id
	string tId                      = 8;//接受者id
	BulletScreen bulletScreenData	= 9;//弹幕数据
	int64  chatId                   = 10;//唯一id
	int32 clickLikeNum              = 11;//点赞次数
	int32 fashionFrame              = 12;//头像框
}

//请求收藏卡牌列表
message ReqGetLikeCard{
	
}

message ResGetLikeCard{
	repeated int32 cardIds      = 1;
}

//收藏卡牌
message ReqSetLikeCard{
	int32 type              = 1;//取值为1设置喜欢卡牌 2为取消喜欢卡牌
	int32 cardId            = 2;
}

message ResSetLikeCard{
    int32 type              = 1;//取值为1设置喜欢卡牌 2为取消喜欢卡牌
	int32 cardId            = 2;//
}

//获取点赞过的评论id
message ReqMyClickLikeRemark{
	int32 cardId            = 1;
}

message ResMyClickLikeRemark{
	repeated int64 remarkId = 1;         
}




//注册结果
enum E_REGISTER_RESULT
{
	REGISTER_RESULT_UNKNOWN = 0;
	REPEATED     = 1;//重复注册
	REGISTER_ING = 2;//正在注册请稍后
}

//通用返回消息
enum E_LOGIN_RESULT
{
	LOGIN_RESULT_UNKNOWN      = 0;   //默认为0
	SUCCESS		 = 1;	//成功
	FAIL		 = 2;	//失败
	AUTH         = 3;   //登录过期，重新认证
	REGISTER     = 4;   //去注册
	WAIT         = 5;   //等待排队
	LOCK         = 6;   //被封号了
}

//登录方式
enum E_LOGIN_TYPE
{	
	LOGIN_TYPE_UNKNOWN                  = 0;//
	DEFAULT                  = 1;//普通登录
	RELINK                   = 2;//断线重连
}

//战斗类型
enum E_BATTLE_TYPE
{
	BATTLE_TYPE_UNKNOWN      = 0;
	ARENA                    = 1;//竞技场
	STORY                    = 2;//剧情副本
	HERO                     = 3;//英雄副本
	GOLD                     = 4;//每日金币试炼
	EXP                      = 5;//每日经验试炼
	EQUIPEXP                 = 6;//每日装备经验试炼
	TOWER                    = 7;//天之塔
	EXPEDITION               = 8;//远征
	CG 						 = 9;//幕间物语
	ADVENTURE                = 10;//大冒险
	GUILD_PK                 = 11;//公会切磋
	ACTIVITY                 = 12;//活动副本
	TOWER_ENCOUNTER          = 13;//天之塔遭遇战
	GUILD_WAR                = 14;//公会战
	FRIEND_PK                = 15;//好友切磋
	TEMPLE                   = 16;//神殿遗迹副本
	ASSIST                   = 17;//协助战斗
	TOWER_EXPAND 			 = 18;//天之塔拓展
}

//渠道
enum E_CHANNEL
{
	CHANNEL_UNKNOW           = 0;//
	QUICK                    = 1;//快速登录
	PHONE                    = 2;//手机号
	YOOZOO 					 = 3;//游族
	YINJI                    = 4;//引继
}

//平台类型，新定义的
enum E_PLATFORM
{
    PLATFORM_UNKNOW          = 0;
	IOS                      = 1;
	ANDROID                  = 2;
	PC                  	 = 3;
}

//性别
enum E_GENDER
{
	GENDER_UNKNOWN           = 0;
	MALE                     = 1;//男
	FEMALE                   = 2;//女
} 

//信息提示
enum E_ALERT_TYPE
{
	ALERT_TYPE_UNKNOWN       = 0;
	NOTICE                   = 1;//公告
	WARN                     = 2;//警告/错误信息
	HIDE                     = 3;//不弹任何提示，只作为消息返回
}

//物品类型
enum E_GOODS_TYPE
{
	GOODS_TYPE_UNKNOWN 				= 0;
	PROP 				= 1;//道具
	ASSET 				= 2;//资源
	CARD 				= 3;//卡片
	EQUIP               = 4;//装备
	TITLE               = 5;//称号
	OTHER				= 6;//其它,对应E_GOODS_OTHER_ID里面的值
	SEED                = 7;//农场种子
	FURNITURE           = 8;//家具
	HEAD_ICON           = 9;//头像
	HEAD_FRAME          = 10;//头像框
	FASHION             = 11;//卡牌皮肤
}

//其它物品类型的ID
enum E_GOODS_OTHER_ID
{
	GOODS_OTHER_ID_UNKNOWN 			= 0;
	FC               = 1;//战力
	LEVEL            = 2;//玩家等级
}

//副本章节开启条件类型
enum E_CHAPTER_OPEN_CONDITION
{
	COC_UNKNOWN = 0;
	PLAYER_LEVEL	= 1;//等级
	PASS_STAGE		= 2;//关卡
}

//排行榜类型
enum E_RANK_TYPE
{
	RANK_TYPE_UNKNOWN        = 0;//
}

//布阵类型
enum E_EMBATTLE_TYPE
{
	EMBATTLE_UNKNOWN         = 0;
	EMBATTLE_DEFAULT         = 1;//默认
	EMBATTLE_STORE           = 2;//剧情副本布阵
	EMBATTLE_ELITE           = 3;//精英副本布阵
	EMBATTLE_GOLD            = 4;//金币试炼布阵
	EMBATTLE_EXP             = 5;//经验试炼布阵
	EMBATTLE_EQUIPEXP        = 6;//装备试炼布阵
	EMBATTLE_ATTA            = 7;//竞技场攻击布阵
	EMBATTLE_ARENA_GUARD     = 8;//竞技场防守布阵
	EMBATTLE_TOWER           = 9;//天之塔布阵
	EMBATTLE_ENCOUNTER       = 10;//天之塔遭遇战布阵
	EMBATTLE_ASSIST_BOSS 	 = 11;//协助战斗BOSS
	EMBATTLE_TOWER_EXPAND    = 12;//天之塔扩展布阵
}

//副本类型
enum E_CHALLENGE_TYPE
{
	UNKNOW_CHALLENGE     	= 0;//
	STORE_CHALLENGE      	= 1;//剧情副本
	ELITE_CHALLENGE      	= 2;//精英副本      
	GOLD_CHALLENGE       	= 3;//金币挑战副本
	EXP_CHALLENGE        	= 4;//经验挑战副本
	EQUIPEXP_CHALLENGE   	= 5;//装备经验挑战副本
	ARENA_CHALLENGE      	= 6;//竞技场
	TOWER_CHALLENGE      	= 7;//天之塔
	EXPEDITION_CHALLENGE 	= 8;//远征
	CG_CHALLENGE 		 	= 9;//幕间物语
	ADVENTURE_CHALLENGE  	= 10;//大冒险战斗
	GUILD_PK_CHALLENGE   	= 11;//公会切磋
	ENCOUNTER_CHALLENGE  	= 13;//天之塔遭遇战
	GUILD_WAR_CHALLENGE  	= 14;//公会战
	FRIEND_PK_CHALLENGE  	= 15;//好友切磋
	TEMPLE_CHALLENGE     	= 20;//神殿遗迹
	ACTIVITY_CHALLENGE   	= 101;//活动副本
    NEW_ACTIVITY_ASSIST     = 103;//新活动副本协助战斗类型
	NEW_ACTIVITY_CHALLENGE	= 201;//新活动副本
	TOWER_EXPAND_CHALLENGE  = 301;//天之塔拓展副本
}

enum E_SET_TYPE
{
	SET_TYPE_UNKNOWN = 0;
	FASHION_HEAD 		= 1;//头像
	FASHION_SHOW        = 2;//形象
	SIGNATURE           = 3;//自我介绍
	NICK_NAME           = 4;//昵称
	NICK_NAME_NO_COST   = 5;//新手引导改名
	SET_TYPE_NOTICE 		= 6;//打开公告
	SET_TYPE_BATTLE_FRAME	= 7;//战斗帧率
	SET_TYPE_UI_FRAME		= 8;//界面帧率
	FASHION_FRAME       = 9;//头像框
}

//抽奖类型
enum E_LOTTERY_TYPE
{
	LOTTERY_TYPE_UNKNOWN = 0;
	LOTTERY_TYPE_CARD   = 1;//角色
	LOTTERY_TYPE_EQUIP  = 2;//装备
	LOTTERY_TYPE_COUPON = 3;//卡券
	LOTTERY_TYPE_NOVICE = 4;//新手
	//LOTTERY_TYPE_ACTIVITY_STAGE = 5;//活动副本
	LOTTERY_TEN_EVEN_CAPSULE = 6;//十连必出扭蛋
	LOTTERY_ACTIVITY_CAPSULE_UP1 = 7;//活动扭蛋UP
	LOTTERY_ACTIVITY_CAPSULE_UP2 = 8;//活动扭蛋up2
	LOTTERY_ACTIVITY_CAPSULE_UP3 = 9;//活动扭蛋up3
	LOTTERY_ACTIVITY_CAPSULE_UP4 = 10;//活动扭蛋up4
	LOTTERY_ACTIVITY_TEN_EVEN_CAPSULE1 = 11;//十连必出扭蛋活动1
	LOTTERY_ACTIVITY_TEN_EVEN_CAPSULE2 = 12;//十连必出扭蛋活动2
	LOTTERY_ACTIVITY_TEN_EVEN_CAPSULE3 = 13;//十连必出扭蛋活动3
	LOTTERY_ACTIVITY_TEN_EVEN_CAPSULE4 = 14;//十连必出扭蛋活动4
	
}

//抽奖模式
enum E_LOTTERY_MODE
{
	LOTTERY_MODE = 0;
	LOTTERY_MODE_ONCE   = 1;//单抽
	LOTTERY_MODE_MORE   = 2;//十连抽
	LOTTERY_MODE_DAY    = 3;//每日一抽
	LOTTERY_MODE_NOVICE = 4;//新手扭蛋
}

//状态类型枚举
enum E_STATUS_TYPE
{
	STATUS_TYPE_NOT = 0;//未（未 完成/满足...）
	STATUS_TYPE_CAN = 1;//可（可 完成/领取...）
	STATUS_TYPE_HAS = 2;//已（已 完成/领取...）
}

//邮件类型枚举
enum E_MAIL_TYPE
{
	MAIL_TYPE_UNKNOWN = 0;
	MAIL_SYSTEM = 1;//系统
	MAIL_BACKEND = 2;//后台
	MAIL_MARKET = 3;//交易行/集市
}

//购买资源枚举值
enum BUY_ASSIST_TYPE
{
	DEFAULT_BUY_TIME              = 0;
	GOLD_BUY_TIME_TYPE            = 1;//金币购买类型
    VIT_BUY_TIME_TYPE             = 2;//体力购买类型
    STA_BUY_TIME_TYPE             = 3;//耐力耐力购买类型
    ENERGY_BUY_TIME_TYPE          = 4;//精力购买类型
}


//玩家公会操作枚举
enum GUILD_ACTION
{
	DEFAULT_ACTION					= 0;
	JOIN_ACTION						= 1;//直接加入
	APPLY_ACTION 					= 2;//提交申请
	CANCEL_ACTION 					= 3;//取消申请
}

//处理申请枚举
enum GUILD_APPLY
{
	DEFAULT_APPLY 					= 0;
	PASS_APPLY 						= 1;//通过
	REFUSE_APPLY 					= 2;//拒绝
}

//公会信息设置枚举
enum GUILD_SET
{
	DEFAULT_SET						= 0;
	ICON_SET 						= 1;//设置icon(int value)
	NAME_SET 						= 2;//设置名称(string value)
	COND_SET 						= 3;//设置入会条件(int value)
	NOTICE_SET 						= 4;//设置公告(seting value)
}

//公会职位枚举（枚举值对应配置表职位ID）
enum GUILD_POST
{
	DEFAULT_POST 					= 0;
	MEMBER_POST 					= 1;//成员
	ELDER_POST 						= 2;//长老
	VICE_LEADER_POST 				= 3;//副会长
	LEADER_POST 					= 4;//会长
}

//公会日志枚举
enum GUILD_LOG
{
	DEFAULT_LOG 					= 0;
	JOIN_LOG 						= 1;//加入公会
	QUIT_LOG 						= 2;//退出公会
	OUT_LOG 						= 3;//被移除公会
	PROMOTION_LOG 					= 4;//成员晋升
	DOWNGRADE_LOG 					= 5;//成员降级
	TRANSFER_LOG 					= 6;//移交会长
	CREATE_LOG                      = 7;//创建公会
	RENAME_LOG                      = 8;//公会改名
}

//公会战状态枚举
enum GUILD_WAR_STATUS
{
	DEFAULT_STATUS           = 0;//即将开启
	READY                    = 1;//备战阶段
	CHALLENGE 			     = 2;//挑战阶段
	SETTLE                   = 3;//结算阶段
}

//公会战提示类型枚举
enum GUILD_WAR_PROMPT
{
	DEFAULT_PROMPT           = 0;//不提示
	NEW_SEASON               = 1;//新赛季
	SETTLE_SEASON            = 2;//赛季结算
}

//公会战支援设置操作类型
enum GUILD_WAR_SUPPORT
{
	DEFAULT_SUPPORT          = 0;//
	JOIN                     = 1;//参与支援
	QUIT                     = 2;//退出支援
}


//聊天类型枚举
enum CHAT_TYPE
{
	DEFAULT_CHAT          = 0;
	GUILD_CHAT            = 1;//公会聊天
	BULLET_CHAT           = 2;//弹幕聊天
	PRIVATE_CHAT          = 3;//私聊
	CHANNEL_CHAT          = 4;//频道聊天
	CARD_CHAT             = 5;//卡牌评论
}

//聊天子类型
enum CHAT_SUB_TYPE
{
	DEFAULT_SUB_CHAT      = 0;
	ADVENTURE_BULLET      = 201;//大冒险弹幕
	WORLD_CHAT            = 401;//世界聊天
	SERVER_CHAT           = 402;//服务器聊天
}


//引导提示类型
enum GUIDE_TYPE
{
	DEFAULT_TYPE 					= 0;
	COPY_STORY_TYPE                 = 1;//剧情冒险开启新章节，参数：新章节ID（首章不提示）
	COPY_HERO_TYPE                  = 2;//英雄冒险开启新章节，参数：新章节ID（首章不提示）
	COPY_DAILY_TYPE                 = 3;//日常冒险新冒险开启，参数：冒险类型
	COPY_DAILY_STAGE_TYPE           = 4;//日常冒险新关卡开启，参数：冒险类型（首关不提示）
	COPY_EXPEDITION_TYPE            = 5;//远征解锁新地图，参数：地图ID（第一张图不提示）
	TASK_TYPE                       = 6;//任务可提交，参数：任务ID
	SHOP_TYPE                       = 7;//商店解锁格子，参数：商店类型
	HANDBOOK_STAGE_TYPE             = 8;//角色解锁幕间物语关卡，参数：卡牌ID
	COPY_TOWER_TYPE                 = 9;//天之塔开启新章节（首章不提示）
	GUILD_WAR_TYPE                  = 10;//公会战增加挑战次数，参数：新增加的挑战次数
	HANDBOOK_CHAPTER                = 11;//手账积分剧情解锁，参数：解锁的配置ID（HandbookAdventureChapterConfig中的ID）
}


//家园农场土地状态
enum LAND_STATUS
{
	DEFAULT_LOCK             = 0;//未解锁
	FREE                     = 1;//空闲
	PLANTED 			     = 2;//已种植
	HARVEST                  = 3;//可收获
}


//推送消息枚举
enum E_PUSH_TYPE
{
	DEFAULT_PUSH_TYPE               = 0;
	VIT_COMEBACK                    = 1;//体力回满
	VIT_GET                         = 2;//体力领取（糖果屋奖励）
	FARM_HARVEST                    = 3;//农场全部可收割
	TIMING_PUSH                     = 4;//固定时间推送
	ACTIVITY_OPEN                   = 5;//指定活动开启
	ACTIVITY_END                    = 6;//指定活动结束
	GM_PUSH                         = 99;//GM推送
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

message SetObject
{
	E_SET_TYPE	type  = 1;
	string		value = 2;
}

message BaseInfo
{
	string          playerIndex   		= 1;//玩家流水号
	string          nickName      		= 2;//昵称
	int32           fashionHead         = 3;//头像
	int32           fashionShow         = 4;//形像
	int32           level           	= 5;//等级
	int32			exp		   			= 6;//经验值(超出这一级的)
	int32			vipLv		   		= 7;//vip等级
	int32			fc		   			= 8;//战力
	string          signature          	= 9;//个性签名
	int32 			guildId 			= 10;//公会ID（==0无公会）
	int32 			registerTime		= 11;//注册时间（秒）
	bool 			bindRewardGet       = 12;//绑定账号奖励是否已领取
	int32           titleId             = 13;//已佩戴称号ID
	int32           fashionFrame        = 14;//头像框
}

message CardObject
{
			 int32		 		     id = 1;//ID
			 int32 		 	      level = 2;//等级
			 int32 		 	        exp = 3;//多出的经验
			 int32 		 	       star = 4;//星级
			 int32		 	    quality = 5;//品质
	repeated EquipObject 	  equipInfo = 6;//穿在身上的装备
	repeated CommonObject 	  skillInfo = 7;//技能
	   		 int32 			  fashionId = 8;//时装id
	   		 int32 			 intimacyLv = 9;//亲密度等级
	   		 int32 			lastStageId = 10;//幕间物语最后通关ID
	   		 int64 			equipScheme = 11;//装备方案
	   		 int32               sealLv = 12;//印文等级
	repeated CommonObject sealSkillInfo = 13;//印文技能列表（TYPE+LV）
	repeated int32             equipSet = 14;//套装id
}

message CardDetail
{
             string		        uid = 1;//UID
    repeated CommonObject      attr = 2;//详细属性列表
}

message PropObject
{
	int32	id          = 1;
	string	objectIndex = 2;//流水号
	int32	count       = 3;//数量
	int32 time          = 4;//获得时间
}

//家具
message FurnitureObject
{
	int32	id          = 1;
	int64	uid      = 2;//唯一id
	int32	count       = 3;//数量
	int32 time          = 4;//获得时间
}

message EquipObject
{
			 int32			id			  = 1;//
			 string			objectIndex   = 2;//
			 int32			level         = 3;//
			 int32	        mainAttrId    = 4;//主属性
	repeated int32          randomAttrId  = 5;//副属性
			 bool           lock          = 6;//是否锁定 
			 bool           identify      = 7;//是否已鉴定
	repeated int32          randomBuff    = 8;//BUFF列表
}

message CommonObject
{
	int32 id    = 1;//ID
	int64 value = 2;//数量或者等级
}

//支援战斗卡牌信息
message SupportObject
{
	int32                   id = 1;//ID
	int32                value = 2;//位置
	string         playerIndex = 3;//所属玩家ID
	int32             serverId = 4;//服务器ID
}

//配置时间解析之后的统一返回格式
message ConfigTime{
	int64  bTime          = 1;//下一次开始时间或者正在执行的活动的开始时间
	int64  durationTime   = 2;//持续时间
	int32  type           = 3;//时间类型
}

message GoodsObject
{
	int32 type        = 1;//类型
	int32 id          = 2;//ID
	int64 value       = 3;//数量或者等级
	//double multiple   = 4;//掉落倍率
}

message GoodsChangeObject
{
	int32 type         = 1;//类型
	int32 id           = 2;//ID
	int32 value        = 3;//数量
	int64 after        = 4;//
	string objectIndex = 5;//
	int32 attr         = 6;//初始属性（不同类型代表各自的属性：卡牌-星级）
	int32 time         = 7;//物品创建时间
}

message TaskObject
{
	int32 id 		  		    	  = 1;//ID
	int64 need		  	      		  = 2;//需要数量
	int64 comp		  	 	  		  = 3;//完成数量
	E_STATUS_TYPE status      		  = 4;//状态
	string param                      = 5;//参数
}

message TaskSimpleObject
{
	int32  id       		  		  = 1;//ID
	E_STATUS_TYPE status     		  = 2;//状态
}

//邮件摘要信息
message MailSummaryInfo 
{
    int64 id 								= 1;//邮件ID
    int32 type 								= 2;//类型
    int32 cId								= 3;//配置ID（无需翻译置0）
	string title						    = 4;//邮件标题
	string sender 							= 5;//邮件发送方
	bool read 								= 6;//是否已读
	bool hasAnnex 							= 7;//是否有附件
	bool received 							= 8;//附件是否已领取
	int64 live								= 9;//有效期（MS）
	repeated string params					= 10;//参数列表
}

//邮件详细信息
message MailDetailInfo
{
			 int64 id 								= 1;//邮件ID
			 int32 type 							= 2;//类型
			 int32 cId								= 3;//配置ID（无需翻译置0）
			 int64 receive						    = 4;//收到时间（单位MS）
			 string title 							= 5;//邮件标题
			 string sender 							= 6;//邮件发送方
			 string content 						= 7;//邮件内容
			 bool hasAnnex 							= 8;//是否有附件
	repeated GoodsObject annexList 					= 9;//附件物品列表
			 bool received 							= 10;//附件是否已领取
			 int64 live								= 11;//有效期（MS）
	repeated string params							= 12;//参数列表
	         bool canDel                            = 13;//能否手动删除
}

//对手卡牌信息
message RivalCardState{
    int32   id                    = 1;//卡牌id
	int32   state                 = 2;//卡牌状态 1为正常 2为疲劳 3为死亡
	int32     supHp               = 3;//卡牌剩余血量
	int32     supDander           = 4;//卡牌剩余怒气
	int32     pos                 = 5;//位置信息
	int32  fc                     = 6;//战斗力
	int32  fashionId              = 7;//模型id
	int32  speed                  = 8;//速度
	int32  hp                     = 9;//总血量
	int32  round                  = 10;//轮次
}

message TalentTreeInfo
{
			 int32	    talentTreeId     = 1;
			 int32		star             = 2;//星级
			 int32		energy           = 3;//星能
			 int32		energyExp        = 4;//星能经验
	repeated CommonObject talentInfo     = 5;//
}

message MatrixTreeInfo
{
			 int32      id         = 1;
	repeated MatrixInfo matrixInfo = 2;
}
message MatrixInfo
{
			 int32	id      = 1;
			 int32  curNode = 2;//当前激活的节点
	repeated CommonObject  sealInfo  = 3;//封印列表(只有激活了的才会发)id表示是类型,value是ID
}

//除了基本扭蛋之外的扭蛋
message OtherLottery{
	int32 lotteryId            = 1;//扭蛋id
	int32 lotteryType          = 2;//扭蛋类型
	int32 lotteryMode          = 3;//扭蛋模型  1.单抽 2.十连抽
	int32 surLotteryNum        = 4;//剩余次数
	int64 beginTime            = 5;//扭蛋活动开始时间 当值为-1时 表示没有开始时间
	int64 endTime              = 6;//扭蛋活动结束时间 当值为-1时 表示没有结束时间
	int32 moreFreeNum          = 7;//免费十连次数
	int32 integral             = 8;//活动扭蛋积分
}




//农场信息
message FarmInfo
{
	         int32                  farmLevel = 1;//等级
	         int32                    farmExp = 2;//经验
	repeated LandInfo                landInfo = 3;//土地
	repeated SeedInfo                seedInfo = 4;//种子列表
}

//土地信息
message LandInfo
{
	int32                                  id = 1;//ID
	LAND_STATUS                        status = 2;//状态
	int32                           countDown = 3;//收割倒计时（秒）
	int32                              seedId = 4;//当前农作物种子ID
}

//种子信息
message SeedInfo
{
	int32                                  id = 1;//ID
	int32                               stock = 2;//库存
}

//种植信息
message PlantInfo
{
	int32                              landId = 1;//土地ID
	int32                              seedId = 2;//种子ID
}


//2301请求进入家园
message ReqInFamily
{
	
}
//2302返回进入家园
message ResInFamily
{
	FarmInfo                         framInfo = 1;//农场信息
	//todo or not todo houseInfo房屋信息
}


//2303请求种子仓库
message ReqSeedWarehouse
{
	
}
//2304返回种子仓库
message ResSeedWarehouse
{
	repeated SeedInfo                seedInfo = 1;//种子列表
}

//2305请求土地种植
message ReqLandPlanting
{
	repeated PlantInfo               plantInfo = 1;//种植列表
}
//2306返回土地种植
message ResLandPlanting
{
	FarmInfo                         framInfo = 1;//农场信息
}

//2307请求土地收割
message ReqLandHarvest
{
	int32                              landId = 1;//土地ID（0：一键收割）
}
//2308返回土地收割
message ResLandHarvest
{
	FarmInfo                         framInfo = 1;//农场信息
	repeated GoodsObject                goods = 2;//获得的物品
	int32                              landId = 3;//土地ID（原样返回）
}

//2309请求土地铲除
message ReqLandUproot
{
	int32                              landId = 1;//土地ID
}
//2310返回土地铲除
message ResLandUproot
{
	FarmInfo                         framInfo = 1;//农场信息
	int32                              seedId = 2;//被铲除的种子ID
}

//2311请求土地解锁
message ReqLandUnlock
{
	int32                              landId = 1;//土地ID
}
//2312返回土地解锁
message ResLandUnlock
{
	FarmInfo                         framInfo = 1;//农场信息
}


//房间信息
message RoomInfo{
	int32 level                          = 1;//房间等级
	int32 id                             = 2;//房间id
	repeated RoomStyle roomStyle         = 3;//房间风格
	
}

//房间
message RoomStyle{
	int32 styleId                        = 1;//方案id
	repeated RoomCardInfo roomCardInfo   = 2;//入驻角色 
	repeated FurnitureData furnitureData = 3;//家具 包括墙纸,地板
	//int32 wallpaper                      = 4;//墙纸
	//int32 floor                          = 5;//地板
}

//房间角色信息 需要根据里面的信息去定位角色模型
message RoomCardInfo{
	int32    cardId          = 1;
	int32 quality            = 2;//品质
}

//家具
message FurnitureData{
	int64 uid				 = 1;//家具唯一id
	int32 id				 = 2;//配置表id 			
	int32 orientation        = 3;//家具朝向 0表示未转向，1表示转向
	int64 time         		 = 4;//家具获得时间
	int32 xCoordinate        = 5;//x坐标
	int32 yCoordinate        = 6;//y坐标
	int32 zCoordinate        = 7;//z坐标
}

//2351获取房屋信息
message ReqRoomInfo{
	
}

//2352
message ResRoomInfo{
	repeated RoomInfo roomInfo    = 1;//房间信息
	int32 defaultRoomId           = 2;//默认房间id 为0 则取第一个
	int32 defaultStyle            = 3;//默认风格 为0 则取第一个
	repeated int32 pastFurniture  = 4;//过期家具的id
}

//2353 房间入驻
message ReqRoomEnter{
	repeated int32 cardId  = 1;//入驻角色
	int32 roomId           = 2;//房间id
	int32 styleId          = 3;//方案id
}

//2354
message ResRoomEnter{
	repeated RoomCardInfo cardInfo = 1;//入驻角色
	int32 roomId                   = 2;//房间id
	int32 styleId                  = 3;//方案id
}

//2355 房间布置 清空也用这个请求 如果是清空 则furnitureData为空  发送这个请求 服务器先执行清空
message ReqRoomLayout{
	int32 roomId                           = 1;//房间id
	repeated RoomStyle roomStyle           = 2;//房间布局
}

//房间布局
//message RoomStyle{
	//repeated FurnitureData furnitureData   = 1;//家具
	//int32 wallpaper                        = 2;//墙纸
	//int32 floor                            = 3;//地板
	//int32 styleId                          = 4;//方案id
//}

//2356
message ResRoomLayout{
	int32 roomId                           = 1;//房间id 
    repeated RoomStyle roomStyle           = 2;//房间布局
}

//2357 房间升级
message ReqRoomLevelUp{
	int32  id      = 1;//房间id
	int32 styleId  = 2;//方案id
}

//2358
message ResRoomLevelUp{
	int32  id      = 1;//房间id
	int32  level   = 2;//房间等级
}

//2359 房间拜访 
message ReqRoomCallOn{
	string objectIndex     = 1;//玩家唯一编号
	int32   serverId       = 2;//服务器id
}

//2360
message ResRoomCallOn{
	RoomInfo  roomInfo            = 1;//房间信息
	string objectIndex     		  = 2;//玩家唯一编号
	int32 fc                      = 3;//战斗力
	int32 fashionHead             = 4;//头像
	string name                   = 5;//名字
	int32 level                   = 6;//等级
	int32 title                   = 7;//称号
	int32 serverId                = 8;//服务器
	bool isRandomVisit            = 9;//是否为随机访问
}

//2363 退出房间
message ReqQuitRoom{
	int32 roomId               = 1;//房间号
	int32 styleId              = 2;//方案id
}

//2364 退出房间
message ResQuitRoom{
	int32 roomId               = 1;//房间号
	int32 styleId              = 2;//方案id
}


//2361 请求随机拜访的玩家
message ReqRandomPlayerInfo{

}

//2362
message ResRandomPlayerInfo{
	string objectIndex     = 1;//玩家id
	int32 fc               = 2;//战斗力
	int32 fashionHead      = 3;//头像
	string name            = 4;//名字
	int32 level            = 5;//等级
	int32 title            = 6;//称号
	int32 serverId         = 7;//服务器
}








//好友系统操作
enum FriendOperationType
{
	UNKNOWN         = 0; //未知
	ADD_FRIEND      = 1; //添加好友
	DEL_FRIEND      = 2; //删除好友
	AGREE_INVITE    = 3; //同意邀请
	REFUSE_INVITE   = 4; //拒绝邀请
	CANCAL_INVITE   = 5; //取消邀请
}

//好友操作结果
enum FriendOperationCode
{
	OP_SUCCESS           			= 0; //成功
	EXCEED_MAX_FRIEND_COUNT     	= 1; //好友已满
	EXCEED_TARGET_MAX_FRIEND_COUNT  = 2; //对方好友已满
	ALREADY_IS_FRIEND           	= 3; //已经是好友了
	EXCEED_MAX_MY_INVITE_COUNT  	= 4; //邀请队列已满
	NEVER_BE_INVITED   				= 5; //没有收到过邀请
	CAN_NOT_ADD_SELF   				= 6; //不能添加自己好友
	CAN_NOT_FIND_PLAYER   			= 7; //找不到玩家数据
	NOT_OPEN_FUNCTION   			= 8; //我的好友功能未开放
	FRIEND_NOT_OPEN_FUNCTION   		= 9; //对方的好友功能未开放
}


//好友信息
message FriendInfo
{
	string          playerIndex   		= 1;//玩家ID
	string          nickName      		= 2;//昵称success
	int32           fashionHead         = 3;//头像
	int32           fashionShow         = 4;//形像
	int32           level           	= 5;//等级
	int32 			guildId 			= 6;//公会ID（==0无公会）
	string 			guildName 			= 7;//公会名字
	int32           titleId             = 8;//已佩戴称号ID
	bool			online          	= 9;//是否在线
	int32			fc		   			= 10;//战力
	int32           serverId            = 11;//服务器ID
	int32           fashionFrame        = 12;//头像框
}

//好友详细信息
message FriendDetailInfo
{
				string          playerIndex   		= 1;//玩家ID
				string          nickName      		= 2;//昵称
				int32           fashionHead         = 3;//头像
				int32           fashionShow         = 4;//形像
				int32           level           	= 5;//等级
				int32			fc		   			= 6;//战力
				int32 			guildId 			= 7;//公会ID（==0无公会）
				string 			guildName 			= 8;//公会名字
				int32           titleId             = 9;//已佩戴称号ID
	repeated	int32			cardIdList          = 10;//最强6张卡ID
				int32			logoutTime          = 11;//离线的时间戳（秒），0就是在线
				int32			serverId            = 12;//玩家服务器ID
				int32           fashionFrame        = 13;//头像框
}

//2201 请求好友数据
message ReqRelations
{
	
}

//2202 返回好友数据
message ResRelations
{
	repeated FriendInfo friendList = 1; //好友列表
	repeated FriendInfo myInviteList = 2; //我的邀请列表
	repeated FriendInfo friendInviteList = 3; //好友邀请列表
}

//2211 请求搜索好友
message ReqSearch
{
	string   content = 1;  //搜索的内容
}

//2212 返回搜索好友结果
message ResSearch
{
	repeated FriendInfo searchList = 1; //符合条件的好友列表
}

//2221 请求改变好友关系
message ReqChangeRelation
{
	FriendOperationType     type            = 1;   //1:添加好友，2:删除好友，3:同意好友邀请，4:拒绝好友邀请，5:取消我的邀请
	string     			    playerIndex     = 2;   //好友的ID
}


//2222 返回改变好友关系
message ResChangeMyRelation
{	
	FriendOperationCode      code            = 1;    //操作的结果
	FriendOperationType      type            = 2;    //1:添加好友，2:删除好友，3:同意好友邀请，4:拒绝好友邀请，5:取消好友的邀请
	FriendInfo               info             = 3;    //好友的信息
}

//2223 通知改变对方好友关系
message ResChangeFriendRelation
{
	FriendOperationType      type            = 1;   //1:添加好友，2:删除好友，3:同意好友邀请，4:拒绝好友邀请，5:取消好友的邀请
	FriendInfo              info            = 2;    //好友的信息
}

//2231 请求好友信息
message ReqFriendInfo
{
	string          playerIndex   		= 1;//玩家ID
}

//2232 返回好友信息
message ResFriendInfo
{
	FriendDetailInfo     detailInfo   		= 1;//好友详细信息
}

//2241 通知好友上线状态变化
message ResFriendState
{
	int32			logoutTime          = 11;//离线的时间戳（秒），0就是上线
	string      playerIndex   		= 2;//玩家ID
}

//2251请求切磋
message ReqFriendPK
{
	string              friendIndex = 1;//切磋对象
	int32 				serverId    = 2;//服务器ID
}
//2252返回切磋
message ResFriendPK
{
	repeated CommonObject       ownCardGroup = 1;//玩家卡组
			 string              friendIndex = 2;//切磋对象
	repeated RivalCardState   rivalCardGroup = 3;//敌方卡组
}

//2261请求进入好友切磋
message ReqInFriendPK
{
	repeated CommonObject           cardGroup = 1;//布阵卡组
}
//2262返回进入好友切磋
message ResInFriendPK
{
	
}

//2271请求结算好友切磋
message ReqEndFriendPK
{
	BattleCompleteData    battleCompleteData = 1;//战斗数据
}
//2272返回结算好友切磋
message ResEndFriendPK
{
	                            bool success = 1;//挑战是否成功
	repeated          CommonObject cardGroup = 2;//卡组
}








//1801请求已开启功能ID列表
message ReqFunctionList
{
	
}
//1802返回已开启功能ID列表
message ResFunctionList
{
	repeated int32 initFuncId 			   = 1;//（登录）已开启功能ID列表
}

//1803请求开启功能
message ReqOpenFunction
{
	
}
//1804返回开启功能
message ResOpenFunction
{
	repeated int32 newFuncId 				= 1;//新功能ID开启
}



enum E_PLAYER_INFO
{
	INFO_UNKNOWN  = 0;
	BASE     = 1;
	BAG      = 2;
	MAIL     = 3;
	TASK     = 4;
}


enum E_GM_TYPE
{
	GM_UNKNOWN = 0;
	SUPER = 1;
	ADMIN = 2;
	GUEST = 3;
}
enum E_QUERY_TYPE
{
	QUERY_UNKNOWN = 0;
	OBJECT_INDEX = 1;
	ACCOUNT      = 2;
	NAME         = 3;
}

//1001
message ReqGMLogin
{
	string	account  = 1;
	string  password = 2;
}
//1002
message ResGMLogin
{
	string	account  = 1;
}

//1003
message ReqGMRegister
{
	string	account  = 1;
	string  password = 2;
	E_GM_TYPE type   = 3;
}
//1004
message ResGMRegister
{
}

//1005
message ReqGMList
{
}
//1006
message ResGMList
{
}

//1007
message ReqGMDel
{
	int32	id = 1;
}
//1008
message ResGMDel
{
	int32 	id = 2;
}

//1009
message ReqGMUpdate
{
	
}
//1010
message ResGMUpdate
{
	
}

//1011
message ReqPlayerList
{
	bool    online   = 1;
	int32	page     = 2;
	int32	count    = 3;
	string  keyword  = 4;
	int32   serverId = 5;
}
//1012
message ResPlayerList
{	
			 bool     online      = 1;
			 int32	  page        = 2;
			 int32    totalPage   = 3;
			 int32    totalCount  = 4;
	repeated BaseInfo playerInfo  = 5;
}


//1013
message ReqPlayerInfo
{
	E_QUERY_TYPE type  = 1;
	string       value = 2;
}
//1014
message ResPlayerInfo
{
	        BaseInfo	  baseInfo  = 1;//基本信息
	repeated CommonObject assetInfo = 2;//资源信息
	repeated CardObject	  cardInfo  = 3;//卡牌信息
	repeated PropObject   propInfo  = 4;//道具信息
	repeated EquipObject  equipInfo = 5;//装备信息
}

//1015
message ReqPlayerAddGoods
{
	int32        serverId = 1;
	string    playerIndex = 2;
	repeated GoodsObject    goods = 3;
}
//1016
message ResPlayerAddGoods
{
}

//1017
message ReqGroupMail
{
}
//1018
message ResGroupMail
{
}

//1019
message ReqSendNotice
{
}
//1020
message ResSendNotice
{
}



message DataConfig
{
	int32	id   = 1;
	string  name = 2;
}

//1021
message ReqGetConfig
{
}
//1022
message ResGetConfig
{
	repeated DataConfig propConfig  = 1;
	repeated DataConfig assetConfig = 2;
	repeated DataConfig cardConfig  = 3;
	repeated DataConfig equipConfig = 4;
}
	
//1023
message ReqServerList
{
	
}
//1024
message ResServerList
{
	repeated	int32	mainServerId = 1;//游戏服列表
}




//公会基本信息
message GuildBaseInfo
{
			 int32	                         id = 1;//ID
			 string                        name = 2;//名称
			 int32                         icon = 3;//图标
			 int32                        level = 4;//等级
			 int32                          exp = 5;//经验
    		 int32                  memberCount = 6;//成员数量
    		 int32                   activation = 7;//活跃度
			 int64                           fc = 8;//战力
			 string                      leader = 9;//会长
			 int64 	                  joinMinFc = 10;//入会最小战力
	repeated MemberSummary              members = 11;//成员摘要
			 int32             dayFixationLevel = 12;//公会每日固定等级
}

///未加入公会时的信息
message GuildInfo
{
	repeated GuildBaseInfo       guilds = 1;//公会列表
			 int64                   cd = 2;//CD时间
	repeated GuildBaseInfo       applys = 3;//申请列表
}


//公会排行信息
message GuildRankInfo
{
	int32	           id = 1;//ID
	string           name = 2;//名称
	int32            icon = 3;//图标
	int32           level = 4;//等级
	string         leader = 5;//会长
	int32     memberCount = 6;//成员数量
	int32      activation = 7;//活跃度
	int64              fc = 8;//战力
}

//成员摘要
message MemberSummary
{
	string       objectindex = 1;//玩家标识
	int32 			    post = 2;//职位
}

//成员信息
message MemberInfo
{
	         string       objectindex = 1;//玩家标识
	         string              name = 2;//名称
	         int32          fashionId = 3;//头像
	         int32              level = 4;//等级
	         int64   			   fc = 5;//战力
	         int32 			     post = 6;//职位
	         int32 	   weekActivation = 7;//周活跃
	         int32 	       activation = 8;//总活跃
	         int64         onlineTime = 9;//最后在线时间
	         int32 		     serverId = 10;//服务器ID
	         int32            titleId = 11;//已佩戴称号ID
	         int32       fashionFrame = 12;//头像框
			 int32 remainHp           = 13;//BOSS剩余百分比血量
	         int32 assistedTime		  = 14;//当日已协助次数
			 int32 byAssistTime       = 15;//当日被协助次数
}

//申请信息
message ApplyInfo
{
	         string       objectindex = 1;//玩家标识
	         string              name = 2;//名称
	         int32          fashionId = 3;//头像
	         int32              level = 4;//等级
	         int64   			   fc = 5;//战力
	         int64         onlineTime = 6;//最后在线时间
	         int32 		     serverId = 7;//服务器ID
	         int64          applyTime = 8;//申请时间
	repeated PlayerCardInfo  cardList = 9;//卡牌列表
	         int32      fashionFrame  = 10;//头像框
}

//卡牌信息
message PlayerCardInfo
{
	int32 				  id = 1;
	int32          fashionId = 2;
	int32              level = 3;
	int32               star = 4;
	int32         intimacyLv = 5;
	int32            quality = 6;
}

//公会日志信息
message GuildLogInfo
{
	GUILD_LOG 		 logType = 1;//日志类型
	string       objectindex = 2;//玩家标识
	string        memberName = 3;//成员名字
	string             param = 4;//附加参数
	int64               time = 5;//日志时间
}


//1501公会列表(未加入公会时)
message ReqGuildList
{
	
}
//1502公会列表(未加入公会时)
message ResGuildList
{
	GuildInfo info = 1;
}

//1503搜索公会
message ReqSearchGuild
{
			 string	           guildName = 1;//公会名
}
//1504搜索公会
message ResSearchGuild
{
	         string            guildName = 1;
	repeated GuildBaseInfo     guildInfo = 2;
}

//1505加入公会
message ReqJoinGuild
{
	int32 			            id = 1;//公会ID
	GUILD_ACTION               act = 2;//操作类型
}
//1506加入公会
message ResJoinGuild
{
	int32 			            id = 1;//公会ID
	GUILD_ACTION               act = 2;//操作类型
}

//1507创建公会
message ReqCreateGuild
{
	string	              guildName = 1;//公会名
}
//1508创建公会
message ResCreateGuild
{
	int32 			             id = 1;//公会ID
}

//1511公会详情
message ReqGuildDetailInfo
{
	
}
//1512公会详情
message ResGuildDetailInfo
{
			 GuildBaseInfo  	        baseInfo = 1;//公会基本信息
			 int32       	         onlineCount = 2;//在线成员数
    		 string           	          notice = 3;//公告
    repeated GuildLogInfo 	 	         logList = 4;//日志列表
             GuildWarSummaryInfo         warInfo = 5;//公会战摘要信息
             int32                       impeach = 6;//0：不能弹劾    1：可弹劾    2：弹劾中    3：已投票
             string                    organizer = 7;//弹劾发起人（玩家ID）
}

//1513修改公会信息
message ReqSetGuildInfo
{
	GUILD_SET                setType = 1;//设置类型
	string                  setValue = 2;//设置值
}
//1514修改公会信息
message ResSetGuildInfo
{
	GUILD_SET                setType = 1;//设置类型
	string                  setValue = 2;//设置值
}

//1515解散公会
message ReqDisbandGuild
{
	
}
//1516解散公会
message ResDisbandGuild
{
	GuildInfo info = 1;
}

//1517退出公会
message ReqQuitGuild
{
	
}
//1518退出公会
message ResQuitGuild
{
	GuildInfo info = 1;
}

//1519公会成员列表
message ReqGuildMemberList
{
	
}
//1520公会成员列表
message ResGuildMemberList
{
	repeated MemberInfo     memberList = 1;//成员列表
}

//1521设置公会成员的职位
message ReqSetGuildJob
{
	string                 objectIndex = 1;
	GUILD_POST                 newPost = 2;//新职位
}
//1522设置公会成员的职位
message ResSetGuildJob
{
	string                 objectIndex = 1;
	GUILD_POST                 newPost = 2;//新职位
}

//1523删除公会成员
message ReqRemoveGuildMember
{
	string                 objectIndex = 1;
}
//1524删除公会成员
message ResRemoveGuildMember
{
	string                 objectIndex = 1;
}

//1507公会审核
message ReqGuildReview
{
	
}
//1526公会审核
message ResGuildReview
{
	repeated ApplyInfo       applyList = 1;
}

//1527处理申请
message ReqProcessApply
{
			 GUILD_APPLY       	   act = 1;//0拒绝	1通过
	repeated string        objectIndex = 2;//被操作的玩家ID列表
}
//1528处理申请
message ResProcessApply
{
			 GUILD_APPLY       	   act = 1;//0拒绝	1通过
	repeated string        objectIndex = 2;//被操作的玩家ID列表
}

//1529公会排行(只有加入公会后才能看到)
message ReqGuildRank
{
	
}
//1530公会排行(只有加入公会后才能看到)
message ResGuildRank
{
	repeated GuildRankInfo    guildRankList = 1;//排行前50的公会列表（顺序排行）
			 int32              myGuildRank = 2;//我的公会排名
			 int64             nextRankTime = 3;//下次刷新排行时间
}

//1531公会基本信息
message ReqGuildBaseInfo
{
	
}
//1532公会基本信息
message ResGuildBaseInfo
{
	GuildBaseInfo  	baseInfo = 1;
}

//1533更新玩家公会ID
message ReqGuildId
{
	
}
//1534更新玩家公会ID
message ResGuildId
{
	int32 			            id = 1;//公会ID
}



//1535公会建设信息初始化
message ReqGuildBuildInit
{
	
}
//1536公会建设信息初始化
message ResGuildBuildInit
{
	 BuildingGuild buildingGuild   = 1;
}

//公会建设
message BuildingGuild
{
	int32 buildingPlan             = 1;//公会的捐献进度
	int32 buildingNum              = 2;//玩家捐献次数
	repeated BuildingRecord record = 3;//捐献记录
	repeated int32 yetRewardType   = 4;//已经领取过的奖励id
}

//公会建设记录
message BuildingRecord
{
	string pName                   = 1;//玩家名
	int32 type                     = 2;//捐献类型
}

//1537公会建设
message ReqGuildBuild
{
	int32 type                     = 1;//建设类型  1为捐献 2为领取奖励
	int32 param                    = 2;//参数  如果type为1 则传入公会建设的type  为2时  传入领取奖励的id
}
//1538公会建设
message ResGuildBuild
{
	repeated GoodsObject              goods = 1;//公会建设奖励
	         BuildingGuild    buildingGuild = 2;
	         int32                     type = 3;//建设类型  1为捐献 2为领取奖励
	         int32                    param = 4;//参数 如果type为1 则传入公会建设的type  为2时  传入领取奖励的id
	         bool                     upper = 5;//是否上限 true为已达上限
	         int32                  guildLv = 6;//当前公会等级
	         int32                 guildExp = 7;//当前公会经验
	         int32                 guildAct = 8;//当前公会活跃度
}



//1539公会馈礼信息初始化
message ReqGuildGiftInit
{
	
}

//1540公会馈礼信息初始化
message ResGuildGiftInit
{
	repeated GuildGiftPostAndType    posAndType = 1;//初始化类型和类型
}

//公会福利位置和类型
message GuildGiftPostAndType
{
	int32 pos               = 1;//位置
	bool isDraw             = 3;//是否已经领取
}

//1541公会馈礼获取
message ReqGuildGiftGet
{
    int32 pos               = 1;//位置
}
//1542公会馈礼获取
message ResGuildGiftGet
{
	repeated GoodsObject goods = 1;//奖励 
}

//1543公会馈礼排行
message ReqGuildGiftRank
{

}
//1544公会馈礼排行
message ResGuildGiftRank
{

	repeated GiftRank rank  = 2;//公会馈礼排行
}

//公会馈礼排行数据
message GiftRank{
	MemberInfo memberInfo      = 1;
	repeated GoodsObject goods = 2;//排行数据
}



message GuessCapRecord
{
	int32 num                  = 1;//轮次
	repeated GoodsObject goods = 2;//奖励

}

//1545猜杯子游戏初始化
message ReqGuildGameInit
{
	int32 type                 = 1;//猜杯子类型
}
//1546猜杯子游戏初始化
message ResGuildGameInit
{
    int32 type                 = 1;//猜杯子类型
	int32 num                  = 2;//猜杯子轮次
	int32 guessCapNum          = 3;//本轮猜杯子使用次数
	repeated GoodsObject goods = 4;//未被翻开的杯子下的奖励
	int32 guessCapsState       = 5;//猜杯子状态 1为可猜状态 2为不可猜状态
	repeated int32 openCaps    = 6;//已经开启的杯子序列
	GuessCapReward reward      = 7;//当前轮次获取的奖励
}

//1547开始猜杯子
message ReqBeginGuildGame
{
    int32 type                  = 1;//猜杯子类型
}
//1548开始猜杯子
message ResBeginGuildGame
{
    int32 type                 = 1;//猜杯子类型
	int32 num                  = 2;//猜杯子轮次
	int32 guessCapNum          = 3;//本轮猜杯子使用次数 0
	int32 guessCapsState       = 4;//猜杯子状态 1为可猜状态 2为不可猜状态
}

//1549猜杯子
message ReqGuildGamePlay
{
	int32 type                 = 1;//猜杯子类型
	int32 operType             = 2;//操作类型 1为猜一次 2为一键猜
	int32 capPos               = 3;//杯子位置
	int32 guessNum             = 4;//一键猜杯子的次数
}
//1550猜杯子
message ResGuildGamePlay
{
    int32 type                     = 1;//猜杯子类型
	int32 num                      = 2;//猜杯子轮次
	int32 guessCapNum              = 3;//本轮猜杯子使用次数
	repeated GuessCapReward reward = 4;//本次点击猜杯子的奖励
	int32 guessCapsState           = 5;//猜杯子状态 1为可猜状态 2为不可猜状态
	repeated int32 openCaps        = 6;//已经开启的杯子序列
	int32 operType                 = 7;//猜杯子类型
	int32 capPos                   = 8;//杯子位置
}

//猜杯子奖励
message GuessCapReward
{
	int32 round                 = 1;//轮次
	repeated GoodsObject reward = 2;//奖励
}

//1551猜杯子重置
message ReqGuildGameReset
{
	int32 type                  = 1;//猜杯子类型
}
//1552猜杯子重置
message ResGuildGameReset
{
	int32 type                  = 1;// 猜杯子类型
	int32 guessCapNum           = 2;//本轮猜杯子使用次数 0
	repeated GoodsObject goods  = 3;//未被翻开的杯子下的奖励
	int32 guessCapsState        = 4;//猜杯子状态 1为可猜状态 2为不可猜状态
}

//1553猜杯子记录
message ReqGuildGameRecord
{
	int32 type                  = 1;// 猜杯子类型
}
//1554猜杯子记录
message ResGuildGameRecord
{
	         int32                 type = 1;// 猜杯子类型
	repeated GuessCapRecord     record  = 2;//猜杯子记录
	repeated CommonObject specialReward = 3;//特殊奖励记录
}



//1555推送公会日志
message ReqGuildLog
{
	
}
//1556推送公会日志
message ResGuildLog
{
	GuildLogInfo log = 1;//公会日志
}



//1557请求切磋
message ReqGuildPK
{
	         string              memberIndex = 1;//切磋对象
	         int32 					serverId = 2;//服务器ID
}
//1558返回切磋
message ResGuildPK
{
	repeated CommonObject       ownCardGroup = 1;//玩家卡组
			 string              memberIndex = 2;//切磋对象
	repeated RivalCardState   rivalCardGroup = 3;//敌方卡组
}

//1559请求进入战斗
message ReqInGuildPK
{
	repeated CommonObject           cardGroup = 1;//布阵卡组
}
//1560返回进入战斗
message ResInGuildPK
{

}

//1561请求结算战斗
message ReqSettleGuildPK
{
	BattleCompleteData    battleCompleteData = 1;//战斗数据
}
//1562返回结算战斗
message ResSettleGuildPK
{
	                            bool success = 1;//挑战是否成功
	repeated          CommonObject cardGroup = 2;//卡组
}



//1563同步公会数据
message ReqSyncGuildData
{
	
}
//1564同步公会数据
message ResSyncGuildData
{
	int32 							   level = 1;
	int32 								 exp = 2;
	int32 						  activation = 3;
}

//1565请求玩家卡牌
message ReqPlayerCards
{
	         string 		     objectIndex = 1;//成员ID
}
//1566返回玩家卡牌
message ResPlayerCards
{
	         string 		     objectIndex = 1;//成员ID
	repeated PlayerCardInfo         cardList = 2;//卡牌列表
}

//1567升级弹窗
message ReqPopUpLevelUp
{
	
}
//1568升级弹窗
message ResPopUpLevelUp
{
	int32 							   level = 1;//公会当前等级
}

//1569请求公会摘要信息
message ReqGuildSummary
{
	
}
//1570返回公会摘要信息
message ResGuildSummary
{
	int32	           id = 1;//ID
	string           name = 2;//名称
	int32            icon = 3;//图标
	int32           level = 4;//等级
}


//投票信息
message VoteInfo
{
	string             memberIndex = 1;//参与投票得成员ID
	bool                      vote = 2;//投票结果（true：支持     false：反对）
}

//1571请求弹劾数据
message ReqImpeachData
{
	//首个请求将视为发起投票
}
//1572返回弹劾数据
message ResImpeachData
{
    bool                   success = 1;
    string               organizer = 2;//弹劾发起人（成员ID）
	string           organizerName = 3;//发起人（成员昵称）
	int64                  voteEnd = 4;//投票截止时间
	repeated VoteInfo     voteInfo = 5;//投票列表
	bool                   request = 6;//客户端请求
}

//1573请求参与投票
message ReqVoting
{
	bool                      vote = 1;//投票结果（true：支持     false：反对）
}
//1574返回参与投票
message ResVoting
{
	//返回弹劾数据
}





//公会摘要信息
message GuildSummaryInfo
{
	int32	                          id = 1;//ID
	string                          name = 2;//名称
	int32                           icon = 3;//图标
	int32                          level = 4;//等级
    int32                    memberCount = 5;//成员数量
	string                        leader = 6;//会长
}

//公会战摘要信息
message GuildWarSummaryInfo
{
	GUILD_WAR_STATUS              status = 1;//公会战状态
	int64                           time = 2;//时间
	int32                           rank = 3;//排名
}

//公会战基本信息
message GuildWarBaseInfo
{
    int32                       seasonId = 1;//赛季ID
	GUILD_WAR_STATUS              status = 2;//公会战状态
	int64                      beginTime = 3;//开始时间
	int64                        endTime = 4;//结束时间
	int32                      obtTalent = 5;//获得的天赋点数
	int32                           rank = 6;//排名
}

//公会战关卡信息
message WarStageInfo
{
	int32                             id = 1;//关卡ID
	int32                          round = 2;//所属周目
	int64                         bossHp = 3;//BOSS剩余血量
	string                      murderer = 4;//击杀BOSS的玩家ID
	int64                      deathTime = 5;//BOSS死亡时间
}

//伤害报告信息
message HurtReportInfo
{
	string                   playerIndex = 1;//玩家ID
	string                          name = 2;//玩家昵称
	int32                    fashionHead = 3;//玩家头像
	int32                          level = 4;//等级
	int32                             fc = 5;//玩家战力
	int32                        titleId = 6;//佩戴的称号ID
	int64                           hurt = 7;//伤害值
	int32                   fashionFrame = 8;//头像框
}

//公会天赋信息
message GuildTalentInfo
{
	int32		                      id = 1;//天赋ID
	int32		                   level = 2;//等级
}

//公会战奖励信息
message WarRewardInfo
{
	int32                             id = 1;//奖励ID
	E_STATUS_TYPE                 status = 2;//状态
}

//公会赛季排行信息
message GsRankInfo
{
	int32	   				          id = 1;//ID
	string           		        name = 2;//名称
	int32      					    icon = 3;//图标
	int32       				   level = 4;//等级
	string    				      leader = 5;//会长
	int32    				 memberCount = 6;//成员数量
	int64     				    integral = 7;//赛季积分
	int32                           rank = 8;//排行
}

//成员赛季排行信息
message MsRankInfo
{
	string         			 objectindex = 1;//玩家标识
	string       			        name = 2;//名称
	int32         			   fashionId = 3;//头像
	int32         			          lv = 4;//等级
	int64   					      fc = 5;//战力
	int32           		     titleId = 6;//已佩戴称号ID
	int32         			    integral = 7;//赛季积分
	int32                   fashionFrame = 8;//头像框
}

//赛季提示信息
message WarPromptInfo
{
	         GUILD_WAR_PROMPT     prompt = 1;//赛季提示类型
	repeated int64                params = 2;//参数列表（promptType==NEW_SEASON:params=[备战开始时间, 挑战开始时间, 结算开始时间]；promptType==SETTLE_SEASON:params=[本赛季排名, 上赛季排名]）
}

//支援卡牌信息
message SupportCardInfo
{
			 int32		                   id = 1;
			 int32    		        fashionId = 2;
			 int32       		        level = 3;
			 int32      		         star = 4;
	         int32   	           intimacyLv = 5;
	         int32     		          quality = 6;
	repeated CardEquipInfo          equipInfo = 7;
	repeated CardSkillInfo          skillInfo = 8;
	         string                playerName = 9;
	         string               playerIndex = 10;
	         int32                   serverId = 11;
	         int32                         fc = 12;
	         int32                        spd = 13;
	         int32                     sealLv = 14;
	repeated CardSealSkillInfo  sealSkillInfo = 15;
	         bool                        used = 16;//今天是否已经使用过了
	repeated int32 equipSetsBuffList          = 17;//套装
}

//卡牌装备信息
message CardEquipInfo
{
             int32                    id = 1;
	repeated int32            randomBuff = 2;
}

//卡牌技能信息
message CardSkillInfo
{
	int32                             id = 1;
	int32                          value = 2;
}

//卡牌印文技能信息
message CardSealSkillInfo
{
	int32                             id = 1;
	int32                          value = 2;
}

//公会战战斗记录
message WarBattleInfo
{
	string                            playerIndex = 1;//玩家ID
	string                             playerName = 2;//玩家昵称
	int32         			             integral = 3;//本次积分
	int64                              settleTime = 4;//结算时间
	BattleData                         battleData = 5;//战斗数据
	int32                                 stageId = 6;//关卡ID
	E_BATTLE_DATA_TYPE             battleDataType = 7;//战斗数据类型
}
message BattleData
{
	repeated ChallengeSummarizeData challengeSummarizeData = 1;//战斗中所有参战卡片的伤害统计
}

//公会战战斗中信息
message InBattleInfo
{
	string                            playerIndex = 1;//玩家ID
	string                             playerName = 2;//玩家昵称
	int64                                  inTime = 3;//进入时间
	int32                                 stageId = 4;//关卡ID
	E_BATTLE_DATA_TYPE             battleDataType = 5;//战斗数据类型
}

//主界面战斗数据类型
enum E_BATTLE_DATA_TYPE
{
	BATTLE_DATA_UNKNOWN = 0;
	BATTLE_DATA_RECORD     = 1;//战斗记录
	BATTLE_DATA_IN_BATTLE  = 2;//战斗中信息
}


//2101请求公会战信息
message ReqGuildWarInfo
{

}
//2102返回公会战信息
message ResGuildWarInfo
{
    		 GuildSummaryInfo                  guildInfo = 1;//公会基本信息
			 GuildWarBaseInfo                   baseInfo = 2;//公会战基本信息
			 WarStageInfo                      stageInfo = 3;//正在挑战的关卡信息
			 int32                              remCount = 4;//剩余挑战次数
			 WarPromptInfo                    promptInfo = 5;//赛季提示信息
			 int32                              activity = 6;//每日活跃
	repeated WarBattleInfo                  battleRecord = 7;//最近10条战斗记录
	         bool                                passAll = 8;//全部通关
	         bool                                request = 9;//是否客户端主动请求
	repeated InBattleInfo                   inBattleInfo = 10;//最近30条战斗中信息
}

//2103请求刷新战斗数据
message ReqRefreshBattleInfo
{
	
}
//2104请求刷新战斗数据
message ResRefreshBattleInfo
{
	repeated WarBattleInfo                  battleRecord = 1;//最近10条战斗记录
	repeated InBattleInfo                   inBattleInfo = 2;//最近30条战斗中信息
}


//2111请求讨伐资讯
message ReqWarAdvisory
{
	
}
//2112返回讨伐资讯
message ResWarAdvisory
{
	repeated WarStageInfo             stageInfo = 1;//关卡信息列表
}

//2113请求伤害报告
message ReqHurtReport
{
	int32                               stageId = 1;//关卡ID
	int32                                 round = 2;//所属周目
}
//2114返回伤害报告
message ResHurtReport
{
             int32                       stageId = 1;//关卡ID
             int32                         round = 2;//所属周目
	repeated HurtReportInfo           hurtReport = 3;//伤害报告列表
}


//2121请求公会天赋
message ReqGuildTalent
{
	
}
//2122返回公会天赋
message ResGuildTalent
{
	repeated GuildTalentInfo                  talentInfo = 1;//激活的天赋信息
	         int32                             invTalent = 2;//当前赛季总投入天赋点数
}

//2123请求升级/激活天赋
message ReqUpTalent
{
	int32	                                    talentId = 1;//天赋ID
}
//2124返回升级/激活天赋
message ResUpTalent
{
	int32                                      invTalent = 1;//当前赛季总投入天赋点数
	GuildTalentInfo                           talentInfo = 2;//激活的天赋信息
}

//2125请求公会天赋重置
message ReqTalentReset
{
}
//2126返回公会天赋重置
message ResTalentReset
{
	bool                                         success = 1;
}


//2131请求公会战奖励
message ReqWarReward
{
	
}
//2132返回公会战奖励
message ResWarReward
{
	repeated WarRewardInfo                    rewardInfo = 1;//奖励列表
}

//2133请求领取公会战奖励
message ReqGetWarReward
{
	int32                                       rewardId = 1;//奖励ID
}
//2134返回领取公会战奖励
message ResGetWarReward
{
	int32                                       rewardId = 1;//奖励ID
}


//2141请求支援信息
message ReqSupportInfo
{
	
}
//2142返回支援信息
message ResSupportInfo
{
	repeated CommonObject                   supportCards = 1;//设置支援的卡牌（id=卡牌ID value=位置）
	         int32                          supportTimes = 2;//今日支援次数
	         int32                              curCanRw = 3;//当前可领取的数量
	         int32                               todayRw = 4;//今日已领取的数量
}

//2143请求支援设置
message ReqSupportSet
{
	int32                                         cardID = 1;//设置支援的卡牌ID
	GUILD_WAR_SUPPORT                               type = 2;//操作类型
	int32                                            pos = 3;//位置（从0开始，目前只有两个）
}
//2144返回支援设置
message ResSupportSet
{
	int32                                         cardID = 1;//设置支援的卡牌ID
	GUILD_WAR_SUPPORT                               type = 2;//操作类型
	int32                                            pos = 3;//位置
}

//2145请求领取支援钻石
message ReqSupportHarvest
{
	
}
//2146返回领取支援钻石
message ResSupportHarvest
{
	int32                              			curCanRw = 1;//当前可领取的数量
	int32                                        todayRw = 2;//今日已领取的数量       
}


//2151请求公会赛季排行
message ReqGSeasonRank
{
	int32                                           page = 1;//分页
	bool                                      lastSeason = 2;//是否请求上赛季
}
//2152返回公会赛季排行
message ResGSeasonRank
{
	repeated GsRankInfo                           gsRank = 1;//公会赛季排行列表
			 int32                                myRank = 2;//本公会排名
			 int64         			            integral = 3;//赛季积分
			 int32                                  page = 4;//分页
			 bool                             lastSeason = 5;//是否请求上赛季
			 int32                              pageSize = 6;//每页容量
}

//2153请求成员赛季排行
message ReqMSeasonRank
{
	bool                                      lastSeason = 1;//是否请求上赛季
}
//2154返回成员赛季排行
message ResMSeasonRank
{
	repeated MsRankInfo                           msRank = 1;//公会赛季排行列表
	bool                                      lastSeason = 2;//是否请求上赛季
}

//2161请求进入关卡
message ReqInGuildStage
{
             int32                               stageId = 1;//关卡ID
	         bool                                    sim = 2;//是否模拟战
}
//2162返回进入关卡
message ResInGuildStage
{
             int32                               stageId = 1;//关卡ID
	repeated SupportObject                     cardGroup = 2;//布阵卡组
	repeated SupportCardInfo                 supportCard = 3;//支援卡牌列表
	         WarStageInfo                      stageInfo = 4;//关卡信息
	         bool                                    sim = 5;//是否模拟战
	repeated int32                             canNotUse = 6;//不能使用的自己的卡牌ID
	repeated int32                             aliveBoss = 7;//活着的BOSS怪物列表
}

//2163请求进入战斗
message ReqInGuildWar
{
             int32                               stageId = 1;//关卡ID
	repeated SupportObject                     cardGroup = 2;//布阵卡组
	         bool                                    sim = 3;//是否模拟战
}
//2164返回进入战斗
message ResInGuildWar
{

}

//2165请求结算战斗
message ReqSettleGuildWar
{
	BattleCompleteData                battleCompleteData = 1;//战斗数据
	bool                                             sim = 2;//是否模拟战
}
//2166返回结算战斗
message ResSettleGuildWar
{
			 int32                               stageId = 1;//关卡ID
	         bool                                success = 2;//挑战是否成功
	repeated SupportObject                     cardGroup = 3;//卡组
	         int64                                  hurt = 4;//本次造成伤害
	         int64                                bossHp = 5;//BOSS当前剩余血量
	         int32                              integral = 6;//本次积分
	repeated GoodsObject                         stageRw = 7;//通关奖励
	         WAR_SETTLE_TYPE                        type = 8;//结算类型
}

//公会战结算类型枚举
enum WAR_SETTLE_TYPE
{
	DEFAULT_SETTLE_TYPE      = 0;//
	SIMULATION               = 1;//模拟战
	MURDERER                 = 2;//击杀BOSS
	PASSED                   = 3;//已通关
}



//1301手账初始化
message ReqHandbookInit
{
}
//1302手账初始化
message ResHandbookInit
{
	int32 cardId      							= 1;
	int32 fashionId                             = 2;
	int32 intimacyLv  							= 3;
}

//幕间关卡信息
message CGCopyStage
{
	int32 stageId								= 1;//ID
	bool status       							= 2;//状态（是否已 首通/领取奖励/播放剧情）
}

//1303请求幕间物语信息
message ReqCGCopyInfo
{
	int32 cardId      							= 1;//卡牌ID
}
//1304返回幕间物语信息
message ResCGCopyInfo
{
			 int32 cardId      					= 1;//卡牌ID
	repeated CGCopyStage stageList				= 2;//关卡列表
	repeated CommonObject cardList   			= 3;//默认卡组
}

//1305请求幕间物语关卡
message ReqCGCopyStage
{
	int32 stageId								= 1;//关卡ID
}
//1306返回幕间物语关卡
message ResCGCopyStage
{
	CGCopyStage stageInfo						= 1;//关卡信息
}



//1307
message ReqStoryCopyGetCG
{
	
}
//1308返回剧情副本CG奖励
message ResStoryCopyGetCG
{
	int32 CGId = 1;
}



//CG信息
message CGInfo
{
	int32 CGId = 1;//id
	bool isNew = 2;//是否是新的未打开过的
}
//1309已收集的CG列表
message ReqCGList
{
}
//1310已收集的CG列表
message ResCGList
{
	repeated CGInfo	CGList = 1;
}

//手信信息
message LetterInfo
{
	int32 letterId = 1;//id
	bool isNew = 2;//是否是新的未打开过的
}
//1311已获得的手信
message ReqHandLetterList
{
}
//1312已获得的手信
message ResHandLetterList
{
	repeated LetterInfo	letterList = 1;
}


//1313
message ReqAdventureStoryChapter
{
	E_BATTLE_TYPE	battleType = 1;
}
//1314
message ResAdventureStoryChapter
{
	E_BATTLE_TYPE	battleType = 1;
	repeated int32	chapterId  = 2;
	repeated PointPlotInfo pointPlotInfo        = 3;//积分解锁的剧情数据
}

//1315
message ReqAdventureStoryStage
{
	int32	chapterId = 1;//章节ID
}
//1316
message ResAdventureStoryStage
{
	repeated int32	stageId = 1;
}

//亲密度道具信息
message IntimacyPropInfo
{
	int32 propId 				= 1;
	int32 usedNum 				= 2;
}

//1317
message ReqIntimacyInfo
{
	int32	cardId = 1;//卡牌ID
}
//1318
message ResIntimacyInfo
{
	int32 cardId                  = 1;
	int32 lv                      = 2;
	int32 exp                     = 3;
	repeated IntimacyPropInfo IntimacyPropList  = 4;//亲密度道具信息列表
	bool isSync					  = 5;//是否主动推送
}

//1319请求进入幕间副本关卡
message ReqInCGCopyStage
{
	int32 stageId   							= 1;//关卡ID
	repeated CommonObject cardList	    		= 2;//布阵卡组
}

//1320返回进入幕间副本关卡
message ResInCGCopyStage
{
	int32 stageId                         		= 1;//进入关卡id
	bool into                        			= 2;//是否可以进入
	repeated CommonObject cardList   			= 3;//布阵卡组
}

//1321请求结算幕间副本关卡
message ReqSettleCGCopyStage
{
	BattleCompleteData battleCompleteData    	= 1;//战斗数据
}

//1322返回结算幕间副本关卡
message ResSettleCGCopyStage
{
	CGCopyStage stageInfo						= 1;//关卡信息
	bool isFirst                     			= 2;//是否首通
	bool success                 				= 3;//挑战是否成功
	repeated CommonObject cardInfo	 			= 4;//卡组
	repeated GoodsObject firstGoods  			= 5;//首通奖励
}

//幕间摘要信息
message CGCopySummary
{
	int32 cardId								= 1;//卡牌ID
	int32 stageCmp								= 2;//通关数量
}

//1323请求幕间摘要信息
message ReqCGCopySummary
{
	int32 type 									= 1;//请求类型：1幕间物语    2关系一览
}
//1324返回幕间摘要信息
message ResCGCopySummary
{
	repeated CGCopySummary cgCopyList			= 1;//摘要信息列表
}

//1325请求切换卡牌
message ReqSwitchCard
{
	int32 cardId								= 1;//原卡牌ID
	int32 direction								= 2;//方向（-1：向左   1：向右）
}
//1326返回切换卡牌
message ResSwitchCard
{
	int32 cardId      							= 1;//新卡牌ID
	int32 fashionId                             = 2;//模型ID
	int32 intimacyLv  							= 3;//亲密度等级
}

//1327请求打开CG
message ReqOpenCG
{
	int32 CGId									= 1;//id
}
//1328返回打开CG
message ResOpenCG
{

}

//1329请求打开手信
message ReqOpenLetter
{
	int32 letterId								= 1;//id
}
//1330返回打开手信
message ResOpenLetter
{

}


//积分解锁的剧情信息
message PointPlotInfo
{
	int32 plotId 				                = 1;//剧情ID（ID为HandbookAdventureChapterConfig中的ID）
	int32 point 				                = 2;//当前积分
	bool click                                  = 3;//是否已查看（查看过后设为true）
}

//1331请求查看新解锁剧情（new=false时不要再请求该剧情ID）
message ReqClickPointPlot
{
	int32 plotId 				                = 1;//剧情ID
}
//1332返回查看新解锁剧情
message ResClickPointPlot
{
	
}




//1201 请求读取邮件内容
message ReqReadMail
{
	int32 id 								= 1;//邮件ID
}

//1202 返回读取邮件内容
message ResReadMail
{
	
}

//1203 请求邮件详细信息
message ReqMailDetail
{
	
}

//1204 返回邮件详细信息
message ResMailDetail
{
	MailDetailInfo detailInfo				= 1;//邮件详细信息
}

//1205 请求邮件列表
message ReqMailList
{
	
}

//1206 返回邮件列表
message ResMailList
{
	repeated MailSummaryInfo mailList       = 1;//邮件摘要列表
}

//1207 请求领取邮件附件
message ReqGetMailAnnex
{
	int32 id								= 1;//请求领取的邮件ID（-1为全部领取）
}

//1208 返回领取邮件附件
message ResGetMailAnnex
{
	repeated MailSummaryInfo mailList       = 1;//被领取的邮件摘要列表
	         bool           vitFailed       = 2;//体力附件领取失败
}

//1209 请求删除邮件
message ReqDeleteMail
{
	int32 id								= 1;//请求删除的邮件ID
}

//1210 返回删除邮件
message ResDeleteMail
{
	int32 id								= 1;//删除的邮件ID
}

//1211 请求未领取附件的预约邮件
message ReqRegisterMail
{
	
}

//1212 返回未领取附件的预约邮件
message ResRegisterMail
{
	int32 id								= 1;//未领取附件的预约邮件ID
}


enum E_MSG_TYPE
{
	MsgType_Unknown             = 0;//
	MsgType_System              = 100;//系统类消息
	MsgType_Player              = 200;//玩家类型消息
	MsgType_Bag                 = 300;//背包类消息
	MsgType_Card                = 400;//卡牌类消息
	MsgType_Challenge           = 500;//挑战相关
	MsgType_Play                = 600;//活动相关
	MsgType_Battle              = 700;//战斗相关
	MsgType_Shop                = 800;//商店相关
	MsgType_Boon                = 900;//抽奖相关
	MsgType_GM                  = 1000;//GM
	MsgType_Task				= 1100;//任务相关
	MsgType_Mail				= 1200;//邮件相关
	MsgType_Handbook            = 1300;//手账相关
	MsgType_Adventure           = 1400;//大冒险相关
	MsgType_Guild               = 1500;//公会相关
	MsgType_Chat                = 1600;//聊天
	MsgType_Activity		    = 1700;//活动相关
	MsgType_Function		    = 1800;//功能开关
	MsgType_RedDot		        = 1900;//红点相关
	MsgType_Pay				    = 2000;//支付相关
	MsgType_GuildWar			= 2100;//公会战
	MsgType_Friend              = 2200;//好友
	MsgType_Family              = 2300;//家园
	MsgType_Risk                = 2400;//冒险
}

enum E_MSG_ID
{
	Unknown						        = 0;  //不使用,proto3枚举首项值必为0
	System_ReqRegister	            	= 101;//
	System_ResRegister	            	= 102;//注册
	
	System_ReqLogin                     = 103;//登录
	System_ResLogin                     = 104;//登录
	
	System_ReqPing                      = 105;//心跳
	System_ResPing                      = 106;//心跳
	
	System_ReqOverture                  = 107;//序章日志
	System_ResOverture                  = 108;//序章日志
	
	System_ResAlert                     = 198;//弹出信息

	
	
	Player_ReqDetailInfo                = 201;//玩家基本信息
	Player_ResDetailInfo                = 202;//玩家基本信息
	
	Player_ReqGoodsChange               = 203;//物品获得或者消耗
	Player_ResGoodsChange               = 204;//物品获得或者消耗
	
	Player_ReqChat						= 205;//聊天
	Player_ResChat						= 206;//聊天
	
	Player_ReqLogout					= 207;//登出
	Player_ResLogout					= 208;//登出
	
	Player_ReqSet						= 209;//设置玩家一些信息
	Player_ResSet						= 210;//设置玩家一些信息
	
	Player_ReqTalentInit                = 211;//天赋信息
	Player_ResTalentInit                = 212;//天赋信息
	
	Player_ReqTalentTreeStarUp          = 213;//天赋树升星
	Player_ResTalentTreeStarUp          = 214;//天赋树升星
	
	Player_ReqTalentLevelUp             = 215;//天赋升级
	Player_ResTalentLevelUp             = 216;//天赋升级
	
	Player_ReqTalentTreeEnergyUp        = 217;//天赋树星能升级
	Player_ResTalentTreeEnergyUp        = 218;//天赋树星能升级
	
	Player_ReqSetYjCode                 = 219;//设置引继码
	Player_ResSetYjCode                 = 220;//设置引继码

	Player_ReqNormalGuide               = 221;//请求普通引导
	Player_ResNormalGuide               = 222;//返回普通引导

	Player_ReqImageGuide                = 223;//请求图片引导
	Player_ResImageGuide                = 224;//返回图片引导
	
	Player_ReqMatrixTreeInfo            = 225;//所有的法阵信息
	Player_ResMatrixTreeInfo            = 226;
	
	Player_ReqMatrixInfo                = 227;//单个阵位信息
	Player_ResMatrixInfo                = 228;
	
	Player_ReqActivateMatrixNode        = 229;//激活节点
	Player_ResActivateMatrixNode        = 230;
	
	Player_ReqLevelUpMatrixSeal         = 231;//升级封印
	Player_ResLevelUpMatrixSeal         = 232;

	Player_ReqSaveNormalGuide           = 233;//请求保存普通引导
	Player_ResSaveNormalGuide           = 234;//返回保存普通引导
	
	Player_ReqUpgradeAccount            = 235;//升级账号
	Player_ResUpgradeAccount            = 236;//升级账号

	Player_ReqGetBindReward             = 237;//请求领取绑定账号奖励
	Player_ResGetBindReward             = 238;//返回领取绑定账号奖励
 
	Player_ReqPlayerLevelUp             = 239;//
	Player_ResPlayerLevelUp             = 240;//升级通知
	
	Player_ReqHorseSet                  = 241;//设置跑马灯信息
	Player_ResHorseSet                  = 242;//设置跑马灯信息

	Player_ReqGiftCode                  = 243;//礼包码
	Player_ResGiftCode                  = 244;//礼包码

	Player_ReqAddEquipScheme            = 245;//添加装备方案
	Player_ResAddEquipScheme            = 246;//添加装备方案
	
	Player_ReqEquipScheme               = 247;//获取装备方案
	Player_ResEquipScheme               = 248;//
	
	Player_ReqRemoveEquipScheme         = 249;//删除装备方案
	Player_ResRemoveEquipScheme         = 250;//
	
	Player_ReqUpdateEquipSchemeName     = 251;//修改装备方案名
	Player_ResUpdateEquipSchemeName     = 252;//修改装备方案名
	
	Player_ReqUseEquipScheme            = 253;//使用方案
	Player_ResUseEquipScheme            = 254;//使用方案

	Player_ReqHeadData                  = 255;//请求头像数据
	Player_ResHeadData                  = 256;//返回头像数据

	Player_ReqPushSet                   = 257;//推送设置
	Player_ResPushSet                   = 258;//推送设置


	Bag_ReqUseProp                      = 301;//使用道具
	Bag_ResUseProp                      = 302;//使用道具
	
	Bag_ReqSellProp						= 303;//出售
	Bag_ResSellProp						= 304;//出售
	
	Bag_ReqPutOnEquip                   = 305;//穿装备
	Bag_ResPutOnEquip                   = 306;//穿装备
	
	Bag_ReqLevelUpEquip                 = 307;//装备升级
	Bag_ResLevelUpEquip                 = 308;//装备升级
	
	Bag_ReqDestroyEquip                 = 309;//分解装备
	Bag_ResDestroyEquip                 = 310;//分解装备
	
	Bag_ReqLockEquip                    = 311;//锁定装备
	Bag_ResLockEquip                    = 312;//锁定装备
	
	Bag_ReqExchangeDebris               = 313;//兑换碎片
	Bag_ResExchangeDebris               = 314;//兑换碎片
	
	Bag_ReqIdentifyEquip                = 315;//鉴定装备
	Bag_ResIdentifyEquip                = 316;//鉴定装备

	Bag_ReqTitleList                    = 317;//请求称号列表
	Bag_ResTitleList                    = 318;//返回称号列表

	Bag_ReqWearTitle                    = 319;//请求佩戴称号
	Bag_ResWearTitle                    = 320;//返回佩戴称号

	Bag_ReqFashionList                  = 321;//请求皮肤列表
	Bag_ResFashionList                  = 322;//返回皮肤列表
	 
	
	
	Card_ReqLevelUp                     = 401;//卡牌升级
	Card_ResLevelUp                     = 402;//卡牌升级
	
	Card_ReqQualityUp					= 403;//卡牌升品
	Card_ResQualityUp					= 404;//卡牌升品
	
	Card_ReqSkillUp                     = 405;//角色技能升级
	Card_ResSkillUp                     = 406;//角色技能升级
	
	Card_ReqStarUp						= 407;//卡牌升星
	Card_ResStarUp						= 408;//卡牌升星
	
	Card_ResUpdateInfo                  = 410;//更新卡牌信息
	
	Card_ReqSetFashion                  = 411;//设置卡牌形象
	Card_ResSetFashion                  = 412;//设置卡牌形象
	
	Card_ReqSetHandbookCover            = 413;//设置手账封面角色
	Card_ResSetHandbookCover			= 414;//设置手账封面角色
	
	Card_ReqSetMainCover                = 415;//设置主页封面
	Card_ResSetMainCover                = 416;//设置主页封面
	
	Card_ReqActivateFetter              = 417;//激活羁绊
	Card_ResActivateFetter              = 418;//激活羁绊

    Card_ReqBirthdayList                = 419;//请求卡牌生日列表（登录请求）
	Card_ResBirthdayList                = 420;//返回卡牌生日列表
	
	Card_ReqBirthdayReward              = 421;//请求领取卡牌生日奖励
	Card_ResBirthdayReward              = 422;//返回领取卡牌生日奖励

	Card_ReqSealOpen                    = 431;//请求开启印文
	Card_ResSealOpen                    = 432;//返回开启印文

	Card_ReqSealData                    = 433;//请求印文数据
	Card_ResSealData                    = 434;//返回印文数据

	Card_ReqSealUp                      = 435;//请求印文升级
	Card_ResSealUp                      = 436;//返回印文升级

	Card_ReqSealSkillAc                 = 437;//请求印文技能激活
	Card_ResSealSkillAc                 = 438;//返回印文技能激活

	Card_ReqSealSkillUp                 = 439;//请求印文技能升级
	Card_ResSealSkillUp                 = 440;//返回印文技能升级

	
	Challenge_ReqStoryInit              = 501;//剧情(英雄)副本初始化
	Challenge_ResStoryInit              = 502;//剧情(英雄)副本初始化
	
	Challenge_ReqStoryReward            = 503;//领取奖励(只针对战斗类型之外的关卡)
	Challenge_ResStoryReward            = 504;//领取奖励(只针对战斗类型之外的关卡)
	
	Challenge_ReqStorySweep             = 505;//剧情(英雄)扫荡
	Challenge_ResStorySweep             = 506;//剧情(英雄)扫荡
	
	Challenge_ReqEmbattle               = 507;//剧情(英雄)布阵
	Challenge_ResEmbattle               = 508;//剧情(英雄)布阵
	
	Challenge_ReqTempleInit             = 582;//神殿遗迹初始化
	Challenge_ResTempleInit             = 583;//神殿遗迹初始化
	
	Challenge_ReqInStage                = 509;//进入剧情(英雄)关卡
	Challenge_ResInStage                = 510;//进入剧情(英雄)关卡
	
	Challenge_ReqSettleStage            = 511;//剧情(英雄)关卡结算
	Challenge_ResSettleStage            = 512;//剧情(英雄)关卡结算
	
	Challenge_ReqTrialInit              = 513;//初始化挑战副本
	Challenge_ResTrialInit              = 514;//初始化挑战副本
	
	Challenge_ReqInTrial                = 515;//进入挑战副本
	Challenge_ResInTrial                = 516;//进入挑战副本
	
	Challenge_ReqSweepTrial             = 580;//挑战关卡扫荡
	Challenge_ResSweepTrial             = 581;
	
	Challenge_ReqSettleTrial            = 517;//挑战副本结算
	Challenge_ResSettleTrial            = 518;//挑战副本结算
	
	Challenge_ReqArenaData              = 519;//请求竞技场数据
	Challenge_ResArenaData              = 520;
	
	Challenge_ReqArenaFight             = 521;//请求竞技场战斗
	Challenge_ResArenaFight             = 522;//竞技场战斗结算
	
	Challenge_ReqArenaRefresh           = 523;//请求竞技场刷新
	Challenge_ResArenaRefresh           = 524;//竞技场刷新次数
	
	Challenge_ReqArenaReward            = 525;//请求竞技场奖励
	Challenge_ResArenaReward            = 526;//竞技场奖励
	
	Challenge_ReqOldSetsTower           = 527;//设置老套装天之塔副本
	Challenge_ResOldSetsTower           = 528;
	
	Challenge_ReqArenaGuardCardGroups   = 531;//请求竞技场布阵防守阵容
	Challenge_ResArenaGuardCardGroups   = 532;//竞技场布阵防守阵容
	
	Challenge_ResNextChapterInfo        = 534;//发送下一章节信息
	
	Challenge_ReqExtraReward            = 535;//请求领取关卡额外奖励
	Challenge_ResExtraReward            = 536;//响应领取关卡额外奖励
	
	Challenge_ReqBattleRcord            = 537;//请求竞技场记录
	Challenge_ResBattleRcord            = 538;//响应竞技场记录
	
	Challenge_ReqArenaRank            	= 539;//请求竞技场排名
	Challenge_ResArenaRank            	= 540;//响应竞技场排名
	
	Challenge_ResUpdateRank             = 542;//更新竞技场排名
	
	Challenge_ReqFastSweep              = 543;//英雄关卡快速扫荡
	Challenge_ResFastSweep              = 544;//英雄关卡快速扫荡
	
	Challenge_ReqTowerInit              = 545;//初始化天之塔
	Challenge_ResTowerInit              = 546;//初始化天之塔

	Challenge_ReqInTower                = 547;//进入天之塔
	Challenge_ResInTower                = 548;//进入天之塔
	
	Challenge_ReqSettleTower            = 549;//天之塔结算
	Challenge_ResSettleTower            = 550;//天之塔结算
	
	Challenge_ReqExpedition             = 551;//请求远征数据
	Challenge_ResExpedition             = 552;//请求远征数据
	
	Challenge_ReqSetExpedition          = 553;//设置远征地图
	
	Challenge_ReqInExpedition           = 555;//进入远征地图 
	Challenge_ResInExpedition           = 556;//进入远征地图
	
	Challenge_ReqSettleExpedition       = 557;//远征关卡结算
	Challenge_ResSettleExpedition       = 558;//远征关卡结算
	
	Challenge_ReqShopExpeditionBuy      = 559;//远征购买关卡购买
	Challenge_ResShopExpeditionBuy      = 560;//远征购买关卡购买
	
	Challenge_ResShopExpedition         = 562;//远征商店关卡
	Challenge_ResBuffExpedition         = 564;//远征buff关卡
	
	Challenge_ReqDrawBuff               = 565;//领取远征buff
	Challenge_ResDrawBuff               = 566;//领取远征buff

	Challenge_ReqFinishStory            = 567;//完成剧情
	Challenge_ResFinishStory            = 568;//完成剧情
	
	Challenge_ReqCheckStoryFinish       = 569;//剧情是否已完成
	Challenge_ResCheckStoryFinish       = 570;//剧情是否已完成
	Challenge_ReqEncounterBattleEmba    = 571;//天之塔遭遇战布阵信息
	Challenge_ResEncounterBattleEmba    = 572;//天之塔遭遇战布阵信息
	Challenge_ReqInTowerEncounter       = 573;//进入天之塔遭遇战
	Challenge_ResInTowerEncounter       = 574;//进入天之塔遭遇战
	Challenge_ReqSettleEncounter        = 575;//结算天之塔遭遇战
	Challenge_ResSettleEncounter        = 576;//结算天之塔遭遇战
	Challenge_ReqCancelEncounter        = 577;//取消天之塔遭遇战
	Challenge_ResCancelEncounter        = 578;//取消天之塔遭遇战
	
	Challenge_ReqDeckScheme             = 591;//获取阵容方案
	Challenge_ResDeckScheme             = 592;//获取阵容方案
	
	Challenge_ReqAddOrUpdateDeckScheme  = 593;//修改,删除,新增阵容方案
	Challenge_ResAddOrUpdateDeckScheme  = 594;//修改,删除,新增阵容方案
	
	Challenge_ReqRandomMonsterGroupList = 595;//设置随机怪物组
	Challenge_ResRandomMonsterGroupList = 596;
	
	Challenge_ReqStageBuyNum            = 597;//关卡购买
	Challenge_ResStageBuyNum            = 598;
	
	Play_ReqPlayBuyNum                  = 601;//请求活动购买次数
	Play_ResPlayBuyNum                  = 602;//活动购买次数
	
	Play_ReqPlayClearCDTime             = 603;//请求活动清空cd
	Play_ResPlayClearCDTime             = 604;//活动清空cd
	
	
	Battle_ReqInitBattleData            = 701;//初始化战斗数据
	Battle_InitBattleData            	= 702;//初始化战斗数据
	Battle_BattleCompleteData			= 703;//竞技场战斗的初始化数据
	Battle_ReqBattleData                = 705;//请求战斗数据
	Battle_ResBattleData                = 706;//请求战斗数据
	Battle_ReqExitBattle                = 707;//请求退出战斗
	Battle_ResExitBattle                = 708;//请求退出战斗  
	
	Shop_ReqShopData                    = 801;//请求商店类型
	Shop_ResShopData					= 802;//商店类型
	
	Shop_ReqShopGridData                = 803;//请求商店格子
	Shop_ResShopGridData				= 804;//商店格子
	
	Shop_ReqShopReset                   = 805;//请求商店刷新
	Shop_ResShopReset 					= 806;//商店刷新
	
	Shop_ReqShopBuy                     = 807;//请求商店购买
	Shop_ResShopBuy                     = 808;//商店购买
	
	Shop_ReqGetBuyAssistNum             = 809;//获取资源购买次数
	Shop_ResGetBuyAssistNum             = 810;//返回资源购买次数
	
	Shop_ReqBuyAssist                   = 811;//资源购买
	Shop_ResBuyAssist                   = 812;//资源购买
	
	Boon_ReqLotteryInit                 = 901;//抽奖初始化
	Boon_ResLotteryInit                 = 902;//请求初始化
	
	Boon_ReqLotteryDraw                 = 903;//请求抽奖
	Boon_ResLotteryDraw					= 904;//请求抽奖
	
	Boon_ReqSignInInit                  = 905;//签到初始化
	Boon_ResSignInInit                  = 906;//签到初始化
	
	Boon_ReqSignIn                      = 907;//签到
	Boon_ResSignIn                      = 908;//签到 
	
	Boon_ReqSignInReward                = 909;//签到领取奖励
	Boon_ResSignInReward                = 910;//签到领取奖励
	
	Boon_ReqVitGetInit                  = 911;//体力领取初始化
	Boon_ResVitGetInit                  = 912;//体力领取初始化
	
	Boon_ReqVitGet                      = 913;//体力领取
	Boon_ResVitGet                      = 914;//体力领取

	Boon_ReqLoginAct                    = 915;//请求登录活动
	Boon_ResLoginAct                    = 916;//返回登录活动

	Boon_ReqLoginActGet                 = 917;//请求领取登录活动奖励
	Boon_ResLoginActGet                 = 918;//返回领取登录活动奖励
	
	Boon_ReqSlotsData                   = 919;//请求拉霸初始化数据
	Boon_ResSlotsData                   = 920;//返回拉霸初始化数据
	
	Boon_ReqSlotsReset                  = 921;//请求拉霸轮次重置
	Boon_ResSlotsReset                  = 922;//返回拉霸轮次重置
	
	Boon_ReqSlotsOperation              = 923;//开始拉霸
	Boon_ResSlotsOperation              = 924;//返回拉霸
	
	Boon_ReqActivityLottery             = 931;//所有活动扭蛋
	Boon_ResActivityLottery             = 932;//所有活动扭蛋
	
	Boon_ReqLotteryRecord               = 925;//扭蛋记录
	Boon_ResLotteryRecord               = 926;//扭蛋记录
	
	Boon_ReqInitConversion              = 927;//初始化扭蛋积分兑换
	Boon_ResInitConversion              = 928;//初始化扭蛋积分兑换
	
	Boon_ReqLotteryConversion           = 929;//扭蛋积分兑换
	Boon_ResLotteryConversion           = 930;//扭蛋积分兑换
	
	Boon_ReqSlotsRecord                 = 933;//拉霸记录
	Boon_ResSlotsRecord                 = 934;//拉霸记录
	
	GM_ReqGMLogin                       = 1001;//GM登录
	GM_ResGMLogin                       = 1002;//GM登录
	
	GM_ReqGMRegister                    = 1003;
	GM_ResGMRegister                    = 1004;
	
	GM_ReqGMList                        = 1005;
	GM_ResGMList                        = 1006;
	
	GM_ReqGMDel                         = 1007;
	GM_ResGMDel                         = 1008;
	
	GM_ReqGMUpdate                      = 1009;
	GM_ResGMUpdate                      = 1010;
	
	GM_ReqPlayerList                    = 1011;
	GM_ResPlayerList                    = 1012;
	
	GM_ReqPlayerInfo                    = 1013;
	GM_ResPlayerInfo                    = 1014;
	
	GM_ReqPlayerAddGoods                = 1015;
	GM_ResPlayerAddGoods                = 1016;
	
	GM_ReqGroupMail                     = 1017;
	GM_ResGroupMail                     = 1018;
	
	GM_ReqSendNotice                    = 1019;
	GM_ResSendNotice                    = 1020;
	
	GM_ReqGetConfig                     = 1021;
	GM_ResGetConfig                     = 1022; 
	
	GM_ReqServerList                    = 1023;
	GM_ResServerList                    = 1024;
	
	Task_ReqTaskData					= 1101;//请求任务数据
	Task_ResTaskData					= 1102;//返回任务数据

	Task_ReqSubmitTask					= 1103;//请求提交任务
	Task_ResSubmitTask					= 1104;//返回提交结果

	Task_ReqGetTaskBox					= 1105;//请求领取宝箱
	Task_ResGetTaskBox					= 1106;//返回领取宝箱


	Mail_ReqReadMail					= 1201;//请求读取邮件内容
	Mail_ResReadMail					= 1202;//返回读取邮件内容

	Mail_ReqMailDetail					= 1203;//请求邮件详细信息
	Mail_ResMailDetail					= 1204;//返回邮件详细信息

	Mail_ReqMailList					= 1205;//请求邮件列表
	Mail_ResMailList					= 1206;//返回邮件列表

	Mail_ReqGetMailAnnex				= 1207;//请求领取邮件附件
	Mail_ResGetMailAnnex				= 1208;//返回领取邮件附件
	
	Mail_ReqDeleteMail					= 1209;//请求删除邮件
	Mail_ResDeleteMail					= 1210;//返回删除邮件

	Mail_ReqRegisterMail			    = 1211;//请求未领取附件的预约邮件
	Mail_ResRegisterMail				= 1212;//返回未领取附件的预约邮件
	
	
	Handbook_ReqHandbookInit            = 1301;//手账初始化界面
	Handbook_ResHandbookInit            = 1302;//手账初始化界面
	
	HandBook_ReqCGCopyInfo              = 1303;//请求幕间物语信息
	HandBook_ResCGCopyInfo              = 1304;//返回幕间物语信息
	
	HandBook_ReqCGCopyStage       		= 1305;//请求幕间物语关卡
	Handbook_ResCGCopyStage       		= 1306;//返回幕间物语关卡
	
	Handbook_ReqStoryCopyGetCG       	= 1307;//
	Handbook_ResStoryCopyGetCG       	= 1308;//返回剧情副本CG奖励
	
	Handbook_ReqCGList                  = 1309;//已收集的CG列表
	Handbook_ResCGList                  = 1310;//已收集的CG列表
	
	Handbook_ReqHandLetterList          = 1311;//已获得的手信
	Handbook_ResHandLetterList          = 1312;//已获得的手信

	Handbook_ReqAdventureStoryChapter   = 1313;//冒险记录章节列表
	Handbook_ResAdventureStoryChapter   = 1314;//冒险记录章节列表
	
	Handbook_ReqAdventureStoryStage     = 1315;//冒险记录关卡列表
	Handbook_ResAdventureStoryStage     = 1316;//冒险记录关卡列表
	
	Handbook_ReqIntimacyInfo            = 1317;//亲密度信息
	Handbook_ResIntimacyInfo            = 1318;//亲密度信息

	Handbook_ReqInCGCopyStage        	= 1319;//请求进入幕间副本关卡
	Handbook_ResInCGCopyStage        	= 1320;//返回进入幕间副本关卡

	Handbook_ReqSettleCGCopyStage       = 1321;//请求结算幕间副本关卡
	Handbook_ResSettleCGCopyStage       = 1322;//返回结算幕间副本关卡

	Handbook_ReqCGCopySummary       	= 1323;//请求幕间摘要信息
	Handbook_ResCGCopySummary       	= 1324;//返回幕间摘要信息

	Handbook_ReqSwitchCard       		= 1325;//请求切换卡牌
	Handbook_ResSwitchCard       		= 1326;//返回切换卡牌

	Handbook_ReqOpenCG       			= 1327;//请求打开CG
	Handbook_ResOpenCG       			= 1328;//返回打开CG

	Handbook_ReqOpenLetter       		= 1329;//请求打开手信
	Handbook_ResOpenLetter       		= 1330;//返回打开手信

	Handbook_ReqClickPointPlot          = 1331;//请求查看新解锁剧情
	Handbook_ResClickPointPlot       	= 1332;//返回查看新解锁剧情
	
	
	Adventure_ReqAdventureInit          = 1401;//初始化大冒险
	Adventure_ResAdventureInit          = 1402;//初始化大冒险
	
	Adventure_ReqPlayDice               = 1403;//大冒险摇骰子
	Adventure_ResPlayDice               = 1404;//大冒险摇骰子
	
	Adventure_ReqWishReward             = 1405;//大冒险许愿
	Adventure_ResWishReward             = 1406;//大冒险许愿
	
	Adventure_ReqAdventureBuilding      = 1407;//大冒险建筑相关操作
	Adventure_ResAdventureBuilding      = 1408;//大冒险建筑
	
	Adventure_ReqAdventureEventReward   = 1409;//大冒险事件奖励
	Adventure_ResAdventureEventReward   = 1410;//大冒险事件奖励
	
	Adventure_ReqInAdventureBattleEmba  = 1411;//大冒险战斗布阵
	Adventure_ResInAdventureBattleEmba  = 1412;//大冒险战斗布阵
	
	Adventure_ReqSettleAdventureBattle  = 1413;//大冒险战斗结算
	Adventure_ResSettleAdventureBattle  = 1414;//大冒险战斗结算
	
	Adventure_ReqInitAdventureBattleEmba= 1415;//大冒险战斗布阵初始化
	Adventure_ResInitAdventureBattleEmba= 1416;//大冒险战斗布阵初始化
	
	
	Guild_ReqGuildList                  = 1501;//公会列表(未加入公会时)
	Guild_ResGuildList                  = 1502;//公会列表(未加入公会时)

	Guild_ReqSearchGuild                = 1503;//搜索公会
	Guild_ResSearchGuild                = 1504;//搜索公会

	Guild_ReqJoinGuild                  = 1505;//加入公会
	Guild_ResJoinGuild                  = 1506;//加入公会
	
	Guild_ReqCreateGuild                = 1507;//创建公会
	Guild_ResCreateGuild                = 1508;//创建公会

	Guild_ReqGuildDetailInfo            = 1511;//公会详情
	Guild_ResGuildDetailInfo            = 1512;//公会详情

	Guild_ReqSetGuildInfo               = 1513;//修改公会信息
	Guild_ResSetGuildInfo               = 1514;//修改公会信息

	Guild_ReqDisbandGuild              = 1515;//解散公会
	Guild_ResDisbandGuild              = 1516;//解散公会

	Guild_ReqQuitGuild                  = 1517;//退出公会
	Guild_ResQuitGuild                  = 1518;//退出公会

	Guild_ReqGuildMemberList            = 1519;//公会成员列表
	Guild_ResGuildMemberList            = 1520;//公会成员列表

	Guild_ReqSetGuildJob                = 1521;//设置公会成员的职位
	Guild_ResSetGuildJob                = 1522;//设置公会成员的职位
	
	Guild_ReqRemoveGuildMember          = 1523;//删除公会成员
	Guild_ResRemoveGuildMember          = 1524;//删除公会成员

	Guild_ReqGuildReview                = 1525;//公会审核
	Guild_ResGuildReview                = 1526;//公会审核
	
	Guild_ReqProcessApply               = 1527;//处理申请
	Guild_ResProcessApply               = 1528;//处理申请
	
	Guild_ReqGuildRank                  = 1529;//公会排行(只有加入公会后才能看到)
	Guild_ResGuildRank                  = 1530;//公会排行(只有加入公会后才能看到)
	
	Guild_ReqGuildBaseInfo              = 1531;//公会基本信息
	Guild_ResGuildBaseInfo              = 1532;//公会基本信息

	Guild_ReqGuildId           			= 1533;//更新玩家公会ID
	Guild_ResGuildId           			= 1534;//更新玩家公会ID
	
	Guild_ReqGuildBuildInit             = 1535;//公会建设信息初始化
	Guild_ResGuildBuildInit             = 1536;//公会建设信息初始化
	
	Guild_ReqGuildBuild                 = 1537;//公会建设
	Guild_ResGuildBuild                 = 1538;//公会建设

	Guild_ReqGuildGiftInit              = 1539;//公会馈礼信息初始化
	Guild_ResGuildGiftInit              = 1540;//公会馈礼信息初始化
	
	Guild_ReqGuildGiftGet               = 1541;//公会馈礼获取
	Guild_ResGuildGiftGet               = 1542;//公会馈礼获取
	
	Guild_ReqGuildGiftRank              = 1543;//公会馈礼排行
	Guild_ResGuildGiftRank              = 1544;//公会馈礼排行
	
	Guild_ReqGuildGameInit              = 1545;//猜杯子游戏初始化
	Guild_ResGuildGameInit              = 1546;//猜杯子游戏初始化

	Guild_ReqBeginGuildGame             = 1547;//开始猜杯子
	Guild_ResBeginGuildGame             = 1548;//开始猜杯子
	
	Guild_ReqGuildGamePlay              = 1549;//猜杯子
	Guild_ResGuildGamePlay              = 1550;//猜杯子
	
	Guild_ReqGuildGameReset             = 1551;//猜杯子重置
	Guild_ResGuildGameReset             = 1552;//猜杯子重置

	Guild_ReqGuildGameRecord            = 1553;//猜杯子记录
	Guild_ResGuildGameRecord            = 1554;//猜杯子记录

	Guild_ReqGuildLog            		= 1555;//推送公会日志
	Guild_ResGuildLog            		= 1556;//推送公会日志

	Guild_ReqGuildPK                    = 1557;//请求切磋
	Guild_ResGuildPK                    = 1558;//返回切磋

	Guild_ReqInGuildPK                  = 1559;//请求进入战斗
	Guild_ResInGuildPK               	= 1560;//返回进入战斗

	Guild_ReqSettleGuildPK              = 1561;//请求结算战斗
	Guild_ResSettleGuildPK              = 1562;//返回结算战斗

	Guild_ReqSyncGuildData              = 1563;//同步公会数据
	Guild_ResSyncGuildData              = 1564;//同步公会数据

	Guild_ReqPlayerCards                = 1565;//请求玩家卡牌
	Guild_ResPlayerCards                = 1566;//返回玩家卡牌

	Guild_ReqPopUpLevelUp               = 1567;//升级弹窗
	Guild_ResPopUpLevelUp               = 1568;//升级弹窗

	Guild_ReqGuildSummary               = 1569;//请求公会摘要信息
	Guild_ResGuildSummary               = 1570;//返回公会摘要信息

	Guild_ReqImpeachData                = 1571;//请求弹劾数据
	Guild_ResImpeachData                = 1572;//返回弹劾数据

	Guild_ReqVoting                     = 1573;//请求参与投票
	Guild_ResVoting                     = 1574;//返回参与投票


	Chat_ReqSetChat                     = 1601;//发送聊天消息
	Chat_ResSetChat                     = 1602;//接收聊天消息
	Chat_ReqSetAccpetChat               = 1603;//设置能否接收消息
	Chat_ResSetAccpetChat               = 1604;//设置能否接收消息
	Chat_ReqGetChat                     = 1605;//获取消息列表
	Chat_ResGetChat                     = 1606;//获取消息列表
	Chat_ReqGetCardChat                 = 1607;//卡牌评论
	Chat_ResGetCardChat                 = 1608;
	Chat_ReqClickLike                   = 1609;//卡片点赞
	Chat_ResClickLike                   = 1610;
	Chat_ReqGetLikeCard                 = 1611;//获取收藏卡牌列表
	Chat_ResGetLikeCard                 = 1612;
	Chat_ReqSetLikeCard                 = 1613;//设置收藏卡牌
	Chat_ResSetLikeCard                 = 1614;
	Chat_ReqMyClickLikeRemark           = 1615;//获取玩家点赞的评论id,用于客户端高亮显示
	Chat_ResMyClickLikeRemark           = 1616;
	
	
	Activity_ReqActivityList            = 1701;//请求活动列表
	Activity_ResActivityList            = 1702;//返回活动列表

	Activity_ReqActivityInfo            = 1703;//请求活动信息
	Activity_ResActivityInfo            = 1704;//返回活动信息

	Activity_ReqDecActivity			    = 1705;//活动过期
	Activity_ResDecActivity			    = 1706;//活动过期

	Activity_ReqTaskGroup               = 1707;//请求任务组
	Activity_ResTaskGroup               = 1708;//返回任务组

	Activity_ReqTaskReward			    = 1709;//请求领取任务奖励
	Activity_ResTaskReward			    = 1710;//返回领取任务奖励

	Activity_ReqPointReward			    = 1711;//请求领取积分奖励
	Activity_ResPointReward			    = 1712;//返回领取积分奖励

	Activity_ReqGetReward			    = 1713;//请求领取活动奖励
	Activity_ResGetReward			    = 1714;//返回领取活动奖励

	Activity_ReqActivityInfoList	    = 1715;//请求活动基本信息列表
	Activity_ResActivityInfoList		= 1716;//返回活动基本信息列表

	Activity_ReqBannerIdList			= 1731;//请求Banner活动ID列表
	Activity_ResBannerIdList			= 1732;//返回Banner活动ID列表

	Activity_ReqSaveBannerId			= 1733;//请求保存Banner活动ID
	Activity_ResSaveBannerId			= 1734;//返回保存Banner活动ID

	Activity_ReqRemoveBannerId			= 1735;//请求删除Banner活动ID
	Activity_ResRemoveBannerId			= 1736;//返回删除Banner活动ID


	Function_ReqFunctionList            = 1801;//请求已开启功能ID列表
	Function_ResFunctionList            = 1802;//返回已开启功能ID列表

	Function_ReqOpenFunction            = 1803;//请求开启功能
	Function_ResOpenFunction            = 1804;//返回开启功能


	RedDot_ReqRedDotList  			    = 1901;//请求红点列表
	RedDot_ResRedDotList  			    = 1902;//返回红点列表

	RedDot_ReqRemoveRedDot  		    = 1903;//请求删除红点
	RedDot_ResRemoveRedDot  		    = 1904;//返回删除红点

	RedDot_ReqAddRedDot  			    = 1905;//请求增加红点
	RedDot_ResAddRedDot  		        = 1906;//返回增加红点

	RedDot_ReqIntimacyLvChange  	    = 1907;//请求亲密度等级改变
	RedDot_ResIntimacyLvChange  	    = 1908;//返回亲密度等级改变

	RedDot_ReqGuideNotice			    = 1909;//引导提示
	RedDot_ResGuideNotice			    = 1910;//引导提示


	Pay_ReqPayCheck                     = 2001;//请求支付检查
	Pay_ResPayCheck                     = 2002;//返回支付检查

	Pay_ReqPayData                      = 2003;//请求支付数据
	Pay_ResPayData                      = 2004;//返回支付数据

	Pay_ReqGetMoonReward                = 2005;//请求领取月卡奖励
	Pay_ResGetMoonReward                = 2006;//返回领取月卡奖励

	Pay_ReqPaySuccess                   = 2007;//请求充值成功
	Pay_ResPaySuccess                   = 2008;//返回充值成功


	GuildWar_ReqGuildWarInfo               = 2101;//请求公会战信息
	GuildWar_ResGuildWarInfo               = 2102;//返回公会战信息

	GuildWar_ReqRefreshBattleInfo          = 2103;//请求刷新战斗数据
	GuildWar_ResRefreshBattleInfo          = 2104;//返回刷新战斗数据

	GuildWar_ReqWarAdvisory                = 2111;//请求讨伐资讯
	GuildWar_ResWarAdvisory                = 2112;//返回讨伐资讯

	GuildWar_ReqHurtReport                 = 2113;//请求伤害报告
	GuildWar_ResHurtReport                 = 2114;//返回伤害报告

	GuildWar_ReqGuildTalent                = 2121;//请求公会天赋
	GuildWar_ResGuildTalent                = 2122;//返回公会天赋

	GuildWar_ReqUpTalent                   = 2123;//请求升级/激活天赋
	GuildWar_ResUpTalent                   = 2124;//返回升级/激活天赋

	GuildWar_ReqTalentReset                = 2125;//请求公会天赋重置
	GuildWar_ResTalentReset                = 2126;//返回公会天赋重置

	GuildWar_ReqWarReward                  = 2131;//请求赛季奖励信息
	GuildWar_ResWarReward                  = 2132;//返回赛季奖励信息

	GuildWar_ReqGetWarReward               = 2133;//请求领取赛季奖励
	GuildWar_ResGetWarReward               = 2134;//返回领取赛季奖励

	GuildWar_ReqSupportInfo                = 2141;//请求支援信息
	GuildWar_ResSupportInfo                = 2142;//返回支援信息

	GuildWar_ReqSupportSet                 = 2143;//请求支援设置
	GuildWar_ResSupportSet                 = 2144;//返回支援设置

	GuildWar_ReqSupportHarvest             = 2145;//请求支援获得钻石
	GuildWar_ResSupportHarvest             = 2146;//返回支援获得钻石

	GuildWar_ReqGSeasonRank                = 2151;//请求公会赛季排行
	GuildWar_ResGSeasonRank                = 2152;//返回公会赛季排行

	GuildWar_ReqMSeasonRank                = 2153;//请求成员赛季排行
	GuildWar_ResMSeasonRank                = 2154;//返回成员赛季排行

	GuildWar_ReqInGuildStage               = 2161;//请求进入关卡
	GuildWar_ResInGuildStage               = 2162;//返回进入关卡

	GuildWar_ReqInGuildWar                 = 2163;//请求进入战斗
	GuildWar_ResInGuildWar                 = 2164;//返回进入战斗

	GuildWar_ReqSettleGuildWar             = 2165;//请求结算战斗
	GuildWar_ResSettleGuildWar             = 2166;//返回结算战斗

	
	Friend_ReqRelations                    = 2201;//请求好友关系数据
	Friend_ResRelations                    = 2202;//返回好友关系数据
	
	Friend_ReqSearch                       = 2211;//请求查找好友
	Friend_ResSearch                       = 2212;//返回查找结果
	
	Friend_ReqChangeRelation               = 2221;//请求改变好友关系
	Friend_ResChangeMyRelation             = 2222;//返回改变我的关系结果
	Friend_ResChangeFriendRelation         = 2223;//通知改变好友的关系结果
	
	Friend_ReqFriendInfo                   = 2231;//请求好友信息
	Friend_ResFriendInfo                   = 2232;//返回好友信息
	
	Friend_ResFriendState				   = 2241;//通知好友上线状态变化
	
	Friend_ReqFriendPK                     = 2251;//请求好友切磋
	Friend_ResFriendPK                     = 2252;//返回好友切磋
	
	Friend_ReqInFriendPK                   = 2261;//请求进入好友切磋
	Friend_ResInFriendPK               	   = 2262;//返回进入好友切磋

	Friend_ReqEndFriendPK                  = 2271;//请求结算好友切磋
	Friend_ResEndFriendPK                  = 2272;//返回结算好友切磋


	Family_ReqInFamily                     = 2301;//请求进入家园
	Family_ResInFamily                     = 2302;//返回进入家园

	Family_ReqSeedWarehouse                = 2303;//请求种子仓库
	Family_ResSeedWarehouse                = 2304;//返回种子仓库

	Family_ReqLandPlanting                 = 2305;//请求土地种植
	Family_ResLandPlanting                 = 2306;//返回土地种植

	Family_ReqLandHarvest                  = 2307;//请求土地收割
	Family_ResLandHarvest                  = 2308;//返回土地收割

	Family_ReqLandUproot                   = 2309;//请求土地铲除
	Family_ResLandUproot                   = 2310;//返回土地铲除

	Family_ReqLandUnlock                   = 2311;//请求土地解锁
	Family_ResLandUnlock                   = 2312;//返回土地解锁
	
	
	Family_ReqRoomInfo                     = 2351;//获取房屋信息
	Family_ResRoomInfo                     = 2352;//获取房屋信息
	
	Family_ReqRoomEnter                    = 2353;//角色入驻
	Family_ResRoomEnter                    = 2354;//角色入驻
	
	Family_ReqRoomLayout                   = 2355;//房间布置
	Family_ResRoomLayout                   = 2356;//房间布置
	
	Family_ReqRoomLevelUp                  = 2357;//房间升级
	Family_ResRoomLevelUp                  = 2358;//房间升级
	
	Family_ReqRoomCallOn                   = 2359;//好友拜访
	Family_ResRoomCallOn                   = 2360;//好友拜访
	
	Family_ReqRandomPlayerInfo             = 2361;//请求随机拜访玩家
	Family_ResRandomPlayerInfo             = 2362;//请求随机拜访玩家
	
	Family_ReqQuitRoom                     = 2363;//退出房间
	Family_ResQuitRoom                     = 2364;
	
	Risk_ReqRiskData                    = 2400;//请求冒险数据
	Risk_ResRiskData                    = 2401;//请求冒险数据
	
	Risk_ReqBeginRisk           	    = 2402;//开始冒险
	Risk_ResBeginRisk           	    = 2403;//开始冒险

	Risk_ReqEndRisk             	    = 2404;//结束冒险
	Risk_ResEndRisk             	    = 2405;//结束冒险
	
	Risk_ReqRiskDataInit         	    = 2406;//初始化冒险数据
	Risk_ResRiskDataInit        	    = 2407;//
	
	Risk_ReqAssistFightInit				= 2408;//初始化新活动副本协助战斗数据
	Risk_ResAssistFightInit				= 2409;
	
	Risk_ReqChallengeAssistFight		= 2410;//请求挑战协助战斗BOSS
	Risk_ResChallengeAssistFight		= 2411;//
	
	Risk_ReqSettleAssistFight			= 2412;//请求结算协助战斗BOSS
	Risk_ResSettleAssistFight			= 2413;//
	
	Risk_ReqGuildAssistData				= 2414;//请求公会协助数据
	Risk_ResGuildAssistData				= 2415;//
	
	Risk_ReqAssistGuildMember			= 2416;//请求协助公会成员战斗
	Risk_ResAssistGuildMember			= 2417;//
	
	Risk_ResAssistFightData				= 2418;//通知BOSS血量变化
	
	Risk_ReqNeedNoticeBossHP			= 2419;//请求保持通知BOSS血量变化
	Risk_ResNeedNoticeBossHP			= 2420;//
	
	Risk_ReqChallengeReward				= 2421;//请求领取挑战BOSS奖励
	Risk_ResChallengeReward				= 2422;//


}



//2001 请求充值检查
message ReqPayCheck
{
	string                   productId = 1;//商品ID
	float                       amount = 2;//充值金额
	string                      cParam = 3;//客户端自定义参数（不能为null或空字符串，未定义请使用 undefined，约定为 platform）
}
//2002 返回充值检查成功
//按此格式 sOrderId_sParam_cParam 放入SDK订单 sdk_pay_extend 参数中 发起SDK充值请求
message ResPayCheck
{
	string                    sOrderId = 1;//内部订单号
	string 					 productId = 2;//商品ID
	string 					    sParam = 3;//服务器自定义参数（约定为 mainServerId）
}

//商品信息
message ProductInfo
{
	string                   productId = 1;//商品ID
	int32                totalBuyCount = 2;//总购买次数
	int32                todayBuyCount = 3;//今日购买次数
	int32                 weekBuyCount = 4;//本周购买次数
	int32                monthBuyCount = 5;//本月购买次数
	bool 						   new = 6;//NEW标签
}

//总充值信息
message TotalPayInfo
{
	float                    payAmount = 1;//总充值金额
	int32           		payDiamond = 2;//总充值获得钻石数量
	int32          		   giveDiamond = 3;//总充值赠送获得钻石数量
	int64         		  firstPayTime = 4;//首充时间	
}

//每日充值信息
message DailyPayInfo
{
	float               todayPayAmount = 1;//今日充值金额
	int32              todayPayDiamond = 2;//今日充值获得钻石数量
	int32             todayGiveDiamond = 3;//今日充值赠送获得钻石数量
}

//月卡充值信息
message MoonPayInfo
{
	int32              resMoonBuyCount = 1;//资源月卡购买次数
	int32 			    resMoonSurplus = 2;//资源月卡剩余有效天数
	bool 				resMoonReceive = 3;//资源月卡当日奖励是否已领
	bool                     resCanBuy = 4;//资源月卡能否购买
	int32 			   diaMoonBuyCount = 5;//钻石月卡购买次数
	int32 			    diaMoonSurplus = 6;//钻石月卡剩余有效天数
	bool 				diaMoonReceive = 7;//钻石月卡当日奖励是否已领
	bool                     diaCanBuy = 8;//钻石月卡能否购买
}

//2003 请求充值数据
message ReqPayData
{
	bool                          login = 1;//是否登录时请求
}
//2004 返回充值数据
message ResPayData
{
	repeated ProductInfo    productList = 1;//商品信息列表
			 TotalPayInfo  totalPayInfo = 2;//总充值信息
			 DailyPayInfo  dailyPayInfo = 3;//每日充值信息
			 MoonPayInfo    moonPayInfo = 4;//月卡充值信息
    bool                          login = 5;//是否登录时请求
}

//2005 请求领取月卡奖励
message ReqGetMoonReward
{
	int32                      moonType = 1;//月卡类型
}
//2006 返回领取月卡奖励
message ResGetMoonReward
{
	int32                      moonType = 1;//月卡类型
	bool 				    moonReceive = 2;//奖励是否已领
}

//2007 请求充值成功
message ReqPaySuccess
{
	
}
//2008 返回充值成功
message ResPaySuccess
{
	string                   productId = 1;//商品ID
}


//请求活动次数购买 601
message ReqPlayBuyNum{
	int32 type     	= 1;//活动类型 (对应play表中的type)
	int32 amount	= 2;//购买次数
}

//响应活动次数购买 602
message ResPlayBuyNum{
	int32 type   = 1;//活动类型 
	int32  num   = 2;//剩余活动次数
	int32 buyNum = 3;//已购买次数
}


//请求清除活动cd时间 603
message ReqPlayClearCDTime{
	int32 type   = 1;//活动类型  (对应play表中的type)
}

//清理cd时间 604
message ResPlayClearCDTime{
				  int32 type     = 1;//活动类型 
	int64 lastArenaFightTime     = 2;//上一次竞技场战斗时间 清理之后 为0
}



//201玩家信息请求
message ReqDetailInfo
{	
}
message EquipObjectGroup
{
			 int32        page      = 1;
	repeated EquipObject  equipInfo = 2;//装备信息
}
message PropObjectGroup
{
			 int32        page      = 1;
	repeated PropObject   propInfo  = 2;//道具信息
}
 
//202玩家信息回复
message ResDetailInfo
{
			 BaseInfo	       baseInfo       = 1;//基本信息
	repeated CommonObject      assetInfo      = 2;//资源信息
	repeated CardObject	       cardInfo       = 3;//卡牌信息
			 PropObjectGroup   propInfo       = 4;//道具信息
			 int32			   propTotalPage  = 5;
			 EquipObjectGroup  equipInfo      = 6;//装备信息
			 int32             equipTotalPage = 7;
	repeated TalentTreeInfo    talentInfo     = 8;//天赋信息
	repeated int32             fetterId       = 9;//已经激活的羁绊列表
			 int32             noviceLotteryOnceNum  = 10;//新手扭蛋单抽剩余次数
			 int32             noviceLotteryMoreNum  = 11;//新手扭蛋十连抽剩余次数
			 int32             noviceLotteryIntegral = 17;//普通扭蛋积分               
	repeated OtherLottery      otherLottery          = 13;//活动扭蛋 
	repeated MatrixTreeInfo    matrixTreeInfo = 12;//所有法阵信息
	repeated FurnitureObject   furnitureObject    = 14;//道具信息
	repeated GoodsChangeObject changeObject       = 15;//离线期间 到期物品列表
	         int32             galaId         = 16;//节日期间第一次登录需要发送此节日ID给客户端
	repeated int32             pushSet        = 18;//已关闭的推送类型
}

//203
//204
message ResGoodsChange
{
	repeated GoodsChangeObject goods    = 1;//资源和卡牌对象(value为负数表示消耗,正数表示获得) 家具 
	repeated EquipObject equip 			= 2;//获得的装备
	repeated string      delEquipIndex  = 3;//失去的装备流水号列表
			 int32	     reqMsgId       = 4;//是哪个操作触发的
}

//205聊天
message ReqChat
{
	string	content = 1;//内容
}
message ResChat
{
	string	content = 1;//返回的内容
}

//207登出
message ReqLogout
{
	string  type = 1;//登出方式
}
//208登出
message ResLogout
{
}

//209设置
message ReqSet
{
	repeated SetObject setObject = 1;
}
//210设置
message ResSet
{
	repeated SetObject setObject = 1;
}

//211 初始化天赋　
message ReqTalentInit
{
	int32	talentTreeId = 1;
	bool    isFirst      = 2;//是否是第一次请求(第一次请求时服务器才发送其它天赋树的总等级)
}
//212
message ResTalentInit
{
			TalentTreeInfo talentTreeInfo   = 1;
	repeated CommonObject  alllTalentTreeLv = 2;//所有天赋树的总等级(只有第一次请求才有值)
}

//213 天赋树升星
message ReqTalentTreeStarUp
{
	int32	talentTreeId = 1;
}
//214
message ResTalentTreeStarUp
{
	int32	talentTreeId = 1;//天赋树ID
	int32	star         = 2;//当前星级
}

//215 天赋升级
message ReqTalentLevelUp
{
	int32	talentId = 1;//天赋ID
}
//216 天赋升级
message ResTalentLevelUp
{
	int32	 talentId           = 1;
	int32	 level              = 2;//当前等级
	int32	 unlockTalentTree   = 3;//解锁新的天赋树
	repeated int32 unlockTalent = 4;//解锁新的天赋	
}

//217
message ReqTalentTreeEnergyUp
{
	int32	talentTreeId = 1;//天赋树ID
	string  debrisIndex  = 2;//碎片流水号
	int32	count        = 3;//使用的碎片数量
}
//218
message ResTalentTreeEnergyUp
{
	int32	talentTreeId = 1;//天赋树ID
	int32	energy       = 2;//星能
	int32   energyExp    = 3;//经验
	int32   totalGetExp  = 4;//本次获得的总经验
}


//219设置引继码
message ReqSetYjCode
{
	string                        password = 1;//引继密码
}
//220设置引继码
message ResSetYjCode
{
	//暂不加返回结果，客户端需要再加
}

//221请求普通引导
message ReqNormalGuide
{
	
}
//222返回普通引导
message ResNormalGuide
{
	int32             gId = 1;
	int32            sgId = 2;
	int32             sId = 3;
	int32			 pgId = 4;
	int32 			psgId = 5;
	int32 			 psId = 6;
}

//223请求图片引导
message ReqImageGuide
{
	int32                    id = 1;
	bool 			       save = 2;
}
//224返回图片引导
message ResImageGuide
{
	repeated int32       idList = 1;
}

//225所有的法阵信息
message ReqMatrixTreeInfo
{
}
//226
message ResMatrixTreeInfo
{
	repeated MatrixTreeInfo    matrixTreeInfo = 1;//所有法阵信息
}

//227单个阵位信息
message ReqMatrixInfo
{
	int32	id = 1;//法阵ID
}
//228
message ResMatrixInfo
{
	         
}

//229激活节点
message ReqActivateMatrixNode
{
	int32   matrixId = 1;//法阵ID
}
//230
message ResActivateMatrixNode
{
	int32   matrixId = 1;//法阵ID
	int32   nodeId   = 2;//激活成功的节点ID
	MatrixInfo unlockMatrix = 3;//新解锁的法阵
}

//231升级封印
message ReqLevelUpMatrixSeal
{
	int32	matrixId = 1;//法阵ID
	int32	sealType = 2;//封印类型
}
//232
message ResLevelUpMatrixSeal
{
	int32	matrixId = 1;//法阵ID
	int32	sealType = 2;//封印类型
	int32   sealId   = 3;//新的封印ID
}

//233请求保存普通引导
message ReqSaveNormalGuide
{
	int32             gId = 1;
	int32            sgId = 2;
	int32             sId = 3;
	int32			 pgId = 4;
	int32 			psgId = 5;
	int32 			 psId = 6;
	int32 			 type = 7;//1普通引导    2副本引导
}
//234返回保存普通引导
message ResSaveNormalGuide
{
	
}

//235升级账号成为正式账号
message ReqUpgradeAccount
{
}
//236
message ResUpgradeAccount
{
}

//237 请求领取绑定账号奖励
message ReqGetBindReward
{
	
}
//238 返回领取绑定账号奖励
message ResGetBindReward
{
	
}

//239
message ReqPlayerLevelUp
{
	
}
//240升级消息
message ResPlayerLevelUp
{
	int32         newLevel = 1;
}


//241设置跑马灯
message ReqHorseSet
{
	bool	open = 1;//是否打开跑马灯
}
//242设置跑马灯
message ResHorseSet
{
	
}


// 243 礼包码
message ReqGiftCode{
	string giftCode               = 1;//礼包码
	string opId                   = 2;//游族opId
	string gameId                 = 3;//游族游戏id
}

//244 
message ResGiftCode{
	int32 code                   = 1;//返回值
}

//装备方案
message EquipScheme{
	string schemeName            = 1;//装备方案名称
	repeated string equipIndex   = 2;//装备id列表
	int64 id                     = 3;//装备方案唯一id,服务器返回
	int32 cardId                 = 4;//装备方案绑定的角色id
}

//新增装备方案 245
message ReqAddEquipScheme{
	EquipScheme equipScheme      = 1;  
	int32 type                   = 2;//1为修改名称 2为修改列表 
}

//246
message ResAddEquipScheme{
	EquipScheme equipScheme      = 1; 
	int32 type                   = 2;//1为修改名称 2为修改列表 3为修改全部
}

//获取装备方案 247
message ReqEquipScheme{
	
}

//248
message ResEquipScheme{
	repeated EquipScheme equipScheme      = 1; 
}

//删除方案 249
message ReqRemoveEquipScheme{
	int64 id            = 1;//唯一id
}

//250
message ResRemoveEquipScheme{
	bool success        = 1;//是否成功
	int64 id            = 2;//唯一id
}

//修改装备方案名称 251
message ReqUpdateEquipSchemeName{
	string schemeName            = 1;//装备方案名称
	int64 id                     = 2;//唯一id
}

//修改装备方案 252
message ResUpdateEquipSchemeName{
	string schemeName            = 1;//装备方案名称
	int64 id                     = 2;//唯一id
	bool success                 = 3;//修改是否成功
}

//使用方案 253
message ReqUseEquipScheme{
	int64 id                     = 1;
	int32 cardId                 = 2;
	int32 useType                = 3;//1为装备方案 2为卸载方案
}

//使用方案 254
message ResUseEquipScheme{
	int64 id                     = 1;
	int32 cardId                 = 2;
	int32 useType                = 3;//1为装备方案 2为卸载方案
	bool success                 = 4;//是否成功
}

//255请求头像数据
message ReqHeadData
{
	
}
//256返回头像数据
message ResHeadData
{
	repeated int32		 headIcon = 1;//激活的头像
	repeated int32		headFrame = 2;//激活的头像框
}

//257推送设置
message ReqPushSet
{
	int32         pushType = 1;//推送配置类型
	bool             value = 2;//开关（true开    false关）
}
//258推送设置
message ResPushSet
{
	
}




message RedDotInfo
{
	         int32 id                       = 1;//红点ID
	repeated int32 params                   = 2;//参数列表
}

//1901请求红点列表
message ReqRedDotList
{
	
}
//1902返回红点列表
message ResRedDotList
{
	repeated RedDotInfo          redDotList = 1;//红点列表
}

//1903请求删除红点
message ReqRemoveRedDot
{
	repeated RedDotInfo          redDotList = 1;//红点列表
}
//1904返回删除红点
message ResRemoveRedDot
{
	repeated RedDotInfo          redDotList = 1;//红点列表
}

//1905请求增加红点
message ReqAddRedDot
{
	
}
//1906请求增加红点
message ResAddRedDot
{
	 repeated RedDotInfo          redDotList = 1;//红点列表
}

//1907请求亲密度等级改变
message ReqIntimacyLvChange
{
	
}
//1908返回亲密度等级改变
message ResIntimacyLvChange
{
	int32 cardId                            = 1;//卡牌ID
	int32 intimacyLv 						= 2;//亲密度等级
}

//1909 引导提示
message ReqGuideNotice
{
	
}

//1910 引导提示
message ResGuideNotice
{
	         GUIDE_TYPE                type = 1;//引导提示类型
    repeated int32                   params = 2;//参数列表
}




//请求冒险数据 2400
message ReqRiskData{
	int32  id        = 1;
}

//冒险数据 这里只返回正在进行的冒险数据 2401
message ResRiskData{
	RiskData riskData  = 1;//
}

//请求初始化冒险数据 2406
message ReqRiskDataInit{

}

//请求初始化冒险数据 2407
message ResRiskDataInit{
	repeated RiskData riskDataList = 1;
}

message RiskData{
	int32   id                  = 1;//id
	int64  beginTime            = 2;//开始时间
	int64  endTime              = 3;//结束时间
	//repeated GoodsObject reward = 4;//奖励
	repeated RiskEvent event    = 5;//事件
	int64 riskTime              = 6;//探险时长(单位 毫秒)
	int32 useVit                = 7;//当前冒险关卡已经使用过的体力数量
}

message RiskEvent{
	int32 eventId               = 1;//事件id
	int32 eventType             = 2;//事件类型
	repeated GoodsObject reward = 3;//奖励 当且仅当事件为奖励事件是 此处才有值
	int32 rank                  = 4;//排序
}

//开始冒险 2402
message ReqBeginRisk{
	int32 id                      = 1;//冒险地图id
	int64 riskTime                = 2;//冒险时长(单位 毫秒)
}

//开始冒险 2403
message ResBeginRisk{
    RiskData riskData  = 1;//冒险数据
}

//结束冒险 2404
message ReqEndRisk{
	int32   id         = 1;
}

//结束冒险 2405
message ResEndRisk{
	repeated GoodsObject rewards = 1;//冒险奖励
		int32   id               = 2;
		int64 riskTime           = 3;//冒险时间
}

//请求初始化协助战斗 2408
message ReqAssistFightInit{

}

//2409
message ResAssistFightInit{
	AssistFightData data	= 1;
}

message AssistFightData{
	int32 id                		= 1;//id
	int32 remainHp          		= 2;//BOSS剩余百分比血量
	int32 assistedTime				= 3;//当日已协助次数
	int32 challengedTime			= 4;//当日已挑战次数
	repeated CommonObject cardInfo	= 5;//卡牌信息(id为卡的ID,value为位置)
	repeated int32 gotReward		= 6;//已经领取的奖励id
	int32 fc                        = 7;//玩家战斗力
}

//请求挑战BOSS 2410
message ReqChallengeAssistFight{
	repeated CommonObject cardInfo  = 1;//卡牌信息(id为卡的ID,value为位置) 布阵
}

//2409
message ResChallengeAssistFight{
	bool success            = 1;//是否能进行挑战
}

//结算挑战BOSS 2411
message ReqSettleAssistFight{
	BattleCompleteData battleCompleteData   = 1;//战斗数据
}

//2413
message ResSettleAssistFight{
	bool success            = 1;//挑战是否成功
	int32 remainHp          = 2;//BOSS剩余百分比血量
}


//请求协助公会成员战斗 2416
message ReqAssistGuildMember{
	string playerIndex			= 1;//玩家唯一id
}

//2417
message ResAssistGuildMember{
	bool success				= 1;
	int32 byAssistTime			= 2;//当日被协助次数
	int32 assistTime            = 3;//当日协助次数
	int32 remainHp				= 4;//BOSS剩余百分比血量
	string playerIndex			= 5;//玩家唯一id
}


///通知BOSS血量变化  2418
message ResAssistFightData{
	int32 remainHp          = 1;//BOSS剩余百分比血量
}

///请求保持通知BOSS血量变化  2419
message ReqNeedNoticeBossHP{
	bool notify            = 1;//true表示通知
}

// 2420
message ResNeedNoticeBossHP{
}

//请求领取挑战BOSS奖励  2421
message ReqChallengeReward{
	int32 id			= 1;
}

//
message ResChallengeReward{
	int32 id		= 1;//已经领取的奖励id
}



//请求商店类型
message ReqShopData{
	int32                  flag = 1;//消息标记（用于客户端界面区分，原样返回）
}

message ResShopData{

	repeated ShopData shopData  = 1;//商店类型数据
	int32                  flag = 2;//消息标记
	
}

//商店类型数据
message ShopData{
	int32 shopId                = 1;//商店的唯一id  根据该字段可以找到商店的唯一配置 获取到相关信息
}

//请求商店格子
message ReqShopGridData{

	int32 shopType                        = 1;//商店的唯一id

}

message ResShopGridData{
	int32 shopType              		    = 1;
	ConfigTime   updateTime   			= 2;//商店的更新时间
	repeated ShopGridData shopGridData  = 3;
	int32 resetNum                      = 4;//商店刷新次数
}

//商店格子
message ShopGridData{	
	int32      shopGridId   	= 1;//商店格子id
	int32 useNum                = 2;//已使用(购买)次数
	ConfigTime  updateTime   	= 3;//格子下次更新时间
	int32 shopPoolId            = 4;//格子上的商品配置id
	bool corner                 = 5;//是否有new角标
	
}

//请求刷新商店
message ReqShopReset{
	int32 shopType                            = 1;//商店的唯一id
}

//商店刷新 
message ResShopReset{
	int32 shopType              			    = 1;
	ConfigTime   updateTime   				= 2;//商店的更新时间
	repeated ShopGridData shopGridData      = 3;//
	int32 resetNum                          = 4;//商店刷新次数
}

//商店购买
message ReqShopBuy{
	
	int32 shopType             = 1;//商店的唯一id
	int32 shopGridId         = 2;//商店格子id
	int32 shopPoolId         = 3;//商品池id
	int32 shopNum            = 4;//购买个数 服务器需要判断 如果该数量够大于可购买数量 按照可购买数量处理
	
}

//商店购买
message ResShopBuy{
	bool success                = 1;//购买是够成功  如果成功 才返回更新数据 失败则不返回
	ShopGridData shopGridData   = 2;//商店购买之后更新商店数据结构
	int32 shopType                = 3;//商店的唯一id
}

//809获取购买资源次数
message ReqGetBuyAssistNum{
	BUY_ASSIST_TYPE type        = 1;//购买类型 对应枚举BUY_ASSIST_TYPE

}

//购买资源次数
message ResGetBuyAssistNum{
	BUY_ASSIST_TYPE type        = 1;//购买类型 对应枚举BUY_ASSIST_TYPE
	int32 buyAssistNum          = 2;//使用的购买次数
}

//811购买资源
message ReqBuyAssist{
	BUY_ASSIST_TYPE type        = 1;//购买类型 对应枚举BUY_ASSIST_TYPE
	int32 buyNum                = 2;//请求购买次数
}

//购买资源
message ResBuyAssist{
	BUY_ASSIST_TYPE type        = 1;//购买类型 对应枚举BUY_ASSIST_TYPE
	int32 buyAssistNum          = 2;//使用的购买次数
	repeated GoodsObject assist = 3;//购买的物品

}



//101注册请求
message ReqRegister
{
	E_CHANNEL         channel              = 1;//渠道
	E_PLATFORM        platform             = 2;//平台
	string            account              = 3;//账号(根据不同渠道代表不同的意思)
	string            password             = 4;//根据不同渠道代表不同的意思
	string            nickName             = 5;//昵称
	int32			  fashionHead          = 6;
	int32			  fashionShow          = 7;
	string            deviceId             = 8;//设备id
	bool              guest                = 9;//是否是游客(游族平台需要区分)
	string            opId             	   = 10;//运营商ID
	string            yzDeviceId           = 11;//游族设备id
	int32             fashionFrame         = 12;//头像框
	string            deviceType           = 13;//设备类型
	string            deviceOs             = 14;//设备系统
	string            gameVer              = 15;//游戏版本号
}
//102注册回复
message ResRegister
{
	E_CHANNEL         channel              = 1;//渠道
	E_PLATFORM        platform             = 2;//平台
	string            account              = 3;//账号
	E_REGISTER_RESULT result               = 4;//注册结果(暂时只有注册不成功时会用到)
}


//103登录请求
message ReqLogin
{
	E_LOGIN_TYPE 	  type      		   = 1;//登录方式
    E_CHANNEL         channel    		   = 2;//渠道
	E_PLATFORM        platform             = 3;//平台
	string       	  account              = 4;//账号
	string 			  password             = 5;//
	string            deviceId             = 6;
	string            key                  = 7;//密钥(本地有保存才发，没有就不发)
	bool              guest                = 8;//是否是游客(游族平台需要区分)
	string            opId             	   = 9;//运营商ID
	string            yzDeviceId           = 10;//游族设备id
	string            deviceType           = 11;//设备类型
	string            deviceOs             = 12;//设备系统
	string            gameVer              = 13;//游戏版本号
}
//104登录回复
message ResLogin
{
	E_LOGIN_TYPE        type   	       	   = 1;//登录方式
	E_CHANNEL    	  channel        	   = 2;//渠道
	E_PLATFORM        platform             = 3;//平台
	E_LOGIN_RESULT      result             = 4;//登录结果
	int32 	            waitTime		   = 5;//排队时间
	string				account            = 6;//账号
	string               key               = 7;//密钥
	int64			currentTime   		   = 8;//服务器时间
	int32           sId                    = 9;//服务器ID
	string          psId                   = 10;//平台服务器ID
	bool            register               = 11;//是否是注册后登录的新用户
}


//105心跳
message ReqPing
{
	string              account    = 1;//账号
}
//106心跳
message ResPing
{
	int64 currentTime   				   = 1;
}

//107序章日志
message ReqOverture
{
	int32	type = 1;
	E_PLATFORM  platform = 2;
	E_CHANNEL  channel = 3;
	string  account = 4;
	string  deviceId = 5;
}


//198通知信息
message ResAlert
{
	E_ALERT_TYPE  type       			   = 1;//通知类型
	string        content    		       = 2;//内容
	int32         msgId                    = 3;//消息号
	string        playerIndex              = 4;//是哪个玩家触发的
	string        param                    = 5;//参数
}





//1101 请求任务数据
message ReqTaskData
{
	int32 type								= 1;//任务类型
}

//1102 返回任务数据
message ResTaskData
{
	repeated TaskObject            taskList = 1;//任务列表
	repeated CommonObject      livenessList = 2;//活跃列表
	repeated TaskSimpleObject   taskBoxList = 3;//宝箱列表
	         bool                    getBox = 4;//是否领取宝箱同步
}

//1103 请求提交任务
message ReqSubmitTask
{
	int32 id		= 1;//任务ID
}

//1104 返回提交结果
message ResSubmitTask
{
	int32 id		= 1;//任务ID
	bool result		= 2;//提交状态（true：成功	false：失败）
	string param    = 3;//参数
}

//1105 请求领取宝箱
message ReqGetTaskBox
{
	int32 boxId		= 1;//宝箱ID
}

//1106 返回领取宝箱
message ResGetTaskBox
{
	int32 boxId		= 1;//宝箱ID
	bool result		= 2;//领取状态（true：成功	false：失败）
}



", 
MsgIdByName = {Unknown = 0,
ReqRegister = 101,
ResRegister = 102,
ReqLogin = 103,
ResLogin = 104,
ReqPing = 105,
ResPing = 106,
ReqOverture = 107,
ResOverture = 108,
ResAlert = 198,
ReqDetailInfo = 201,
ResDetailInfo = 202,
ReqGoodsChange = 203,
ResGoodsChange = 204,
ReqChat = 205,
ResChat = 206,
ReqLogout = 207,
ResLogout = 208,
ReqSet = 209,
ResSet = 210,
ReqTalentInit = 211,
ResTalentInit = 212,
ReqTalentTreeStarUp = 213,
ResTalentTreeStarUp = 214,
ReqTalentLevelUp = 215,
ResTalentLevelUp = 216,
ReqTalentTreeEnergyUp = 217,
ResTalentTreeEnergyUp = 218,
ReqSetYjCode = 219,
ResSetYjCode = 220,
ReqNormalGuide = 221,
ResNormalGuide = 222,
ReqImageGuide = 223,
ResImageGuide = 224,
ReqMatrixTreeInfo = 225,
ResMatrixTreeInfo = 226,
ReqMatrixInfo = 227,
ResMatrixInfo = 228,
ReqActivateMatrixNode = 229,
ResActivateMatrixNode = 230,
ReqLevelUpMatrixSeal = 231,
ResLevelUpMatrixSeal = 232,
ReqSaveNormalGuide = 233,
ResSaveNormalGuide = 234,
ReqUpgradeAccount = 235,
ResUpgradeAccount = 236,
ReqGetBindReward = 237,
ResGetBindReward = 238,
ReqPlayerLevelUp = 239,
ResPlayerLevelUp = 240,
ReqHorseSet = 241,
ResHorseSet = 242,
ReqGiftCode = 243,
ResGiftCode = 244,
ReqAddEquipScheme = 245,
ResAddEquipScheme = 246,
ReqEquipScheme = 247,
ResEquipScheme = 248,
ReqRemoveEquipScheme = 249,
ResRemoveEquipScheme = 250,
ReqUpdateEquipSchemeName = 251,
ResUpdateEquipSchemeName = 252,
ReqUseEquipScheme = 253,
ResUseEquipScheme = 254,
ReqHeadData = 255,
ResHeadData = 256,
ReqPushSet = 257,
ResPushSet = 258,
ReqUseProp = 301,
ResUseProp = 302,
ReqSellProp = 303,
ResSellProp = 304,
ReqPutOnEquip = 305,
ResPutOnEquip = 306,
ReqLevelUpEquip = 307,
ResLevelUpEquip = 308,
ReqDestroyEquip = 309,
ResDestroyEquip = 310,
ReqLockEquip = 311,
ResLockEquip = 312,
ReqExchangeDebris = 313,
ResExchangeDebris = 314,
ReqIdentifyEquip = 315,
ResIdentifyEquip = 316,
ReqTitleList = 317,
ResTitleList = 318,
ReqWearTitle = 319,
ResWearTitle = 320,
ReqFashionList = 321,
ResFashionList = 322,
ReqLevelUp = 401,
ResLevelUp = 402,
ReqQualityUp = 403,
ResQualityUp = 404,
ReqSkillUp = 405,
ResSkillUp = 406,
ReqStarUp = 407,
ResStarUp = 408,
ResUpdateInfo = 410,
ReqSetFashion = 411,
ResSetFashion = 412,
ReqSetHandbookCover = 413,
ResSetHandbookCover = 414,
ReqSetMainCover = 415,
ResSetMainCover = 416,
ReqActivateFetter = 417,
ResActivateFetter = 418,
ReqBirthdayList = 419,
ResBirthdayList = 420,
ReqBirthdayReward = 421,
ResBirthdayReward = 422,
ReqSealOpen = 431,
ResSealOpen = 432,
ReqSealData = 433,
ResSealData = 434,
ReqSealUp = 435,
ResSealUp = 436,
ReqSealSkillAc = 437,
ResSealSkillAc = 438,
ReqSealSkillUp = 439,
ResSealSkillUp = 440,
ReqStoryInit = 501,
ResStoryInit = 502,
ReqStoryReward = 503,
ResStoryReward = 504,
ReqStorySweep = 505,
ResStorySweep = 506,
ReqEmbattle = 507,
ResEmbattle = 508,
ReqTempleInit = 582,
ResTempleInit = 583,
ReqInStage = 509,
ResInStage = 510,
ReqSettleStage = 511,
ResSettleStage = 512,
ReqTrialInit = 513,
ResTrialInit = 514,
ReqInTrial = 515,
ResInTrial = 516,
ReqSweepTrial = 580,
ResSweepTrial = 581,
ReqSettleTrial = 517,
ResSettleTrial = 518,
ReqArenaData = 519,
ResArenaData = 520,
ReqArenaFight = 521,
ResArenaFight = 522,
ReqArenaRefresh = 523,
ResArenaRefresh = 524,
ReqArenaReward = 525,
ResArenaReward = 526,
ReqOldSetsTower = 527,
ResOldSetsTower = 528,
ReqArenaGuardCardGroups = 531,
ResArenaGuardCardGroups = 532,
ResNextChapterInfo = 534,
ReqExtraReward = 535,
ResExtraReward = 536,
ReqBattleRcord = 537,
ResBattleRcord = 538,
ReqArenaRank = 539,
ResArenaRank = 540,
ResUpdateRank = 542,
ReqFastSweep = 543,
ResFastSweep = 544,
ReqTowerInit = 545,
ResTowerInit = 546,
ReqInTower = 547,
ResInTower = 548,
ReqSettleTower = 549,
ResSettleTower = 550,
ReqExpedition = 551,
ResExpedition = 552,
ReqSetExpedition = 553,
ReqInExpedition = 555,
ResInExpedition = 556,
ReqSettleExpedition = 557,
ResSettleExpedition = 558,
ReqShopExpeditionBuy = 559,
ResShopExpeditionBuy = 560,
ResShopExpedition = 562,
ResBuffExpedition = 564,
ReqDrawBuff = 565,
ResDrawBuff = 566,
ReqFinishStory = 567,
ResFinishStory = 568,
ReqCheckStoryFinish = 569,
ResCheckStoryFinish = 570,
ReqEncounterBattleEmba = 571,
ResEncounterBattleEmba = 572,
ReqInTowerEncounter = 573,
ResInTowerEncounter = 574,
ReqSettleEncounter = 575,
ResSettleEncounter = 576,
ReqCancelEncounter = 577,
ResCancelEncounter = 578,
ReqDeckScheme = 591,
ResDeckScheme = 592,
ReqAddOrUpdateDeckScheme = 593,
ResAddOrUpdateDeckScheme = 594,
ReqRandomMonsterGroupList = 595,
ResRandomMonsterGroupList = 596,
ReqStageBuyNum = 597,
ResStageBuyNum = 598,
ReqPlayBuyNum = 601,
ResPlayBuyNum = 602,
ReqPlayClearCDTime = 603,
ResPlayClearCDTime = 604,
ReqInitBattleData = 701,
InitBattleData = 702,
BattleCompleteData = 703,
ReqBattleData = 705,
ResBattleData = 706,
ReqExitBattle = 707,
ResExitBattle = 708,
ReqShopData = 801,
ResShopData = 802,
ReqShopGridData = 803,
ResShopGridData = 804,
ReqShopReset = 805,
ResShopReset = 806,
ReqShopBuy = 807,
ResShopBuy = 808,
ReqGetBuyAssistNum = 809,
ResGetBuyAssistNum = 810,
ReqBuyAssist = 811,
ResBuyAssist = 812,
ReqLotteryInit = 901,
ResLotteryInit = 902,
ReqLotteryDraw = 903,
ResLotteryDraw = 904,
ReqSignInInit = 905,
ResSignInInit = 906,
ReqSignIn = 907,
ResSignIn = 908,
ReqSignInReward = 909,
ResSignInReward = 910,
ReqVitGetInit = 911,
ResVitGetInit = 912,
ReqVitGet = 913,
ResVitGet = 914,
ReqLoginAct = 915,
ResLoginAct = 916,
ReqLoginActGet = 917,
ResLoginActGet = 918,
ReqSlotsData = 919,
ResSlotsData = 920,
ReqSlotsReset = 921,
ResSlotsReset = 922,
ReqSlotsOperation = 923,
ResSlotsOperation = 924,
ReqActivityLottery = 931,
ResActivityLottery = 932,
ReqLotteryRecord = 925,
ResLotteryRecord = 926,
ReqInitConversion = 927,
ResInitConversion = 928,
ReqLotteryConversion = 929,
ResLotteryConversion = 930,
ReqSlotsRecord = 933,
ResSlotsRecord = 934,
ReqGMLogin = 1001,
ResGMLogin = 1002,
ReqGMRegister = 1003,
ResGMRegister = 1004,
ReqGMList = 1005,
ResGMList = 1006,
ReqGMDel = 1007,
ResGMDel = 1008,
ReqGMUpdate = 1009,
ResGMUpdate = 1010,
ReqPlayerList = 1011,
ResPlayerList = 1012,
ReqPlayerInfo = 1013,
ResPlayerInfo = 1014,
ReqPlayerAddGoods = 1015,
ResPlayerAddGoods = 1016,
ReqGroupMail = 1017,
ResGroupMail = 1018,
ReqSendNotice = 1019,
ResSendNotice = 1020,
ReqGetConfig = 1021,
ResGetConfig = 1022,
ReqServerList = 1023,
ResServerList = 1024,
ReqTaskData = 1101,
ResTaskData = 1102,
ReqSubmitTask = 1103,
ResSubmitTask = 1104,
ReqGetTaskBox = 1105,
ResGetTaskBox = 1106,
ReqReadMail = 1201,
ResReadMail = 1202,
ReqMailDetail = 1203,
ResMailDetail = 1204,
ReqMailList = 1205,
ResMailList = 1206,
ReqGetMailAnnex = 1207,
ResGetMailAnnex = 1208,
ReqDeleteMail = 1209,
ResDeleteMail = 1210,
ReqRegisterMail = 1211,
ResRegisterMail = 1212,
ReqHandbookInit = 1301,
ResHandbookInit = 1302,
ReqCGCopyInfo = 1303,
ResCGCopyInfo = 1304,
ReqCGCopyStage = 1305,
ResCGCopyStage = 1306,
ReqStoryCopyGetCG = 1307,
ResStoryCopyGetCG = 1308,
ReqCGList = 1309,
ResCGList = 1310,
ReqHandLetterList = 1311,
ResHandLetterList = 1312,
ReqAdventureStoryChapter = 1313,
ResAdventureStoryChapter = 1314,
ReqAdventureStoryStage = 1315,
ResAdventureStoryStage = 1316,
ReqIntimacyInfo = 1317,
ResIntimacyInfo = 1318,
ReqInCGCopyStage = 1319,
ResInCGCopyStage = 1320,
ReqSettleCGCopyStage = 1321,
ResSettleCGCopyStage = 1322,
ReqCGCopySummary = 1323,
ResCGCopySummary = 1324,
ReqSwitchCard = 1325,
ResSwitchCard = 1326,
ReqOpenCG = 1327,
ResOpenCG = 1328,
ReqOpenLetter = 1329,
ResOpenLetter = 1330,
ReqClickPointPlot = 1331,
ResClickPointPlot = 1332,
ReqAdventureInit = 1401,
ResAdventureInit = 1402,
ReqPlayDice = 1403,
ResPlayDice = 1404,
ReqWishReward = 1405,
ResWishReward = 1406,
ReqAdventureBuilding = 1407,
ResAdventureBuilding = 1408,
ReqAdventureEventReward = 1409,
ResAdventureEventReward = 1410,
ReqInAdventureBattleEmba = 1411,
ResInAdventureBattleEmba = 1412,
ReqSettleAdventureBattle = 1413,
ResSettleAdventureBattle = 1414,
ReqInitAdventureBattleEmba = 1415,
ResInitAdventureBattleEmba = 1416,
ReqGuildList = 1501,
ResGuildList = 1502,
ReqSearchGuild = 1503,
ResSearchGuild = 1504,
ReqJoinGuild = 1505,
ResJoinGuild = 1506,
ReqCreateGuild = 1507,
ResCreateGuild = 1508,
ReqGuildDetailInfo = 1511,
ResGuildDetailInfo = 1512,
ReqSetGuildInfo = 1513,
ResSetGuildInfo = 1514,
ReqDisbandGuild = 1515,
ResDisbandGuild = 1516,
ReqQuitGuild = 1517,
ResQuitGuild = 1518,
ReqGuildMemberList = 1519,
ResGuildMemberList = 1520,
ReqSetGuildJob = 1521,
ResSetGuildJob = 1522,
ReqRemoveGuildMember = 1523,
ResRemoveGuildMember = 1524,
ReqGuildReview = 1525,
ResGuildReview = 1526,
ReqProcessApply = 1527,
ResProcessApply = 1528,
ReqGuildRank = 1529,
ResGuildRank = 1530,
ReqGuildBaseInfo = 1531,
ResGuildBaseInfo = 1532,
ReqGuildId = 1533,
ResGuildId = 1534,
ReqGuildBuildInit = 1535,
ResGuildBuildInit = 1536,
ReqGuildBuild = 1537,
ResGuildBuild = 1538,
ReqGuildGiftInit = 1539,
ResGuildGiftInit = 1540,
ReqGuildGiftGet = 1541,
ResGuildGiftGet = 1542,
ReqGuildGiftRank = 1543,
ResGuildGiftRank = 1544,
ReqGuildGameInit = 1545,
ResGuildGameInit = 1546,
ReqBeginGuildGame = 1547,
ResBeginGuildGame = 1548,
ReqGuildGamePlay = 1549,
ResGuildGamePlay = 1550,
ReqGuildGameReset = 1551,
ResGuildGameReset = 1552,
ReqGuildGameRecord = 1553,
ResGuildGameRecord = 1554,
ReqGuildLog = 1555,
ResGuildLog = 1556,
ReqGuildPK = 1557,
ResGuildPK = 1558,
ReqInGuildPK = 1559,
ResInGuildPK = 1560,
ReqSettleGuildPK = 1561,
ResSettleGuildPK = 1562,
ReqSyncGuildData = 1563,
ResSyncGuildData = 1564,
ReqPlayerCards = 1565,
ResPlayerCards = 1566,
ReqPopUpLevelUp = 1567,
ResPopUpLevelUp = 1568,
ReqGuildSummary = 1569,
ResGuildSummary = 1570,
ReqImpeachData = 1571,
ResImpeachData = 1572,
ReqVoting = 1573,
ResVoting = 1574,
ReqSetChat = 1601,
ResSetChat = 1602,
ReqSetAccpetChat = 1603,
ResSetAccpetChat = 1604,
ReqGetChat = 1605,
ResGetChat = 1606,
ReqGetCardChat = 1607,
ResGetCardChat = 1608,
ReqClickLike = 1609,
ResClickLike = 1610,
ReqGetLikeCard = 1611,
ResGetLikeCard = 1612,
ReqSetLikeCard = 1613,
ResSetLikeCard = 1614,
ReqMyClickLikeRemark = 1615,
ResMyClickLikeRemark = 1616,
ReqActivityList = 1701,
ResActivityList = 1702,
ReqActivityInfo = 1703,
ResActivityInfo = 1704,
ReqDecActivity = 1705,
ResDecActivity = 1706,
ReqTaskGroup = 1707,
ResTaskGroup = 1708,
ReqTaskReward = 1709,
ResTaskReward = 1710,
ReqPointReward = 1711,
ResPointReward = 1712,
ReqGetReward = 1713,
ResGetReward = 1714,
ReqActivityInfoList = 1715,
ResActivityInfoList = 1716,
ReqBannerIdList = 1731,
ResBannerIdList = 1732,
ReqSaveBannerId = 1733,
ResSaveBannerId = 1734,
ReqRemoveBannerId = 1735,
ResRemoveBannerId = 1736,
ReqFunctionList = 1801,
ResFunctionList = 1802,
ReqOpenFunction = 1803,
ResOpenFunction = 1804,
ReqRedDotList = 1901,
ResRedDotList = 1902,
ReqRemoveRedDot = 1903,
ResRemoveRedDot = 1904,
ReqAddRedDot = 1905,
ResAddRedDot = 1906,
ReqIntimacyLvChange = 1907,
ResIntimacyLvChange = 1908,
ReqGuideNotice = 1909,
ResGuideNotice = 1910,
ReqPayCheck = 2001,
ResPayCheck = 2002,
ReqPayData = 2003,
ResPayData = 2004,
ReqGetMoonReward = 2005,
ResGetMoonReward = 2006,
ReqPaySuccess = 2007,
ResPaySuccess = 2008,
ReqGuildWarInfo = 2101,
ResGuildWarInfo = 2102,
ReqRefreshBattleInfo = 2103,
ResRefreshBattleInfo = 2104,
ReqWarAdvisory = 2111,
ResWarAdvisory = 2112,
ReqHurtReport = 2113,
ResHurtReport = 2114,
ReqGuildTalent = 2121,
ResGuildTalent = 2122,
ReqUpTalent = 2123,
ResUpTalent = 2124,
ReqTalentReset = 2125,
ResTalentReset = 2126,
ReqWarReward = 2131,
ResWarReward = 2132,
ReqGetWarReward = 2133,
ResGetWarReward = 2134,
ReqSupportInfo = 2141,
ResSupportInfo = 2142,
ReqSupportSet = 2143,
ResSupportSet = 2144,
ReqSupportHarvest = 2145,
ResSupportHarvest = 2146,
ReqGSeasonRank = 2151,
ResGSeasonRank = 2152,
ReqMSeasonRank = 2153,
ResMSeasonRank = 2154,
ReqInGuildStage = 2161,
ResInGuildStage = 2162,
ReqInGuildWar = 2163,
ResInGuildWar = 2164,
ReqSettleGuildWar = 2165,
ResSettleGuildWar = 2166,
ReqRelations = 2201,
ResRelations = 2202,
ReqSearch = 2211,
ResSearch = 2212,
ReqChangeRelation = 2221,
ResChangeMyRelation = 2222,
ResChangeFriendRelation = 2223,
ReqFriendInfo = 2231,
ResFriendInfo = 2232,
ResFriendState = 2241,
ReqFriendPK = 2251,
ResFriendPK = 2252,
ReqInFriendPK = 2261,
ResInFriendPK = 2262,
ReqEndFriendPK = 2271,
ResEndFriendPK = 2272,
ReqInFamily = 2301,
ResInFamily = 2302,
ReqSeedWarehouse = 2303,
ResSeedWarehouse = 2304,
ReqLandPlanting = 2305,
ResLandPlanting = 2306,
ReqLandHarvest = 2307,
ResLandHarvest = 2308,
ReqLandUproot = 2309,
ResLandUproot = 2310,
ReqLandUnlock = 2311,
ResLandUnlock = 2312,
ReqRoomInfo = 2351,
ResRoomInfo = 2352,
ReqRoomEnter = 2353,
ResRoomEnter = 2354,
ReqRoomLayout = 2355,
ResRoomLayout = 2356,
ReqRoomLevelUp = 2357,
ResRoomLevelUp = 2358,
ReqRoomCallOn = 2359,
ResRoomCallOn = 2360,
ReqRandomPlayerInfo = 2361,
ResRandomPlayerInfo = 2362,
ReqQuitRoom = 2363,
ResQuitRoom = 2364,
ReqRiskData = 2400,
ResRiskData = 2401,
ReqBeginRisk = 2402,
ResBeginRisk = 2403,
ReqEndRisk = 2404,
ResEndRisk = 2405,
ReqRiskDataInit = 2406,
ResRiskDataInit = 2407,
ReqAssistFightInit = 2408,
ResAssistFightInit = 2409,
ReqChallengeAssistFight = 2410,
ResChallengeAssistFight = 2411,
ReqSettleAssistFight = 2412,
ResSettleAssistFight = 2413,
ReqGuildAssistData = 2414,
ResGuildAssistData = 2415,
ReqAssistGuildMember = 2416,
ResAssistGuildMember = 2417,
ResAssistFightData = 2418,
ReqNeedNoticeBossHP = 2419,
ResNeedNoticeBossHP = 2420,
ReqChallengeReward = 2421,
ResChallengeReward = 2422}
, 
MsgNameByID = {[0] = "Unknown",
[101] = "ReqRegister",
[102] = "ResRegister",
[103] = "ReqLogin",
[104] = "ResLogin",
[105] = "ReqPing",
[106] = "ResPing",
[107] = "ReqOverture",
[108] = "ResOverture",
[198] = "ResAlert",
[201] = "ReqDetailInfo",
[202] = "ResDetailInfo",
[203] = "ReqGoodsChange",
[204] = "ResGoodsChange",
[205] = "ReqChat",
[206] = "ResChat",
[207] = "ReqLogout",
[208] = "ResLogout",
[209] = "ReqSet",
[210] = "ResSet",
[211] = "ReqTalentInit",
[212] = "ResTalentInit",
[213] = "ReqTalentTreeStarUp",
[214] = "ResTalentTreeStarUp",
[215] = "ReqTalentLevelUp",
[216] = "ResTalentLevelUp",
[217] = "ReqTalentTreeEnergyUp",
[218] = "ResTalentTreeEnergyUp",
[219] = "ReqSetYjCode",
[220] = "ResSetYjCode",
[221] = "ReqNormalGuide",
[222] = "ResNormalGuide",
[223] = "ReqImageGuide",
[224] = "ResImageGuide",
[225] = "ReqMatrixTreeInfo",
[226] = "ResMatrixTreeInfo",
[227] = "ReqMatrixInfo",
[228] = "ResMatrixInfo",
[229] = "ReqActivateMatrixNode",
[230] = "ResActivateMatrixNode",
[231] = "ReqLevelUpMatrixSeal",
[232] = "ResLevelUpMatrixSeal",
[233] = "ReqSaveNormalGuide",
[234] = "ResSaveNormalGuide",
[235] = "ReqUpgradeAccount",
[236] = "ResUpgradeAccount",
[237] = "ReqGetBindReward",
[238] = "ResGetBindReward",
[239] = "ReqPlayerLevelUp",
[240] = "ResPlayerLevelUp",
[241] = "ReqHorseSet",
[242] = "ResHorseSet",
[243] = "ReqGiftCode",
[244] = "ResGiftCode",
[245] = "ReqAddEquipScheme",
[246] = "ResAddEquipScheme",
[247] = "ReqEquipScheme",
[248] = "ResEquipScheme",
[249] = "ReqRemoveEquipScheme",
[250] = "ResRemoveEquipScheme",
[251] = "ReqUpdateEquipSchemeName",
[252] = "ResUpdateEquipSchemeName",
[253] = "ReqUseEquipScheme",
[254] = "ResUseEquipScheme",
[255] = "ReqHeadData",
[256] = "ResHeadData",
[257] = "ReqPushSet",
[258] = "ResPushSet",
[301] = "ReqUseProp",
[302] = "ResUseProp",
[303] = "ReqSellProp",
[304] = "ResSellProp",
[305] = "ReqPutOnEquip",
[306] = "ResPutOnEquip",
[307] = "ReqLevelUpEquip",
[308] = "ResLevelUpEquip",
[309] = "ReqDestroyEquip",
[310] = "ResDestroyEquip",
[311] = "ReqLockEquip",
[312] = "ResLockEquip",
[313] = "ReqExchangeDebris",
[314] = "ResExchangeDebris",
[315] = "ReqIdentifyEquip",
[316] = "ResIdentifyEquip",
[317] = "ReqTitleList",
[318] = "ResTitleList",
[319] = "ReqWearTitle",
[320] = "ResWearTitle",
[321] = "ReqFashionList",
[322] = "ResFashionList",
[401] = "ReqLevelUp",
[402] = "ResLevelUp",
[403] = "ReqQualityUp",
[404] = "ResQualityUp",
[405] = "ReqSkillUp",
[406] = "ResSkillUp",
[407] = "ReqStarUp",
[408] = "ResStarUp",
[410] = "ResUpdateInfo",
[411] = "ReqSetFashion",
[412] = "ResSetFashion",
[413] = "ReqSetHandbookCover",
[414] = "ResSetHandbookCover",
[415] = "ReqSetMainCover",
[416] = "ResSetMainCover",
[417] = "ReqActivateFetter",
[418] = "ResActivateFetter",
[419] = "ReqBirthdayList",
[420] = "ResBirthdayList",
[421] = "ReqBirthdayReward",
[422] = "ResBirthdayReward",
[431] = "ReqSealOpen",
[432] = "ResSealOpen",
[433] = "ReqSealData",
[434] = "ResSealData",
[435] = "ReqSealUp",
[436] = "ResSealUp",
[437] = "ReqSealSkillAc",
[438] = "ResSealSkillAc",
[439] = "ReqSealSkillUp",
[440] = "ResSealSkillUp",
[501] = "ReqStoryInit",
[502] = "ResStoryInit",
[503] = "ReqStoryReward",
[504] = "ResStoryReward",
[505] = "ReqStorySweep",
[506] = "ResStorySweep",
[507] = "ReqEmbattle",
[508] = "ResEmbattle",
[582] = "ReqTempleInit",
[583] = "ResTempleInit",
[509] = "ReqInStage",
[510] = "ResInStage",
[511] = "ReqSettleStage",
[512] = "ResSettleStage",
[513] = "ReqTrialInit",
[514] = "ResTrialInit",
[515] = "ReqInTrial",
[516] = "ResInTrial",
[580] = "ReqSweepTrial",
[581] = "ResSweepTrial",
[517] = "ReqSettleTrial",
[518] = "ResSettleTrial",
[519] = "ReqArenaData",
[520] = "ResArenaData",
[521] = "ReqArenaFight",
[522] = "ResArenaFight",
[523] = "ReqArenaRefresh",
[524] = "ResArenaRefresh",
[525] = "ReqArenaReward",
[526] = "ResArenaReward",
[527] = "ReqOldSetsTower",
[528] = "ResOldSetsTower",
[531] = "ReqArenaGuardCardGroups",
[532] = "ResArenaGuardCardGroups",
[534] = "ResNextChapterInfo",
[535] = "ReqExtraReward",
[536] = "ResExtraReward",
[537] = "ReqBattleRcord",
[538] = "ResBattleRcord",
[539] = "ReqArenaRank",
[540] = "ResArenaRank",
[542] = "ResUpdateRank",
[543] = "ReqFastSweep",
[544] = "ResFastSweep",
[545] = "ReqTowerInit",
[546] = "ResTowerInit",
[547] = "ReqInTower",
[548] = "ResInTower",
[549] = "ReqSettleTower",
[550] = "ResSettleTower",
[551] = "ReqExpedition",
[552] = "ResExpedition",
[553] = "ReqSetExpedition",
[555] = "ReqInExpedition",
[556] = "ResInExpedition",
[557] = "ReqSettleExpedition",
[558] = "ResSettleExpedition",
[559] = "ReqShopExpeditionBuy",
[560] = "ResShopExpeditionBuy",
[562] = "ResShopExpedition",
[564] = "ResBuffExpedition",
[565] = "ReqDrawBuff",
[566] = "ResDrawBuff",
[567] = "ReqFinishStory",
[568] = "ResFinishStory",
[569] = "ReqCheckStoryFinish",
[570] = "ResCheckStoryFinish",
[571] = "ReqEncounterBattleEmba",
[572] = "ResEncounterBattleEmba",
[573] = "ReqInTowerEncounter",
[574] = "ResInTowerEncounter",
[575] = "ReqSettleEncounter",
[576] = "ResSettleEncounter",
[577] = "ReqCancelEncounter",
[578] = "ResCancelEncounter",
[591] = "ReqDeckScheme",
[592] = "ResDeckScheme",
[593] = "ReqAddOrUpdateDeckScheme",
[594] = "ResAddOrUpdateDeckScheme",
[595] = "ReqRandomMonsterGroupList",
[596] = "ResRandomMonsterGroupList",
[597] = "ReqStageBuyNum",
[598] = "ResStageBuyNum",
[601] = "ReqPlayBuyNum",
[602] = "ResPlayBuyNum",
[603] = "ReqPlayClearCDTime",
[604] = "ResPlayClearCDTime",
[701] = "ReqInitBattleData",
[702] = "InitBattleData",
[703] = "BattleCompleteData",
[705] = "ReqBattleData",
[706] = "ResBattleData",
[707] = "ReqExitBattle",
[708] = "ResExitBattle",
[801] = "ReqShopData",
[802] = "ResShopData",
[803] = "ReqShopGridData",
[804] = "ResShopGridData",
[805] = "ReqShopReset",
[806] = "ResShopReset",
[807] = "ReqShopBuy",
[808] = "ResShopBuy",
[809] = "ReqGetBuyAssistNum",
[810] = "ResGetBuyAssistNum",
[811] = "ReqBuyAssist",
[812] = "ResBuyAssist",
[901] = "ReqLotteryInit",
[902] = "ResLotteryInit",
[903] = "ReqLotteryDraw",
[904] = "ResLotteryDraw",
[905] = "ReqSignInInit",
[906] = "ResSignInInit",
[907] = "ReqSignIn",
[908] = "ResSignIn",
[909] = "ReqSignInReward",
[910] = "ResSignInReward",
[911] = "ReqVitGetInit",
[912] = "ResVitGetInit",
[913] = "ReqVitGet",
[914] = "ResVitGet",
[915] = "ReqLoginAct",
[916] = "ResLoginAct",
[917] = "ReqLoginActGet",
[918] = "ResLoginActGet",
[919] = "ReqSlotsData",
[920] = "ResSlotsData",
[921] = "ReqSlotsReset",
[922] = "ResSlotsReset",
[923] = "ReqSlotsOperation",
[924] = "ResSlotsOperation",
[931] = "ReqActivityLottery",
[932] = "ResActivityLottery",
[925] = "ReqLotteryRecord",
[926] = "ResLotteryRecord",
[927] = "ReqInitConversion",
[928] = "ResInitConversion",
[929] = "ReqLotteryConversion",
[930] = "ResLotteryConversion",
[933] = "ReqSlotsRecord",
[934] = "ResSlotsRecord",
[1001] = "ReqGMLogin",
[1002] = "ResGMLogin",
[1003] = "ReqGMRegister",
[1004] = "ResGMRegister",
[1005] = "ReqGMList",
[1006] = "ResGMList",
[1007] = "ReqGMDel",
[1008] = "ResGMDel",
[1009] = "ReqGMUpdate",
[1010] = "ResGMUpdate",
[1011] = "ReqPlayerList",
[1012] = "ResPlayerList",
[1013] = "ReqPlayerInfo",
[1014] = "ResPlayerInfo",
[1015] = "ReqPlayerAddGoods",
[1016] = "ResPlayerAddGoods",
[1017] = "ReqGroupMail",
[1018] = "ResGroupMail",
[1019] = "ReqSendNotice",
[1020] = "ResSendNotice",
[1021] = "ReqGetConfig",
[1022] = "ResGetConfig",
[1023] = "ReqServerList",
[1024] = "ResServerList",
[1101] = "ReqTaskData",
[1102] = "ResTaskData",
[1103] = "ReqSubmitTask",
[1104] = "ResSubmitTask",
[1105] = "ReqGetTaskBox",
[1106] = "ResGetTaskBox",
[1201] = "ReqReadMail",
[1202] = "ResReadMail",
[1203] = "ReqMailDetail",
[1204] = "ResMailDetail",
[1205] = "ReqMailList",
[1206] = "ResMailList",
[1207] = "ReqGetMailAnnex",
[1208] = "ResGetMailAnnex",
[1209] = "ReqDeleteMail",
[1210] = "ResDeleteMail",
[1211] = "ReqRegisterMail",
[1212] = "ResRegisterMail",
[1301] = "ReqHandbookInit",
[1302] = "ResHandbookInit",
[1303] = "ReqCGCopyInfo",
[1304] = "ResCGCopyInfo",
[1305] = "ReqCGCopyStage",
[1306] = "ResCGCopyStage",
[1307] = "ReqStoryCopyGetCG",
[1308] = "ResStoryCopyGetCG",
[1309] = "ReqCGList",
[1310] = "ResCGList",
[1311] = "ReqHandLetterList",
[1312] = "ResHandLetterList",
[1313] = "ReqAdventureStoryChapter",
[1314] = "ResAdventureStoryChapter",
[1315] = "ReqAdventureStoryStage",
[1316] = "ResAdventureStoryStage",
[1317] = "ReqIntimacyInfo",
[1318] = "ResIntimacyInfo",
[1319] = "ReqInCGCopyStage",
[1320] = "ResInCGCopyStage",
[1321] = "ReqSettleCGCopyStage",
[1322] = "ResSettleCGCopyStage",
[1323] = "ReqCGCopySummary",
[1324] = "ResCGCopySummary",
[1325] = "ReqSwitchCard",
[1326] = "ResSwitchCard",
[1327] = "ReqOpenCG",
[1328] = "ResOpenCG",
[1329] = "ReqOpenLetter",
[1330] = "ResOpenLetter",
[1331] = "ReqClickPointPlot",
[1332] = "ResClickPointPlot",
[1401] = "ReqAdventureInit",
[1402] = "ResAdventureInit",
[1403] = "ReqPlayDice",
[1404] = "ResPlayDice",
[1405] = "ReqWishReward",
[1406] = "ResWishReward",
[1407] = "ReqAdventureBuilding",
[1408] = "ResAdventureBuilding",
[1409] = "ReqAdventureEventReward",
[1410] = "ResAdventureEventReward",
[1411] = "ReqInAdventureBattleEmba",
[1412] = "ResInAdventureBattleEmba",
[1413] = "ReqSettleAdventureBattle",
[1414] = "ResSettleAdventureBattle",
[1415] = "ReqInitAdventureBattleEmba",
[1416] = "ResInitAdventureBattleEmba",
[1501] = "ReqGuildList",
[1502] = "ResGuildList",
[1503] = "ReqSearchGuild",
[1504] = "ResSearchGuild",
[1505] = "ReqJoinGuild",
[1506] = "ResJoinGuild",
[1507] = "ReqCreateGuild",
[1508] = "ResCreateGuild",
[1511] = "ReqGuildDetailInfo",
[1512] = "ResGuildDetailInfo",
[1513] = "ReqSetGuildInfo",
[1514] = "ResSetGuildInfo",
[1515] = "ReqDisbandGuild",
[1516] = "ResDisbandGuild",
[1517] = "ReqQuitGuild",
[1518] = "ResQuitGuild",
[1519] = "ReqGuildMemberList",
[1520] = "ResGuildMemberList",
[1521] = "ReqSetGuildJob",
[1522] = "ResSetGuildJob",
[1523] = "ReqRemoveGuildMember",
[1524] = "ResRemoveGuildMember",
[1525] = "ReqGuildReview",
[1526] = "ResGuildReview",
[1527] = "ReqProcessApply",
[1528] = "ResProcessApply",
[1529] = "ReqGuildRank",
[1530] = "ResGuildRank",
[1531] = "ReqGuildBaseInfo",
[1532] = "ResGuildBaseInfo",
[1533] = "ReqGuildId",
[1534] = "ResGuildId",
[1535] = "ReqGuildBuildInit",
[1536] = "ResGuildBuildInit",
[1537] = "ReqGuildBuild",
[1538] = "ResGuildBuild",
[1539] = "ReqGuildGiftInit",
[1540] = "ResGuildGiftInit",
[1541] = "ReqGuildGiftGet",
[1542] = "ResGuildGiftGet",
[1543] = "ReqGuildGiftRank",
[1544] = "ResGuildGiftRank",
[1545] = "ReqGuildGameInit",
[1546] = "ResGuildGameInit",
[1547] = "ReqBeginGuildGame",
[1548] = "ResBeginGuildGame",
[1549] = "ReqGuildGamePlay",
[1550] = "ResGuildGamePlay",
[1551] = "ReqGuildGameReset",
[1552] = "ResGuildGameReset",
[1553] = "ReqGuildGameRecord",
[1554] = "ResGuildGameRecord",
[1555] = "ReqGuildLog",
[1556] = "ResGuildLog",
[1557] = "ReqGuildPK",
[1558] = "ResGuildPK",
[1559] = "ReqInGuildPK",
[1560] = "ResInGuildPK",
[1561] = "ReqSettleGuildPK",
[1562] = "ResSettleGuildPK",
[1563] = "ReqSyncGuildData",
[1564] = "ResSyncGuildData",
[1565] = "ReqPlayerCards",
[1566] = "ResPlayerCards",
[1567] = "ReqPopUpLevelUp",
[1568] = "ResPopUpLevelUp",
[1569] = "ReqGuildSummary",
[1570] = "ResGuildSummary",
[1571] = "ReqImpeachData",
[1572] = "ResImpeachData",
[1573] = "ReqVoting",
[1574] = "ResVoting",
[1601] = "ReqSetChat",
[1602] = "ResSetChat",
[1603] = "ReqSetAccpetChat",
[1604] = "ResSetAccpetChat",
[1605] = "ReqGetChat",
[1606] = "ResGetChat",
[1607] = "ReqGetCardChat",
[1608] = "ResGetCardChat",
[1609] = "ReqClickLike",
[1610] = "ResClickLike",
[1611] = "ReqGetLikeCard",
[1612] = "ResGetLikeCard",
[1613] = "ReqSetLikeCard",
[1614] = "ResSetLikeCard",
[1615] = "ReqMyClickLikeRemark",
[1616] = "ResMyClickLikeRemark",
[1701] = "ReqActivityList",
[1702] = "ResActivityList",
[1703] = "ReqActivityInfo",
[1704] = "ResActivityInfo",
[1705] = "ReqDecActivity",
[1706] = "ResDecActivity",
[1707] = "ReqTaskGroup",
[1708] = "ResTaskGroup",
[1709] = "ReqTaskReward",
[1710] = "ResTaskReward",
[1711] = "ReqPointReward",
[1712] = "ResPointReward",
[1713] = "ReqGetReward",
[1714] = "ResGetReward",
[1715] = "ReqActivityInfoList",
[1716] = "ResActivityInfoList",
[1731] = "ReqBannerIdList",
[1732] = "ResBannerIdList",
[1733] = "ReqSaveBannerId",
[1734] = "ResSaveBannerId",
[1735] = "ReqRemoveBannerId",
[1736] = "ResRemoveBannerId",
[1801] = "ReqFunctionList",
[1802] = "ResFunctionList",
[1803] = "ReqOpenFunction",
[1804] = "ResOpenFunction",
[1901] = "ReqRedDotList",
[1902] = "ResRedDotList",
[1903] = "ReqRemoveRedDot",
[1904] = "ResRemoveRedDot",
[1905] = "ReqAddRedDot",
[1906] = "ResAddRedDot",
[1907] = "ReqIntimacyLvChange",
[1908] = "ResIntimacyLvChange",
[1909] = "ReqGuideNotice",
[1910] = "ResGuideNotice",
[2001] = "ReqPayCheck",
[2002] = "ResPayCheck",
[2003] = "ReqPayData",
[2004] = "ResPayData",
[2005] = "ReqGetMoonReward",
[2006] = "ResGetMoonReward",
[2007] = "ReqPaySuccess",
[2008] = "ResPaySuccess",
[2101] = "ReqGuildWarInfo",
[2102] = "ResGuildWarInfo",
[2103] = "ReqRefreshBattleInfo",
[2104] = "ResRefreshBattleInfo",
[2111] = "ReqWarAdvisory",
[2112] = "ResWarAdvisory",
[2113] = "ReqHurtReport",
[2114] = "ResHurtReport",
[2121] = "ReqGuildTalent",
[2122] = "ResGuildTalent",
[2123] = "ReqUpTalent",
[2124] = "ResUpTalent",
[2125] = "ReqTalentReset",
[2126] = "ResTalentReset",
[2131] = "ReqWarReward",
[2132] = "ResWarReward",
[2133] = "ReqGetWarReward",
[2134] = "ResGetWarReward",
[2141] = "ReqSupportInfo",
[2142] = "ResSupportInfo",
[2143] = "ReqSupportSet",
[2144] = "ResSupportSet",
[2145] = "ReqSupportHarvest",
[2146] = "ResSupportHarvest",
[2151] = "ReqGSeasonRank",
[2152] = "ResGSeasonRank",
[2153] = "ReqMSeasonRank",
[2154] = "ResMSeasonRank",
[2161] = "ReqInGuildStage",
[2162] = "ResInGuildStage",
[2163] = "ReqInGuildWar",
[2164] = "ResInGuildWar",
[2165] = "ReqSettleGuildWar",
[2166] = "ResSettleGuildWar",
[2201] = "ReqRelations",
[2202] = "ResRelations",
[2211] = "ReqSearch",
[2212] = "ResSearch",
[2221] = "ReqChangeRelation",
[2222] = "ResChangeMyRelation",
[2223] = "ResChangeFriendRelation",
[2231] = "ReqFriendInfo",
[2232] = "ResFriendInfo",
[2241] = "ResFriendState",
[2251] = "ReqFriendPK",
[2252] = "ResFriendPK",
[2261] = "ReqInFriendPK",
[2262] = "ResInFriendPK",
[2271] = "ReqEndFriendPK",
[2272] = "ResEndFriendPK",
[2301] = "ReqInFamily",
[2302] = "ResInFamily",
[2303] = "ReqSeedWarehouse",
[2304] = "ResSeedWarehouse",
[2305] = "ReqLandPlanting",
[2306] = "ResLandPlanting",
[2307] = "ReqLandHarvest",
[2308] = "ResLandHarvest",
[2309] = "ReqLandUproot",
[2310] = "ResLandUproot",
[2311] = "ReqLandUnlock",
[2312] = "ResLandUnlock",
[2351] = "ReqRoomInfo",
[2352] = "ResRoomInfo",
[2353] = "ReqRoomEnter",
[2354] = "ResRoomEnter",
[2355] = "ReqRoomLayout",
[2356] = "ResRoomLayout",
[2357] = "ReqRoomLevelUp",
[2358] = "ResRoomLevelUp",
[2359] = "ReqRoomCallOn",
[2360] = "ResRoomCallOn",
[2361] = "ReqRandomPlayerInfo",
[2362] = "ResRandomPlayerInfo",
[2363] = "ReqQuitRoom",
[2364] = "ResQuitRoom",
[2400] = "ReqRiskData",
[2401] = "ResRiskData",
[2402] = "ReqBeginRisk",
[2403] = "ResBeginRisk",
[2404] = "ReqEndRisk",
[2405] = "ResEndRisk",
[2406] = "ReqRiskDataInit",
[2407] = "ResRiskDataInit",
[2408] = "ReqAssistFightInit",
[2409] = "ResAssistFightInit",
[2410] = "ReqChallengeAssistFight",
[2411] = "ResChallengeAssistFight",
[2412] = "ReqSettleAssistFight",
[2413] = "ResSettleAssistFight",
[2414] = "ReqGuildAssistData",
[2415] = "ResGuildAssistData",
[2416] = "ReqAssistGuildMember",
[2417] = "ResAssistGuildMember",
[2418] = "ResAssistFightData",
[2419] = "ReqNeedNoticeBossHP",
[2420] = "ResNeedNoticeBossHP",
[2421] = "ReqChallengeReward",
[2422] = "ResChallengeReward"}
, 
MsgName = {ResTrialInit = "ResTrialInit",
ReqInCGCopyStage = "ReqInCGCopyStage",
ResGuildLog = "ResGuildLog",
ReqStarUp = "ReqStarUp",
ReqEquipScheme = "ReqEquipScheme",
ResTempleInit = "ResTempleInit",
ReqQuitRoom = "ReqQuitRoom",
ResSyncGuildData = "ResSyncGuildData",
ResLotteryRecord = "ResLotteryRecord",
ReqSeedWarehouse = "ReqSeedWarehouse",
ReqDeleteMail = "ReqDeleteMail",
ResGuildWarInfo = "ResGuildWarInfo",
ResTalentReset = "ResTalentReset",
ReqGuideNotice = "ReqGuideNotice",
ResSettleTrial = "ResSettleTrial",
ResInitAdventureBattleEmba = "ResInitAdventureBattleEmba",
CardObject = "CardObject",
ReqCGCopyInfo = "ReqCGCopyInfo",
DataConfig = "DataConfig",
ReqShopExpeditionBuy = "ReqShopExpeditionBuy",
ResPlayerAddGoods = "ResPlayerAddGoods",
ReqEncounterBattleEmba = "ReqEncounterBattleEmba",
SettleTrial = "SettleTrial",
ResSkillUp = "ResSkillUp",
ReqSwitchCard = "ReqSwitchCard",
ReqSetGuildJob = "ReqSetGuildJob",
ReqLotteryDraw = "ReqLotteryDraw",
ReqDecActivity = "ReqDecActivity",
ResServerList = "ResServerList",
ResUpgradeAccount = "ResUpgradeAccount",
ReqArenaRefresh = "ReqArenaRefresh",
ResGuildSummary = "ResGuildSummary",
ReqMSeasonRank = "ReqMSeasonRank",
ResSetYjCode = "ResSetYjCode",
ReqPayCheck = "ReqPayCheck",
ReqActivateMatrixNode = "ReqActivateMatrixNode",
ReqInTrial = "ReqInTrial",
ReqPlayerAddGoods = "ReqPlayerAddGoods",
ReqInFriendPK = "ReqInFriendPK",
ReqRoomInfo = "ReqRoomInfo",
BattleBuffEffect = "BattleBuffEffect",
ResGetConfig = "ResGetConfig",
EquipObject = "EquipObject",
CardState = "CardState",
ReqSetExpedition = "ReqSetExpedition",
ReqRoomLayout = "ReqRoomLayout",
ReqInitAdventureBattleEmba = "ReqInitAdventureBattleEmba",
ReqSetLikeCard = "ReqSetLikeCard",
IntimacyPropInfo = "IntimacyPropInfo",
TotalPayInfo = "TotalPayInfo",
ReqStorySweep = "ReqStorySweep",
ChallengeSummarizeData = "ChallengeSummarizeData",
ResChallengeReward = "ResChallengeReward",
ReqGetLikeCard = "ReqGetLikeCard",
FurnitureData = "FurnitureData",
ReqSettleAdventureBattle = "ReqSettleAdventureBattle",
ResArenaFight = "ResArenaFight",
ResGuildGiftRank = "ResGuildGiftRank",
ResAssistFightInit = "ResAssistFightInit",
ResAdventureStoryChapter = "ResAdventureStoryChapter",
ReqSlotsData = "ReqSlotsData",
CGCopySummary = "CGCopySummary",
ResMatrixInfo = "ResMatrixInfo",
ResEquipScheme = "ResEquipScheme",
MsRankInfo = "MsRankInfo",
ReqSettleAssistFight = "ReqSettleAssistFight",
PropObject = "PropObject",
ReqInStage = "ReqInStage",
ResEndFriendPK = "ResEndFriendPK",
CardDetail = "CardDetail",
ResSlotsOperation = "ResSlotsOperation",
CardSummarizeData = "CardSummarizeData",
ResCreateGuild = "ResCreateGuild",
ResSetHandbookCover = "ResSetHandbookCover",
AllBattleTeamCardState = "AllBattleTeamCardState",
ReqExpedition = "ReqExpedition",
ArenaRival = "ArenaRival",
ReqShopGridData = "ReqShopGridData",
ResRoomEnter = "ResRoomEnter",
ReqGetBuyAssistNum = "ReqGetBuyAssistNum",
ResWearTitle = "ResWearTitle",
ReqGuildGiftInit = "ReqGuildGiftInit",
SlotsData = "SlotsData",
GuildWarBaseInfo = "GuildWarBaseInfo",
ResTalentTreeEnergyUp = "ResTalentTreeEnergyUp",
ResDestroyEquip = "ResDestroyEquip",
ResLotteryInit = "ResLotteryInit",
ResStarUp = "ResStarUp",
MailDetailInfo = "MailDetailInfo",
ReqRemoveEquipScheme = "ReqRemoveEquipScheme",
ReqActivityInfoList = "ReqActivityInfoList",
ReqPopUpLevelUp = "ReqPopUpLevelUp",
ConfigTime = "ConfigTime",
ResMailList = "ResMailList",
OtherLottery = "OtherLottery",
PointPlotInfo = "PointPlotInfo",
ReqSupportSet = "ReqSupportSet",
ReqLandHarvest = "ReqLandHarvest",
BaseInfo = "BaseInfo",
ReqWarAdvisory = "ReqWarAdvisory",
ReqRemoveRedDot = "ReqRemoveRedDot",
ReqGuildGiftGet = "ReqGuildGiftGet",
ReqTitleList = "ReqTitleList",
ReqSetChat = "ReqSetChat",
ReqPaySuccess = "ReqPaySuccess",
RoomStyle = "RoomStyle",
TrialStage = "TrialStage",
ReqPlayDice = "ReqPlayDice",
ResRemoveEquipScheme = "ResRemoveEquipScheme",
ReqGuildSummary = "ReqGuildSummary",
ReqLogout = "ReqLogout",
ResTaskGroup = "ResTaskGroup",
WarBattleInfo = "WarBattleInfo",
ResGMUpdate = "ResGMUpdate",
ReqDestroyEquip = "ReqDestroyEquip",
BuildingRecord = "BuildingRecord",
ResCancelEncounter = "ResCancelEncounter",
ResFastSweep = "ResFastSweep",
ResOpenCG = "ResOpenCG",
ResLevelUp = "ResLevelUp",
ResChangeMyRelation = "ResChangeMyRelation",
ResPlayBuyNum = "ResPlayBuyNum",
ResInAdventureBattleEmba = "ResInAdventureBattleEmba",
ResSlotsData = "ResSlotsData",
ResInExpedition = "ResInExpedition",
ResRegister = "ResRegister",
ReqCGCopyStage = "ReqCGCopyStage",
ResRoomCallOn = "ResRoomCallOn",
SlotsRecord = "SlotsRecord",
ReqSettleGuildPK = "ReqSettleGuildPK",
ResLandUproot = "ResLandUproot",
ResSettleGuildPK = "ResSettleGuildPK",
ResGuildPK = "ResGuildPK",
ResUpdateEquipSchemeName = "ResUpdateEquipSchemeName",
MoonPayInfo = "MoonPayInfo",
ResSubmitTask = "ResSubmitTask",
ResWarReward = "ResWarReward",
EquipSetsBuff = "EquipSetsBuff",
BattleWave = "BattleWave",
ReqGuildGiftRank = "ReqGuildGiftRank",
ResUseProp = "ResUseProp",
ResOldSetsTower = "ResOldSetsTower",
ResAdventureEventReward = "ResAdventureEventReward",
ResDecActivity = "ResDecActivity",
ShopData = "ShopData",
ReqPayData = "ReqPayData",
ReqFinishStory = "ReqFinishStory",
ReqAddOrUpdateDeckScheme = "ReqAddOrUpdateDeckScheme",
ResAddRedDot = "ResAddRedDot",
ReqOldSetsTower = "ReqOldSetsTower",
ReqGiftCode = "ReqGiftCode",
ReqIntimacyInfo = "ReqIntimacyInfo",
ReqUseEquipScheme = "ReqUseEquipScheme",
ResRoomLevelUp = "ResRoomLevelUp",
SeedInfo = "SeedInfo",
ReqGuildDetailInfo = "ReqGuildDetailInfo",
ResSettleGuildWar = "ResSettleGuildWar",
ResRiskData = "ResRiskData",
ReqSetGuildInfo = "ReqSetGuildInfo",
ReqArenaFight = "ReqArenaFight",
GuildSummaryInfo = "GuildSummaryInfo",
PlayerCardInfo = "PlayerCardInfo",
BulletScreen = "BulletScreen",
ReqRoomEnter = "ReqRoomEnter",
WarRewardInfo = "WarRewardInfo",
ResGuildList = "ResGuildList",
ResIntimacyLvChange = "ResIntimacyLvChange",
ReqDisbandGuild = "ReqDisbandGuild",
ResChallengeAssistFight = "ResChallengeAssistFight",
GuessCapRecord = "GuessCapRecord",
ResBuffExpedition = "ResBuffExpedition",
ResRiskDataInit = "ResRiskDataInit",
BattleData = "BattleData",
ReqPlayerList = "ReqPlayerList",
ResSellProp = "ResSellProp",
Event = "Event",
Expedition = "Expedition",
ResImpeachData = "ResImpeachData",
ReqGetCardChat = "ReqGetCardChat",
ResGoodsChange = "ResGoodsChange",
ReqSealSkillAc = "ReqSealSkillAc",
ResRelations = "ResRelations",
ResUpdateRank = "ResUpdateRank",
ResTalentInit = "ResTalentInit",
ReqLotteryConversion = "ReqLotteryConversion",
ArenaChangeData = "ArenaChangeData",
ReqSealSkillUp = "ReqSealSkillUp",
ReqFunctionList = "ReqFunctionList",
ReqSellProp = "ReqSellProp",
ReqGuildReview = "ReqGuildReview",
ResVitGetInit = "ResVitGetInit",
ReqClickLike = "ReqClickLike",
ResLevelUpMatrixSeal = "ResLevelUpMatrixSeal",
ReqAdventureStoryChapter = "ReqAdventureStoryChapter",
DeckScheme = "DeckScheme",
ResSaveNormalGuide = "ResSaveNormalGuide",
ReqTalentLevelUp = "ReqTalentLevelUp",
ResPlayerLevelUp = "ResPlayerLevelUp",
ResInitConversion = "ResInitConversion",
ResPlayClearCDTime = "ResPlayClearCDTime",
ResSettleAssistFight = "ResSettleAssistFight",
ResSetGuildJob = "ResSetGuildJob",
StageRivalCardState = "StageRivalCardState",
FriendDetailInfo = "FriendDetailInfo",
ResNeedNoticeBossHP = "ResNeedNoticeBossHP",
ResTowerInit = "ResTowerInit",
ReqSealUp = "ReqSealUp",
ReqSetYjCode = "ReqSetYjCode",
GsRankInfo = "GsRankInfo",
ReqSweepTrial = "ReqSweepTrial",
GuildInfo = "GuildInfo",
ResHurtReport = "ResHurtReport",
ReqCGCopySummary = "ReqCGCopySummary",
BattleDataRcord = "BattleDataRcord",
ResPing = "ResPing",
ReqLockEquip = "ReqLockEquip",
PropObjectGroup = "PropObjectGroup",
ProductInfo = "ProductInfo",
ResInGuildStage = "ResInGuildStage",
ReqRiskDataInit = "ReqRiskDataInit",
ReqSlotsReset = "ReqSlotsReset",
ReqGuildWarInfo = "ReqGuildWarInfo",
ReqReadMail = "ReqReadMail",
ResInGuildWar = "ResInGuildWar",
ResFriendInfo = "ResFriendInfo",
ReqMyClickLikeRemark = "ReqMyClickLikeRemark",
ResActivityInfoList = "ResActivityInfoList",
ReturnLoginActInfo = "ReturnLoginActInfo",
ReqEmbattle = "ReqEmbattle",
LimitGiftActInfo = "LimitGiftActInfo",
ReqLotteryRecord = "ReqLotteryRecord",
ReqRandomMonsterGroupList = "ReqRandomMonsterGroupList",
ResAdventureStoryStage = "ResAdventureStoryStage",
ReqAssistGuildMember = "ReqAssistGuildMember",
BuildingGuild = "BuildingGuild",
ResGuildReview = "ResGuildReview",
ReqClickPointPlot = "ReqClickPointPlot",
RedDotInfo = "RedDotInfo",
BattleAtkInfo = "BattleAtkInfo",
ResGetReward = "ResGetReward",
ReqBuyAssist = "ReqBuyAssist",
ResLotteryConversion = "ResLotteryConversion",
ResMatrixTreeInfo = "ResMatrixTreeInfo",
ResShopData = "ResShopData",
ReqVoting = "ReqVoting",
ResGMRegister = "ResGMRegister",
ResSupportHarvest = "ResSupportHarvest",
ReqDrawBuff = "ReqDrawBuff",
ResTaskData = "ResTaskData",
ResHeadData = "ResHeadData",
ReqSupportInfo = "ReqSupportInfo",
ReqBattleData = "ReqBattleData",
ResLandPlanting = "ResLandPlanting",
ResMSeasonRank = "ResMSeasonRank",
ReqGetBindReward = "ReqGetBindReward",
SupportObject = "SupportObject",
ResHandLetterList = "ResHandLetterList",
ArenaCard = "ArenaCard",
ReqGetMoonReward = "ReqGetMoonReward",
ResSupportSet = "ResSupportSet",
ResPutOnEquip = "ResPutOnEquip",
ResAdventureBuilding = "ResAdventureBuilding",
ReqGuildLog = "ReqGuildLog",
ResImageGuide = "ResImageGuide",
ReqJoinGuild = "ReqJoinGuild",
ReqGetConfig = "ReqGetConfig",
ReqFashionList = "ReqFashionList",
ReqInTowerEncounter = "ReqInTowerEncounter",
ReqGuildBuildInit = "ReqGuildBuildInit",
ReqBeginRisk = "ReqBeginRisk",
ResFashionList = "ResFashionList",
ResGetWarReward = "ResGetWarReward",
ExpeditionBattleData = "ExpeditionBattleData",
ResGuildGameRecord = "ResGuildGameRecord",
ReqSubmitTask = "ReqSubmitTask",
ExpeditionData = "ExpeditionData",
ResInStage = "ResInStage",
ResStoryCopyGetCG = "ResStoryCopyGetCG",
ResAdventureInit = "ResAdventureInit",
ReqPlayBuyNum = "ReqPlayBuyNum",
ResSettleAdventureBattle = "ResSettleAdventureBattle",
ResStoryInit = "ResStoryInit",
ReqGetMailAnnex = "ReqGetMailAnnex",
ResIntimacyInfo = "ResIntimacyInfo",
ReqTrialInit = "ReqTrialInit",
ReqGuildMemberList = "ReqGuildMemberList",
ReqCreateGuild = "ReqCreateGuild",
ReqProcessApply = "ReqProcessApply",
BattleTeamCardState = "BattleTeamCardState",
ExBuyData = "ExBuyData",
ResProcessApply = "ResProcessApply",
ReqGuildBaseInfo = "ReqGuildBaseInfo",
TaskSimpleObject = "TaskSimpleObject",
BattleBuffObject = "BattleBuffObject",
ReqSettleTrial = "ReqSettleTrial",
ResGuildDetailInfo = "ResGuildDetailInfo",
ReqPlayerLevelUp = "ReqPlayerLevelUp",
ReqShopBuy = "ReqShopBuy",
ResArenaRefresh = "ResArenaRefresh",
ReqTalentTreeEnergyUp = "ReqTalentTreeEnergyUp",
ReqUpTalent = "ReqUpTalent",
ReqSkillUp = "ReqSkillUp",
ResBattleRcord = "ResBattleRcord",
ResInFamily = "ResInFamily",
ReqPutOnEquip = "ReqPutOnEquip",
ReqWarReward = "ReqWarReward",
ReqGuildPK = "ReqGuildPK",
ResGMList = "ResGMList",
ReqSettleGuildWar = "ReqSettleGuildWar",
ResGuildRank = "ResGuildRank",
GuildGiftPostAndType = "GuildGiftPostAndType",
ReqRedDotList = "ReqRedDotList",
ReqCancelEncounter = "ReqCancelEncounter",
ReqVitGet = "ReqVitGet",
ReqBirthdayList = "ReqBirthdayList",
ResExchangeDebris = "ResExchangeDebris",
ReqSetMainCover = "ReqSetMainCover",
ReqRoomCallOn = "ReqRoomCallOn",
ReqSettleEncounter = "ReqSettleEncounter",
ResLandUnlock = "ResLandUnlock",
ResActivateMatrixNode = "ResActivateMatrixNode",
ResPushSet = "ResPushSet",
TotalPayActInfo = "TotalPayActInfo",
ReqNeedNoticeBossHP = "ReqNeedNoticeBossHP",
BattleCompleteData = "BattleCompleteData",
ReqInGuildWar = "ReqInGuildWar",
ResGMLogin = "ResGMLogin",
ResFriendPK = "ResFriendPK",
StageInfo = "StageInfo",
ResWishReward = "ResWishReward",
ReqPing = "ReqPing",
ReqAdventureBuilding = "ReqAdventureBuilding",
ReqHandLetterList = "ReqHandLetterList",
ResSignInInit = "ResSignInInit",
ResAssistGuildMember = "ResAssistGuildMember",
ReqSettleExpedition = "ReqSettleExpedition",
ResPlayDice = "ResPlayDice",
GuildRankInfo = "GuildRankInfo",
ResPlayerInfo = "ResPlayerInfo",
ResDeleteMail = "ResDeleteMail",
ResCGCopyInfo = "ResCGCopyInfo",
TrialData = "TrialData",
ReqDeckScheme = "ReqDeckScheme",
ReqStoryReward = "ReqStoryReward",
ResHorseSet = "ResHorseSet",
DailyPayInfo = "DailyPayInfo",
ReqVitGetInit = "ReqVitGetInit",
ResExitBattle = "ResExitBattle",
ResMyClickLikeRemark = "ResMyClickLikeRemark",
ResRoomInfo = "ResRoomInfo",
ResRemoveRedDot = "ResRemoveRedDot",
ResGuildGiftInit = "ResGuildGiftInit",
ResGetMailAnnex = "ResGetMailAnnex",
ExpeBuff = "ExpeBuff",
ReqGSeasonRank = "ReqGSeasonRank",
BattleTeamInfo = "BattleTeamInfo",
ReqDetailInfo = "ReqDetailInfo",
ReqActivateFetter = "ReqActivateFetter",
ResSealUp = "ResSealUp",
ReqRelations = "ReqRelations",
ReqLoginAct = "ReqLoginAct",
ResLockEquip = "ResLockEquip",
ReqGuildList = "ReqGuildList",
ReqLandUnlock = "ReqLandUnlock",
ResNextChapterInfo = "ResNextChapterInfo",
ResTalentLevelUp = "ResTalentLevelUp",
ReqLogin = "ReqLogin",
ReqActivityInfo = "ReqActivityInfo",
ReqInTower = "ReqInTower",
GuessCapReward = "GuessCapReward",
ResDeckScheme = "ResDeckScheme",
ResInTower = "ResInTower",
ResPaySuccess = "ResPaySuccess",
ResUseEquipScheme = "ResUseEquipScheme",
ResInTowerEncounter = "ResInTowerEncounter",
ReqSaveNormalGuide = "ReqSaveNormalGuide",
ReqMailDetail = "ReqMailDetail",
ReqOpenCG = "ReqOpenCG",
ReqHurtReport = "ReqHurtReport",
ResInFriendPK = "ResInFriendPK",
RiskEvent = "RiskEvent",
ResDisbandGuild = "ResDisbandGuild",
ResStageBuyNum = "ResStageBuyNum",
ReqFastSweep = "ReqFastSweep",
ReqAddRedDot = "ReqAddRedDot",
ReqGuildGameRecord = "ReqGuildGameRecord",
ShowSlotsRecord = "ShowSlotsRecord",
ReqArenaReward = "ReqArenaReward",
WarPromptInfo = "WarPromptInfo",
ResExtraReward = "ResExtraReward",
LotterRecord = "LotterRecord",
ResBeginGuildGame = "ResBeginGuildGame",
ReqQualityUp = "ReqQualityUp",
ReqBeginGuildGame = "ReqBeginGuildGame",
ReqSendNotice = "ReqSendNotice",
ResStoryReward = "ResStoryReward",
ResChangeFriendRelation = "ResChangeFriendRelation",
ResRandomMonsterGroupList = "ResRandomMonsterGroupList",
ResTalentTreeStarUp = "ResTalentTreeStarUp",
ReqSignInReward = "ReqSignInReward",
ReqPlayClearCDTime = "ReqPlayClearCDTime",
ResBeginRisk = "ResBeginRisk",
ResAddOrUpdateDeckScheme = "ResAddOrUpdateDeckScheme",
ResEmbattle = "ResEmbattle",
ReqLoginActGet = "ReqLoginActGet",
ReqTalentTreeStarUp = "ReqTalentTreeStarUp",
ResActivityList = "ResActivityList",
ReqInFamily = "ReqInFamily",
ReqWishReward = "ReqWishReward",
ReqPushSet = "ReqPushSet",
TempleCardCommonObject = "TempleCardCommonObject",
GuildWarSummaryInfo = "GuildWarSummaryInfo",
ReqSettleStage = "ReqSettleStage",
ResPointReward = "ResPointReward",
ResDetailInfo = "ResDetailInfo",
ReqMatrixTreeInfo = "ReqMatrixTreeInfo",
ResAssistFightData = "ResAssistFightData",
GiftRank = "GiftRank",
ReqCheckStoryFinish = "ReqCheckStoryFinish",
ResIdentifyEquip = "ResIdentifyEquip",
ResDrawBuff = "ResDrawBuff",
ResTaskReward = "ResTaskReward",
ResGuildBuild = "ResGuildBuild",
ResWarAdvisory = "ResWarAdvisory",
ResHandbookInit = "ResHandbookInit",
ReqOverture = "ReqOverture",
ReqInExpedition = "ReqInExpedition",
ReqSealOpen = "ReqSealOpen",
ReqSet = "ReqSet",
ReqGuildGameReset = "ReqGuildGameReset",
ReqGMRegister = "ReqGMRegister",
ReqSignInInit = "ReqSignInInit",
ResPayData = "ResPayData",
InitBattleData = "InitBattleData",
ReqTaskReward = "ReqTaskReward",
ResSlotsReset = "ResSlotsReset",
ReqBattleRcord = "ReqBattleRcord",
ResSignIn = "ResSignIn",
ReqStoryCopyGetCG = "ReqStoryCopyGetCG",
ResSettleStage = "ResSettleStage",
EquipScheme = "EquipScheme",
ReqWearTitle = "ReqWearTitle",
BattleTeam = "BattleTeam",
ResShopGridData = "ResShopGridData",
InBattleInfo = "InBattleInfo",
ResActivityInfo = "ResActivityInfo",
ReqExtraReward = "ReqExtraReward",
ReqRemoveGuildMember = "ReqRemoveGuildMember",
ReqArenaRank = "ReqArenaRank",
ResSettleEncounter = "ResSettleEncounter",
ResBirthdayList = "ResBirthdayList",
ReqAddEquipScheme = "ReqAddEquipScheme",
CardLevelInfo = "CardLevelInfo",
EquipObjectGroup = "EquipObjectGroup",
ResUpdateInfo = "ResUpdateInfo",
ReqChat = "ReqChat",
ResQualityUp = "ResQualityUp",
ReqSetAccpetChat = "ReqSetAccpetChat",
TempleActInfo = "TempleActInfo",
TaskObject = "TaskObject",
ReqChallengeAssistFight = "ReqChallengeAssistFight",
CardEquipInfo = "CardEquipInfo",
ResRoomLayout = "ResRoomLayout",
ResInCGCopyStage = "ResInCGCopyStage",
ReqStoryInit = "ReqStoryInit",
ResJoinGuild = "ResJoinGuild",
ReqRoomLevelUp = "ReqRoomLevelUp",
ReqQuitGuild = "ReqQuitGuild",
GuildBaseInfo = "GuildBaseInfo",
ReqMailList = "ReqMailList",
ResSetChat = "ResSetChat",
ReqAdventureEventReward = "ReqAdventureEventReward",
MatrixTreeInfo = "MatrixTreeInfo",
ReqEndRisk = "ReqEndRisk",
ResOpenFunction = "ResOpenFunction",
ResArenaReward = "ResArenaReward",
SupportCardInfo = "SupportCardInfo",
ResChat = "ResChat",
ReqInAdventureBattleEmba = "ReqInAdventureBattleEmba",
ResAddEquipScheme = "ResAddEquipScheme",
ResGuildGamePlay = "ResGuildGamePlay",
ReqImpeachData = "ReqImpeachData",
ReqEndFriendPK = "ReqEndFriendPK",
ResSaveBannerId = "ResSaveBannerId",
SetObject = "SetObject",
ReqSupportHarvest = "ReqSupportHarvest",
ResSignInReward = "ResSignInReward",
ReqTaskGroup = "ReqTaskGroup",
ReqRemoveBannerId = "ReqRemoveBannerId",
ReqUpdateEquipSchemeName = "ReqUpdateEquipSchemeName",
ResShopReset = "ResShopReset",
MatrixInfo = "MatrixInfo",
ReqChallengeReward = "ReqChallengeReward",
ResSweepTrial = "ResSweepTrial",
ResNormalGuide = "ResNormalGuide",
ReqSetFashion = "ReqSetFashion",
ResTitleList = "ResTitleList",
ResSeedWarehouse = "ResSeedWarehouse",
ReqSettleCGCopyStage = "ReqSettleCGCopyStage",
ReqServerList = "ReqServerList",
ResAlert = "ResAlert",
ReqInitConversion = "ReqInitConversion",
ResCGCopyStage = "ResCGCopyStage",
ReqLevelUpMatrixSeal = "ReqLevelUpMatrixSeal",
ResPopUpLevelUp = "ResPopUpLevelUp",
ReqChangeRelation = "ReqChangeRelation",
ReqSlotsRecord = "ReqSlotsRecord",
ResSupportInfo = "ResSupportInfo",
ReqHeadData = "ReqHeadData",
ResCGList = "ResCGList",
ResSetGuildInfo = "ResSetGuildInfo",
ReqStageBuyNum = "ReqStageBuyNum",
ReqHandbookInit = "ReqHandbookInit",
ReqTalentReset = "ReqTalentReset",
DefendCardInfo = "DefendCardInfo",
TowerStage = "TowerStage",
ReqFriendInfo = "ReqFriendInfo",
ReqTaskData = "ReqTaskData",
ResBirthdayReward = "ResBirthdayReward",
ReqSearch = "ReqSearch",
SlotItemData = "SlotItemData",
ResGuildBaseInfo = "ResGuildBaseInfo",
ReqOpenFunction = "ReqOpenFunction",
ResCheckStoryFinish = "ResCheckStoryFinish",
NodeReward = "NodeReward",
ResShopExpedition = "ResShopExpedition",
ReqSignIn = "ReqSignIn",
ResSearch = "ResSearch",
ResExpedition = "ResExpedition",
BaseActivityInfo = "BaseActivityInfo",
ResQuitGuild = "ResQuitGuild",
ResOpenLetter = "ResOpenLetter",
ReqInGuildPK = "ReqInGuildPK",
ResGuildBuildInit = "ResGuildBuildInit",
MemberSummary = "MemberSummary",
TitleInfo = "TitleInfo",
ReqAdventureStoryStage = "ReqAdventureStoryStage",
ResArenaData = "ResArenaData",
LotteryIntegralActInfo = "LotteryIntegralActInfo",
ReqPointReward = "ReqPointReward",
ReqRandomPlayerInfo = "ReqRandomPlayerInfo",
ResGetMoonReward = "ResGetMoonReward",
ResEndRisk = "ResEndRisk",
AssistFightData = "AssistFightData",
ReqInGuildStage = "ReqInGuildStage",
GoodsList = "GoodsList",
ResGuideNotice = "ResGuideNotice",
FarmInfo = "FarmInfo",
ArenaRankData = "ArenaRankData",
ReqSearchGuild = "ReqSearchGuild",
ReqGroupMail = "ReqGroupMail",
ResGetBindReward = "ResGetBindReward",
RivalCardState = "RivalCardState",
ShopGridData = "ShopGridData",
ResLotteryDraw = "ResLotteryDraw",
CGCopyStage = "CGCopyStage",
ReqHorseSet = "ReqHorseSet",
ResQuitRoom = "ResQuitRoom",
ReqActivityLottery = "ReqActivityLottery",
ReqGuildBuild = "ReqGuildBuild",
BattleCardData = "BattleCardData",
ResCGCopySummary = "ResCGCopySummary",
ResSettleExpedition = "ResSettleExpedition",
ReqShopData = "ReqShopData",
ResPlayerList = "ResPlayerList",
Building = "Building",
ResVitGet = "ResVitGet",
ReqIdentifyEquip = "ReqIdentifyEquip",
ReqRiskData = "ReqRiskData",
DropInfo = "DropInfo",
RiskData = "RiskData",
ResGetCardChat = "ResGetCardChat",
ResGetLikeCard = "ResGetLikeCard",
ReqUpgradeAccount = "ReqUpgradeAccount",
ResEncounterBattleEmba = "ResEncounterBattleEmba",
LandInfo = "LandInfo",
ReqLandUproot = "ReqLandUproot",
ResRefreshBattleInfo = "ResRefreshBattleInfo",
CardSealSkillInfo = "CardSealSkillInfo",
ResGMDel = "ResGMDel",
ArenaData = "ArenaData",
ResSetLikeCard = "ResSetLikeCard",
ResGetTaskBox = "ResGetTaskBox",
ReqIntimacyLvChange = "ReqIntimacyLvChange",
HurtReportInfo = "HurtReportInfo",
ResArenaRank = "ResArenaRank",
ResGuildGameInit = "ResGuildGameInit",
ResLoginAct = "ResLoginAct",
ReqRegisterMail = "ReqRegisterMail",
ReqExchangeDebris = "ReqExchangeDebris",
ChapterInfo = "ChapterInfo",
ReqGuildTalent = "ReqGuildTalent",
WarStageInfo = "WarStageInfo",
ReqGuildId = "ReqGuildId",
ReqNormalGuide = "ReqNormalGuide",
PreBattleEvent = "PreBattleEvent",
ReqLevelUpEquip = "ReqLevelUpEquip",
GoodsChangeObject = "GoodsChangeObject",
ResRedDotList = "ResRedDotList",
ResVoting = "ResVoting",
ApplyInfo = "ApplyInfo",
ReqArenaData = "ReqArenaData",
ReqSettleTower = "ReqSettleTower",
ResPlayerCards = "ResPlayerCards",
ResSetAccpetChat = "ResSetAccpetChat",
CommonObject = "CommonObject",
ResGuildMemberList = "ResGuildMemberList",
ReqSealData = "ReqSealData",
ReqGuildRank = "ReqGuildRank",
ResRandomPlayerInfo = "ResRandomPlayerInfo",
ReqLevelUp = "ReqLevelUp",
MailSummaryInfo = "MailSummaryInfo",
ResSealSkillUp = "ResSealSkillUp",
ResSet = "ResSet",
ReqGMUpdate = "ReqGMUpdate",
GuildTalentInfo = "GuildTalentInfo",
ReqSlotsOperation = "ReqSlotsOperation",
ReqAssistFightInit = "ReqAssistFightInit",
ReqGetWarReward = "ReqGetWarReward",
ResSlotsRecord = "ResSlotsRecord",
ReqLandPlanting = "ReqLandPlanting",
ReqTalentInit = "ReqTalentInit",
ReqUseProp = "ReqUseProp",
ResSealOpen = "ResSealOpen",
RoomInfo = "RoomInfo",
ResSealSkillAc = "ResSealSkillAc",
ResBattleData = "ResBattleData",
ResGiftCode = "ResGiftCode",
ResLevelUpEquip = "ResLevelUpEquip",
ResRegisterMail = "ResRegisterMail",
ReqSaveBannerId = "ReqSaveBannerId",
ResGuildGameReset = "ResGuildGameReset",
ResGSeasonRank = "ResGSeasonRank",
LetterInfo = "LetterInfo",
ResPayCheck = "ResPayCheck",
ResSettleTower = "ResSettleTower",
ResInTrial = "ResInTrial",
ResShopBuy = "ResShopBuy",
ReqImageGuide = "ReqImageGuide",
ResGuildId = "ResGuildId",
TalentTreeInfo = "TalentTreeInfo",
ReqPlayerCards = "ReqPlayerCards",
ReqSetHandbookCover = "ReqSetHandbookCover",
ReqPlayerInfo = "ReqPlayerInfo",
ResMailDetail = "ResMailDetail",
DamageData = "DamageData",
ResBuyAssist = "ResBuyAssist",
ReqActivityList = "ReqActivityList",
ResSetMainCover = "ResSetMainCover",
ReqGMList = "ReqGMList",
ReqGMDel = "ReqGMDel",
ResBannerIdList = "ResBannerIdList",
DailyPayActInfo = "DailyPayActInfo",
ReqRegister = "ReqRegister",
Tower = "Tower",
ResStorySweep = "ResStorySweep",
SevenDayActInfo = "SevenDayActInfo",
ResClickPointPlot = "ResClickPointPlot",
ResSearchGuild = "ResSearchGuild",
CardStateExpedition = "CardStateExpedition",
ResActivateFetter = "ResActivateFetter",
ReqOpenLetter = "ReqOpenLetter",
ResRemoveBannerId = "ResRemoveBannerId",
PlantInfo = "PlantInfo",
ResGuildTalent = "ResGuildTalent",
PreBattleEventInfo = "PreBattleEventInfo",
ReqFriendPK = "ReqFriendPK",
ResLoginActGet = "ResLoginActGet",
StoryData = "StoryData",
ResFunctionList = "ResFunctionList",
ReqMatrixInfo = "ReqMatrixInfo",
ResLogout = "ResLogout",
ReqRefreshBattleInfo = "ReqRefreshBattleInfo",
ResSwitchCard = "ResSwitchCard",
MemberInfo = "MemberInfo",
ChatData = "ChatData",
LoginDayActInfo = "LoginDayActInfo",
ReqExitBattle = "ReqExitBattle",
ReqSyncGuildData = "ReqSyncGuildData",
CardSkillInfo = "CardSkillInfo",
ResLandHarvest = "ResLandHarvest",
ResSendNotice = "ResSendNotice",
ResSetFashion = "ResSetFashion",
ResInGuildPK = "ResInGuildPK",
ArenaRewardTemp = "ArenaRewardTemp",
FurnitureObject = "FurnitureObject",
GuildLogInfo = "GuildLogInfo",
ResLogin = "ResLogin",
VoteInfo = "VoteInfo",
ReqTempleInit = "ReqTempleInit",
ReqGuildGamePlay = "ReqGuildGamePlay",
ResSettleCGCopyStage = "ResSettleCGCopyStage",
ReqGetReward = "ReqGetReward",
ReqBirthdayReward = "ReqBirthdayReward",
ResActivityLottery = "ResActivityLottery",
CGInfo = "CGInfo",
FriendInfo = "FriendInfo",
ResReadMail = "ResReadMail",
ReqBannerIdList = "ReqBannerIdList",
BattleRound = "BattleRound",
ResShopExpeditionBuy = "ResShopExpeditionBuy",
ResSealData = "ResSealData",
ReqGuildGameInit = "ReqGuildGameInit",
ReqTowerInit = "ReqTowerInit",
ReqShopReset = "ReqShopReset",
ResGetChat = "ResGetChat",
ResGroupMail = "ResGroupMail",
GoodsObject = "GoodsObject",
ReqGetTaskBox = "ReqGetTaskBox",
ReqAdventureInit = "ReqAdventureInit",
ReqLotteryInit = "ReqLotteryInit",
ResFriendState = "ResFriendState",
ResClickLike = "ResClickLike",
ReqGMLogin = "ReqGMLogin",
ResGetBuyAssistNum = "ResGetBuyAssistNum",
BattleBuff = "BattleBuff",
ResUpTalent = "ResUpTalent",
RoomCardInfo = "RoomCardInfo",
ReqGetChat = "ReqGetChat",
ReqCGList = "ReqCGList",
ResGuildGiftGet = "ResGuildGiftGet",
ResRemoveGuildMember = "ResRemoveGuildMember",
Trial = "Trial"}
}
_ENV.ProtoEnum = {
E_PLAYER_INFO = {INFO_UNKNOWN = 0, BASE = 1, BAG = 2, MAIL = 3, TASK = 4}
, 
GUILD_WAR_SUPPORT = {DEFAULT_SUPPORT = 0, JOIN = 1, QUIT = 2}
, 
E_GM_TYPE = {GM_UNKNOWN = 0, SUPER = 1, ADMIN = 2, GUEST = 3}
, 
E_PUSH_TYPE = {DEFAULT_PUSH_TYPE = 0, VIT_COMEBACK = 1, VIT_GET = 2, FARM_HARVEST = 3, TIMING_PUSH = 4, ACTIVITY_OPEN = 5, ACTIVITY_END = 6, GM_PUSH = 99}
, 
CHAT_SUB_TYPE = {DEFAULT_SUB_CHAT = 0, ADVENTURE_BULLET = 201, WORLD_CHAT = 401, SERVER_CHAT = 402}
, 
E_MSG_TYPE = {MsgType_Unknown = 0, MsgType_System = 100, MsgType_Player = 200, MsgType_Bag = 300, MsgType_Card = 400, MsgType_Challenge = 500, MsgType_Play = 600, MsgType_Battle = 700, MsgType_Shop = 800, MsgType_Boon = 900, MsgType_GM = 1000, MsgType_Task = 1100, MsgType_Mail = 1200, MsgType_Handbook = 1300, MsgType_Adventure = 1400, MsgType_Guild = 1500, MsgType_Chat = 1600, MsgType_Activity = 1700, MsgType_Function = 1800, MsgType_RedDot = 1900, MsgType_Pay = 2000, MsgType_GuildWar = 2100, MsgType_Friend = 2200, MsgType_Family = 2300, MsgType_Risk = 2400}
, 
GUILD_APPLY = {DEFAULT_APPLY = 0, PASS_APPLY = 1, REFUSE_APPLY = 2}
, 
E_LOGIN_TYPE = {LOGIN_TYPE_UNKNOWN = 0, DEFAULT = 1, RELINK = 2}
, 
GUILD_ACTION = {DEFAULT_ACTION = 0, JOIN_ACTION = 1, APPLY_ACTION = 2, CANCEL_ACTION = 3}
, 
E_EMBATTLE_TYPE = {EMBATTLE_UNKNOWN = 0, EMBATTLE_DEFAULT = 1, EMBATTLE_STORE = 2, EMBATTLE_ELITE = 3, EMBATTLE_GOLD = 4, EMBATTLE_EXP = 5, EMBATTLE_EQUIPEXP = 6, EMBATTLE_ATTA = 7, EMBATTLE_ARENA_GUARD = 8, EMBATTLE_TOWER = 9, EMBATTLE_ENCOUNTER = 10, EMBATTLE_ASSIST_BOSS = 11, EMBATTLE_TOWER_EXPAND = 12}
, 
E_ALERT_TYPE = {ALERT_TYPE_UNKNOWN = 0, NOTICE = 1, WARN = 2, HIDE = 3}
, 
GUILD_WAR_PROMPT = {DEFAULT_PROMPT = 0, NEW_SEASON = 1, SETTLE_SEASON = 2}
, 
LAND_STATUS = {DEFAULT_LOCK = 0, FREE = 1, PLANTED = 2, HARVEST = 3}
, 
E_LOGIN_RESULT = {LOGIN_RESULT_UNKNOWN = 0, SUCCESS = 1, FAIL = 2, AUTH = 3, REGISTER = 4, WAIT = 5, LOCK = 6}
, 
GUILD_POST = {DEFAULT_POST = 0, MEMBER_POST = 1, ELDER_POST = 2, VICE_LEADER_POST = 3, LEADER_POST = 4}
, 
E_PLATFORM = {PLATFORM_UNKNOW = 0, IOS = 1, ANDROID = 2, PC = 3}
, 
E_GOODS_TYPE = {GOODS_TYPE_UNKNOWN = 0, PROP = 1, ASSET = 2, CARD = 3, EQUIP = 4, TITLE = 5, OTHER = 6, SEED = 7, FURNITURE = 8, HEAD_ICON = 9, HEAD_FRAME = 10, FASHION = 11}
, 
E_REGISTER_RESULT = {REGISTER_RESULT_UNKNOWN = 0, REPEATED = 1, REGISTER_ING = 2}
, 
E_BATTLE_DATA_TYPE = {BATTLE_DATA_UNKNOWN = 0, BATTLE_DATA_RECORD = 1, BATTLE_DATA_IN_BATTLE = 2}
, 
FriendOperationType = {UNKNOWN = 0, ADD_FRIEND = 1, DEL_FRIEND = 2, AGREE_INVITE = 3, REFUSE_INVITE = 4, CANCAL_INVITE = 5}
, 
WAR_SETTLE_TYPE = {DEFAULT_SETTLE_TYPE = 0, SIMULATION = 1, MURDERER = 2, PASSED = 3}
, 
GUILD_SET = {DEFAULT_SET = 0, ICON_SET = 1, NAME_SET = 2, COND_SET = 3, NOTICE_SET = 4}
, 
E_BATTLE_TYPE = {BATTLE_TYPE_UNKNOWN = 0, ARENA = 1, STORY = 2, HERO = 3, GOLD = 4, EXP = 5, EQUIPEXP = 6, TOWER = 7, EXPEDITION = 8, CG = 9, ADVENTURE = 10, GUILD_PK = 11, ACTIVITY = 12, TOWER_ENCOUNTER = 13, GUILD_WAR = 14, FRIEND_PK = 15, TEMPLE = 16, ASSIST = 17, TOWER_EXPAND = 18}
, 
GUILD_WAR_STATUS = {DEFAULT_STATUS = 0, READY = 1, CHALLENGE = 2, SETTLE = 3}
, 
E_STATUS_TYPE = {STATUS_TYPE_NOT = 0, STATUS_TYPE_CAN = 1, STATUS_TYPE_HAS = 2}
, 
E_MAIL_TYPE = {MAIL_TYPE_UNKNOWN = 0, MAIL_SYSTEM = 1, MAIL_BACKEND = 2, MAIL_MARKET = 3}
, 
E_CHAPTER_OPEN_CONDITION = {COC_UNKNOWN = 0, PLAYER_LEVEL = 1, PASS_STAGE = 2}
, 
E_CHALLENGE_TYPE = {UNKNOW_CHALLENGE = 0, STORE_CHALLENGE = 1, ELITE_CHALLENGE = 2, GOLD_CHALLENGE = 3, EXP_CHALLENGE = 4, EQUIPEXP_CHALLENGE = 5, ARENA_CHALLENGE = 6, TOWER_CHALLENGE = 7, EXPEDITION_CHALLENGE = 8, CG_CHALLENGE = 9, ADVENTURE_CHALLENGE = 10, GUILD_PK_CHALLENGE = 11, ENCOUNTER_CHALLENGE = 13, GUILD_WAR_CHALLENGE = 14, FRIEND_PK_CHALLENGE = 15, TEMPLE_CHALLENGE = 20, ACTIVITY_CHALLENGE = 101, NEW_ACTIVITY_ASSIST = 103, NEW_ACTIVITY_CHALLENGE = 201, TOWER_EXPAND_CHALLENGE = 301}
, 
BUY_ASSIST_TYPE = {DEFAULT_BUY_TIME = 0, GOLD_BUY_TIME_TYPE = 1, VIT_BUY_TIME_TYPE = 2, STA_BUY_TIME_TYPE = 3, ENERGY_BUY_TIME_TYPE = 4}
, 
FriendOperationCode = {OP_SUCCESS = 0, EXCEED_MAX_FRIEND_COUNT = 1, EXCEED_TARGET_MAX_FRIEND_COUNT = 2, ALREADY_IS_FRIEND = 3, EXCEED_MAX_MY_INVITE_COUNT = 4, NEVER_BE_INVITED = 5, CAN_NOT_ADD_SELF = 6, CAN_NOT_FIND_PLAYER = 7, NOT_OPEN_FUNCTION = 8, FRIEND_NOT_OPEN_FUNCTION = 9}
, 
E_RANK_TYPE = {RANK_TYPE_UNKNOWN = 0}
, 
E_LOTTERY_TYPE = {LOTTERY_TYPE_UNKNOWN = 0, LOTTERY_TYPE_CARD = 1, LOTTERY_TYPE_EQUIP = 2, LOTTERY_TYPE_COUPON = 3, LOTTERY_TYPE_NOVICE = 4, LOTTERY_TEN_EVEN_CAPSULE = 6, LOTTERY_ACTIVITY_CAPSULE_UP1 = 7, LOTTERY_ACTIVITY_CAPSULE_UP2 = 8, LOTTERY_ACTIVITY_CAPSULE_UP3 = 9, LOTTERY_ACTIVITY_CAPSULE_UP4 = 10, LOTTERY_ACTIVITY_TEN_EVEN_CAPSULE1 = 11, LOTTERY_ACTIVITY_TEN_EVEN_CAPSULE2 = 12, LOTTERY_ACTIVITY_TEN_EVEN_CAPSULE3 = 13, LOTTERY_ACTIVITY_TEN_EVEN_CAPSULE4 = 14}
, 
E_QUERY_TYPE = {QUERY_UNKNOWN = 0, OBJECT_INDEX = 1, ACCOUNT = 2, NAME = 3}
, 
E_SET_TYPE = {SET_TYPE_UNKNOWN = 0, FASHION_HEAD = 1, FASHION_SHOW = 2, SIGNATURE = 3, NICK_NAME = 4, NICK_NAME_NO_COST = 5, SET_TYPE_NOTICE = 6, SET_TYPE_BATTLE_FRAME = 7, SET_TYPE_UI_FRAME = 8, FASHION_FRAME = 9}
, 
E_LOTTERY_MODE = {LOTTERY_MODE = 0, LOTTERY_MODE_ONCE = 1, LOTTERY_MODE_MORE = 2, LOTTERY_MODE_DAY = 3, LOTTERY_MODE_NOVICE = 4}
, 
CHAT_TYPE = {DEFAULT_CHAT = 0, GUILD_CHAT = 1, BULLET_CHAT = 2, PRIVATE_CHAT = 3, CHANNEL_CHAT = 4, CARD_CHAT = 5}
, 
E_CHANNEL = {CHANNEL_UNKNOW = 0, QUICK = 1, PHONE = 2, YOOZOO = 3, YINJI = 4}
, 
GUIDE_TYPE = {DEFAULT_TYPE = 0, COPY_STORY_TYPE = 1, COPY_HERO_TYPE = 2, COPY_DAILY_TYPE = 3, COPY_DAILY_STAGE_TYPE = 4, COPY_EXPEDITION_TYPE = 5, TASK_TYPE = 6, SHOP_TYPE = 7, HANDBOOK_STAGE_TYPE = 8, COPY_TOWER_TYPE = 9, GUILD_WAR_TYPE = 10, HANDBOOK_CHAPTER = 11}
, 
GUILD_LOG = {DEFAULT_LOG = 0, JOIN_LOG = 1, QUIT_LOG = 2, OUT_LOG = 3, PROMOTION_LOG = 4, DOWNGRADE_LOG = 5, TRANSFER_LOG = 6, CREATE_LOG = 7, RENAME_LOG = 8}
, 
E_GOODS_OTHER_ID = {GOODS_OTHER_ID_UNKNOWN = 0, FC = 1, LEVEL = 2}
, 
E_GENDER = {GENDER_UNKNOWN = 0, MALE = 1, FEMALE = 2}
}
;
(_ENV.setmetatable)(Proto.MsgName, {__index = function(t, k, ...)
  -- function num : 0_0 , upvalues : _ENV
  loge("访问了MsgName不存在的key:" .. k)
end
})
;
(_ENV.setmetatable)(Proto.MsgIdByName, {__index = function(t, k, ...)
  -- function num : 0_1 , upvalues : _ENV
  loge("访问了MsgIdByName不存在的key:" .. k)
end
})
;
(_ENV.setmetatable)(Proto.MsgNameByID, {__index = function(t, k, ...)
  -- function num : 0_2 , upvalues : _ENV
  loge("访问了MsgIdByName不存在的key:" .. k)
end
})
return Proto

