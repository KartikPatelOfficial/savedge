# SavEdgeBackend API
**Version:** 1.0.0

## `/api/admin/claims/set-admin`
### POST
**Operation ID:** AdminClaims_SetAdminClaims
**Tags:** AdminClaims
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/SetAdminClaimsRequest`
**Responses:**
- **200**: 

## `/api/admin/claims/remove-admin`
### POST
**Operation ID:** AdminClaims_RemoveAdminClaims
**Tags:** AdminClaims
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/RemoveAdminClaimsRequest`
**Responses:**
- **200**: 

## `/api/admin/claims/get-claims/{firebaseUid}`
### GET
**Operation ID:** AdminClaims_GetUserClaims
**Tags:** AdminClaims
**Parameters:**
- `firebaseUid` (path): string
- `adminKey` (query): string
**Responses:**
- **200**: 

## `/api/admin/ledger/points`
### GET
**Operation ID:** AdminLedger_GetSystemPointsLedger
**Tags:** AdminLedger
**Responses:**
- **200**: 

## `/api/admin/ledger/coupons`
### GET
**Operation ID:** AdminLedger_GetCouponRedemptions
**Tags:** AdminLedger
**Responses:**
- **200**: 

## `/api/admin/subscriptions`
### GET
**Operation ID:** AdminSubscriptions_GetPlans
**Tags:** AdminSubscriptions
**Parameters:**
- `pageNumber` (query): integer
- `pageSize` (query): integer
- `isActive` (query): boolean
- `search` (query): string
**Responses:**
- **200**: 
### POST
**Operation ID:** AdminSubscriptions_CreatePlan
**Tags:** AdminSubscriptions
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/CreateSubscriptionPlanRequest`
**Responses:**
- **200**: 

## `/api/admin/subscriptions/{id}`
### GET
**Operation ID:** AdminSubscriptions_GetPlan
**Tags:** AdminSubscriptions
**Parameters:**
- `id` (path): integer
**Responses:**
- **200**: 
### PUT
**Operation ID:** AdminSubscriptions_UpdatePlan
**Tags:** AdminSubscriptions
**Parameters:**
- `id` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/UpdateSubscriptionPlanRequest`
**Responses:**
- **200**: 
### DELETE
**Operation ID:** AdminSubscriptions_DeletePlan
**Tags:** AdminSubscriptions
**Parameters:**
- `id` (path): integer
**Responses:**
- **200**: 

## `/api/admin/subscriptions/{id}/subscribers`
### GET
**Operation ID:** AdminSubscriptions_GetPlanSubscribers
**Tags:** AdminSubscriptions
**Parameters:**
- `id` (path): integer
- `pageNumber` (query): integer
- `pageSize` (query): integer
**Responses:**
- **200**: 

## `/api/Auth/validate-token`
### POST
**Operation ID:** Auth_ValidateToken
**Tags:** Auth
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/ValidateTokenRequest`
**Responses:**
- **200**: 

## `/api/Coupons`
### OPTIONS
**Operation ID:** Coupons_Options
**Tags:** Coupons
**Responses:**
- **200**: 
### GET
**Operation ID:** Coupons_GetCoupons
**Tags:** Coupons
**Parameters:**
- `pageNumber` (query): integer
- `pageSize` (query): integer
- `searchTerm` (query): string
- `vendorId` (query): integer
- `discountType` (query): 
- `status` (query): 
- `isActive` (query): boolean
- `isExpired` (query): boolean
**Responses:**
- **200**: 
### POST
**Operation ID:** Coupons_CreateCoupon
**Tags:** Coupons
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/CreateCouponRequest`
**Responses:**
- **200**: 

## `/api/Coupons/{id}`
### GET
**Operation ID:** Coupons_GetCoupon
**Tags:** Coupons
**Parameters:**
- `id` (path): integer
**Responses:**
- **200**: 
### PUT
**Operation ID:** Coupons_UpdateCoupon
**Tags:** Coupons
**Parameters:**
- `id` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/UpdateCouponRequest`
**Responses:**
- **200**: 
### DELETE
**Operation ID:** Coupons_DeleteCoupon
**Tags:** Coupons
**Parameters:**
- `id` (path): integer
**Responses:**
- **200**: 

## `/api/employees/check-by-phone`
### POST
**Operation ID:** Employees_CheckEmployeeByPhone
**Tags:** Employees
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/CheckEmployeeByPhoneRequest`
**Responses:**
- **200**: 

## `/api/employees/register-by-phone`
### POST
**Operation ID:** Employees_RegisterEmployeeByPhone
**Tags:** Employees
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/EmployeeRegistrationByPhoneRequest`
**Responses:**
- **200**: 

## `/api/admin/organizations/{organizationId}/employees`
### GET
**Operation ID:** Employees_GetEmployeesByOrganization
**Tags:** Employees
**Parameters:**
- `organizationId` (path): integer
**Responses:**
- **200**: 
### POST
**Operation ID:** Employees_AddEmployee
**Tags:** Employees
**Parameters:**
- `organizationId` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/AdminAddEmployeeRequest`
**Responses:**
- **200**: 

## `/api/admin/organizations/{organizationId}/employees/bulk`
### POST
**Operation ID:** Employees_BulkAddEmployees
**Tags:** Employees
**Parameters:**
- `organizationId` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/BulkAddEmployeesRequest`
**Responses:**
- **200**: 

## `/api/admin/employees/{employeeId}`
### DELETE
**Operation ID:** Employees_RemoveEmployee
**Tags:** Employees
**Parameters:**
- `employeeId` (path): integer
- `deactivateUserAccount` (query): boolean
- `reason` (query): string
**Responses:**
- **200**: 
### PUT
**Operation ID:** Employees_UpdateEmployee
**Tags:** Employees
**Parameters:**
- `employeeId` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/UpdateEmployeeRequest`
**Responses:**
- **200**: 
### GET
**Operation ID:** Employees_GetEmployee
**Tags:** Employees
**Parameters:**
- `employeeId` (path): integer
**Responses:**
- **200**: 

## `/api/ImageProxy/{fileName}`
### GET
**Operation ID:** ImageProxy_GetImage
**Tags:** ImageProxy
**Parameters:**
- `fileName` (path): string
**Responses:**
- **200**: 

## `/api/vendors/{vendorId}/Images`
### GET
**Operation ID:** Images_GetVendorImages
**Tags:** Images
**Parameters:**
- `vendorId` (path): integer
**Responses:**
- **200**: 
### POST
**Operation ID:** Images_AddVendorImage
**Tags:** Images
**Parameters:**
- `vendorId` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/AddVendorImageRequest`
**Responses:**
- **200**: 

## `/api/vendors/{vendorId}/Images/{imageId}`
### PUT
**Operation ID:** Images_UpdateVendorImage
**Tags:** Images
**Parameters:**
- `vendorId` (path): integer
- `imageId` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/UpdateVendorImageRequest`
**Responses:**
- **200**: 
### DELETE
**Operation ID:** Images_DeleteVendorImage
**Tags:** Images
**Parameters:**
- `vendorId` (path): integer
- `imageId` (path): integer
**Responses:**
- **200**: 

## `/api/admin/reports`
### GET
**Operation ID:** LedgerReports_GetReports
**Tags:** LedgerReports
**Responses:**
- **200**: 

## `/api/admin/offers`
### GET
**Operation ID:** Offers_GetOffers
**Tags:** Offers
**Parameters:**
- `status` (query): string
**Responses:**
- **200**: 
### POST
**Operation ID:** Offers_CreateAdminOffer
**Tags:** Offers
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/CreateAdminOfferRequest`
**Responses:**
- **200**: 

## `/api/admin/offers/{offerId}/status`
### PUT
**Operation ID:** Offers_UpdateOfferStatus
**Tags:** Offers
**Parameters:**
- `offerId` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/UpdateOfferStatusRequest`
**Responses:**
- **200**: 

## `/api/admin/organizations`
### GET
**Operation ID:** Organizations_GetOrganizations
**Tags:** Organizations
**Parameters:**
- `pageNumber` (query): integer
- `pageSize` (query): integer
- `searchTerm` (query): string
- `isActive` (query): boolean
**Responses:**
- **200**: 
### POST
**Operation ID:** Organizations_CreateOrganization
**Tags:** Organizations
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/CreateOrganizationRequest`
**Responses:**
- **200**: 

## `/api/admin/organizations/{id}`
### GET
**Operation ID:** Organizations_GetOrganization
**Tags:** Organizations
**Parameters:**
- `id` (path): integer
**Responses:**
- **200**: 

## `/api/subscriptions/create-payment-order`
### POST
**Operation ID:** RazorpaySubscriptions_CreatePaymentOrder
**Tags:** RazorpaySubscriptions
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/CreatePaymentOrderRequest`
**Responses:**
- **200**: 

## `/api/subscriptions/verify-payment`
### POST
**Operation ID:** RazorpaySubscriptions_VerifyPayment
**Tags:** RazorpaySubscriptions
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/VerifyPaymentRequest`
**Responses:**
- **200**: 

## `/api/subscriptions/payment-status/{transactionId}`
### GET
**Operation ID:** RazorpaySubscriptions_GetPaymentStatus
**Tags:** RazorpaySubscriptions
**Parameters:**
- `transactionId` (path): integer
**Responses:**
- **200**: 

## `/api/webhooks/razorpay`
### POST
**Operation ID:** RazorpayWebhook_HandleRazorpayWebhook
**Tags:** RazorpayWebhook
**Responses:**
- **200**: 

## `/api/vendors/{vendorId}/reviews`
### GET
**Operation ID:** Reviews_GetVendorReviews
**Tags:** Reviews
**Parameters:**
- `vendorId` (path): integer
**Responses:**
- **200**: 

## `/api/user/reviews`
### POST
**Operation ID:** Reviews_CreateReview
**Tags:** Reviews
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/CreateReviewRequest`
**Responses:**
- **200**: 

## `/api/user/reviews/{id}`
### DELETE
**Operation ID:** Reviews_DeleteOwnReview
**Tags:** Reviews
**Parameters:**
- `id` (path): integer
**Responses:**
- **200**: 

## `/api/admin/reviews/{id}`
### DELETE
**Operation ID:** Reviews_AdminDeleteReview
**Tags:** Reviews
**Parameters:**
- `id` (path): integer
**Responses:**
- **200**: 

## `/api/vendors/{vendorId}/SocialMedia`
### GET
**Operation ID:** SocialMedia_GetVendorSocialMedia
**Tags:** SocialMedia
**Parameters:**
- `vendorId` (path): integer
**Responses:**
- **200**: 
### POST
**Operation ID:** SocialMedia_AddVendorSocialMedia
**Tags:** SocialMedia
**Parameters:**
- `vendorId` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/AddVendorSocialMediaRequest`
**Responses:**
- **200**: 

## `/api/vendors/{vendorId}/SocialMedia/{socialMediaId}`
### PUT
**Operation ID:** SocialMedia_UpdateVendorSocialMedia
**Tags:** SocialMedia
**Parameters:**
- `vendorId` (path): integer
- `socialMediaId` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/UpdateVendorSocialMediaRequest`
**Responses:**
- **200**: 
### DELETE
**Operation ID:** SocialMedia_DeleteVendorSocialMedia
**Tags:** SocialMedia
**Parameters:**
- `vendorId` (path): integer
- `socialMediaId` (path): integer
**Responses:**
- **200**: 

## `/api/subscriptions`
### GET
**Operation ID:** Subscriptions_GetPlans
**Tags:** Subscriptions
**Responses:**
- **200**: 

## `/api/user/subscription`
### GET
**Operation ID:** Subscriptions_GetMySubscription
**Tags:** Subscriptions
**Responses:**
- **200**: 

## `/api/user/subscription/purchase`
### POST
**Operation ID:** Subscriptions_PurchaseSubscription
**Tags:** Subscriptions
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/PurchaseSubscriptionRequest`
**Responses:**
- **200**: 

## `/api/user/coupons`
### GET
**Operation ID:** UserCoupons_GetMyCoupons
**Tags:** UserCoupons
**Responses:**
- **200**: 

## `/api/user/coupons/claim`
### POST
**Operation ID:** UserCoupons_ClaimCoupon
**Tags:** UserCoupons
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/ClaimCouponRequest`
**Responses:**
- **200**: 

## `/api/user/coupons/purchase`
### POST
**Operation ID:** UserCoupons_PurchaseCoupon
**Tags:** UserCoupons
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/PurchaseCouponRequest`
**Responses:**
- **200**: 

## `/api/users/check-exists`
### POST
**Operation ID:** Users_CheckUserExists
**Tags:** Users
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/CheckUserExistsRequest`
**Responses:**
- **200**: 

## `/api/users/register`
### POST
**Operation ID:** Users_RegisterUser
**Tags:** Users
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/UserRegistrationRequest`
**Responses:**
- **200**: 

## `/api/users/profile`
### GET
**Operation ID:** Users_GetUserProfile
**Tags:** Users
**Responses:**
- **200**: 

## `/api/users/register-with-phone`
### POST
**Operation ID:** Users_RegisterUserWithPhone
**Tags:** Users
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/PhoneRegistrationRequest`
**Responses:**
- **200**: 

## `/api/user/points`
### GET
**Operation ID:** UserWallet_GetPoints
**Tags:** UserWallet
**Responses:**
- **200**: 

## `/api/user/ledger`
### GET
**Operation ID:** UserWallet_GetLedger
**Tags:** UserWallet
**Responses:**
- **200**: 

## `/api/vendor/profile`
### GET
**Operation ID:** VendorPortal_GetProfile
**Tags:** VendorPortal
**Responses:**
- **200**: 
### PUT
**Operation ID:** VendorPortal_UpdateProfile
**Tags:** VendorPortal
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/UpdateVendorProfileRequest`
**Responses:**
- **200**: 

## `/api/vendor/offers`
### GET
**Operation ID:** VendorPortal_GetMyOffers
**Tags:** VendorPortal
**Responses:**
- **200**: 

## `/api/vendor/redeem`
### POST
**Operation ID:** VendorPortal_RedeemCoupon
**Tags:** VendorPortal
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/RedeemCouponRequest`
**Responses:**
- **200**: 

## `/api/vendor/redemptions`
### GET
**Operation ID:** VendorPortal_GetRedemptions
**Tags:** VendorPortal
**Responses:**
- **200**: 

## `/api/Vendors`
### OPTIONS
**Operation ID:** Vendors_Options
**Tags:** Vendors
**Responses:**
- **200**: 
### GET
**Operation ID:** Vendors_GetVendors
**Tags:** Vendors
**Parameters:**
- `pageNumber` (query): integer
- `pageSize` (query): integer
- `searchTerm` (query): string
- `category` (query): string
- `businessType` (query): string
- `isApproved` (query): boolean
- `isActive` (query): boolean
**Responses:**
- **200**: 
### POST
**Operation ID:** Vendors_CreateVendor
**Tags:** Vendors
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/CreateVendorRequest`
**Responses:**
- **200**: 

## `/api/Vendors/register`
### OPTIONS
**Operation ID:** Vendors_RegisterOptions
**Tags:** Vendors
**Responses:**
- **200**: 
### POST
**Operation ID:** Vendors_RegisterVendor
**Tags:** Vendors
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/VendorRegistrationRequest`
**Responses:**
- **200**: 

## `/api/Vendors/with-images`
### POST
**Operation ID:** Vendors_CreateVendorWithImages
**Tags:** Vendors
**Request Body:**
- Content-Type: `multipart/form-data`
**Responses:**
- **200**: 

## `/api/Vendors/register/with-images`
### POST
**Operation ID:** Vendors_RegisterVendorWithImages
**Tags:** Vendors
**Request Body:**
- Content-Type: `multipart/form-data`
**Responses:**
- **200**: 

## `/api/Vendors/{id}`
### GET
**Operation ID:** Vendors_GetVendor
**Tags:** Vendors
**Parameters:**
- `id` (path): integer
**Responses:**
- **200**: 
### PUT
**Operation ID:** Vendors_UpdateVendor
**Tags:** Vendors
**Parameters:**
- `id` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/UpdateVendorRequest`
**Responses:**
- **200**: 
### DELETE
**Operation ID:** Vendors_DeleteVendor
**Tags:** Vendors
**Parameters:**
- `id` (path): integer
**Responses:**
- **200**: 

## `/api/Vendors/{id}/with-images`
### PUT
**Operation ID:** Vendors_UpdateVendorWithImages
**Tags:** Vendors
**Parameters:**
- `id` (path): integer
**Request Body:**
- Content-Type: `multipart/form-data`
**Responses:**
- **200**: 

## `/api/Vendors/{id}/approve`
### PUT
**Operation ID:** Vendors_ApproveVendor
**Tags:** Vendors
**Parameters:**
- `id` (path): integer
**Responses:**
- **200**: 

## `/api/Vendors/{id}/reject`
### PUT
**Operation ID:** Vendors_RejectVendor
**Tags:** Vendors
**Parameters:**
- `id` (path): integer
**Request Body:**
- Content-Type: `application/json`
  - Schema: `#/components/schemas/RejectVendorRequest`
**Responses:**
- **200**: 
