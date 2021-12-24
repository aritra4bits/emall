import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:emall/constants/colors.dart';
import 'package:emall/managers/auth_manager/auth_manager.dart';
import 'package:emall/managers/cart_manager/address_manager.dart';
import 'package:emall/managers/cart_manager/cart_manager.dart';
import 'package:emall/managers/ui_manager/cart_page_manager.dart';
import 'package:emall/models/cart/country_code_model.dart';
import 'package:emall/models/cart/region_code_model.dart';
import 'package:emall/models/cart/shipping_estimate_model.dart';
import 'package:emall/models/cart/shipping_information_model.dart';
import 'package:emall/models/user_model/user_model.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:emall/widgets/dropdown_select_button.dart';
import 'package:emall/widgets/grey_button.dart';
import 'package:emall/widgets/keyboard_dismiss_wrapper.dart';
import 'package:emall/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddNewAddressView extends StatefulWidget {
  final bool isNewWindow;
  const AddNewAddressView({Key? key, this.isNewWindow = false}) : super(key: key);

  @override
  State<AddNewAddressView> createState() => _AddNewAddressViewState();
}

class _AddNewAddressViewState extends State<AddNewAddressView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  // TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  // TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode focusNode = FocusNode();

  String? selectedCountry;
  String? countryId;
  Region? selectedRegion;
  String? regionId;
  bool isLoading = false;
  bool isEdit = false;
  Address? address;

  @override
  void initState() {
    super.initState();
    setAddress();
  }

  setAddress() async {
    address = addressManager.getEditAddress();
    if (address != null) {
      isEdit = true;
      firstNameController.text = address!.firstname!;
      lastNameController.text = address!.lastname!;
      streetAddressController.text = address!.street!.first;
      cityController.text = address!.city!;
      zipCodeController.text = address!.postcode!;
      phoneController.text = address!.telephone!;
      countryId = address!.countryId;
      selectedCountry = cartManager
          .getCountryList()
          .firstWhere((element) => element.id == address!.countryId)
          .fullNameLocale;
      await cartManager.getRegionCodes(countryId: countryId!);
      selectedRegion = address!.region!;
      regionId = address!.region!.regionId.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: Container(
        color: AppColors.purplePrimary.withOpacity(0.3),
        alignment: Alignment.center,
        child: const LoadingIndicator(
          indicatorType: Indicator.ballScale,
          colors: [AppColors.purplePrimary],
        ),
      ),
      child: KeyboardDismissWrapper(
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.all(8.sp),
              child: GreyRoundButton(
                onPressed: () {
                  if(widget.isNewWindow){
                    Navigator.pop(context);
                  } else {
                    cartPageManager.updatePageIndex(1);
                  }
                },
                icon: Icons.arrow_back_ios_rounded,
              ),
            ),
            iconTheme: const IconThemeData(color: AppColors.textLightBlack),
            titleSpacing: 0,
            title: AutoSizeText(
              isEdit ? 'EDIT ADDRESS' : 'SHIPPING ADDRESS',
              style: TextStyle(
                  color: AppColors.textLightBlack.withOpacity(0.7),
                  fontWeight: FontWeight.w600),
            ),
          ),
          body: Stack(
            children: [
              SizedBox.expand(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      // textFieldWithTitle(title: 'Email', textCapitalization: TextCapitalization.none, textInputType: TextInputType.emailAddress, textInputAction: TextInputAction.next),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                      //   child: Text('You can create an account after checkout.', style: TextStyle(color: AppColors.textBlack, fontWeight: FontWeight.w300, fontSize: 14.sp),),
                      // ),
                      // Divider(color: AppColors.textBlack, height: 70.h, thickness: 1.sp, indent: 20.w, endIndent: 20.w,),
                      textFieldWithTitle(
                          title: 'First Name',
                          controller: firstNameController,
                          textCapitalization: TextCapitalization.words,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.next),
                      textFieldWithTitle(
                          title: 'Last Name',
                          controller: lastNameController,
                          textCapitalization: TextCapitalization.words,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.next),
                      textFieldWithTitle(
                          title: 'Street Address',
                          controller: streetAddressController,
                          textCapitalization: TextCapitalization.words,
                          textInputType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.next),
                      textFieldWithTitle(
                          title: 'City',
                          controller: cityController,
                          textCapitalization: TextCapitalization.words,
                          textInputType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.next),
                      // textFieldWithTitle(title: 'State', textCapitalization: TextCapitalization.words, textInputType: TextInputType.streetAddress, textInputAction: TextInputAction.next),
                      textFieldWithTitle(
                          title: 'Zip/Postal Code',
                          controller: zipCodeController,
                          textCapitalization: TextCapitalization.none,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next),
                      // textFieldWithTitle(title: 'Country', textCapitalization: TextCapitalization.words, textInputType: TextInputType.name, textInputAction: TextInputAction.next),
                      StreamBuilder<ApiResponse<List<CountryCodeModel>>?>(
                          stream: cartManager.countryData,
                          builder: (BuildContext context,
                              AsyncSnapshot<ApiResponse<List<CountryCodeModel>>?>
                                  snapshot) {
                            if (snapshot.hasData) {
                              switch (snapshot.data!.status) {
                                case Status.LOADING:
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        AppColors.purplePrimary),
                                  ));
                                case Status.COMPLETED:
                                  return countrySelector(
                                      title: 'Country',
                                      countries: snapshot.data?.data != null
                                          ? snapshot.data?.data!
                                              .where((element) =>
                                                  element.availableRegions != null)
                                              .toList()
                                          : []);
                                case Status.NODATAFOUND:
                                  return SizedBox();
                                case Status.ERROR:
                                  return SizedBox();
                              }
                            }
                            return Container();
                          }),
                      StreamBuilder<ApiResponse<RegionCodeModel>?>(
                          stream: cartManager.regionData,
                          builder: (BuildContext context,
                              AsyncSnapshot<ApiResponse<RegionCodeModel>?> snapshot) {
                            if (snapshot.hasData) {
                              switch (snapshot.data!.status) {
                                case Status.LOADING:
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        AppColors.purplePrimary),
                                  ));
                                case Status.COMPLETED:
                                  return stateSelector(
                                      title: 'State',
                                      regionCodes: snapshot.data?.data);
                                case Status.NODATAFOUND:
                                  return SizedBox();
                                case Status.ERROR:
                                  return SizedBox();
                              }
                            }
                            return stateSelector(
                                title: 'State',
                                regionCodes: RegionCodeModel(availableRegions: []));
                          }),
                      textFieldWithTitle(
                          title: 'Phone Number',
                          controller: phoneController,
                          textCapitalization: TextCapitalization.none,
                          textInputType: TextInputType.phone,
                          textInputAction: TextInputAction.done),
                      SizedBox(height: 54.h,),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: nextButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldWithTitle(
      {required String title,
      TextEditingController? controller,
      FocusNode? focusNode,
      TextCapitalization? textCapitalization,
      TextInputAction? textInputAction,
      TextInputType? textInputType}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: 'DinBold',
                fontSize: 14.sp),
          ),
          TextFieldWidget(
            controller: controller,
            focusNode: focusNode,
            hintText: title,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            textInputAction: textInputAction,
            textInputType: textInputType,
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }

  Widget countrySelector(
      {required String title, required List<CountryCodeModel>? countries}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: 'DinBold',
                fontSize: 14.sp),
          ),
          DropdownSelectButton(
            hintText: title,
            items: countries != null
                ? countries.map((e) => e.fullNameLocale ?? "").toList()
                : [],
            value: selectedCountry,
            onChanged: (country) {
              setState(() {
                selectedCountry = country;
                countryId = countries!
                    .firstWhere(
                        (element) => element.fullNameLocale == selectedCountry)
                    .id;
                selectedRegion = null;
                regionId = null;
                cartManager.getRegionCodes(countryId: countryId!);
              });
            },
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }

  Widget stateSelector(
      {required String title, required RegionCodeModel? regionCodes}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: 'DinBold',
                fontSize: 14.sp),
          ),
          DropdownSelectButton(
            hintText: title,
            items: regionCodes != null
                ? regionCodes.availableRegions!
                    .map((e) => e.name ?? "")
                    .toList()
                : [],
            value: selectedRegion?.region,
            onChanged: (region) {
              setState(() {
                RegionInfo regionInfo = regionCodes!.availableRegions!
                    .firstWhere((element) => element.name == region);
                selectedRegion = Region(
                    regionId: int.parse(regionInfo.id!),
                    region: regionInfo.name,
                    regionCode: regionInfo.code);
                regionId = regionCodes.availableRegions!
                    .firstWhere(
                        (element) => element.name == selectedRegion?.region)
                    .id;
              });
            },
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }

  Widget nextButton() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54.h,
            child: TextButton(
              child: Text(
                'Next',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontFamily: 'DinRegular'),
              ),
              onPressed: () async {
                // if(emailController.text.isEmpty){
                //   AppUtils.showToast("Please enter a valid email");
                // } else
                if (firstNameController.text.isEmpty) {
                  AppUtils.showToast("Please enter your first name");
                } else if (lastNameController.text.isEmpty) {
                  AppUtils.showToast("Please enter your last name");
                } else if (streetAddressController.text.isEmpty) {
                  AppUtils.showToast("Please enter your street address");
                } else if (cityController.text.isEmpty) {
                  AppUtils.showToast("Please enter your city name");
                } else if (zipCodeController.text.isEmpty) {
                  AppUtils.showToast("Please enter your zip code");
                } else if (selectedCountry == null) {
                  AppUtils.showToast("Please select your country");
                } else if (selectedRegion == null) {
                  AppUtils.showToast("Please select your state");
                } else if (phoneController.text.isEmpty) {
                  AppUtils.showToast("Please enter your phone number");
                } else {
                  if(isEdit){
                    Customer? userDetails = authManager.getUserDetails();
                    if(userDetails != null){
                      List<Address> addresses = userDetails.addresses!.map((e) {
                        if(e.id == address!.id){
                          return Address(
                              id: e.id,
                              region: selectedRegion,
                              customerId: e.customerId,
                              regionId: selectedRegion?.regionId,
                              countryId: countryId,
                              street: [streetAddressController.text],
                              telephone: phoneController.text,
                              postcode: zipCodeController.text,
                              city: cityController.text,
                              firstname: firstNameController.text,
                              lastname: lastNameController.text,
                              defaultBilling: e.defaultBilling,
                              defaultShipping: e.defaultShipping
                          );
                        } else {
                          return Address(
                              id: e.id,
                              region: e.region,
                              customerId: e.customerId,
                              regionId: e.regionId,
                              countryId: e.countryId,
                              street: e.street,
                              telephone: e.telephone,
                              postcode: e.postcode,
                              city: e.city,
                              firstname: e.firstname,
                              lastname: e.lastname,
                              defaultBilling: e.defaultBilling,
                              defaultShipping: e.defaultShipping
                          );
                        }
                      }).toList();
                      Map params = {
                        "customer": {
                          "email": userDetails.email,
                          "firstname": userDetails.firstname,
                          "lastname": userDetails.lastname,
                          "addresses": List<dynamic>.from(addresses.map((x) => x.toJson()))
                        }
                      };
                      setState(() {
                        isLoading = true;
                      });
                      await authManager.updateUser(params: params, withLoading: false);
                      setState(() {
                        isLoading = false;
                      });
                      if(widget.isNewWindow){
                        Navigator.pop(context);
                      } else {
                        cartPageManager.updatePageIndex(1);
                      }
                    }
                  } else {
                    Customer? userDetails = authManager.getUserDetails();
                    if (userDetails != null) {
                      userDetails.addresses!.add(Address(
                          regionId: int.tryParse(regionId ?? "0") != null
                              ? int.parse(regionId ?? "0")
                              : 0,
                          countryId: countryId,
                          street: streetAddressController.text.split(","),
                          telephone: phoneController.text,
                          postcode: zipCodeController.text,
                          city: cityController.text,
                          firstname: firstNameController.text,
                          lastname: lastNameController.text,
                          defaultShipping: true,
                          defaultBilling: true));
                      Map params = {
                        "customer": {
                          "email": userDetails.email,
                          "firstname": userDetails.firstname,
                          "lastname": userDetails.lastname,
                          "addresses": List<dynamic>.from(
                              userDetails.addresses!.map((x) => x.toJson()))
                        }
                      };
                      setState(() {
                        isLoading = true;
                      });
                      Customer? customerDetails =
                      await authManager.updateUser(params: params);

                      if (customerDetails?.id != null) {
                        if (customerDetails?.addresses != null) {
                          Address? address = customerDetails!.addresses!
                              .lastWhere(
                                  (element) => element.defaultShipping == true);
                          Map estimateParams = {
                            "address": {
                              "region": address.region?.region,
                              "region_id": address.region?.regionId,
                              "region_code": address.region?.regionCode,
                              "country_id": address.countryId,
                              "street": address.street,
                              "postcode": address.postcode,
                              "city": address.city,
                              "firstname": address.firstname,
                              "lastname": address.lastname,
                              "customer_id": customerDetails.id,
                              "email": customerDetails.email,
                              "telephone": address.telephone,
                              "same_as_billing": 1
                            },
                          };
                          List<ShippingEstimateModel>? shippingEstimate =
                          await cartManager.getShippingEstimate(
                              params: estimateParams);
                          if (shippingEstimate?.first.amount != null) {
                            Map shippingParams = {
                              "addressInformation": {
                                "shipping_address": {
                                  "region": address.region?.region,
                                  "region_id": address.region?.regionId,
                                  "region_code": address.region?.regionCode,
                                  "country_id": address.countryId,
                                  "street": address.street,
                                  "postcode": address.postcode,
                                  "city": address.city,
                                  "firstname": address.firstname,
                                  "lastname": address.lastname,
                                  "email": customerDetails.email,
                                  "telephone": address.telephone,
                                },
                                "billing_address": {
                                  "region": address.region?.region,
                                  "region_id": address.region?.regionId,
                                  "region_code": address.region?.regionCode,
                                  "country_id": address.countryId,
                                  "street": address.street,
                                  "postcode": address.postcode,
                                  "city": address.city,
                                  "firstname": address.firstname,
                                  "lastname": address.lastname,
                                  "email": customerDetails.email,
                                  "telephone": address.telephone,
                                },
                                "shipping_carrier_code":
                                shippingEstimate?.first.carrierCode ?? "",
                                "shipping_method_code":
                                shippingEstimate?.first.methodCode
                              }
                            };
                            ShippingCartInformationModel? shippingInfo =
                            await cartManager.setShippingInformation(
                                params: shippingParams);
                            if (shippingInfo?.totals?.shippingAmount != null) {
                              AppUtils.showToast(
                                  "Address set as default shipping and billing address");
                            }
                            await authManager.getUser();
                          }
                        }
                        cartPageManager.updatePageIndex(1);
                      } else {
                        AppUtils.showToast(
                            "Failed to add new address. Try again.");
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.purpleSecondary),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
