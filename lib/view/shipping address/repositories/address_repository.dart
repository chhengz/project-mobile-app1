import 'package:shoes_app/view/shipping%20address/models/address.dart';

class AddressRepository {
  List<Address> getAddresses(){
    return const[
      Address(
        id: '1', 
        label: 'Home', 
        fullAddress: '627', 
        city: 'PP',  
        zipCode: '12000',
        isDefault: true,
        type: AddressType.home,
      ),
      Address(
        id: '2', 
        label: 'Office', 
        fullAddress: 'AAAA', 
        city: 'PP',  
        zipCode: '12000',
        isDefault: true,
        type: AddressType.office,
      ),
    ];
  }
  Address? getDefaultAddress(){
    return getAddresses().firstWhere(
      (address)=> address.isDefault,
      orElse: ()=> getAddresses().first,
    );
  }
}