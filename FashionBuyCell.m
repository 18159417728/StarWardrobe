//
//  FashionBuyCell.m
//  StarWardrobe
//
//  Created by qianfeng on 16/11/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "FashionBuyCell.h"

@interface FashionBuyCell ()

@property(nonatomic,strong)UIImageView *picsImage;
@property(nonatomic,strong)UILabel *descLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIImageView *iocn;
@property(nonatomic,strong)UILabel *subLabel;

@end


@implementation FashionBuyCell

-(void)setModel:(FashionCellDetailModel *)model{
    
    _model = model;
    
    [self.picsImage sd_setImageWithURL:[self picUrl:_model.picUrl]];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price];
    self.descLabel.text = _model.desc;
}

- (NSURL *)picUrl:(NSString *)urlString
{
    NSString *url = urlString;
    
    NSRange range = [urlString rangeOfString:@"?image"];
    
    if (range.location != NSNotFound) {
        url = [url substringToIndex:range.location];
    }
    
    return [NSURL URLWithString:url];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self instanceUI];
        [self addConstraintsWithUI];
    }
    return self;
}

-(void)instanceUI{
    
    self.picsImage = [[UIImageView alloc]init];
    [self.contentView addSubview:self.picsImage];
    
    self.descLabel = [[UILabel alloc]init];
    self.descLabel.font = [UIFont systemFontOfSize:14];
    self.descLabel.numberOfLines = 0;
    [self.contentView addSubview:self.descLabel];
    
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.font = [UIFont systemFontOfSize:18];
    self.priceLabel.textColor = DefaultColor;
    [self.contentView addSubview:self.priceLabel];
    
    self.iocn = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_list_dapei"]];
    [self.contentView addSubview:self.iocn];
    
    self.subLabel = [[UILabel alloc]init];
    self.subLabel.font = [UIFont systemFontOfSize:10];
    self.subLabel.text = @"相关搭配";
    [self.contentView addSubview:self.subLabel];
    
}

-(void)addConstraintsWithUI{
    
    [_picsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@0);
        make.left.equalTo(@5);
        make.right.equalTo(@-5);
        make.height.equalTo(@320);
    }];
    
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@10);
        make.top.equalTo(_picsImage.mas_bottom).offset(10);
        make.width.equalTo(@70);
        make.height.equalTo(@20);

    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_priceLabel.mas_right).offset(10);
        make.top.equalTo(_picsImage.mas_bottom).offset(10);
        make.right.equalTo(@-5);
    }];
    
    
    [_iocn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        make.top.equalTo(_descLabel.mas_bottom).offset(10);
        make.width.height.equalTo(@15);
    }];
    
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iocn.mas_right).offset(10);
        make.top.equalTo(_descLabel.mas_bottom).offset(12);
        
    }];
   
}


- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
