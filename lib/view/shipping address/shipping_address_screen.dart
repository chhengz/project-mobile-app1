import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shoes_app/utils/app_textstyles.dart';
import 'package:shoes_app/view/shipping%20address/models/address.dart';
import 'package:shoes_app/view/shipping%20address/repositories/address_repository.dart';
import 'package:shoes_app/view/shipping%20address/widgets/address_card.dart';

class ShippingAddressScreen extends StatelessWidget {
  final AddressRepository _repository = AddressRepository();
  ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=> Get.back(), 
        icon: Icon(
          Icons.arrow_back_ios,
          color: isDark? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Shipping Address',
          style: AppTextstyles.withColor(
            AppTextstyles.h3,
            isDark? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: ()=> _showAddAddressBottomSheet(context), 
            icon: Icon(
              Icons.add_circle_outline,
              color: isDark? Colors.white : Colors.black,
            ),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _repository.getAddresses().length,
        itemBuilder: (context,index)=> _buildAddressCard(context,index),
      ),
    );
  }
  Widget _buildAddressCard(BuildContext context,int index){
    final address =_repository.getAddresses()[index];

    return AddressCard(
      address: address,
      onEdit: ()=> _showEditAddressBottomSheet(context,address),
      onDelete: ()=> _showDeleteConfirmation(context),
    );
  }

  void _showEditAddressBottomSheet(BuildContext context,Address address){
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
               'Edit Address',
                 style: AppTextstyles.withColor(
                AppTextstyles.h3, 
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
            IconButton(
              onPressed: ()=> Get.back(), 
              icon: Icon(
                Icons.close,
                color: isDark? Colors.white : Colors.black,
              ),
            ),
             ],
             ),
             const SizedBox(height: 24),
             _buildTextField(
              context,
              'Label (e.g. Home,Office)',
              Icons.label_outline,
              initiaValue: address.label,
             ),
             const SizedBox(height: 16),
             _buildTextField(
              context,
              'Full Address',
              Icons.location_on_outlined,
              initiaValue: address.fullAddress,
             ),
             const SizedBox(height: 16),
             _buildTextField(
              context,
              'City',
              Icons.location_city_outlined,
              initiaValue: address.city,
             ),
             const SizedBox(width: 16),
             Row(
              children: [
                Expanded(child: _buildTextField(
              context, 'Zip Code',
               Icons.pin_outlined,initiaValue: address.zipCode,
              ),
            ),
              ],
             ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                Get.back();
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:Text(
                'Update Address',
                style: AppTextstyles.withColor(
                  AppTextstyles.buttonMedium, 
                  Colors.white,
                  ),
              ),),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
  void _showDeleteConfirmation(BuildContext context){
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Delete Address',
              style: AppTextstyles.withColor(
                AppTextstyles.h3,
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Are you sure you want to delete this address?',
              textAlign: TextAlign.center,
              style: AppTextstyles.withColor(
                AppTextstyles.bodyMedium,
                isDark? Colors.grey[400]! : Colors.grey[600]!,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: ()=>  Get.back(), 
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(
                        color: isDark? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style:AppTextstyles.withColor(
                        AppTextstyles.buttonMedium,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                      ), 
                    ),
                  ),
                ),
                const SizedBox(width:16),
                Expanded(
                  child:ElevatedButton(
                    onPressed: (){
                       Get.back();
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style:AppTextstyles.withColor(
                        AppTextstyles.buttonMedium,
                      Colors.white,
                      ), 
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierColor: Colors.black54,
    );
  }
  Widget _buildTextField(
    BuildContext context,
    String label,
    IconData icon,{String? initiaValue}
  ){
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      initialValue: initiaValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
  void _showAddAddressBottomSheet(BuildContext context){
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20),),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add New Address',
                      style: AppTextstyles.withColor(
                        AppTextstyles.h3,
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                    IconButton(                    
                      onPressed: ()=> Get.back(),
                      icon: Icon(
                        Icons.close,
                        color: isDark? Colors.white : Colors.black,
                      ),
                    ),
                  ],         
            ),
            const SizedBox(height: 24),
                _buildTextField(
                  context, 
                  'Label (e.g., Home,Office)', 
                  Icons.label_outline,
                ),
                const SizedBox(height: 16),
                 _buildTextField(
                  context, 
                  'Label(Full Address)', 
                  Icons.location_on_outlined,
                ),
                const SizedBox(height: 16),
                 _buildTextField(
                  context, 
                  'City', 
                  Icons.location_city_outlined,
                ),
                const SizedBox(height: 16),
                 _buildTextField(
                  context, 
                  'Zip Code', 
                  Icons.pin_outlined,
                ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                Get.back();
              }, 
               style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
               ),
              child: Text(
                'Save Address',
                style: AppTextstyles.withColor(
                  AppTextstyles.buttonMedium,
                  Colors.white,
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}