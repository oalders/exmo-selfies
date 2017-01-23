requires "Cpanel::JSON::XS" => "0";
requires "Data::Printer" => "0";
requires "LWP::ConsoleLogger::Easy" => "0";
requires "List::AllUtils" => "0";
requires "Mojolicious::Plugin::Web::Auth::Site::Reddit" => "0.000003";
requires "Moo" => "0";
requires "MooX::Options" => "0";
requires "Path::Tiny" => "0";
requires "Types::Standard" => "0";
requires "URI::FromHash" => "0";
requires "WWW::Mechanize::Cached" => "0";
requires "WebService::Reddit" => "0";
requires "feature" => "0";
requires "perl" => "5.010";
requires "strict" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "perl" => "5.010";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "perl" => "5.010";
};

on 'develop' => sub {
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Test::CPAN::Changes" => "0.19";
  requires "Test::Code::TidyAll" => "0.50";
  requires "Test::More" => "0.88";
  requires "Test::Pod::Coverage" => "1.08";
  requires "Test::Spelling" => "0.12";
  requires "Test::Synopsis" => "0";
};
