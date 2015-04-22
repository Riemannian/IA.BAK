#!/usr/bin/perl
use warnings;
use strict;
use CGI;
my $q = CGI->new;
my $email = $q->param("email");
my $shard = $q->param("shard");
my $pubkey = $q->param("pubkey");
if ($shard !~ /^SHARD\d+$/) {
	die "bad SHARD\n";
}

chdir("/home/registrar/users/") || die "chdir: $!";
if (! -d $shard) {
	mkdir("$shard") || die "mkdir: $!";
}
open (OUT, ">>$shard/pubkeys") || die "open: $!";
print OUT "$pubkey $email";
close OUT;
system("git add $shard/pubkeys; git commit -m registration; git push");
print "** REGISTRATION SUCCEEDED **";
exit 0;
