use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker 6.17;

my %WriteMakefileArgs = (
  "ABSTRACT" => "BSON serialization and deserialization",
  "AUTHOR" => "David Golden <david\@mongodb.com>, Stefan G. <minimalist\@lavabit.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.17"
  },
  "DISTNAME" => "BSON",
  "LICENSE" => "apache",
  "MIN_PERL_VERSION" => "5.010001",
  "NAME" => "BSON",
  "PREREQ_PM" => {
    "B" => 0,
    "Carp" => 0,
    "Digest::MD5" => 0,
    "Exporter" => 0,
    "List::Util" => 0,
    "MIME::Base64" => 0,
    "Math::BigFloat" => 0,
    "Math::BigInt" => 0,
    "Moo" => "2.002004",
    "Scalar::Util" => 0,
    "Sys::Hostname" => 0,
    "Tie::IxHash" => 0,
    "Time::HiRes" => 0,
    "Time::Local" => 0,
    "base" => 0,
    "boolean" => "0.45",
    "constant" => 0,
    "if" => 0,
    "mro" => 0,
    "namespace::clean" => 0,
    "overload" => 0,
    "re" => 0,
    "strict" => 0,
    "threads::shared" => 0,
    "version" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Data::Dumper" => 0,
    "Devel::Peek" => 0,
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "JSON::MaybeXS" => 0,
    "Path::Tiny" => "0.054",
    "Test::Deep" => 0,
    "Test::More" => "0.96",
    "lib" => 0,
    "utf8" => 0
  },
  "VERSION" => "v1.6.7",
  "test" => {
    "TESTS" => "t/*.t t/common/*.t t/corpus/*.t t/legacy/*.t t/mapping/*.t"
  }
);


my %FallbackPrereqs = (
  "B" => 0,
  "Carp" => 0,
  "Data::Dumper" => 0,
  "Devel::Peek" => 0,
  "Digest::MD5" => 0,
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "JSON::MaybeXS" => 0,
  "List::Util" => 0,
  "MIME::Base64" => 0,
  "Math::BigFloat" => 0,
  "Math::BigInt" => 0,
  "Moo" => "2.002004",
  "Path::Tiny" => "0.054",
  "Scalar::Util" => 0,
  "Sys::Hostname" => 0,
  "Test::Deep" => 0,
  "Test::More" => "0.96",
  "Tie::IxHash" => 0,
  "Time::HiRes" => 0,
  "Time::Local" => 0,
  "base" => 0,
  "boolean" => "0.45",
  "constant" => 0,
  "if" => 0,
  "lib" => 0,
  "mro" => 0,
  "namespace::clean" => 0,
  "overload" => 0,
  "re" => 0,
  "strict" => 0,
  "threads::shared" => 0,
  "utf8" => 0,
  "version" => 0,
  "warnings" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
