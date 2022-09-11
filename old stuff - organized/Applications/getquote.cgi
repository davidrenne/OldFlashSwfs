#!/usr/bin/perl -w

use strict;
my %Symbol=("0"=>"Symbol","1"=>"Company Name","2"=>"Last Price","3"=>"Last Trade Date","4"=>"Last Trade Time","5"=>"Change","6"=>"Percent Change","7"=>"Volume","8"=>"Average Daily Vol","9"=>"Bid","10"=>"Ask","11"=>"Previous Close","12"=>"Today's Open","13"=>"Day's Range","14"=>"52-Week Range","15"=>"Earnings per Share","16"=>"P/E Ratio","17"=>"Dividend Pay Date","18"=>"Dividend per Share","19"=>"Dividend Yield","20"=>"Market Capitalization","21"=>"Stock Exchange","22"=>"Short ratio","23"=>"1yr Target Price","24"=>"EPS Est. Current Yr","25"=>"EPS Est. Next Year","26"=>"EPS Est. Next Quarter","27"=>"Price/EPS Est. Current Yr","28"=>"Price/EPS Est. Next Yr","29"=>"PEG Ratio","30"=>"Book Value","31"=>"Price/Book","32"=>"Price/Sales","33"=>"EBITDA","34"=>"50-day Moving Avg","35"=>"200-day Moving Avg","36"=>"Ask (real-time)","37"=>"Bid (real-time)","38"=>"Change in Percent (real-time)","39"=>"Last trade with time (real-time)","40"=>"Change (real-time)","41"=>"Day range (real-time)","42"=>"Market-cap (real-time)");

use Flash::FLAP;

package cpuUsage;

sub new
{
    my ($proto)=@_;
    my $self={};
    bless $self, $proto;
    return $self;
}

sub getCpuUsage
{
    my ($self, $arg1) = @_;
    my @array;
    if($arg1){
      use Finance::YahooQuote;
      
      $Finance::YahooQuote::TIMEOUT=60;
      
      useExtendedQueryFormat();
      useRealtimeQueryFormat();
      
      my @quote=getonequote $arg1;
      for(my $i=0;$i<@quote;$i++){
          my $numb=$i+1;
          my %hash = ("Name" => "$numb", "Value" => "$quote[$i]");
          push @array, \%hash;
      }
my $lcarg1=lc(${arg1});
my $H=undef;
if($lcarg1=~m/^(\w)/){
  $H=$1;
}
use Socket;
use LWP::Simple;
my %leter=(
1=>"http://ichart.yahoo.com/v?s=$arg1",
2=>"http://chart.yahoo.com/c/0b/$H/${lcarg1}.gif",
3=>"http://ichart.yahoo.com/t?s=$arg1"
);
for(my $i=1;$i<=3;$i++){
my $name="$leter{$i}";
my $content=undef;
unless (defined ($content = get $name)) {
         warn "ERROR \$name=$name";
}
else{
use Image::Magick;
my $image = new Image::Magick;
open(FF,"> /scsi/apache/htdocs/yahoo${i}.gif");
print FF $content;
close(FF);
my $x=$image->Read("/scsi/apache/htdocs/yahoo${i}.gif");
my ($w, $h) = $image->Get("width", "height");
my $rc = $image->Write("/scsi/apache/htdocs/yahoo${i}.jpg");
undef $image;
}     
}
    }
    
    return \@array;
}
    
my $gateway = Flash::FLAP->new;
$gateway->registerService("CpuUsage",new cpuUsage());
$gateway->service();