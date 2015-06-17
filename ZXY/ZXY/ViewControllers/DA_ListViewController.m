//
//  DA_ListViewController.m
//  ZXYY
//
//  Created by acewill on 15-4-5.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#import "DA_ListViewController.h"
#import "DA_ListTableViewCell.h"

@interface DA_ListViewController ()
{
}

@end

@implementation DA_ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
//    [titleView setBackgroundColor:UIColorFromHex(0xd2d2d2)];
//    [self.view addSubview:titleView];
    
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    [listTableView setBackgroundColor:[UIColor whiteColor]];
    [listTableView setDelegate:self];
    [listTableView setDataSource:self];
    [listTableView setShowsHorizontalScrollIndicator:NO];
    [listTableView setShowsVerticalScrollIndicator:YES];
    [listTableView setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:listTableView];
    
}

- (void)updateDA_ListViewControllerInfo:(NSArray *)updataArray {
    
    titleArray = [[NSMutableArray alloc] init];
    selectArray = [[NSMutableArray alloc] init];
    self.listArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] init];
    for (int i =0; i < [updataArray count]; i++) {
        [tmpDic setDictionary:[updataArray objectAtIndex:i]];
        if (_headType == 0) {
            if (![titleArray containsObject:[tmpDic objectForKey:@"ItemType"]])
            {
                [titleArray addObject:[tmpDic objectForKey:@"ItemType"]];
                NSMutableArray *groupArray = [[NSMutableArray alloc] init];
                NSDictionary *titleDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"titleInfo", nil];
                [groupArray addObject:titleDic];
                [self.listArray addObject:groupArray];
            }
        }else if (_headType == 1) {
            if (![titleArray containsObject:[tmpDic objectForKey:@"TOTALID"]])
            {
                [titleArray addObject:[tmpDic objectForKey:@"TOTALID"]];
                NSMutableArray *groupArray = [[NSMutableArray alloc] init];
                NSDictionary *titleDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"titleInfo", nil];
                [groupArray addObject:titleDic];
                [self.listArray addObject:groupArray];
            }
        }else if (_headType == 2) {
            if (![titleArray containsObject:[tmpDic objectForKey:@"PAYDATE"]])
            {
                [titleArray addObject:[tmpDic objectForKey:@"PAYDATE"]];
                NSMutableArray *groupArray = [[NSMutableArray alloc] init];
                NSDictionary *titleDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"titleInfo", nil];
                [groupArray addObject:titleDic];
                [self.listArray addObject:groupArray];
            }
        }

        
    }
    
    for (int i = 0; i < [updataArray count]; i++)
    {
        for (int j = 0; j < [titleArray count]; j++)
        {
            if (_headType == 0) {
                if ([[titleArray objectAtIndex:j]
                     isEqual:[[updataArray objectAtIndex:i] objectForKey:@"ItemType"]]) {
                    [[self.listArray objectAtIndex:j] addObject:[updataArray objectAtIndex:i]];
                }
            }else if (_headType == 1) {
                if ([[titleArray objectAtIndex:j]
                     isEqual:[[updataArray objectAtIndex:i] objectForKey:@"TOTALID"]]) {
                    [[self.listArray objectAtIndex:j] addObject:[updataArray objectAtIndex:i]];
                }
            }else if (_headType == 2) {
                if ([[titleArray objectAtIndex:j]
                     isEqual:[[updataArray objectAtIndex:i] objectForKey:@"PAYDATE"]]) {
                    [[self.listArray objectAtIndex:j] addObject:[updataArray objectAtIndex:i]];
                }
            }

        }
    }

}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return [titleArray count];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([selectArray containsObject:[titleArray objectAtIndex:section]]) {
        UIImageView *imageV = (UIImageView *)[listTableView viewWithTag:1000+section];
        imageV.image = [UIImage imageNamed:@"buddy_header_arrow_down@2x.png"];
        
        return [[self.listArray objectAtIndex:section] count];
    }
    return 0;
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    [headerView setBackgroundColor:UIColorFromHex(0xeeeeee)];
    
    UIButton *headerBt = [[UIButton alloc] initWithFrame:headerView.frame];
    [headerBt setBackgroundColor:[UIColor clearColor]];
    [headerBt addTarget:self action:@selector(headerBtClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerBt setTag:section+100];
    [headerView addSubview:headerBt];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 15, 15)];
    [imgV setBackgroundColor:[UIColor clearColor]];
    [imgV setTag:1000+section];
    
    if ([selectArray containsObject:[titleArray objectAtIndex:section]])
    {
        imgV.image = [UIImage imageNamed:@"buddy_header_arrow_down@2x.png"];
    }else {
        imgV.image = [UIImage imageNamed:@"buddy_header_arrow_right@2x.png"];
    }
    [headerView addSubview:imgV];
    
    if (_headType == 0) {         //预算
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, ScreenWidth-30, 20)];
        [titleLab setFont:[UIFont systemFontOfSize:10.0f]];
        NSString *titStr = [[[self.listArray objectAtIndex:section] objectAtIndex:1] objectForKey:@"ItemType"];
        NSInteger itemCount = [[self.listArray objectAtIndex:section] count];
        [titleLab setText:[NSString stringWithFormat:@"%@(%d)",titStr, (int)itemCount-1]];
        [headerView addSubview:titleLab];
        
    }else if (_headType == 1) {   //变更
        //显示时间
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100+100, 20)];
        [timeLab setFont:[UIFont systemFontOfSize:10.0f]];
        NSString *timeLabStr = [[[self.listArray objectAtIndex:section] objectAtIndex:1] objectForKey:@"CREATEDATETIME"];
        NSInteger itemCount = [[self.listArray objectAtIndex:section] count];
        [timeLab setText:[NSString stringWithFormat:@"%@    （%d）",timeLabStr,(int)itemCount-1]];
        [headerView addSubview:timeLab];
        
        /*显示增项费用 交付后需求变更 去掉了增减项费用 只显示时间和条目数量
        UILabel *addPrice = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 60, 20)];
        [addPrice setFont:[UIFont systemFontOfSize:10.0f]];
        [addPrice setText:[NSString stringWithFormat:@"%@",[[[self.listArray objectAtIndex:section] objectAtIndex:1] objectForKey:@"ADD_TOTAL_PRICE"]]];
        [addPrice setTextAlignment:NSTextAlignmentCenter];
        [headerView addSubview:addPrice];
        //显示减项费用
        UILabel *lessPrice = [[UILabel alloc] initWithFrame:CGRectMake(190, 10, 60, 20)];
        [lessPrice setFont:[UIFont systemFontOfSize:10.0f]];
        [lessPrice setText:[NSString stringWithFormat:@"%@",[[[self.listArray objectAtIndex:section] objectAtIndex:1] objectForKey:@"LESS_TOTAL_PRICE"]]];
        [lessPrice setTextAlignment:NSTextAlignmentCenter];
        [headerView addSubview:lessPrice];
        //总费用
        UILabel *allPrice = [[UILabel alloc] initWithFrame:CGRectMake(250, 10, 60, 20)];
        [allPrice setFont:[UIFont systemFontOfSize:10.0f]];
        [allPrice setText:[NSString stringWithFormat:@"%@",[[[self.listArray objectAtIndex:section] objectAtIndex:1] objectForKey:@"TOTAL_PRICE"]]];
        [allPrice setTextAlignment:NSTextAlignmentCenter];
        [headerView addSubview:allPrice];
        */
    }else if (_headType == 2) {   //交费
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, ScreenWidth-30, 20)];
        [titleLab setFont:[UIFont systemFontOfSize:10.0f]];
        NSString *titStr = [[[self.listArray objectAtIndex:section] objectAtIndex:1] objectForKey:@"PAYDATE"];
        NSInteger itemCount = [[self.listArray objectAtIndex:section] count];
//        [titleLab setText:[NSString stringWithFormat:@"%@(%d)",titStr, (int)itemCount-1]];
        //MFJ 去掉了缴费记录中具体时间的显示
        [titleLab setText:[NSString stringWithFormat:@"%@    (%d)",[[titStr componentsSeparatedByString:@" "] objectAtIndex:0], (int)itemCount-1]];
        [headerView addSubview:titleLab];
    }
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, ScreenWidth, 0.5f)];
    [lineV setBackgroundColor:[UIColor grayColor]];
    [headerView addSubview:lineV];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"listTableViewCell";
    DA_ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[DA_ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    if ([selectArray containsObject:[titleArray objectAtIndex:indexPath.section]])
    {
        switch (_headType) {
            case 0:
                [cell createBudgetInfo:[[self.listArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
                break;
            case 1:
                [cell createChangeInfo:[[self.listArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
                break;
            case 2:
                [cell createPaymentInfo:[[self.listArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
                break;
            default:
                break;
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *descStr = [[[self.listArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"ItemDesc"];
    if (descStr.length > 0 ) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"工艺说明" message:descStr delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertV show];
    }
}

- (IBAction)headerBtClicked:(id)sender {
    UIButton *tmpBt = (UIButton *)sender;
    
    if ([selectArray containsObject:[titleArray objectAtIndex:(int)tmpBt.tag-100]]) {
        [selectArray removeObject:[titleArray objectAtIndex:(int)tmpBt.tag-100]];
    }else {
        [selectArray addObject:[titleArray objectAtIndex:(int)tmpBt.tag-100]];
    }
    
    [listTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
