#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use encoding 'utf8';
use Encode;
use utf8;

# AM: From, 503 To, 1600
my @am_all = (503..1600);

foreach (@am_all) {
	my @all_version_for_the_num;

	my $normal=$_;						# 正常说法：五零三、一六零零、一零零零、六零零
	$normal=~s/1/一/g; $normal=~s/2/二/g; $normal=~s/3/三/g;
	$normal=~s/4/四/g; $normal=~s/5/五/g; $normal=~s/6/六/g;
	$normal=~s/7/七/g; $normal=~s/8/八/g; $normal=~s/9/九/g;
	$normal=~s/0/零/g;
	push(@all_version_for_the_num, $normal);

	my $with_decade_hundred_thousand=$normal;
	if(503<=$_ && $_<1000) {
		# 三位数
		if($_%100 == 0) {
			# 整百
			$with_decade_hundred_thousand =~ s/^(.)零零/$1百/;
			push(@all_version_for_the_num, $with_decade_hundred_thousand);
		} elsif($_%10 == 0) {
			# 整十
			$with_decade_hundred_thousand =~ s/^(.)(.)零/$1百$2十/;
			push(@all_version_for_the_num, $with_decade_hundred_thousand);
			$with_decade_hundred_thousand =~ s/^(.+)十/$1/;
			push(@all_version_for_the_num, $with_decade_hundred_thousand);
		} else {
			# 普通
			$with_decade_hundred_thousand =~ s/^(.)(.)(.)$/$1百$2十$3/;
			$with_decade_hundred_thousand =~ s/百零十/百零/;
			push(@all_version_for_the_num, $with_decade_hundred_thousand);
		}
	} elsif(1000<=$_ && $_<=1600) {
		# 四位数
		if($_%1000 == 0) {
			# 整千
			$with_decade_hundred_thousand =~ s/^(.)零零零$/$1千/;
			push(@all_version_for_the_num, $with_decade_hundred_thousand);
		} elsif($_%100 == 0) {
			# 整百
			$with_decade_hundred_thousand =~ s/^(.)(.)零零$/$1千$2百/;
			push(@all_version_for_the_num, $with_decade_hundred_thousand);
			$with_decade_hundred_thousand =~ s/^(.+)百$/$1/;
			push(@all_version_for_the_num, $with_decade_hundred_thousand);
		} elsif($_%10 == 0) {
			# 整十
			$with_decade_hundred_thousand =~ s/^(.)(.)(.)零$/$1千$2百$3十/;
			$with_decade_hundred_thousand =~ s/零百/零/;
			push(@all_version_for_the_num, $with_decade_hundred_thousand);
			$with_decade_hundred_thousand =~ s/^(.+)十$/$1/;
			push(@all_version_for_the_num, $with_decade_hundred_thousand);
		} else {
			# 普通
			$with_decade_hundred_thousand =~ s/^(.)(.)(.)(.)$/$1千$2百$3十$4/;
			$with_decade_hundred_thousand =~ s/零百/零/;
			$with_decade_hundred_thousand =~ s/零十/零/;
			$with_decade_hundred_thousand =~ s/零+/零/;
			push(@all_version_for_the_num, $with_decade_hundred_thousand);
		}
	} else {
		die "Error: value ".$_." not right.\n";
	}

	my $normal_onetoyao=$normal;
	$normal_onetoyao =~ s/一/幺/g;
	push(@all_version_for_the_num, $normal_onetoyao);
	
	# 去重
	my %hash = ();
	@all_version_for_the_num = grep {!$hash{$_}++} @all_version_for_the_num;

	printf("%s\t".("%s\t" x @all_version_for_the_num)."\n", $_, @all_version_for_the_num);
}
