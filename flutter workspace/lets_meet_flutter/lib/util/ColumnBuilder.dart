import 'package:flutter/material.dart';

class ColumnBuilder extends StatelessWidget {
	final IndexedWidgetBuilder itemBuilder;
	final MainAxisAlignment mainAxisAlignment;
	final MainAxisSize mainAxisSize;
	final CrossAxisAlignment crossAxisAlignment;
	final TextDirection textDirection;
	final VerticalDirection verticalDirection;
	final int itemCount;

	const ColumnBuilder({
		Key key,
		@required this.itemBuilder,
		@required this.itemCount,
		this.mainAxisAlignment: MainAxisAlignment.start,
		this.mainAxisSize: MainAxisSize.max,
		this.crossAxisAlignment: CrossAxisAlignment.center,
		this.textDirection,
		this.verticalDirection: VerticalDirection.down,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return new Column(
			children: new List.generate(this.itemCount,
					(index) => this.itemBuilder(context, index)).toList(),
		);
	}
}


class RowBuilder extends StatelessWidget {
	final IndexedWidgetBuilder itemBuilder;
	final MainAxisAlignment mainAxisAlignment;
	final MainAxisSize mainAxisSize;
	final CrossAxisAlignment crossAxisAlignment;
	final TextDirection textDirection;
	final VerticalDirection verticalDirection;
	final int itemCount;

	const RowBuilder({
		Key key,
		@required this.itemBuilder,
		@required this.itemCount,
		this.mainAxisAlignment: MainAxisAlignment.start,
		this.mainAxisSize: MainAxisSize.max,
		this.crossAxisAlignment: CrossAxisAlignment.center,
		this.textDirection,
		this.verticalDirection: VerticalDirection.down,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return new Row(
       mainAxisAlignment:  this.mainAxisAlignment,
			children: new List.generate(this.itemCount,
					(index) => this.itemBuilder(context, index)).toList(),
		);
	}
}

class WrapBuilder extends StatelessWidget {
	final IndexedWidgetBuilder itemBuilder;
	final MainAxisAlignment mainAxisAlignment;
	final MainAxisSize mainAxisSize;
	final CrossAxisAlignment crossAxisAlignment;
  final WrapAlignment alignment;
	final TextDirection textDirection;
	final VerticalDirection verticalDirection;
	final int itemCount;

	const WrapBuilder({
		Key key,
		@required this.itemBuilder,
		@required this.itemCount,
		this.mainAxisAlignment: MainAxisAlignment.start,
		this.mainAxisSize: MainAxisSize.max,
		this.crossAxisAlignment: CrossAxisAlignment.center,
		this.textDirection,
		this.verticalDirection: VerticalDirection.down, this.alignment,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return new Wrap(
       runAlignment: WrapAlignment.center,
       alignment:  this.alignment,
			children: new List.generate(this.itemCount,
					(index) => this.itemBuilder(context, index)).toList(),
		);
	}
}