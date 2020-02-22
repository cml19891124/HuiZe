//
//  HUZEditProfileViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZEditProfileViewController.h"
#import "MOFSPickerManager.h"
#import "HUZMineService.h"
#import "HUZMyUser.h"
#import "HUZMiddleschoolModel.h"
#import "UIImage+LWImage.h"

#define  NormalColor    [UIColor colorWithRed:(80 / 255.0) green:(169 / 255.0) blue:(181 / 255.0) alpha:1]
@interface HUZEditProfileViewController ()<HUZPPPSelectViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *ivHeader;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labStudentType;
@property (weak, nonatomic) IBOutlet UILabel *labCharacter;
@property (weak, nonatomic) IBOutlet UILabel *labArea;
@property (weak, nonatomic) IBOutlet UILabel *labSchoolName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labOrg;
@property (weak, nonatomic) IBOutlet UILabel *labGrade;

@property (nonatomic,strong) HUZPPPSelectView *studentTypeView;
@property (nonatomic,strong) HUZPPPSelectView *characterView;
@property (nonatomic,strong) HUZPPPSelectView *schoolNameView;

@property (nonatomic, strong) UIImagePickerController *photoPicker;

@property (nonatomic, strong) NSMutableDictionary * upDatePar;

@end

@implementation HUZEditProfileViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [[UIStoryboard storyboardWithName:@"HUZEditProfileViewController" bundle:nil] instantiateInitialViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"编辑资料";
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    ViewRadius(self.ivHeader, 32/2);
    [self getMiddleschoolData];
    [self loadData];
}

- (void)loadData {
    [self displayOverFlowActivityView];
    HUZWEAK_SELF;
    [HUZMineService getUserMsgInfoWithSuccess:^(HUZMyUser * _Nonnull object) {
        HUZUser *user = object.data;
        [weakSelf removeOverFlowActivityView];
        [weakSelf.ivHeader sd_setImageWithURL:[NSURL URLWithString:user.headUrl] placeholderImage:ImageNamed(@"")];
        weakSelf.labName.text = user.username;
        weakSelf.labStudentType.text = user.category;
        NSString *role = @"老师";
        if ([user.userRole integerValue] == 0) { role = @"学生"; }
        else if ([user.userRole integerValue] == 1) { role = @"家长";  }
        weakSelf.labCharacter.text = role;
        weakSelf.labArea.text = user.area;
        weakSelf.labSchoolName.text = user.school;
        weakSelf.labGrade.text = user.gredes;
        [weakSelf.tableView reloadData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];
    }];
}

//middleschoolArr #import "HUZMiddleschoolModel.h"
-(void)getMiddleschoolData{
    HUZWEAK_SELF;
    [HUZNetWorkTool huz_POST:kUrl_middleschool_selectSchool parameters:@{} success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            NSMutableArray *middleschoolArr = [NSMutableArray array];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZMiddleschoolModel class] json:responseObject[@"data"][@"list"]];
            for (HUZMiddleschoolModel *schoolModel in arr) {
                [middleschoolArr addObject:schoolModel.schoolName];
            }
            weakSelf.schoolNameView.dataArray = middleschoolArr;
            NSLog(@"");
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf presentErrorSheet:error];
    }];
}

-(void)updateUserDataPar:(NSDictionary *)par {
    [self displayOverFlowActivityView];
    
    HUZWEAK_SELF;
    [HUZNetWorkTool huz_POST:kUrl_updateuser parameters:par success:^(id  _Nonnull responseObject) {
        [weakSelf removeOverFlowActivityView];
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            if ([par.allKeys containsObject:@"area"]) {
                [weakSelf getMiddleschoolData];
            }
            [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
            HUZUser *model = [HUZUser modelWithJSON:responseObject[@"data"]];
            HUZUserCenterManager.userModel = model;
            [HUZUserCenterManager saveToCache];
            [weakSelf loadData];
        }else{
            [weakSelf presentErrorSheet:responseObject[@"msg"]];
        }

    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:error];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 10;
    return 24;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {

        if (indexPath.row == 0) {
            /// 头像
            [self headImageAlert];
        }
        /// 名称
        else if (indexPath.row == 1) {
            ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
            [popView popInputAlertWithTitle:@"编辑名称" placeholder:@"请输入名称"];
            HUZWEAK_SELF
            popView.inputViewBlock = ^(NSString *str) {
                HUZSTRONG_SELF
                /// 上传名称
                [strongSelf updateUserDataPar:@{@"username":str}];
            };
        }
    }
    
    else if (indexPath.section == 1) {
        /// 招生类别
        if (indexPath.row == 0) {
            //[self.studentTypeView show];
        }
        /// 高考角色
        else if (indexPath.row == 1) {
            [self.characterView show];
        }
    }
    else if (indexPath.section == 2) {
        /// 所在地区
        if (indexPath.row == 0) {
            HUZWEAK_SELF
            [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultZipcode:@"450000-450900-450921" title:@"请选择所在地区" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString * _Nullable address, NSString * _Nullable zipcode) {
                HUZSTRONG_SELF
                /// 上传地区
                [strongSelf updateUserDataPar:@{@"area":address}];
            } cancelBlock:^{
                
            }];
        }
        ///学校名称
        else if (indexPath.row == 1) {
            if (!self.schoolNameView.superview) {
                [self.view addSubview:self.schoolNameView];
            }
            [self.schoolNameView show];
        }
        /// 所在年级
        else if (indexPath.row == 2) {
        }
    
    }
}
#pragma mark - 图片上传
- (void)headImageAlert
{
    self.photoPicker = [[UIImagePickerController alloc] init];
    
    [self.photoPicker setDelegate:self];
    self.photoPicker.allowsEditing = YES;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [cancelAction setValue:NormalColor forKey:@"titleTextColor"];
    
    [alertController addAction:cancelAction];
    
    UIAlertAction *librayAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.photoPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:self.photoPicker animated:YES completion:^{}];
        
    }];
    
    [librayAction setValue:NormalColor forKey:@"titleTextColor"];
    
    [alertController addAction:librayAction];
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.photoPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:self.photoPicker animated:YES completion:^{}];
    }];
    
    [takePhotoAction setValue:NormalColor forKey:@"titleTextColor"];
    
    [alertController addAction:takePhotoAction];
    
    [self presentViewController:alertController animated:YES  completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *photo = [info[UIImagePickerControllerOriginalImage] imageByScalingAndCroppingForLength:1024*100];
    
    [self uploadHeaderImage:photo];
    
    self.ivHeader.image = photo;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 上传图片
- (void)uploadHeaderImage:(UIImage *)image
{
    //@"/api/user/upload"
    HUZWEAK_SELF;
    [SDUploadImageHandle sendPOSTWithUrl:kUrl_uploads_img withLocalImage:image isNeedToken:YES parameters:@{} success:^(id  _Nullable responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            [MBProgressHUD showSuccess:@"上传成功" toView:self.view];
            NSString *headerUrl = responseObject[@"data"];
            [weakSelf updateUserDataPar:@{@"headUrl":headerUrl}];
        }else{
            [MBProgressHUD showSuccess:responseObject[@"msg"] toView:self.view];
        }
    } fail:^(NSError * _Nullable error) {
        [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
    }];
    
}

#pragma mark - HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView result:(NSString *)result {
    NSInteger tag = selectView.tag;
    
    HUZWEAK_SELF
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    /// 招生类别
    if (tag == 1) {
        [self updateUserDataPar:@{@"category":result}];
    }
    
    /// 高考角色
    else if (tag == 2){
        NSString *userRole = @"0";
        if ([result isEqualToString:@"家长"]) {
            userRole = @"1";
        }
        else if ([result isEqualToString:@"老师"]) {
            userRole = @"2";
        }
        [self updateUserDataPar:@{@"userRole":userRole}];
    }
    
    /// 学校名称
    else if (tag == 3){
        [self updateUserDataPar:@{@"school":result}];

    }
}

#pragma mark - Lazy
-(NSMutableDictionary *)upDatePar {
    if (!_upDatePar) {
        _upDatePar = [NSMutableDictionary dictionary];
    }
    return _upDatePar;
}

- (HUZPPPSelectView *)studentTypeView {
    if (!_studentTypeView) {
        _studentTypeView = [HUZPPPSelectView new];
        _studentTypeView.headTitle = @"选择招生类别";
        _studentTypeView.dataArray = @[@"普通招生", @"自主招生", @"高校专项计划",@"保送生", @"高水平艺术团", @"艺术类专业",@"体育类专业"].mutableCopy;
        _studentTypeView.delegate = self;
        _studentTypeView.tag = 1;
        [self.view addSubview:_studentTypeView];
    }
    return _studentTypeView;
}

- (HUZPPPSelectView *)characterView {
    if (!_characterView) {
        _characterView = [HUZPPPSelectView new];
        _characterView.headTitle = @"高考角色";
        _characterView.dataArray = @[@"学生", @"家长", @"老师"].mutableCopy;
        _characterView.delegate = self;
        _characterView.tag = 2;
        [self.view addSubview:_characterView];
    }
    return _characterView;
}

- (HUZPPPSelectView *)schoolNameView {
    if (!_schoolNameView) {
        _schoolNameView = [HUZPPPSelectView new];
        _schoolNameView.headTitle = @"选择学校";
        _schoolNameView.dataArray = @[@""].mutableCopy;
        _schoolNameView.delegate = self;
        _schoolNameView.tag = 3;
        
    }
    return _schoolNameView;
}
@end
