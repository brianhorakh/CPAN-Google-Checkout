package Google::Checkout::General::FlatRateShipping;

=head1 NAME

Google::Checkout::General::FlatRateShipping

=head1 SYNOPSIS

  use Google::Checkout::General::GCO;
  use Google::Checkout::General::MerchantCheckoutFlow;
  use Google::Checkout::General::FlatRateShipping;
  use Google::Checkout::General::ShoppingCart;
  use Google::Checkout::General::Util qw/is_gco_error/;

  my $gco = Google::Checkout::General::GCO->new;

  my $flat_rate_shipping = Google::Checkout::General::FlatRateShipping->new(
                           shipping_name => "Flat rate",
                           price         => 9.99);

  my $checkout_flow = Google::Checkout::General::MerchantCheckoutFlow->new(
                      shipping_method       => [$flat_rate_shipping],
                      edit_cart_url         => "http://...",
                      continue_shopping_url => "http://...",
                      buyer_phone           => "1-111-111-1111",
                      tax_table             => [$table1, $table2],
                      merchant_calculation  => $merchant_calculation);

  my $cart = Google::Checkout::General::ShoppingCart->new(
             expiration    => "+1 month",
             private       => "Private data",
             checkout_flow => $checkout_flow);

  $cart->add_item($item1);
  $cart->add_item($item2);

  my $response = $gco->checkout($cart);

  die $response if is_gco_error($response);

  #--
  #-- redirect URL
  #--
  print $response,"\n";

=head1 DESCRIPTION

Sub-class of C<Google::Checkout::General::Shipping>. 
Create flat rate shipping method which can be used to 
add to merchant checkout flow.

=over 4

=item new SHIPPING_NAME => ..., PRICE => ...

Constructor. Takes a shipping name and a price.

=back

=cut

=head1 COPYRIGHT

Copyright 2006 Google. All rights reserved.

=head1 SEE ALSO

Google::Checkout::General::Shipping

=cut

#--
#--   <flat-rate-shipping></flat-rate-shipping> 
#--

use strict;
use warnings;

use Google::Checkout::XML::Constants;

use Google::Checkout::General::Shipping;
our @ISA = qw/Google::Checkout::General::Shipping/;

sub new 
{
  my ($class, %args) = @_;

  my $self = $class->SUPER::new(
               %args, 
               name  => Google::Checkout::XML::Constants::FLAT_RATE_SHIPPING);

  return bless $self => $class;
}

1;
