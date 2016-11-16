# -*- mode:perl; -*-
use Rex -feature => [qw(no_path_cleanup)];
use Path::Tiny;
use Text::Xslate;

set 'theme' => 'cosmo';

my $bootstrap  = path('node_modules/bootstrap/dist');
my $bootswatch = path('node_modules/bootswatch/'.get 'theme');
my $jquery     = path('node_modules/jquery/dist');

desc "Generate CSS";
task "scss", sub {
    file "public/stylesheets", ensure => "directory";
    run "cat $bootswatch/bootstrap.min.css > public/stylesheets/app.min.css";
    run "cat src/stylesheets/main.scss | ./node_modules/.bin/node-sass --output-style compressed >> public/stylesheets/app.min.css";
};

desc "Generate javascript";
task "js", sub {
    file "public/javascripts", ensure => "directory";
    run "cat $jquery/jquery.min.js > public/javascripts/app.min.js";
    run "cat $bootstrap/js/bootstrap.min.js >> public/javascripts/app.min.js";
};

desc "Run local http server";
task "serve", sub {
    run_task "sysdeps";
    run_task "build";
    run "./node_modules/.bin/http-server public";
};

desc "builds site";
task "build", sub {
    run_task 'js';
    run_task 'scss';
    my $tx = Text::Xslate->new(path => ['src']);
    file "public/index.html", content => $tx->render('index.tx', {});
    file "public/setup.sh", source => 'src/setup.sh';
    cp "src/images", "public";
};

desc "install system deps";
task "sysdeps", sub {
    run "yarn";
    run "cpanm -n --installdeps .";
};
