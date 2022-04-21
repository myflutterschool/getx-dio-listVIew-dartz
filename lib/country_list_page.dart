import 'package:countries_list/controller/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryListPage extends StatelessWidget {
  const CountryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('CountryList'),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) => Obx(
        () => Column(
          children: [
            _title(),
            Expanded(
                child: _controller.isLoadingGetAllCountries.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _listView())
          ],
        ),
      );

  Widget _listView() {
    return RefreshIndicator(
      onRefresh: _controller.onRefresh,
      child: Stack(children: [
        _listItemView(),
        if (_controller.hasError.isTrue)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _controller.errorMessage,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                OutlinedButton(
                    onPressed: _controller.onRefresh,
                    child: const Text('try again'))
              ],
            ),
          )
      ]),
    );
  }

  ListView _listItemView() {
    return ListView.builder(
        itemCount: _controller.countries.length,
        itemBuilder: (context, index) => Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(6)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _controller.countries[index].name!,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    _controller.countries[index].capital!,
                    style: const TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ));
  }

  Widget _title() => const Text(
        'Countries and capitals endpoints',
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      );

  MyController get _controller => Get.find<MyController>();
}
