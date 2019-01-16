//
//  ViewController.m
//  ChatBot
//
//  Created by Ashish Kr Singh on 13/07/18.
//  Copyright © 2018 Ashish Kr Singh. All rights reserved.
//

#import "ViewController.h"

#import "SenderTableViewCell.h"
#import "ReciverTableViewCell.h"
#import "SenderImageTableViewCell.h"
#import "ImageReceiverTableViewCell.h"
#import "MessageInfo.h"
#import "MenuTableViewCell.h"
#import "CollectionViewTableViewCell.h"
#import "CarausalCollectionViewCell.h"
#import "UIImage+animatedGIF.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVKit/AVKit.h>
#import "Header.h"
#import "AlertView.h"
#import "OptionsTableViewCell.h"
#import "ProgressCell.h"
#import "AttachmentCell.h"

#define kBaseUrl @"https://early-salary-backend.herokuapp.com/ios/JUBI15Q9uk_EarlySalary"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIDocumentMenuDelegate,UIDocumentPickerDelegate, UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *menuContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstant;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (strong, nonatomic) UIImageView *previewImage;
@property (strong, nonatomic) NSString *projectID;
@property (strong, nonatomic) NSString *baseURL;
@end

@implementation ViewController
{
    CGPoint centerView;
    NSArray *menuList;
    NSArray *carausalList;
    BOOL isAllSender;

}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    [self setDummyData];
    
    _projectID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"ChatBotProjectID"];
    _baseURL = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"ChatBotBaseURL"];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.myTableView
//         scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
//                                                   inSection:0]
//         atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(collectionCellButtonAction:)
                                                 name:@"collectionCellButtonActionNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(initialApiCall)
                                                 name:@"initialCallNotification"
                                               object:nil];
   
}

-(void)initialApiCall{
     [self callAPIToSubmitAnswer:@"Start over"];
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    NSLog(@"userInfo %@",notification.object);
    [self addMessageReplyToArray:notification.object];
//    [[AlertView sharedManager] displayInformativeAlertwithTitle:@"jkh" andMessage:token onController:self];
    
}


-(void)initialSetup{
    self.messageTextField.delegate = self;
   // self.messageTextField.layer.borderWidth = 1;
  //  self.messageTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    centerView = self.view.center;
    self.containerView.layer.cornerRadius = 4;
    self.containerView.layer.masksToBounds = true;
    //keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
   // self.messageTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.menuContainerView.layer.cornerRadius = 8;
    self.menuContainerView.layer.masksToBounds = false;
    
    self.menuContainerView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.menuContainerView.layer.shadowOffset = CGSizeMake(0, 1);
    self.menuContainerView.layer.shadowOpacity = 1;
    self.menuContainerView.layer.shadowRadius = 2.0;
//    self.menuView.layer.borderWidth = 1;
//    self.menuView.layer.borderColor = [UIColor colorWithRed:(228.0/255.0) green:(228/255.0) blue:(228/255.0) alpha:1.0].CGColor;
    self.menuView.layer.cornerRadius = 8;
    self.menuView.clipsToBounds = true;
    self.heightConstant.constant = 0;
    self.widthConstant.constant = 0;
    
    
}
-(void)setDummyData{
    self.messageList = [[NSMutableArray alloc] init];
//    MessageInfo *mes = [MessageInfo new];
//    mes.message = @"This is sender messaage for testing.";
//    mes.isSender = true;
//    [self.messageList addObject:mes];
//
//    MessageInfo *mes1 = [MessageInfo new];
//    mes1.message = @"This is reciever messaage for testing. For the purpose of checking multiple line two go in next line.";
//    mes1.isSender = false;
//    [self.messageList addObject:mes1];
//
//    MessageInfo *mes2 = [MessageInfo new];
//    mes2.imageName = [UIImage imageNamed:@"pexels-photo"];
//    mes2.isSender = false;
//    [self.messageList addObject:mes2];
//
//    MessageInfo *mes4 = [MessageInfo new];
//    mes4.message = @"😎😎😎😎😎";
//    mes4.isSender = true;
//    [self.messageList addObject:mes4];
    
//    MessageInfo *mes5 = [MessageInfo new];
//    mes5.message = @"😎😎😎😎😎";
//    mes5.isCarausal = true;
//    [self.messageList addObject:mes5];
   
//    MessageInfo *mes6 = [MessageInfo new];
//    mes6.gifImage = @"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif";
//    [self.messageList addObject:mes6];
    
    
    
//    [self.myTableView reloadData];
    
    menuList = [[NSArray alloc] initWithObjects:@"Start over",@"Advantages of EarlySalary loan",@"How can I apply for loan",@"EarlySalary vs CreditCard",@"Interest rate on EarlySalary loans",@"How to repay the loan",@"Talk to agent", @"Cancel conversation",nil];
    
}

#pragma mark - Keyboard methods

- (void)keyboardShow:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
  
    CGRect keyboard = [[info valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGFloat heightKeyboard = keyboard.size.height;
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        if (@available(iOS 11.0, *)) {
            self.view.center = CGPointMake(self->centerView.x, self->centerView.y - heightKeyboard + self.view.safeAreaInsets.bottom);
        } else {
            // Fallback on earlier versions
        }
    } completion:nil];
   
    [[UIMenuController sharedMenuController] setMenuItems:nil];
}

- (void)keyboardHide:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    NSTimeInterval duration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.view.center = self->centerView;
    } completion:nil];
}

- (void)dismissKeyboard{
    [self.view endEditing:YES];
}

- (void)openMediaOption{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self openCameraForPhoto];
        
    }];
    UIAlertAction *actionPhoto = [UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self openGalleryForPhoto];
        
    }];
    UIAlertAction *actionVideo = [UIAlertAction actionWithTitle:@"Video" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self openGalleryForVideo];
        
    }];
    UIAlertAction *actionDocument = [UIAlertAction actionWithTitle:@"Document" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self openDoc];
        
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    [actionSheet addAction:actionCamera];
    [actionSheet addAction:actionPhoto];
    [actionSheet addAction:actionVideo];
    [actionSheet addAction:actionDocument];
    [actionSheet addAction:actionCancel];

    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void)openGalleryForPhoto{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

-(void)openGalleryForVideo{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, nil];
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

-(void)openCameraForPhoto{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraPicker.delegate = self;
//        if (![self isPhotoSelection:photoSelectionType]) cameraPicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        [self presentViewController:cameraPicker animated:YES completion:nil];
    }
}

-(void)openDoc{
//    @[@"public.data",@"public.content",@"public.audiovisual-content",@"public.movie",@"public.audiovisual-content",@"public.video",@"public.audio",@"public.text",@"public.data",@"public.zip-archive",@"com.pkware.zip-archive",@"public.composite-content",@"public.text"]
    UIDocumentMenuViewController *documentProviderMenu =
    [[UIDocumentMenuViewController alloc] initWithDocumentTypes:@[@"public.data"]
                                                         inMode:UIDocumentPickerModeOpen];
    
    documentProviderMenu.delegate = self;
    documentProviderMenu.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:documentProviderMenu animated:YES completion:nil];
    
}



#pragma mark - Selector Methods


-(void)docBtnAction:(UIButton*)sender{
    
    MessageInfo *info = [self.messageList objectAtIndex:sender.tag - 200];
    
}

-(void)playBtnAction:(UIButton*)sender{
    
    MessageInfo *info = [self.messageList objectAtIndex:sender.tag - 100];
    if (info.videoURL != nil) {
        AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
        playerViewController.player = [AVPlayer playerWithURL:info.videoURL];
        [self presentViewController:playerViewController animated:YES completion:nil];
    }
   
    
}



#pragma mark - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
        MessageInfo *info1 = [MessageInfo new];
        info1.imageName = chosenImage;
        info1.isSender = true;
        [self.messageList addObject:info1];
        
    } else if ([mediaType isEqualToString:@"public.movie"]){
        
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];

        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *thumbnail = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);

        MessageInfo *info1 = [MessageInfo new];
        info1.thumbnailImage = thumbnail;
        info1.videoURL = videoURL;
        info1.isSender = true;
        [self.messageList addObject:info1];
    }
    
    [self.myTableView reloadData];
    [self.myTableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
                                               inSection:0]
     atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIDocumentPicker Delegate

- (void)documentMenu:(nonnull UIDocumentMenuViewController *)documentMenu didPickDocumentPicker:(nonnull UIDocumentPickerViewController *)documentPicker {
    
    documentPicker.delegate = self;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    NSLog(@"picked %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"extenstion %@", [request.URL lastPathComponent]);
    //UIImage *thumbnail = [UIImage imageNamed:@"document"];
    MessageInfo *info1 = [MessageInfo new];
    info1.videoURL = url;
    info1.message = [request.URL lastPathComponent];
    info1.isDoc = true;
    info1.isSender = true;
    [self.messageList addObject:info1];
    
    [self.myTableView reloadData];
    [self.myTableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
                                               inSection:0]
     atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - UITextField Delegate Methode

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSBundle *resourceBundle = [Utility getBundleForChatBotPro];
    UIImage *img = [UIImage imageNamed:@"sendActive.png" inBundle:resourceBundle compatibleWithTraitCollection:nil];
    [self.sendBtn setImage:img forState:UIControlStateNormal];

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([_messageTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        NSBundle *resourceBundle = [Utility getBundleForChatBotPro];
        UIImage *img = [UIImage imageNamed:@"send.png" inBundle:resourceBundle compatibleWithTraitCollection:nil];
       [self.sendBtn setImage:img forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];

    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.text.length >= 265 && range.length == 0){
        return NO;
    }
    
    return YES;
}

#pragma mark - UITableViewDelegate & DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.menuTableView) {
        return menuList.count;
    }
    return self.messageList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.myTableView){
        return;
    }
    [UIView animateWithDuration:0.85 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        self.heightConstant.constant = 0;
        self.widthConstant.constant = 0;
    } completion:^(BOOL finished) {
        
        //code for completion
    }];
    self.menuBtn.selected = false;
//    MessageInfo *info = [MessageInfo new];
//    info.message = [menuList objectAtIndex:indexPath.row];
//    info.isSender = true;
//    [self.messageList addObject:info];
//    [self.myTableView reloadData];
//    [self.myTableView
//     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
//                                               inSection:0]
//     atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    
//    //send request to bot
//    [self callAPIToSubmitAnswer:[menuList objectAtIndex:indexPath.row]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"collectionCellButtonActionNotification" object:[menuList objectAtIndex:indexPath.row]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.menuTableView) {
        MenuTableViewCell *cell = (MenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
        cell.titleLabel.textColor = [UIColor colorWithRed:22/255.0 green:188/255.0 blue:206/255.0 alpha:1];
        cell.titleLabel.text = [menuList objectAtIndex:indexPath.row];
        return cell;
    }
    
    MessageInfo *info = [self.messageList objectAtIndex:indexPath.row];
    if (info.isProgress) {
        ProgressCell *cell = (ProgressCell *)[tableView dequeueReusableCellWithIdentifier:@"ProgressCell"];
        return cell;
    }
    
    
    if (info.thumbnailImage != nil) {
        SenderImageTableViewCell *cell = (SenderImageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SenderImageTableViewCell"];
                cell.playBtn.hidden = false;
        cell.playBtn.tag = indexPath.row + 100;
            [cell.playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];

        
        cell.messageImageView.image = info.thumbnailImage;
        return cell;
    }
    if(info.isDoc){
        AttachmentCell *cell = (AttachmentCell*)[tableView dequeueReusableCellWithIdentifier:@"AttachmentCell"];
        cell.messageTitle.text = info.message;
        return cell;
    }
    
    if (info.gifImage.length > 0) {
        ImageReceiverTableViewCell *cell = (ImageReceiverTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ImageReceiverTableViewCell"];
        
        NSURL *url = [NSURL URLWithString:info.gifImage];
        
        
        NSData *fileData = [Utility getFileInDocDir:info.gifImage];
        if(fileData != nil){
            cell.messageImageView.image = [UIImage animatedImageWithAnimatedGIFData:fileData];
        }
        else{
        
//        cell.messageImageView.image = [UIImage imageNamed:@"messageplaceholder"];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            [Utility saveFile:info.gifImage];
            NSData * imageData = [NSData dataWithContentsOfURL:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                 cell.messageImageView.image = [UIImage animatedImageWithAnimatedGIFData:imageData];
            });
        });
        }
        return cell;
        
    }
    
    if (info.isCarausal) {
        CollectionViewTableViewCell *cell = (CollectionViewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CollectionViewTableViewCell"];
        cell.myCollectionView.delegate = cell;
        cell.myCollectionView.dataSource = cell;
        NSArray *articleData = info.carausalArray;
        [cell setCollectionData:articleData];
        return cell;
    }
    
    if (info.isOption) {
        OptionsTableViewCell *cell = (OptionsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"OptionsTableViewCell"];
        [cell setData:info.optionsArray];
        return cell;
    }
    
    if (info.isSender) {
        if (info.imageName == nil) {
            SenderTableViewCell *cell = (SenderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SenderTableViewCell"];
            cell.messageLabel.text = info.message;
            
            return cell;
        }else{
            SenderImageTableViewCell *cell = (SenderImageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SenderImageTableViewCell"];
            cell.playBtn.hidden = true;
            cell.messageImageView.image = info.imageName;
            UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            imgBtn.frame = cell.messageImageView.frame;
            imgBtn.tag = indexPath.row + 300;;
            [imgBtn addTarget:self action:@selector(imageBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:imgBtn];
            return cell;
        }
    }else {
        if (info.imageName == nil) {
            ReciverTableViewCell *cell = (ReciverTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ReciverTableViewCell"];
            cell.messageTitle.text = info.message;
            return cell;
        }else{
            ImageReceiverTableViewCell *cell = (ImageReceiverTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ImageReceiverTableViewCell"];
            cell.messageImageView.image = info.imageName;
            

            return cell;
        }
    }
    
    
    return nil;
}

-(void)imageBtnTapped:(UIButton *)sender{
    MessageInfo *info = [self.messageList objectAtIndex:sender.tag - 300];
    UIImage *image = info.imageName;
    
    _previewImage = [[UIImageView alloc] initWithImage:image];
    _previewImage.frame = self.view.bounds;
    _previewImage.contentMode = UIViewContentModeScaleAspectFill;
    _previewImage.userInteractionEnabled = YES;
    _previewImage.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_previewImage];
    
    UIButton *crossBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [crossBtn setImage:[UIImage imageNamed:@"corss"] forState:UIControlStateNormal];
    crossBtn.frame = CGRectMake(self.view.bounds.size.width - 54, 25, 44, 44);
    [crossBtn addTarget:self action:@selector(removeImageVIew) forControlEvents:UIControlEventTouchUpInside];
//    [_previewImage addSubview:crossBtn];
    
//    [self.view bringSubviewToFront:_previewImage];
    
   
    
    TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:_previewImage.image];
    // Don't forget to set ourselves as the transition delegate
    viewController.transitioningDelegate = self;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:_previewImage];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:_previewImage];
    }
    return nil;
}

-(void)removeImageVIew{
    [_previewImage removeFromSuperview];
}

#pragma mark- UIButton Action Methods

-(void)readMoreBtn:(UIButton*)sender{
    MessageInfo *info = [MessageInfo new];
    info.message = @"Read more";
    info.isSender = true;
    [self.messageList addObject:info];
    [self.myTableView reloadData];
    [self.myTableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
                                               inSection:0]
     atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (IBAction)sendBtnAction:(id)sender {
    [self.view endEditing:true];
    if ([self.messageTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length != 0) {
        MessageInfo *info = [MessageInfo new];
        info.message = self.messageTextField.text;
        info.isSender = true;
        [self.messageList addObject:info];
        [self.myTableView reloadData];
        [self.myTableView
         scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
                                                   inSection:0]
         atScrollPosition:UITableViewScrollPositionBottom animated:YES];
       
        
        NSBundle *resourceBundle = [Utility getBundleForChatBotPro];
        UIImage *img = [UIImage imageNamed:@"send.png" inBundle:resourceBundle compatibleWithTraitCollection:nil];
        [self.sendBtn setImage:img forState:UIControlStateNormal];

        //send request to bot
        [self callAPIToSubmitAnswer:self.messageTextField.text];
         [self.messageTextField setText:@""];
    }
}

- (IBAction)menuBtnAction:(UIButton*)sender {
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        [UIView animateWithDuration:0.85 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{

        } completion:^(BOOL finished) {
            self.heightConstant.constant = 410;
            self.widthConstant.constant = 294;
            //code for completion
        }];
    }else{
        [UIView animateWithDuration:0.85 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{

        } completion:^(BOOL finished) {
            self.heightConstant.constant = 0;
            self.widthConstant.constant = 0;
            //code for completion
        }];
    }
    
    
//        // grab the view controller we want to show
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
//        
//    // set modal presentation style to popover on your view controller
//    // must be done before you reference controller.popoverPresentationController
//    controller.modalPresentationStyle = UIModalPresentationPopover;
//    controller.preferredContentSize = CGSizeMake(270, 360);
//    
//    // configure popover style & delegate
//    UIPopoverPresentationController *popover =  controller.popoverPresentationController;
//    popover.delegate = self;
//    popover.sourceView = self.menuBtn;
//    popover.sourceRect = CGRectMake(0+13,0,self.menuBtn.frame.size.width,self.menuBtn.frame.size.height);
//    popover.permittedArrowDirections = UIPopoverArrowDirectionDown;
//    
//    // display the controller in the usual way
//    [self presentViewController:controller animated:YES completion:nil];
//    
}
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}

- (IBAction)closeMenuAction:(id)sender {
    [UIView animateWithDuration:0.85 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        
    } completion:^(BOOL finished) {
        self.heightConstant.constant = 0;
        self.widthConstant.constant = 0;
        self.menuBtn.selected = false;
    }];
}

- (IBAction)uploadBtnAction:(id)sender {
    [self openMediaOption];
}

- (IBAction)downBtnACtion:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showProgressCell{
    MessageInfo *info = [MessageInfo new];
    info.isSender = false;
    info.isProgress = YES;
    [self.messageList addObject:info];
    [self.myTableView reloadData];
    [self.myTableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
                                               inSection:0]
     atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)removeProgressCell{
    for(MessageInfo *info in self.messageList){
        if (info.isProgress) {
            [self.messageList removeObject:info];
        }
    }
}

#pragma mark - Service Helper Methods
-(void)callAPIToSubmitAnswer:(NSString *)message{
    [self showProgressCell];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         message, @"lastAnswer",
                                         token, @"iosId",_projectID,@"projectId",nil];

    [[OPServiceHelper sharedServiceHelper] PostAPICallWithParameter:requestDict apiName:_baseURL methodName:WebMethodLogin WithComptionBlock:^(id result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeProgressCell];
            if(!error){
                if([[result objectForKeyNotNull:pRESPONSE_CODE expectedObj:@"0"] integerValue] == 200){
                    
                    

                } else{

                }
            }
        });
    }];
}

-(void)addInfo:(NSDictionary*)dict{
    MessageInfo *info = [MessageInfo new];
    if([[dict objectForKey:@"type"] isEqualToString:@"text"]){
        info.message = [dict objectForKey:@"value"];
    }
    else if([[dict objectForKey:@"type"] isEqualToString:@"image"]){
        info.gifImage = [dict objectForKey:@"value"];
    }
    info.isSender = false;
    if(info.message.length != 0 || info.gifImage.length != 0)
    [self.messageList addObject:info];
    dispatch_async(dispatch_get_main_queue(), ^{
        // Your UI update code here
        [self.myTableView reloadData];
        [self.myTableView
         scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
                                                   inSection:0]
         atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
   
}

-(void)addMessageReplyToArray:(NSDictionary *)messageDict{
     [MBProgressHUD hideHUDForView:[Utility getWindow] animated:YES];
    if([[messageDict objectForKey:@"answerType"] isEqualToString:@"text"]){
        id object = [self dictionaryFromString:[messageDict objectForKey:@"botMessage"]];
        if ([object isKindOfClass:[NSArray class]]) {
            NSLog(@"arrclass");
            double delayInSeconds = 0.0;
            for(NSDictionary *dict in object){
                delayInSeconds += .5;
                
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                               {
                                   NSLog(@"Block");
                                   [self performSelectorOnMainThread:@selector(addInfo:)
                                                          withObject:dict
                                                       waitUntilDone:NO];
                                   
                               });
            }
        }
        }
    else if([[messageDict objectForKey:@"answerType"] isEqualToString:@"generic"]){
        id object = [self dictionaryFromString:[messageDict objectForKey:@"botMessage"]];
        
        if ([object isKindOfClass:[NSArray class]]) {
            NSLog(@"arrclass");
            double delayInSeconds = 0.0;
            for(NSDictionary *dict in object){
                 delayInSeconds += .5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                               {
                                   NSLog(@"Block");
                                   [self performSelectorOnMainThread:@selector(addInfo:)
                                                          withObject:dict
                                                       waitUntilDone:NO];
                                   if ([object lastObject] == dict) {
                                       id optionsObject = [self dictionaryFromString:[messageDict objectForKey:@"options"]];
                                       [self addCaraousalOptionsToArray:optionsObject];
                                   }
                               });
//                MessageInfo *info = [MessageInfo new];
//                info.message = [dict objectForKey:@"value"];
//                info.isSender = false;
//                [self.messageList addObject:info];
//                [self.myTableView reloadData];
//                [self.myTableView
//                 scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
//                                                           inSection:0]
//                 atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                NSLog(@"done with for loop");
            }
        }
        
        
    }
    else if([[messageDict objectForKey:@"answerType"] isEqualToString:@"option"]){
        id object = [self dictionaryFromString:[messageDict objectForKey:@"botMessage"]];
        if ([object isKindOfClass:[NSArray class]]) {
            NSLog(@"arrclass");
            double delayInSeconds = 0.0;
            for(NSDictionary *dict in object){
                delayInSeconds += .5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                               {
                                   NSLog(@"Block");
                                   [self performSelectorOnMainThread:@selector(addInfo:)
                                                          withObject:dict
                                                       waitUntilDone:NO];
                                   if ([object lastObject] == dict) {
                                       id optionsObject = [self dictionaryFromString:[messageDict objectForKey:@"options"]];
                                       [self addTempOptionsToArray:optionsObject];
                                   }
                               });
//                MessageInfo *info = [MessageInfo new];
//                if([[dict objectForKey:@"type"] isEqualToString:@"text"]){
//                info.message = [dict objectForKey:@"value"];
//                }
//                else if([[dict objectForKey:@"type"] isEqualToString:@"image"]){
//                    info.gifImage = [dict objectForKey:@"value"];
//                }
//                info.isSender = false;
//                if(info.message.length != 0 || info.gifImage.length != 0)
//                [self.messageList addObject:info];
//                [self.myTableView reloadData];
//                [self.myTableView
//                 scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
//                                                           inSection:0]
//                 atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                
            }
        }
       
       
    }
}

-(void)addCaraousalOptionsToArray:(id)options{
    MessageInfo *info2 = [MessageInfo new];
    info2.isSender = false;
    info2.isCarausal = true;
    if ([options isKindOfClass:[NSArray class]]) {
        info2.carausalArray = options;
    }
    [self.messageList addObject:info2];
    dispatch_async(dispatch_get_main_queue(), ^{
        // Your UI update code here
        [self.myTableView reloadData];
        [self.myTableView
         scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
                                                   inSection:0]
         atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
    
    
}

-(void)addTempOptionsToArray:(id)options{
    if ([options isKindOfClass:[NSArray class]]) {
        MessageInfo *info = [MessageInfo new];
        
        info.isSender = false;
        info.isOption = true;
        NSMutableArray *tempArr = [NSMutableArray new];
        for (NSDictionary *dict in options) {
            [tempArr addObject:[dict objectForKey:@"text"]];
            
        }
        info.optionsArray = tempArr;
        [self.messageList addObject:info];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.myTableView reloadData];
        [self.myTableView
         scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
                                                   inSection:0]
         atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            });
    }
    
}

- (NSDictionary*)dictionaryFromString:(NSString*)strActionData
{
    if(strActionData){
        NSString *str = [strActionData stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError* error = nil;
        NSDictionary *dictActionData = [NSJSONSerialization JSONObjectWithData:data options:0
                                                                         error:&error];
        
        return dictActionData;
    }
    else
        return nil;
}

-(void)collectionCellButtonAction:(NSNotification *) notification
{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.messageList];
    for(MessageInfo *msgInfo in tempArray){
        if (msgInfo.isOption) {
            [self.messageList removeObject:msgInfo];
        }
    }
    
    NSLog(@"userInfo %@",notification.object);
    MessageInfo *info = [MessageInfo new];
    info.message = notification.object;
    info.isSender = true;
    [self.messageList addObject:info];
    [self.myTableView reloadData];
    [self.myTableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageList.count-1
                                               inSection:0]
     atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [self performSelector:@selector(callApi:) withObject:notification.object afterDelay:1];
    
}

-(void)callApi:(NSString*)text{
    
    [self callAPIToSubmitAnswer:text];
}

#pragma mark - Memory Warning Methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//[[AlertView sharedManager] displayInformativeAlertwithTitle:fcmToken andMessage:fcmToken onController:]




@end
