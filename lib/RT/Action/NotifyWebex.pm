package RT::Action::NotifyWebex;
use base 'RT::Action';
use constant API_URL => 'https://webexapis.com/v1/messages';

use strict;
use warnings;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use JSON;

sub Describe  {
  my $self = shift;
  return (ref $self . "Send template payload to WebEX API.");
}

sub Prepare  {
    return 1;
}

sub Commit {
    my $self = shift;

    my $token = RT->Config->Get( 'WebexToken' ) || return RT::Logger->error( 'WebexToken not configured' );

    my $room_ids = RT->Config->Get( 'WebexRooms' ) || {};
    my $room = $self->Argument;

    my $room_id = undef;
    for my $key ( keys %{ $room_ids } ) {
        if ( $key eq $room ) {
            $room_id = $room_ids->{ $key };
        }
    }
    return RT::Logger->error( 'Webex Room:' . $room .  ' not found. Check %WebexRooms config values.' ) unless $room_id;

    # Need to create our MIMEObj
    $self->TemplateObj->Parse(
        TicketObj      => $self->TicketObj,
        TransactionObj => $self->TransactionObj,
        Argument       => $self->Argument,
        ConditionArgs  => $self->ScripObj->{values}->{ConditionArgs},
	Room_ID	       => $room_id,
    );

    return unless $self->TemplateObj && $self->TemplateObj->MIMEObj;
    my $json = $self->TemplateObj->MIMEObj->as_string;

    my $ua = LWP::UserAgent->new;
    $ua->timeout(3);


    my $req = POST(API_URL, Content => $json);
    $req->header(authorization => "Bearer $token");
    $req->header('Content-Type' => 'application/json');
    my $resp = $ua->request($req);

    RT::Logger->error( "Failed post to webex, status is:" . $resp->status_line . $resp->decoded_content() ) unless $resp->is_success;

    return 1;
}

1;
