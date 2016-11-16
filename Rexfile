# -*- mode:perl; -*-
use Rex -feature => [qw(no_path_cleanup)];
use Path::Tiny;
use Text::Xslate;

set 'theme' => 'cosmo';

desc "Generate CSS";
task "scss", sub {
    run "cat src/stylesheets/main.scss | ./node_modules/.bin/node-sass --output-style compressed >> public/stylesheets/app.min.css";
};

desc "Run local http server";
task "serve", sub {
    run_task "sysdeps";
    run_task "build";
    run "./node_modules/.bin/http-server public";
};

desc "builds site";
task "build", sub {
    my $jquery     = path('node_modules/jquery/dist');
    my $bootstrap  = path('node_modules/bootstrap/dist');
    my $bootswatch = path('node_modules/bootswatch/'.get 'theme');

    file "public/javascripts", ensure => "directory";
    file "public/stylesheets", ensure => "directory";

    run "cat $jquery/jquery.min.js $bootstrap/js/bootstrap.min.js > public/javascripts/app.min.js";
    run "cat $bootswatch/bootstrap.min.css > public/stylesheets/app.min.css";
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
