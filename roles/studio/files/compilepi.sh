#!/bin/sh

#cd /home/b08x/studio/sonic-pi

../../server/ruby/bin/compile-extensions.rb && \
../../server/ruby/bin/i18n-tool.rb -t && \
cp -f ruby_help.tmpl ruby_help.h && \
../../server/ruby/bin/qt-doc.rb -o ruby_help.h && \
lrelease-qt5 SonicPi.pro && \
qmake-qt5 SonicPi.pro && \
make && \
./create-pdf
