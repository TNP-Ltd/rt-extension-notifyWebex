use strict;
use warnings;
package RT::Extension::NotifyWebex;

our $VERSION = '0.01';

=head1 NAME

RT-Extension-NotifyWebex - RT ScripAction Webex Teams integration

=head1 DESCRIPTION

Allow for Webex notifications to be sent out via RT, heaving inspired by RT-Extension-NotifySlack.

=head1 RT VERSION

Works with RT 5.0.3.

=head1 INSTALLATION

=over

=item C<perl Makefile.PL>

=item C<make>

=item C<make install>

May need root permissions

=item C<make initdb>
See the CONFIGURATION section below before running this command.
Only run this the first time you install this module.
If you run this twice, you may end up with duplicate data
in your database.

=item Edit your F</opt/rt5/etc/RT_SiteConfig.pm>

Add this line:

    Plugin('RT::Extension::NotifyWebex');

=item Clear your mason cache

    rm -rf /opt/rt5/var/mason_data/obj

=item Restart your webserver

=back

=head1 CONFIGURATION

You must configure a $WebexToken to authenticate against the Webex APIs using a 
webex Bot. https://developer.webex.com/docs/bots#creating-a-webex-bot

You must also add the rooms which the integration posts to by id in %WebexRooms

Example configuration:

    Set($WebexToken, '<mywebextoken>');
    Set(%WebexRooms,
        'test'  => '<room1 id>',
        'room2' => '<room2 id>',
    );

The 'Notify Webex' ScripAction posts to one webex room. The default
room is currently set to 'test'. You can update this in
the initialdata file by changing the 'Notify Webex' ScripAction
Argument to the desired webex room 
To post to additional webex rooms, copy the ScripAction giving it
a new Name and Argument, something like "Webex Updates To Support".

=head1 AUTHOR

Dan Poltawski E<lt>dan.poltawski@tnp.net.ukE<gt>


=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2022 by The Networking People (TNP) Ltd

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

1;
