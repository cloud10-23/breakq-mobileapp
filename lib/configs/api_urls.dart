import 'package:breakq/configs/constants.dart';

/// ALL THE API ENDPOINT URLs for BreakQ Application
/// For more information visit: `http://breakq.api.magratechs.com/swagger/index.html`
/// Firebase UID: `hgv7ElNZQwfxYK8ZL4GcrlXwEJw1`

/// BASE URL
const String apiBase = 'breakq.api.magratechs.com';
const String apiBaseFull = 'http://breakq.api.magratechs.com';

/// User URLs
const String apiUserRegister = '/api/User/RegisterUser';
const String apiUserLogin = '/api/User/Login';

/// Main URLs
const String apiHome = '/api/HomePageData/GetHomePageDataforMenus';
const String apiOfferProducts =
    '/api/HomePageData/GetProductsForDealsAndOffers';
const String apiCategory = '/api/Category';
const String apiBrand = '/api/Brand';
const String apiProducts = '/api/Products';
const String apiExclusiveProducts = '/api/Products/ExclusiveProducts';

/// Cart APIs
const String apiCartAddOrUpdate = '/api/Cart/AddOrUpdateCart';
const String apiCartDelete = '/api/Cart/DeleteCart';
const String apiCartGet = '/api/Cart/GetCart';

/// Checkout
const String apiCheckoutWalkin = '/api/Checkout/CheckoutWalkin';
const String apiCheckoutWithTime = '/api/Checkout/CheckoutWithTime';
const String apiCheckoutGetSlots = '/api/Checkout/GetCheckoutSlots';

/// My Orders
const String apiMyOrders = '/api/Order/Order';

/// Address APIs
const String apiPostAddress = '/api/Address/AddOrUpdateAddress';
const String apiGetAddress = '/api/Address/GetAddress';

/// Query Parameters
const String apiCategoryQuery = 'categoryCode';
const String apiProductQuery = 'productName';
const String apiBrandCode = 'brandCode';
const String apiSortBy = 'sortBy';
const String apiFilterBy = 'filterBy';
const String apiFilterByValue = 'filterByValue';
const String apiPageNumber = 'pageNumber';

/// Home product values
/// http://breakq.api.magratechs.com/api/HomePageData/GetProductsForDealsAndOffers?StoreId=1&Name=TopDeals&value=50%25&description=FLAT&pageNumber=1
const String apiStoreId = 'StoreId';
const String apiName = 'Name';
const String apiValue = 'value';
const String apiDescription = 'description';

/// Cart Parameters
const String apistoreId = 'storeId';
const String apiFirebaseId = 'fireBaseID';

/// Cart Parameters
const String apiDeliveryDate = 'deliveryDate';
const String apiStartTime = 'startTime';
const String apiEndTime = 'endTime';
const String apiCheckoutType = 'checkoutType';

/// Filter Values
/// <param name="categoryCode"></param>
/// <param name="productName"></param>
/// <param name="brandCode"></param>
/// <param name="sortBy"> Possible values lowtohigh and hightolow</param>
/// <param name="filterBy">Possible values greaterthan,  lessthan ,minmax</param>
/// <param name="filterByValue"> For greaterthan and lessthan single number, for minmax two numbers separated by comma</param>
/// <param name="pageNumber">  1</param>

const String apiSortHTL = 'hightolow';
const String apiSortLTH = 'lowtohigh';
const String apiFilterByGT = 'greaterthan';
const String apiFilterByLT = 'lessthan';
const String apiFilterByMM = 'minmax';

const Map<CheckoutType, String> apiCheckoutTypes = {
  CheckoutType.pickUp: 'SP',
  CheckoutType.delivery: 'DTH'
};
// const String apiCheckoutTypeSelfPickup = 'SP';
// const String apiCheckoutTypeDelivery = 'DTH';