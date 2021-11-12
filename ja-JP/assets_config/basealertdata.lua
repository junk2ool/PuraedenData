-- params : ...
-- function num : 0 , upvalues : _ENV
BaseAlertData = {
auth_fail = {id = "auth_fail", name = "ログインに失敗しました", name_cn = "登录验证失败"}
, 
access_not_enough = {id = "access_not_enough", name = "権限なし", name_cn = "没有这个权限呢"}
, 
activity_config_error = {id = "activity_config_error", name = "イベントデータエラー", name_cn = "活动数据错误"}
, 
activity_not_exist = {id = "activity_not_exist", name = "イベント未開催です", name_cn = "现在还不是活动开启时间哦"}
, 
activity_server_error = {id = "activity_server_error", name = "イベントサーバーエラー", name_cn = "活动服暂未开启，请稍后"}
, 
already_apply_guild = {id = "already_apply_guild", name = "ギルドに加入申請をしました", name_cn = "已向该公会递交过申请"}
, 
already_have_guild = {id = "already_have_guild", name = "ギルド加入済み", name_cn = "已拥有公会"}
, 
arena_day_score_deficiency = {id = "arena_day_score_deficiency", name = "ポイント不足", name_cn = "积分不够哦"}
, 
arena_reward_month_no_match = {id = "arena_reward_month_no_match", name = "シーズンボーナスは当月と合わない", name_cn = "赛季奖励和当前月份不匹配"}
, 
arena_reward_type_wrong = {id = "arena_reward_type_wrong", name = "闘技場ボーナスタイプエラー", name_cn = "领取竞技场奖励的类型不正确"}
, 
arena_reward_yet_draw = {id = "arena_reward_yet_draw", name = "闘技場デイリーボーナス受取済み", name_cn = "竞技场每日奖励已领取"}
, 
asset_not_enough = {id = "asset_not_enough", name = "資源不足", name_cn = "已删除"}
, 
battle_failure = {id = "battle_failure", name_cn = "已删除"}
, 
buy_num_exceed_max = {id = "buy_num_exceed_max", name = "購入可能回数MAX", name_cn = "已达最大购买次数"}
, 
card_group_not_null = {id = "card_group_not_null", name = "パーティーを編成してください", name_cn = "阵容不能为空"}
, 
card_include = {id = "card_include", name_cn = "已删除"}
, 
card_is_exist = {id = "card_is_exist", name = "キャラ獲得済み", name_cn = "你已拥有此冒险者"}
, 
card_level_error = {id = "card_level_error", name = "キャラレベルが不足しているから、レベルを上げてください", name_cn = "冒险者等级不足，请提升冒险者等级"}
, 
card_level_max = {id = "card_level_max", name = "キャラレベルMAX", name_cn = "冒险者已达当前等级上限"}
, 
card_level_over_player = {id = "card_level_over_player", name = "キャラのレベルは冒険団を超えてはいけない", name_cn = "冒险者等级不能超过冒险团等级"}
, 
card_not_exist = {id = "card_not_exist", name = "検索キャラなし", name_cn = "无法找到冒险者"}
, 
card_num_big = {id = "card_num_big", name = "出陣キャラが満員になっています", name_cn = "上阵的冒险者已满啦"}
, 
card_quality_max = {id = "card_quality_max", name = "キャラ突破MAX", name_cn = "冒险者已突破至极限"}
, 
card_skill_level_over = {id = "card_skill_level_over", name = "才能レベルはキャラレベルを超えてはいけない", name_cn = "才能等级不能超过冒险者等级"}
, 
card_skill_max_level = {id = "card_skill_max_level", name = "才能MAX", name_cn = "才能已训练至极限"}
, 
card_skill_not_exist = {id = "card_skill_not_exist", name = "才能ロック中", name_cn = "才能未解锁"}
, 
card_star_max = {id = "card_star_max", name = "キャラ覚醒MAX", name_cn = "冒险者已觉醒至极限"}
, 
cd_error = {id = "cd_error", name = "制限時間経過後、ギルドに再加入できます", name_cn = "再次加入公会的时间未到"}
, 
cd_time_no_arrived = {id = "cd_time_no_arrived", name = "ステージ挑戦が冷却中ですから、お待ちください", name_cn = "副本挑战冷却中，请稍后"}
, 
config_error = {id = "config_error", name = "配置エラー", name_cn = "配置错误"}
, 
diamond_not_enough = {id = "diamond_not_enough", name = "ダイヤ不足", name_cn = "已删除"}
, 
embattle_no_card = {id = "embattle_no_card", name = "少なくとも1名キャラが出陣必須です", name_cn = "至少需要上阵一名冒险者"}
, 
equip_already_identify = {id = "equip_already_identify", name = "装備未鑑定", name_cn = "已删除"}
, 
equip_exp_not_enough = {id = "equip_exp_not_enough", name = "星の砂不足", name_cn = "已删除"}
, 
equip_max_level = {id = "equip_max_level", name_cn = "已删除"}
, 
equip_no_identify = {id = "equip_no_identify", name = "装備未鑑定", name_cn = "装备还没鉴定呢"}
, 
equip_not_exist = {id = "equip_not_exist", name = "この装備なし", name_cn = "没有这件装备呢"}
, 
equip_only_card = {id = "equip_only_card", name = "キャラ専用装備です", name_cn = "装备属于特定冒险者"}
, 
equip_position_no_unlock = {id = "equip_position_no_unlock", name = "装備欄ロック中", name_cn = "装备栏未解锁"}
, 
expedition_exist = {id = "expedition_exist", name = "遠征区域を選択しました、再選定できません", name_cn = "当前已选择了远征区域，无法重新选定"}
, 
expedition_sweep_condition_no_pass = {id = "expedition_sweep_condition_no_pass", name = "掃討条件が未満足ですから、掃討できません", name_cn = "已删除"}
, 
failed = {id = "failed", name = "何か問題があるようです", name_cn = "出了点问题呢"}
, 
fc_not_enough = {id = "fc_not_enough", name = "現在の戦力がまだ足りない", name_cn = "当前战斗力还不够哦"}
, 
func_not_open = {id = "func_not_open", name = "機能未開放", name_cn = "功能暂未开启"}
, 
gm_close = {id = "gm_close", name = "サーバーに接続できません", name_cn = "无法连接服务器"}
, 
gold_not_enough = {id = "gold_not_enough", name = "コイン不足", name_cn = "已删除"}
, 
goods_no_enough = {id = "goods_no_enough", name = "素材不足", name_cn = "已删除"}
, 
guild_apply_max = {id = "guild_apply_max", name = "申請を十分に出しました、ご返事をお待ちください", name_cn = "已递交了足够多的申请了，请等待回复吧"}
, 
guild_building_max_num = {id = "guild_building_max_num", name = "ギルド建設MAX", name_cn = "公会建设已达极限"}
, 
guild_building_plan_not_enough = {id = "guild_building_plan_not_enough", name = "ギルド建設進度不足", name_cn = "公会建设进度不足"}
, 
guild_draw_reward_num_up = {id = "guild_draw_reward_num_up", name_cn = "已删除"}
, 
guild_join_error = {id = "guild_join_error", name = "ギルドが忙しいので、後ほどお試しください", name_cn = "公会繁忙，请稍后再试"}
, 
guild_member_max = {id = "guild_member_max", name = "ギルドメンバー人数MAX", name_cn = "公会成员已达上限"}
, 
guild_member_not_exist = {id = "guild_member_not_exist", name = "検索ギルドメンバーなし", name_cn = "公会成员不存在"}
, 
guild_not_exist = {id = "guild_not_exist", name = "検索ギルドなし", name_cn = "未查询到此公会"}
, 
guild_reward_yet_draw = {id = "guild_reward_yet_draw", name = "ギルドボーナス受取済み", name_cn = "公会奖励已领取"}
, 
illegal_error = {id = "illegal_error", name = "不正エラー", name_cn = "非法错误"}
, 
init_error = {id = "init_error", name = "初期化エラー", name_cn = "初始化错误"}
, 
insufficient_player_level = {id = "insufficient_player_level", name = "冒険団レベルが不足しています", name_cn = "已删除"}
, 
intimacy_gift_num_max = {id = "intimacy_gift_num_max", name = "十分なギフトを贈りしました", name_cn = "已赠送了足够多的礼物啦"}
, 
lottery_cd_error = {id = "lottery_cd_error", name_cn = "已删除"}
, 
lottery_max_num = {id = "lottery_max_num", name = "本日の募集回数が使用切れです", name_cn = "今日的招募次数已使用完啦"}
, 
max_buy_num_zero = {id = "max_buy_num_zero", name = "最大購入可能回数はゼロです", name_cn = "最大购买次数为0"}
, 
no_arena_cd = {id = "no_arena_cd", name = "闘技場挑戦が冷却中ですから、お待ちください", name_cn = "竞技场挑战冷却中，请稍后"}
, 
no_arena_player = {id = "no_arena_player", name = "適当な相手を見つけられなかった", name_cn = "没能找到合适的对手呢"}
, 
no_arena_sweep = {id = "no_arena_sweep", name = "自分の順位より高いプレヤーを抑えられない", name_cn = "无法压制排名比自己高的选手"}
, 
no_arena_time = {id = "no_arena_time", name = "挑戦回数不足", name_cn = "挑战次数不够啦"}
, 
no_battle_data = {id = "no_battle_data", name = "検索バトルデータなし", name_cn = "未查询到战斗数据"}
, 
no_battle_stage = {id = "no_battle_stage", name_cn = "已删除"}
, 
no_draw_reward = {id = "no_draw_reward", name = "受取可能ボーナスなし", name_cn = "暂时没有奖励可以领取哦"}
, 
no_enough = {id = "no_enough", name = "%s不足", name_cn = "%s 不足"}
, 
no_get_reward_coefficient = {id = "no_get_reward_coefficient", name = "ボーナスデータがなくなりました", name_cn = "奖励数据丢失"}
, 
no_next_stage = {id = "no_next_stage", name = "最後のステージです", name_cn = "已是最后一关啦"}
, 
no_shop_buy_time = {id = "no_shop_buy_time", name = "購入回数MAX", name_cn = "当前已达最大购买次数"}
, 
no_type_shop = {id = "no_type_shop", name = "ショップ整理中、しばらくお待ちください", name_cn = "商店正在整理，请稍后"}
, 
no_use_sweep_num = {id = "no_use_sweep_num", name_cn = "已删除"}
, 
not_exist_apply = {id = "not_exist_apply", name_cn = "已删除"}
, 
not_have_guild = {id = "not_have_guild", name = "ギルド未所属", name_cn = "当前没有加入公会"}
, 
not_same_guild = {id = "not_same_guild", name_cn = "已删除"}
, 
oneself_apply_max = {id = "oneself_apply_max", name = "申請をしたギルド数が上限に達しました", name_cn = "申请的公会数量已达上限啦"}
, 
open_condition_no_meet = {id = "open_condition_no_meet", name = "開放条件未満足", name_cn = "未达到开启条件呢"}
, 
other_login = {id = "other_login", name = "アカウントが他の端末にログインされました", name_cn = "你的账号已在其它地方登录"}
, 
play_off_time = {id = "play_off_time", name = "イベント未開催です", name_cn = "当前不是活动开启时间哦"}
, 
player_del_error = {id = "player_del_error", name = "アカウントがロックされています", name_cn = "您的账户已被封停"}
, 
player_not_exist = {id = "player_not_exist", name = "検索プレヤーなし", name_cn = "未查询到此人"}
, 
player_over_max_level = {id = "player_over_max_level", name = "冒険団レベルMAX！", name_cn = "冒险团等级MAX！"}
, 
post_count_max = {id = "post_count_max", name = "この役職の任命人数が上限に達しました", name_cn = "该职位的任命人数已达上限"}
, 
post_repeat_error = {id = "post_repeat_error", name = "この役職は任命できません", name_cn = "无法再任命这个职位了"}
, 
pre_task_is_not_completed = {id = "pre_task_is_not_completed", name = "まだクエストがあります", name_cn = "还有任务没处理哦"}
, 
prop_add_failed = {id = "prop_add_failed", name = "アイテム追加に失敗しました", name_cn = "物品添加失败"}
, 
prop_count_error = {id = "prop_count_error", name = "アイテムの数が間違いました", name_cn = "物品数量错误"}
, 
prop_debris_exchange_intelligence_error = {id = "prop_debris_exchange_intelligence_error", name = "証明書のレベルが不足しています", name_cn = "当前凭证的品级不够哦"}
, 
prop_not_exist = {id = "prop_not_exist", name = "このアイテムなし", name_cn = "物品不存在"}
, 
prop_not_sell = {id = "prop_not_sell", name = "このアイテムを売ることができません", name_cn = "这件物品无法出售"}
, 
prop_not_use = {id = "prop_not_use", name = "このアイテムが使用できません", name_cn = "这件物品无法使用"}
, 
register_repeated = {id = "register_repeated", name = "すでに登録されているのですから、ログインしてください", name_cn = "已经注册过了呢，无法重复操作"}
, 
reward_no_repetition = {id = "reward_no_repetition", name = "ボーナス受取済み", name_cn = "奖励已领取"}
, 
rmi_exception = {id = "rmi_exception", name_cn = "已删除"}
, 
rmi_result_error = {id = "rmi_result_error", name = "サーバーにエラーが発生しました、後ほど再試行してください", name_cn = "服务器异常，请稍后再试"}
, 
rmi_result_param_error = {id = "rmi_result_param_error", name = "サーバーにエラーが発生しました、後ほど再試行してください", name_cn = "服务器异常，请稍后再试"}
, 
server_busy = {id = "server_busy", name = "サーバーがビジー状態であるため、後でお試しください。", name_cn = "服务器繁忙"}
, 
server_close = {id = "server_close", name = "サーバーとの接続が切断されました", name_cn = "与服务器连接断开"}
, 
server_error = {id = "server_error", name = "サーバーにエラーが発生しました、後ほど再試行してください", name_cn = "服务器异常，请稍后再试"}
, 
shop_not_hand_refresh = {id = "shop_not_hand_refresh", name = "このショップには手動で更新できません", name_cn = "此商店无法手动刷新"}
, 
shop_not_match = {id = "shop_not_match", name = "アイテムが間違いました、もう一度お試しください", name_cn = "商品不正确，请稍后再试"}
, 
shop_type_not_match = {id = "shop_type_not_match", name = "ショップは何か問題があるようですが、もう一度お試しください", name_cn = "商店似乎出了点问题，请稍后再试"}
, 
sign_in_count_error = {id = "sign_in_count_error", name = "累計冒険の日数が不足しています", name_cn = "累计冒险的天数还不够哦"}
, 
sign_in_ed = {id = "sign_in_ed", name = "本日サインインをしました", name_cn = "今天已完成签到"}
, 
stage_no_pass = {id = "stage_no_pass", name = "未クリアのステージは掃討できません", name_cn = "无法扫荡还未通关的关卡哦"}
, 
stage_no_sweep = {id = "stage_no_sweep", name = "このステージが掃討できません", name_cn = "当前关卡还不能扫荡"}
, 
stage_num_of_less = {id = "stage_num_of_less", name = "挑戦回数不足", name_cn = "挑战次数不足"}
, 
stage_rewarded = {id = "stage_rewarded", name = "ボーナス受取済み", name_cn = "奖励已领取"}
, 
stage_up_no_pass = {id = "stage_up_no_pass", name = "前のステージをクリアしてください", name_cn = "请先通关前置关卡"}
, 
status_error = {id = "status_error", name = "ステータスエラー", name_cn = "状态错误"}
, 
success = {id = "success", name = "成功しました", name_cn = "成功"}
, 
talent_energy_max = {id = "talent_energy_max", name_cn = "已删除"}
, 
talent_level_max = {id = "talent_level_max", name_cn = "已删除"}
, 
talent_no_unlock = {id = "talent_no_unlock", name_cn = "已删除"}
, 
talent_tree_lock = {id = "talent_tree_lock", name_cn = "已删除"}
, 
talent_tree_star_max = {id = "talent_tree_star_max", name_cn = "已删除"}
, 
target_not_reached = {id = "target_not_reached", name = "目標未達成", name_cn = "目标未达成"}
, 
task_group_cal_error = {id = "task_group_cal_error", name = "タスクグループ計算エラー", name_cn = "任务组计算错误"}
, 
task_group_not_exist = {id = "task_group_not_exist", name = "タスクグループなし", name_cn = "任务组不存在"}
, 
task_item_eno = {id = "task_item_eno", name = "タスク完了", name_cn = "任务已完成"}
, 
task_not_exist = {id = "task_not_exist", name = "タスクなし", name_cn = "任务不存在"}
, 
test_param = {id = "test_param", name = "テストパラメータ{0}パラメータ{1}", name_cn = "已删除"}
, 
type_error = {id = "type_error", name = "タイプエラー", name_cn = "类型错误"}
, 
unknown_error = {id = "unknown_error", name = "未知エラー", name_cn = "未知错误"}
, 
vip_not_enough = {id = "vip_not_enough", name = "VIPレベル不足", name_cn = "vip等级不够"}
, 
vit_define = {id = "vit_define", name = "体力不足", name_cn = "体力不足"}
, 
vit_get_ed = {id = "vit_get_ed", name = "受取済み", name_cn = "已经领取过了"}
, 
wish_point_no_enough = {id = "wish_point_no_enough", name_cn = "已删除"}
, 
server_full = {id = "server_full", name = "サーバーフル", name_cn = "服务器人数已达上限"}
, 
http_result_error = {id = "http_result_error", name = "http戻るエラー", name_cn = "http返回错误"}
, 
server_close_ing = {id = "server_close_ing", name = "サーバーロック中", name_cn = "服务器尚未开启"}
, 
player_level_not_enough = {id = "player_level_not_enough", name = "冒険団レベル不足", name_cn = "冒险团等级不足"}
, 
card_fetter_activated = {id = "card_fetter_activated", name = "絆スキル解放", name_cn = "属性已激活"}
, 
card_fetter_error = {id = "card_fetter_error", name = "解放条件未満足", name_cn = "未满足激活条件"}
, 
prop_not_use_level = {id = "prop_not_use_level", name = "アイテムレベル不足", name_cn = "物品使用等级不足"}
, 
yet_draw_guild_gift = {id = "yet_draw_guild_gift", name = "ギルド整理ボーナス受取済み", name_cn = "公会整理奖励已领取"}
, 
guild_gift_finish = {id = "guild_gift_finish", name_cn = "已删除"}
, 
guild_member_data_error = {id = "guild_member_data_error", name = "ギルドメンバー検索に失敗しました", name_cn = "公会成员获取失败"}
, 
reward_not_exist = {id = "reward_not_exist", name = "ボーナスなし", name_cn = "奖励不存在"}
, 
reward_send_failed = {id = "reward_send_failed", name = "ボーナス配給に失敗しました", name_cn = "奖励发放失败"}
, 
activity_type_error = {id = "activity_type_error", name = "イベントタイプエラー", name_cn = "活动类型错误"}
, 
activity_is_end = {id = "activity_is_end", name = "イベント終了です", name_cn = "活动已结束"}
, 
task_group_unopened = {id = "task_group_unopened", name = "タスク未開放", name_cn = "任务暂未开启"}
, 
equip_bag_max = {id = "equip_bag_max", name = "装備バッグMAX、これ以上購入できない、整理しますか", name_cn = "装备背包已满，无法继续购买装备，是否前往整理"}
, 
activity_player_is_null = {id = "activity_player_is_null", name = "イベント参加プレヤーなし", name_cn = "无参与活动玩家"}
, 
WORLD_LIMIT = {id = "WORLD_LIMIT", name = "内容が少し多いです", name_cn = "输入的内容有点多了呢"}
, 
world_null = {id = "world_null", name = "内容なし", name_cn = "没有内容可以发送呢"}
, 
NO_CHAT_CONTENT = {id = "NO_CHAT_CONTENT", name = "コメントなし", name_cn = "点赞失败，该条评论失踪了"}
, 
no_like_card = {id = "no_like_card", name = "このキャラなし", name_cn = "此冒险者不存在"}
, 
set_like_card_type_error = {id = "set_like_card_type_error", name = "お気に入りカードのタイプを間違って設置しました　1又は2の一つを選んでください", name_cn = "设置喜欢卡牌的类型错误 类型只能为1或者2"}
, 
like_card_exist = {id = "like_card_exist", name = "お気に入りキャラはリストにあります", name_cn = "喜欢的冒险者已在列表中"}
, 
contains_sensitive_word = {id = "contains_sensitive_word", name = "特殊な文字が検出されました", name_cn = "检测到特殊的字符"}
, 
unlock_trial_lost = {id = "unlock_trial_lost", name = "ステージ開放に失敗しました", name_cn = "关卡解锁失败"}
, 
guild_pos_discordant = {id = "guild_pos_discordant", name = "ギルド整理位置が正しくありません", name_cn = "公会整理位置错误"}
, 
no_attach_get = {id = "no_attach_get", name = "受取可能アイテムなし", name_cn = "没有可领取的附件"}
, 
password_error = {id = "password_error", name = "パスワードが間違っています", name_cn = "密码错误"}
, 
please_logout_first = {id = "please_logout_first", name = "ゲームを終了してください", name_cn = "请先退出游戏"}
, 
limit_max = {id = "limit_max", name = "これ以上購入不可", name_cn = "已达可购买的上限"}
, 
limit_gift_max = {id = "limit_gift_max", name = "これ以上購入不可", name_cn = "已达可购买的上限"}
, 
moon_is_expired = {id = "moon_is_expired", name = "月間カード権限がすでに有効期限を過ぎました", name_cn = "月卡权限已过期"}
, 
adventure_event_nodeid_no_fit = {id = "adventure_event_nodeid_no_fit", name = "キャンプ位置を検索できません", name_cn = "营地位置获取失败"}
, 
trial_sweep_no_condition = {id = "trial_sweep_no_condition", name = "相手を完全に勝たないから、掃討ができません", name_cn = "未能完全战胜对手，无法进行扫荡"}
, 
trial_sweep_no_num = {id = "trial_sweep_no_num", name = "掃討回数不足", name_cn = "扫荡次数不足"}
, 
arena_rank_deficiency = {id = "arena_rank_deficiency", name = "闘技場ボーナス獲得可能のランキングに入らなかった", name_cn = "竞技场排名不足"}
, 
player_no_clear_cd = {id = "player_no_clear_cd", name = "冷却時間中、挑戦できるまでしばらくお待ちください", name_cn = "活动CD无需重置(竞技场CD中)"}
, 
guild_name_repeated = {id = "guild_name_repeated", name = "ギルド名が使用されました", name_cn = "公会名已被使用了"}
, 
no_init_battle_record = {id = "no_init_battle_record", name = "初期対戦履歴なし", name_cn = "没有初始化战斗记录"}
, 
battle_not_like = {id = "battle_not_like", name = "初期対戦履歴が合わない", name_cn = "战斗初始化记录不匹配"}
, 
guild_build_num_up = {id = "guild_build_num_up", name = "ギルド建設回数が上限に達しました", name_cn = "公会建设次数已达上限"}
, 
arena_rival_myself = {id = "arena_rival_myself", name = "自分に挑戦できない", name_cn = "竞技场对手不能是自己"}
, 
guild_notice_is_same = {id = "guild_notice_is_same", name = "現在最新のお知らせはありません", name_cn = "已是最新公告"}
, 
exp_goods_no_enough = {id = "exp_goods_no_enough", name = "経験薬剤が足りません", name_cn = "经验药剂不够啦"}
, 
vip_not_yj = {id = "vip_not_yj", name = "すでにチャージ済みのアカウントを引き継ぐことができません", name_cn = "账号已充值，不可引继"}
, 
role_is_not_guest = {id = "role_is_not_guest", name = "正式アカウントを引き継ぐことができません", name_cn = "正式账号不可引继"}
, 
gift_code_format_wrong = {id = "gift_code_format_wrong", name = "無効なコードです", name_cn = "请输入正确礼包码"}
, 
gift_code_is_use = {id = "gift_code_is_use", name = "このコードは既に使用済みです", name_cn = "该礼包码已经使用"}
, 
gift_code_invalid = {id = "gift_code_invalid", name = "無効なコードです", name_cn = "请输入正确礼包码"}
, 
guess_cup_no_num = {id = "guess_cup_no_num", name = "お祈り回数が足りません", name_cn = "祈福次数已用完"}
, 
guess_cup_is_zero = {id = "guess_cup_is_zero", name = "お祈りのリセット回数が足りません", name_cn = "祈福重置次数已用完"}
, 
guess_cup_upper = {id = "guess_cup_upper", name = "お祈り回数が足りません", name_cn = "祈福次数已用完"}
, 
guild_level_no_enough = {id = "guild_level_no_enough", name = "ギルドレベルが足りません", name_cn = "公会等级不足"}
, 
expedition_buy_num_no_matching = {id = "expedition_buy_num_no_matching", name = "購入可能回数不足", name_cn = "购买次数不匹配"}
, 
expedition_buy_num_no_enough = {id = "expedition_buy_num_no_enough", name = "購入可能回数不足", name_cn = "购买次数不足"}
, 
expedition_no_drop = {id = "expedition_no_drop", name = "「ドロップ」データが間違っています", name_cn = "没有获取到掉落"}
, 
no_expedition_player = {id = "no_expedition_player", name = "遠征相手が見つかりません", name_cn = "没有找到远征对手"}
, 
can_not_quit_guild = {id = "can_not_quit_guild", name = "公会战挑战期间无法退出/剔除/解散公会", name_cn = "公会战挑战期间无法退出/剔除/解散公会"}
, 
param_error = {id = "param_error", name = "パラメーターが間違っています", name_cn = "参数错误"}
, 
param_length_error = {id = "param_length_error", name = "パラメーターが間違っています", name_cn = "参数长度错误"}
, 
guild_war_need_refresh = {id = "guild_war_need_refresh", name = "ギルド戦データが更新されました", name_cn = "公会战数据已更新"}
, 
season_end = {id = "season_end", name = "今シーズン終了", name_cn = "本赛季挑战已结束"}
, 
adventure_event_nonentity = {id = "adventure_event_nonentity", name = "イベントが存在しません", name_cn = "大冒险事件不存在"}
, 
adventure_event_no_battle = {id = "adventure_event_no_battle", name = "当該イベントは戦闘イベントではありません", name_cn = "该节点的事件不是战斗事件"}
, 
no_adventure_player = {id = "no_adventure_player", name = "戦闘相手が見つかりません", name_cn = "没有找到大冒险对手"}
, 
slots_not_reset = {id = "slots_not_reset", name = "操作が頻繁すぎます。しばらくしてからお試しください", name_cn = "请勿重复重置奖励"}
, 
prop_pass_stamp = {id = "prop_pass_stamp", name = "アイテム使用期限が切れました", name_cn = "物品已过期"}
, 
only_friend_can_chat = {id = "only_friend_can_chat", name = "フレンドになるだけでメッセージを送ることができます", name_cn = "只有好友才能私聊"}
, 
no_house = {id = "no_house", name = "相手の「ハウス」機能がまだ解放されていません", name_cn = "对方还没有开启【家园】"}
, 
can_not_quit_guild_of_im = {id = "can_not_quit_guild_of_im", name = "弾劾期間中にギルドを脱退できません", name_cn = "公会弹劾期间发起者无法退出公会"}
, 
arena_not_open_time = {id = "arena_not_open_time", name = "現在は開催期間外です", name_cn = "竞技场不在开启时间"}
, 
equip_scheme_not_exist = {id = "equip_scheme_not_exist", name = "この装備案は使用できない", name_cn = "装备方案不存在"}
, 
add_equip_scheme_lose = {id = "add_equip_scheme_lose", name = "装備案の設定に失敗しました", name_cn = "添加装备方案失败"}
, 
arena_rival_rank_not_correct = {id = "arena_rival_rank_not_correct", name = "ランキングが更新されました", name_cn = "对手的排名不正确"}
, 
slots_cost_deficiency = {id = "slots_cost_deficiency", name = "抽選用アイテムが不足しています", name_cn = "抽取道具不足"}
, 
equip_scheme_is_full = {id = "equip_scheme_is_full", name = "装備プリセットが上限に達しました", name_cn = "装备方案已达上限"}
, 
no_player_to_house = {id = "no_player_to_house", name = "表示できるプレイヤーがいません", name_cn = "暂时没有随机访问的目标"}
, 
lottery_conversion_integral_no_enough = {id = "lottery_conversion_integral_no_enough", name = "交換ptが不足しています", name_cn = "扭蛋兑换积分不足"}
, 
lottery_conversion_num_no_enough = {id = "lottery_conversion_num_no_enough", name = "当該冒険者の交換可能回数が不足しています", name_cn = "扭蛋兑换次数不足"}
, 
deck_scheme_not_exist = {id = "deck_scheme_not_exist", name = "現陣容が登録されていない", name_cn = "阵容方案不存在"}
, 
deck_scheme_is_full = {id = "deck_scheme_is_full", name = "登録した陣容がいっぱいのため保存できません", name_cn = "阵容方案已满"}
, 
not_call_on_myself = {id = "not_call_on_myself", name = "自分自身を訪問することができません", name_cn = "家园随机访问不能访问自己"}
, 
farm_level_no_enough = {id = "farm_level_no_enough", name = "農場レベルが Lv.%d に達すると部屋を拡張できる", name_cn = "农场等级不足d%,不能升级家园"}
, 
arena_rank_busy = {id = "arena_rank_busy", name = "ランキングリセット中、しばらくお待ちください", name_cn = "排行榜初始化中，请稍后"}
, 
temple_stage_not_open_time = {id = "temple_stage_not_open_time", name = "毎月10日5：00より開放！", name_cn = "神殿遗迹关卡未到开启时间"}
, 
no_stage_buy_time = {id = "no_stage_buy_time", name = "これ以上掃討回数をリセットできません", name_cn = "关卡已经没有购买次数"}
, 
have_num_not_buy = {id = "have_num_not_buy", name = "掃討回数をリセットするには、残り回数が「0」になる必要があります", name_cn = "剩余次数为0时才能购买次数"}
, 
not_use_stage_num = {id = "not_use_stage_num", name = "残り回数を使い切ってからリセットしてください", name_cn = "次数已满,无法购买次数"}
, 
assist_no_num = {id = "assist_no_num", name = "ご自分の残り回数不足のため、メンバーに協力できません", name_cn = "当前协助次数不足，无法协助"}
, 
by_assist_no_num = {id = "by_assist_no_num", name = "このメンバーの協力可能回数が尽きましたため、協力できません", name_cn = "当前成员被协助次数不足，无法协助"}
, 
assist_monster_death = {id = "assist_monster_death", name = "ボスは撃破されました。このメンバーへの協力はできません。", name_cn = "强敌已被击败，无法协助"}
, 
risk_vit_no_enough = {id = "risk_vit_no_enough", name = "本日この探索の残りスタミナ消費は～%sです。", name_cn = "今日剩余可分配的体力为：%s，当前分配体力值已超过上限"}
, 
not_change = {id = "not_change", name = "ギルド名は変わっていません", name_cn = "公会名没有被改变"}
, 
ex_code_not = {id = "ex_code_not", name = "ex_code_not", name_cn = "兑换未开始，暂时无法兑换"}
, 
ex_code_expired = {id = "ex_code_expired", name = "ex_code_expired", name_cn = "兑换码已过期"}
, 
ex_code_used = {id = "ex_code_used", name = "ex_code_used", name_cn = "兑换码已被使用"}
, 
ex_code_error = {id = "ex_code_error", name = "ex_code_error", name_cn = "兑换码输入错误"}
, 
ex_code_only = {id = "ex_code_only", name = "ex_code_only", name_cn = "一个账号同类兑换码只能使用一次"}
, 
pay_rebate_success = {id = "pay_rebate_success", name = "pay_rebate_success", name_cn = "已兑换成功,请在邮箱中查看"}
, 
already_login = {id = "already_login", name = "すでにログインしている場合", name_cn = "账号已经在其他客户端登陆,请从其他设备下线后再次尝试"}
, 
activity_not_open = {id = "activity_not_open", name = "イベントは終了しました", name_cn = "活动未开启"}
, 
risk_time_not_enough = {id = "risk_time_not_enough", name = "イベントはまもなく終了となりますので、探索することができません。", name_cn = "活动即将结束，无法开始探索"}
, 
text_is_empty = {id = "text_is_empty", name = "空のテキスト", name_cn = "文本为空"}
, 
player_del_not_support = {id = "player_del_not_support", name = "player_del_not_support", name_cn = "对方账号异常，无法使用该支援角色"}
, 
product_locked = {id = "product_locked", name = "購入ができません", name_cn = "商品已锁定"}
}
return BaseAlertData

