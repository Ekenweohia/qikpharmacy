import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qik_pharma_mobile/core/models/response/order.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;
  const OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String? currency;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      currency = await Helper.currency();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopSection(),
          const SizedBox(height: 34),
          _buildMainContent(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    final date = DateTime.parse(widget.order.createdAt!);
    final time = DateFormat('hh:mma').format(date).toLowerCase();

    final dayMap = {1: 'st', 2: 'nd', 3: 'rd'};
    final getDateSuffix = '${date.day}${dayMap[date.day] ?? 'th'}';
    final formattedDate =
        '$getDateSuffix ${month(date.month)} ${date.year} at $time';

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  '${Helper.orderDetailSubText(widget.order.status ?? '')} $formattedDate',
                  style: textStyle13Light,
                ),
              ),
              const SizedBox(height: 10.0),
              const Divider(),
              const SizedBox(height: 5.0),
              _buildOrderSummarySection(),
              const SizedBox(height: 5.0),
              const Divider(),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Total ', style: textStyle13Light),
                  Text(
                    '$currency ${widget.order.subTotal}',
                    style: textStyle13w500,
                  ),
                ],
              ),
              const SizedBox(height: 35.0),
              _buildOrderDetailsSection(formattedDate),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetailsSection(String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text('Order Details', style: textStyle17w400),
        ),
        const SizedBox(height: 15),
        Text('Order Number', style: textStyle13LightPrimaryColor),
        const SizedBox(height: 10),
        Text(
          widget.order.orderId!.substring(0, 8).toUpperCase(),
          style: textStyle15w500,
        ),
        const SizedBox(height: 10),
        Text('Order Items', style: textStyle13LightPrimaryColor),
        const SizedBox(height: 10),
        if (widget.order.orderItems == null || widget.order.orderItems!.isEmpty)
          Text('No items', style: textStyle13Light),
        for (final item in widget.order.orderItems!)
          _buildOrderItem(
            name: item.product?.name.toString() ?? 'N/A',
          ),
        const SizedBox(height: 10),
        Text('Delivery Type', style: textStyle13LightPrimaryColor),
        const SizedBox(height: 10),
        Text(widget.order.logisticsCompany?.name ?? 'N/A',
            style: textStyle15w500),
        const SizedBox(height: 10),
        Text('Date', style: textStyle13LightPrimaryColor),
        const SizedBox(height: 10),
        Text(date, style: textStyle15w500),
        const SizedBox(height: 40),
        _buildButtons(),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        if (widget.order.status != 'delivered')
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: AppCustomColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text('Contact', style: textStyle15w500White),
                ],
              ),
            ),
          ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: AppCustomColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text('Get help', style: textStyle15w500White),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem({
    required String name,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5.0),
        Text(name, style: textStyle15w500),
      ],
    );
  }

  Widget _buildOrderSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Delivery Charges', style: textStyle13Light),
            Text('$currency 0.00', style: textStyle13w500),
          ],
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Qikpharma Delivery', style: textStyle13Light),
            Text('$currency 0.00', style: textStyle13w500),
          ],
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax & Service Charges', style: textStyle13Light),
            Text('$currency 0.00', style: textStyle13w500),
          ],
        ),
      ],
    );
  }

  Widget _buildTopSection() {
    return Container(
      width: double.infinity,
      height: 166,
      decoration: const BoxDecoration(
        color: AppCustomColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Order no: ${widget.order.orderId!.substring(0, 8).toUpperCase()}',
                style: textStyle17w300White,
              ),
              const SizedBox(height: 5),
              Text(
                Helper.orderDetailHeaderText(widget.order.status ?? ''),
                style: textStyle17BoldWhite.copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// move to helper function
String month(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    default:
      return 'December';
  }
}
