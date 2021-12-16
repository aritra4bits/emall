

class UrlController {
  String kBaseURL = "https://mage2.fireworksmedia.com";
  ///////////////////////////////////  API End Points //////////////////////////////////////////

  String registerUrlEndpoint = "/rest/default/V1/customers";
  String loginUrlEndpoint = "/rest/default/V1/integration/customer/token";
  String userDetailsUrlEndpoint = "/rest/default/V1/customers/me";
  String searchUrlEndpoint = "/rest/default/V1/search";
  String productUrlEndpoint = "/rest/default/V1/products";
  String categoryListUrlEndpoint = "/rest/default/V1/categories";
  String categoryDetailsUrlEndpoint = "/rest/default/V1/categories/";
  String createCartIdUrlEndpoint = "/rest/default/V1/carts/mine";
  String getGuestCartItemsUrlEndpoint = "/rest/default/V1/carts/";

  registerUserUrl() {
    return kBaseURL + registerUrlEndpoint;
  }

  loginUserUrl() {
    return kBaseURL + loginUrlEndpoint;
  }

  userDetailsUrl() {
    return kBaseURL + userDetailsUrlEndpoint;
  }

  searchUrl(String searchTerm) {
    return kBaseURL + searchUrlEndpoint + "?searchCriteria[requestName]=quick_search_container&searchCriteria[filterGroups][0][filters][0][field]=search_term&searchCriteria[filterGroups][0][filters][0][value]=$searchTerm&searchCriteria[sortOrders][0][field]=created_at&searchCriteria[sortOrders][0][direction]=DESC";
  }

  productUrl(String productId) {
    return kBaseURL + productUrlEndpoint + "?searchCriteria[filterGroups][0][filters][0][field]=entity_id&searchCriteria[filterGroups][0][filters][0][condition_type]=in&searchCriteria[filterGroups][0][filters][0][value]=$productId";
  }

  onSaleUrl() {
    return kBaseURL + productUrlEndpoint + "?searchCriteria[filterGroups][0][filters][0][field]=special_price&searchCriteria[filterGroups][0][filters][0][condition_type]=notnull";
  }

  categoryListUrl() {
    return kBaseURL + categoryListUrlEndpoint;
  }

  categoryDetailsUrl(String categoryId) {
    return kBaseURL + categoryDetailsUrlEndpoint + categoryId;
  }

  createQuoteIdUrl() {
    return kBaseURL + createCartIdUrlEndpoint;
  }

  getCartItemsUrl(String cartId) {
    return kBaseURL + getGuestCartItemsUrlEndpoint + cartId;
  }

  addToCartUrl(String cartId) {
    return kBaseURL + getGuestCartItemsUrlEndpoint + cartId + "/items";
  }

  getCartTotalUrl(String cartId) {
    return kBaseURL + getGuestCartItemsUrlEndpoint + cartId + "/payment-information";
  }

  updateCartItemUrl(String cartId, int? itemId) {
    return kBaseURL + getGuestCartItemsUrlEndpoint + cartId + "/items/$itemId";
  }

  addCouponUrl(String cartId, String coupon) {
    return kBaseURL + getGuestCartItemsUrlEndpoint + cartId + "/coupons/$coupon";
  }
}
