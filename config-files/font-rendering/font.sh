#!/bin/bash

cp 10-antialias.conf /etc/fonts/conf.d;
cp 10-antialias.conf /usr/share/fontconfig/conf.avail;
cp 64-language-selector-prefer.conf /etc/fonts/conf.d;
cp 64-language-selector-prefer.conf /usr/share/fontconfig/conf.avail;
cp 69-language* /usr/share/fontconfig/conf.avail;
ln -s /usr/share/fontconfig/conf.avail/10-antialias.conf /usr/share/fontconfig/conf.default/10-antialias.conf;
ln -s /usr/share/fontconfig/conf.avail/64-language-selector-prefer.conf /usr/share/fontconfig/conf.default/64-language-selector-prefer.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-ja.conf /usr/share/fontconfig/conf.default/69-language-selector-ja.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-zh-cn.conf /usr/share/fontconfig/conf.default/69-language-selector-zh-cn.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-zh-hk.conf /usr/share/fontconfig/conf.default/69-language-selector-zh-hk.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-zh-mo.conf /usr/share/fontconfig/conf.default/69-language-selector-zh-mo.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-zh-sg.conf /usr/share/fontconfig/conf.default/69-language-selector-zh-sg.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-zh-tw.conf /usr/share/fontconfig/conf.default/69-language-selector-zh-tw.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-ja.conf /etc/fonts/conf.d/69-language-selector-ja.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-zh-cn.conf /etc/fonts/conf.d/69-language-selector-zh-cn.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-zh-hk.conf /etc/fonts/conf.d/69-language-selector-zh-hk.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-zh-mo.conf /etc/fonts/conf.d/69-language-selector-zh-mo.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-zh-sg.conf /etc/fonts/conf.d/69-language-selector-zh-sg.conf;
ln -s /usr/share/fontconfig/conf.avail/69-language-selector-zh-tw.conf /etc/fonts/conf.d/69-language-selector-zh-tw.conf;
ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/70-no-bitmaps.conf;
fc-cache -rv

exit 0
