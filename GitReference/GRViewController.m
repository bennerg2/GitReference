//
//  GRViewController.m
//  GitReference
//
//  Created by Benjamin Thomas Gurrola on 10/2/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

#import "GRViewController.h"

static CGFloat heightForLabel = 20.0;
static CGFloat margin = 15.0;
static NSString * const Command = @"command";
static NSString * const Reference = @"reference";

@interface GRViewController ()

@end

@implementation GRViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Step 1.2 - instantiate a scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, heightForLabel, self.view.frame.size.width, self.view.frame.size.height - heightForLabel)];
    // add scrollView to self.view
    [self.view addSubview:scrollView];
    
    // Don't use magic numbers!!
    CGFloat topMargin = heightForLabel;
    CGFloat widthMinusMargin = self.view.frame.size.width - margin * 2.0;
    
    // Step 1.3 - add Title to scrollView
    UILabel *scrollTitle = [[UILabel alloc] initWithFrame:CGRectMake(margin, topMargin, widthMinusMargin, heightForLabel)];
    scrollTitle.font = [UIFont boldSystemFontOfSize:20.0]; // did this because it was in the solution code.. and it probably makes it look nicer.
    scrollTitle.text = @"GitReference";
    [scrollView addSubview:scrollTitle];
    
    // Step 3.1 - set a starting point to track height
    CGFloat top = topMargin + heightForLabel + margin * 2.0;
    
    // Step 3.2 - for-in loop for all key-value pairs in gitCommands
    for (NSDictionary *gitCommand in [self gitCommands]) {
        
        // Constants to pull out info at keys
        NSString *command = gitCommand[Command];
        NSString *reference = gitCommand[Reference];
        
        // Step 3.3 - add commandLabel
        UILabel *commandLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, widthMinusMargin, heightForLabel)];
        commandLabel.font = [UIFont boldSystemFontOfSize:17.0]; // just copied
        commandLabel.text = command;
        [scrollView addSubview:commandLabel];
        
        // Move down the space of another label
        top += (heightForLabel + margin);
        
        // Call heightOfReferenceString method to get the total height of the reference
        CGFloat heightForReference = [self heightOfReferenceString:reference];
        
        // Step 3.4 - add referenceLabel
        UILabel *referenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, widthMinusMargin, heightForReference)];
        referenceLabel.numberOfLines = 0; // I guess if you don't add this, it will show up on one line
        referenceLabel.font = [UIFont systemFontOfSize:15.0]; // copied this
        referenceLabel.text = reference;
        [scrollView addSubview:referenceLabel];
        
        // update top once more to move it down for the next command
        top += (heightForReference + margin * 2.0);
        
    }
    
    // You've got to add this otherwise you won't be able to scroll!
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, top);
}

- (NSArray *)gitCommands {
    
    return @[@{Command: @"git status", Reference: @": shows changed files"},
             @{Command: @"git diff", Reference: @": shows actual changes"},
             @{Command: @"git add", Reference: @": adds changed files to the commit"},
             @{Command: @"git commit -m \"notes\"", Reference: @": commits the changes"},
             @{Command: @"git push origin _branch_", Reference: @": pushes commits to branch named _branch_"},
             @{Command: @"git log", Reference: @": displays progress log"},
             @{Command: @"git comment --amend", Reference: @": re-enter last commit message"}
             ];
    
}

- (CGFloat)heightOfReferenceString:(NSString *)reference {
    
    CGRect bounding = [reference boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 2 * margin, 0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                              context:nil];
    
    return bounding.size.height;
}

@end
