class Order {
  String? orderId;
  String? orderBill;
  String? orderPaid;
  String? buyerId;
  String? sellerId;
  String? orderDate;
  String? orderStatus;
  String? orderLat;
  String? orderLng;
  String? orderState;
  String? orderLocality;

  Order(
      {this.orderId,
      this.orderBill,
      this.orderPaid,
      this.buyerId,
      this.sellerId,
      this.orderDate,
      this.orderStatus,
      this.orderLat,
      this.orderLng,
      this.orderState,
      this.orderLocality});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderBill = json['order_bill'];
    orderPaid = json['order_paid'];
    buyerId = json['buyer_id'];
    sellerId = json['seller_id'];
    orderDate = json['order_date'];
    orderStatus = json['order_status'];
    orderLat = json['order_lat'];
    orderLng = json['order_lng'];
    orderState = json['order_state'];
    orderLocality = json['order_locality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['order_bill'] = orderBill;
    data['order_paid'] = orderPaid;
    data['buyer_id'] = buyerId;
    data['seller_id'] = sellerId;
    data['order_date'] = orderDate;
    data['order_status'] = orderStatus;
    data['order_lat'] = orderLat;
    data['order_lng'] = orderLng;
    data['order_state'] = orderState;
    data['order_locality'] = orderLocality;
    return data;
  }
}