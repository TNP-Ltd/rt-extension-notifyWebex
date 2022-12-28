use lib '.';
use inc::Module::Install;

RTx     'RT-Extension-NotifyWebex';
license 'gpl_2';
repository 'https://github.com/TNP-Ltd/rt-extension-notifywebex';

requires_rt '5.0.2';
rt_too_new '5.2.0';

sign;
WriteAll;
