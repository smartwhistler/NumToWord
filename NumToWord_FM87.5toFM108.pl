#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use encoding 'utf8';
use Encode;
use utf8;

# FM: From, 87.5 To, 108.5
my $fm_num=87.5;		 # 从87.5开始
my @fm_all_num=();		 # 保存所有数字
while($fm_num<=108.5) {
	push(@fm_all_num, $fm_num);
	$fm_num+=0.5;
}

foreach(@fm_all_num) {
	my @all_version_for_the_num;

	my $normal=$_;						# 正常说法：八七点五、一零八点五
	$normal=~s/1/一/g; $normal=~s/2/二/g; $normal=~s/3/三/g;
	$normal=~s/4/四/g; $normal=~s/5/五/g; $normal=~s/6/六/g;
	$normal=~s/7/七/g; $normal=~s/8/八/g; $normal=~s/9/九/g;
	$normal=~s/0/零/g; $normal=~s/\./点/g; 
	push(@all_version_for_the_num, $normal);

	my $normal_without_dot=$normal;			# 去点：八七五、一零八五
	$normal_without_dot =~ s/点//g;
	push(@all_version_for_the_num, $normal_without_dot);

	my $with_decade_hundred_dot=$normal;	# 带十、百、点：八十七点五、一百零八点五
	if(87.5<=$_ && $_<100) {
	# 两位数
		if($_%10 == 0) {
		# 整十
			$with_decade_hundred_dot =~ s/^(.)零/$1十/;
			push(@all_version_for_the_num, $with_decade_hundred_dot);
		} else {
			$with_decade_hundred_dot =~ s/^(.)/$1十/;
			push(@all_version_for_the_num, $with_decade_hundred_dot);
		}
	} elsif (100<=$_ && $_<101) {
	# 整百
		$with_decade_hundred_dot =~ s/^(.)零零/$1百/;
		push(@all_version_for_the_num, $with_decade_hundred_dot);
	} elsif (101<=$_ && $_<=108.5) {
	# 三位数
		$with_decade_hundred_dot =~ s/^(.)/$1百/;
		push(@all_version_for_the_num, $with_decade_hundred_dot);
	} else {
		die "Error: value ".$_." not right.\n";
	}

	my $normal_onetoyao=$normal;		# 一变幺：幺零八点五
	$normal_onetoyao =~ s/一/幺/g;
	push(@all_version_for_the_num, $normal_onetoyao);

	my $normal_without_dot_onetoyao=$normal;	# 去点，一变幺：幺零八五
	$normal_without_dot_onetoyao =~ s/点//g;
	$normal_without_dot_onetoyao =~ s/一/幺/g;
	push(@all_version_for_the_num, $normal_without_dot_onetoyao);

	# 去重
	my %hash = ();
	@all_version_for_the_num = grep {!$hash{$_}++} @all_version_for_the_num;

	printf("%s\t".("%s\t" x @all_version_for_the_num)."\n", $_, @all_version_for_the_num);
}
