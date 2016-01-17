//
//  DataControl.m
//  orekano
//
//  Created by MACM001 on 2014/09/16.
//  Copyright (c) 2014年 CCW. All rights reserved.
//

#import "DataControl.h"

static NSDictionary *ryouris;

@implementation DataControl

+ (void)initializeData{
    
    NSMutableDictionary *item10 = [NSMutableDictionary dictionary];
    [item10 setObject:@"seika_item0" forKey:@"Image_name"];
    [item10 setObject:@"10" forKey:@"rid"];
    [item10 setObject:@"アイテム0" forKey:@"name"];
    [item10 setObject:@"アイテム0詳細" forKey:@"detail"];
    [item10 setObject:@"8" forKey:@"x_l"];
    [item10 setObject:@"8" forKey:@"y_l"];
    
    //アイテム1
    NSMutableDictionary *item11 = [NSMutableDictionary dictionary];
    [item11 setObject:@"seika_item1" forKey:@"Image_name"];
    [item11 setObject:@"11" forKey:@"rid"];
    [item11 setObject:@"1おく円…??" forKey:@"name"];
    [item11 setObject:@"たぶんお殿様の自作。" forKey:@"detail"];
    [item11 setObject:@"8" forKey:@"x_l"];
    [item11 setObject:@"8" forKey:@"y_l"];
    
    
    //お茶漬け
    NSMutableDictionary *item12 = [NSMutableDictionary dictionary];
    [item12 setObject:@"seika_item2" forKey:@"Image_name"];
    [item12 setObject:@"12" forKey:@"rid"];
    [item12 setObject:@"0点の解答用紙" forKey:@"name"];
    [item12 setObject:@"お母さんに見つからないように隠してあったテストだ…。" forKey:@"detail"];
    [item12 setObject:@"8" forKey:@"x_l"];
    [item12 setObject:@"8" forKey:@"y_l"];
    
    NSMutableDictionary *item13 = [NSMutableDictionary dictionary];
    [item13 setObject:@"seika_item3" forKey:@"Image_name"];
    [item13 setObject:@"13" forKey:@"rid"];
    [item13 setObject:@"土偶" forKey:@"name"];
    [item13 setObject:@"小さい頃、お気に入りだったおもちゃ。よく見るとかわいい…?" forKey:@"detail"];
    [item13 setObject:@"8" forKey:@"x_l"];
    [item13 setObject:@"10" forKey:@"y_l"];
    
    NSMutableDictionary *item14 = [NSMutableDictionary dictionary];
    [item14 setObject:@"seika_item4" forKey:@"Image_name"];
    [item14 setObject:@"14" forKey:@"rid"];
    [item14 setObject:@"木刀" forKey:@"name"];
    [item14 setObject:@"修学旅行で清水寺で買った木刀。値札がまだついてる。" forKey:@"detail"];
    [item14 setObject:@"8" forKey:@"x_l"];
    [item14 setObject:@"8" forKey:@"y_l"];
    
    NSMutableDictionary *item15 = [NSMutableDictionary dictionary];
    [item15 setObject:@"seika_item5" forKey:@"Image_name"];
    [item15 setObject:@"15" forKey:@"rid"];
    [item15 setObject:@"めがね" forKey:@"name"];
    [item15 setObject:@"盗んでしまってよかったのか心配。" forKey:@"detail"];
    [item15 setObject:@"8" forKey:@"x_l"];
    [item15 setObject:@"8" forKey:@"y_l"];
    
    NSMutableDictionary *item16 = [NSMutableDictionary dictionary];
    [item16 setObject:@"seika_item6" forKey:@"Image_name"];
    [item16 setObject:@"16" forKey:@"rid"];
    [item16 setObject:@"書初め" forKey:@"name"];
    [item16 setObject:@"地元のスーパーのコンクールで銅賞をもらった書初め。" forKey:@"detail"];
    [item16 setObject:@"8" forKey:@"x_l"];
    [item16 setObject:@"9" forKey:@"y_l"];
    
    NSMutableDictionary *item17 = [NSMutableDictionary dictionary];
    [item17 setObject:@"seika_item7" forKey:@"Image_name"];
    [item17 setObject:@"17" forKey:@"rid"];
    [item17 setObject:@"ゲーム◯ーイカラー" forKey:@"name"];
    [item17 setObject:@"ピカ◯ュウカラーの人気色！" forKey:@"detail"];
    [item17 setObject:@"8" forKey:@"x_l"];
    [item17 setObject:@"10" forKey:@"y_l"];
    
    NSMutableDictionary *item18 = [NSMutableDictionary dictionary];
    [item18 setObject:@"seika_item8" forKey:@"Image_name"];
    [item18 setObject:@"18" forKey:@"rid"];
    [item18 setObject:@"熊の置物" forKey:@"name"];
    [item18 setObject:@"よく玄関に飾ってある置物。おじいちゃんちにもあったなあ。" forKey:@"detail"];
    [item18 setObject:@"9" forKey:@"x_l"];
    [item18 setObject:@"11" forKey:@"y_l"];
    
    NSMutableDictionary *item19 = [NSMutableDictionary dictionary];
    [item19 setObject:@"seika_item9" forKey:@"Image_name"];
    [item19 setObject:@"19" forKey:@"rid"];
    [item19 setObject:@"鯛の置物" forKey:@"name"];
    [item19 setObject:@"…おめでたい…！！" forKey:@"detail"];
    [item19 setObject:@"8" forKey:@"x_l"];
    [item19 setObject:@"10" forKey:@"y_l"];
    
    NSMutableDictionary *item20 = [NSMutableDictionary dictionary];
    [item20 setObject:@"seika_item10" forKey:@"Image_name"];
    [item20 setObject:@"20" forKey:@"rid"];
    [item20 setObject:@"アイテム10" forKey:@"name"];
    [item20 setObject:@"アイテム10詳細" forKey:@"detail"];
    
    NSMutableDictionary *item21 = [NSMutableDictionary dictionary];
    [item21 setObject:@"seika_item11" forKey:@"Image_name"];
    [item21 setObject:@"21" forKey:@"rid"];
    [item21 setObject:@"織田信長のサイン" forKey:@"name"];
    [item21 setObject:@"信長主演映画”Honnohji”の試写会で抽選でもらったサイン。" forKey:@"detail"];
    [item21 setObject:@"7" forKey:@"x_l"];
    [item21 setObject:@"9" forKey:@"y_l"];
    
    NSMutableDictionary *item22 = [NSMutableDictionary dictionary];
    [item22 setObject:@"seika_item12" forKey:@"Image_name"];
    [item22 setObject:@"22" forKey:@"rid"];
    [item22 setObject:@"大仏" forKey:@"name"];
    [item22 setObject:@"結構重かった。というかだいぶ重かった。" forKey:@"detail"];
    [item22 setObject:@"7" forKey:@"x_l"];
    [item22 setObject:@"8" forKey:@"y_l"];
    
    NSMutableDictionary *item23 = [NSMutableDictionary dictionary];
    [item23 setObject:@"seika_item13" forKey:@"Image_name"];
    [item23 setObject:@"23" forKey:@"rid"];
    [item23 setObject:@"しゃちほこ" forKey:@"name"];
    [item23 setObject:@"名古屋といえばしゃちほこ！" forKey:@"detail"];
    [item23 setObject:@"8" forKey:@"x_l"];
    [item23 setObject:@"8" forKey:@"y_l"];
    
    NSMutableDictionary *item24 = [NSMutableDictionary dictionary];
    [item24 setObject:@"seika_item14" forKey:@"Image_name"];
    [item24 setObject:@"24" forKey:@"rid"];
    [item24 setObject:@"前方後円墳" forKey:@"name"];
    [item24 setObject:@"お殿様が今後のために用意していた古墳。" forKey:@"detail"];
    [item24 setObject:@"9" forKey:@"x_l"];
    [item24 setObject:@"9" forKey:@"y_l"];
    
    NSMutableDictionary *item25 = [NSMutableDictionary dictionary];
    [item25 setObject:@"seika_item15" forKey:@"Image_name"];
    [item25 setObject:@"25" forKey:@"rid"];
    [item25 setObject:@"兜" forKey:@"name"];
    [item25 setObject:@"なんでもアノ武将のものだとか。なんかちょっとこわい。" forKey:@"detail"];
    [item25 setObject:@"9" forKey:@"x_l"];
    [item25 setObject:@"10" forKey:@"y_l"];
    
    NSMutableDictionary *item26 = [NSMutableDictionary dictionary];
    [item26 setObject:@"seika_item16" forKey:@"Image_name"];
    [item26 setObject:@"26" forKey:@"rid"];
    [item26 setObject:@"◯Phone7" forKey:@"name"];
    [item26 setObject:@"この時代から存在していた!?大きくなって使いやすいよね。" forKey:@"detail"];
    [item26 setObject:@"8" forKey:@"x_l"];
    [item26 setObject:@"7" forKey:@"y_l"];
    
    NSMutableDictionary *item27 = [NSMutableDictionary dictionary];
    [item27 setObject:@"seika_item17" forKey:@"Image_name"];
    [item27 setObject:@"27" forKey:@"rid"];
    [item27 setObject:@"◯acBookPro1556-Late" forKey:@"name"];
    [item27 setObject:@"かなり初期型…??最新OSがインストールされているようだが…。" forKey:@"detail"];
    [item27 setObject:@"7" forKey:@"x_l"];
    [item27 setObject:@"10" forKey:@"y_l"];
    
    NSMutableDictionary *item28 = [NSMutableDictionary dictionary];
    [item28 setObject:@"seika_item18" forKey:@"Image_name"];
    [item28 setObject:@"28" forKey:@"rid"];
    [item28 setObject:@"通帳" forKey:@"name"];
    [item28 setObject:@"残高が気になる一品である。" forKey:@"detail"];
    [item28 setObject:@"8" forKey:@"x_l"];
    [item28 setObject:@"11" forKey:@"y_l"];
    
    NSMutableDictionary *item29 = [NSMutableDictionary dictionary];
    [item29 setObject:@"seika_item19" forKey:@"Image_name"];
    [item29 setObject:@"29" forKey:@"rid"];
    [item29 setObject:@"変形ギター" forKey:@"name"];
    [item29 setObject:@"お殿様、意外とヘビメタとか好きなんですかね。" forKey:@"detail"];
    [item29 setObject:@"9" forKey:@"x_l"];
    [item29 setObject:@"9" forKey:@"y_l"];
    
    NSMutableDictionary *item31 = [NSMutableDictionary dictionary];
    [item31 setObject:@"seika_item21" forKey:@"Image_name"];
    [item31 setObject:@"31" forKey:@"rid"];
    [item31 setObject:@"記念電子決済カード" forKey:@"name"];
    [item31 setObject:@"人気のあまり一時手に入らなかった一品。お殿様ミーハーだね。" forKey:@"detail"];
    [item31 setObject:@"8" forKey:@"x_l"];
    [item31 setObject:@"10" forKey:@"y_l"];
    
    NSMutableDictionary *item32 = [NSMutableDictionary dictionary];
    [item32 setObject:@"seika_item22" forKey:@"Image_name"];
    [item32 setObject:@"32" forKey:@"rid"];
    [item32 setObject:@"トレーディングカード" forKey:@"name"];
    [item32 setObject:@"昔は強かったよね、このカード。" forKey:@"detail"];
    [item32 setObject:@"7" forKey:@"x_l"];
    [item32 setObject:@"9" forKey:@"y_l"];
    
    NSMutableDictionary *item33 = [NSMutableDictionary dictionary];
    [item33 setObject:@"seika_item23" forKey:@"Image_name"];
    [item33 setObject:@"33" forKey:@"rid"];
    [item33 setObject:@"90年代ハイテクシューズ" forKey:@"name"];
    [item33 setObject:@"90年代に爆発的なブームですごく貴重だったシューズ。" forKey:@"detail"];
    [item33 setObject:@"8" forKey:@"x_l"];
    [item33 setObject:@"10" forKey:@"y_l"];
    
    NSMutableDictionary *item34 = [NSMutableDictionary dictionary];
    [item34 setObject:@"seika_item24" forKey:@"Image_name"];
    [item34 setObject:@"34" forKey:@"rid"];
    [item34 setObject:@"お母さんの手編みマフラー" forKey:@"name"];
    [item34 setObject:@"昔お母さんが編んでくれたマフラー。恥ずかしくて使わなかったのか結構まだきれい。" forKey:@"detail"];
    [item34 setObject:@"8" forKey:@"x_l"];
    [item34 setObject:@"10" forKey:@"y_l"];
    
    NSMutableDictionary *item35 = [NSMutableDictionary dictionary];
    [item35 setObject:@"seika_item25" forKey:@"Image_name"];
    [item35 setObject:@"35" forKey:@"rid"];
    [item35 setObject:@"モナ・リザ" forKey:@"name"];
    [item35 setObject:@"原版だったらすごい額になるんじゃないだろうか。" forKey:@"detail"];
    [item35 setObject:@"8" forKey:@"x_l"];
    [item35 setObject:@"10" forKey:@"y_l"];
    
    //夢
    NSMutableDictionary *item100 = [NSMutableDictionary dictionary];
    //[item100 setObject:@"seika_item1" forKey:@"Image_name"];
    [item100 setObject:@"s1_1" forKey:@"gazo"];
    [item100 setObject:@"100" forKey:@"rid"];
    [item100 setObject:@"2" forKey:@"time"];
    [item100 setObject:@"いい調子" forKey:@"text"];
    
    NSMutableDictionary *item101 = [NSMutableDictionary dictionary];
    //[item101 setObject:@"seika_item1" forKey:@"Image_name"];
    [item101 setObject:@"s1_2" forKey:@"gazo"];
    [item101 setObject:@"101" forKey:@"rid"];
    [item101 setObject:@"2" forKey:@"time"];
    [item101 setObject:@"全国制覇も" forKey:@"text"];
    
    NSMutableDictionary *item102 = [NSMutableDictionary dictionary];
    //[item102 setObject:@"seika_item1" forKey:@"Image_name"];
    [item102 setObject:@"s1_3" forKey:@"gazo"];
    [item102 setObject:@"102" forKey:@"rid"];
    [item102 setObject:@"3" forKey:@"time"];
    [item102 setObject:@"夢じゃない！！" forKey:@"text"];
    
    //夢
    NSMutableDictionary *item110 = [NSMutableDictionary dictionary];
    //[item100 setObject:@"seika_item1" forKey:@"Image_name"];
    [item110 setObject:@"110" forKey:@"rid"];
    [item110 setObject:@"3" forKey:@"time"];
    [item110 setObject:@"1" forKey:@"text"];
    
    NSMutableDictionary *item111 = [NSMutableDictionary dictionary];
    //[item101 setObject:@"seika_item1" forKey:@"Image_name"];
    [item111 setObject:@"111" forKey:@"rid"];
    [item111 setObject:@"3" forKey:@"time"];
    [item111 setObject:@"2" forKey:@"text"];
    
    NSMutableDictionary *item112 = [NSMutableDictionary dictionary];
    //[item102 setObject:@"seika_item1" forKey:@"Image_name"];
    [item112 setObject:@"112" forKey:@"rid"];
    [item112 setObject:@"3" forKey:@"time"];
    [item112 setObject:@"3！！" forKey:@"text"];
    
    //まとめ
    
    NSMutableDictionary *rrDict = [NSMutableDictionary dictionary];
    [rrDict setObject:item10 forKey:@"10"];
    [rrDict setObject:item11 forKey:@"11"];
    [rrDict setObject:item12 forKey:@"12"];
    [rrDict setObject:item13 forKey:@"13"];
    [rrDict setObject:item14 forKey:@"14"];
    [rrDict setObject:item15 forKey:@"15"];
    [rrDict setObject:item16 forKey:@"16"];
    [rrDict setObject:item17 forKey:@"17"];
    [rrDict setObject:item18 forKey:@"18"];
    [rrDict setObject:item19 forKey:@"19"];
    [rrDict setObject:item20 forKey:@"20"];
    [rrDict setObject:item21 forKey:@"21"];
    [rrDict setObject:item22 forKey:@"22"];
    [rrDict setObject:item23 forKey:@"23"];
    [rrDict setObject:item24 forKey:@"24"];
    [rrDict setObject:item25 forKey:@"25"];
    [rrDict setObject:item26 forKey:@"26"];
    [rrDict setObject:item27 forKey:@"27"];
    [rrDict setObject:item28 forKey:@"28"];
    [rrDict setObject:item29 forKey:@"29"];
    [rrDict setObject:item31 forKey:@"31"];
    [rrDict setObject:item32 forKey:@"32"];
    [rrDict setObject:item33 forKey:@"33"];
    [rrDict setObject:item34 forKey:@"34"];
    [rrDict setObject:item35 forKey:@"35"];
    
    [rrDict setObject:item100 forKey:@"100"];
    [rrDict setObject:item101 forKey:@"101"];
    [rrDict setObject:item102 forKey:@"102"];
    //[rrDict setObject:item110 forKey:@"110"];
    //[rrDict setObject:item111 forKey:@"111"];
    //[rrDict setObject:item112 forKey:@"112"];

    
    ryouris = rrDict;
}

+ (NSDictionary *)getRyouri:(NSString *)rid{
    return [ryouris objectForKey:rid];
}

@end
