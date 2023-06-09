//d

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradients/gradients.dart';

import '../../layout/socialapp/cubit/cubit.dart';
import '../styles/iconbroken.dart';



Widget defaultButton({
  required VoidCallback onTap,
  required String text,
  double? width = 400,
}) =>
    Container(
      height: 50,
      width: width,
      child: MaterialButton(
        color: Colors.blueAccent,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: onTap,
        child: Text(
          '$text',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );



PreferredSizeWidget  defaultAppBar({
  required BuildContext context,
  String ? title,
   List<Widget> ? actions,
}) => AppBar(
  leading: 
  IconButton(
    onPressed: ()
    {
      // Navigator.pop(context);
        showDialog(
                      context: context,
                      builder: (context) {
                        // Future.delayed(Duration(seconds: 5), () {
                        //   Navigator.of(context).pop(true);
                        // });
                        // return AlertDialog(
                        //   title: Text('Title'),
                        // );
                        return 
                         baseAlertDialog(
                          context: context,
                          title: 'Rời khỏi',
                          content: 'Rời khỏi sẽ không lưu, bạn chắc chứ?',
                          outlinedButtonText: 'Đồng ý',
                          elevatedButtonText: 'Hủy bỏ',
                          // elevatedButtonIcon: Icons.cancel,
                          );
                      });
      // Navigator.of(context).pop();
      
    }, icon:  Icon(
    IconBroken.Arrow___Left_2,
  ),
  ),
  titleSpacing: 5.0,
  title: Text(
    title!,
  ),
  actions: actions,
);

PreferredSizeWidget  defaultAppBarNoPop({
  required BuildContext context,
  String ? title,
   List<Widget> ? actions,
}) => AppBar(
   shadowColor : Colors.blue ,
elevation: 1,
  leading: IconButton(
    onPressed: ()
    {
      Navigator.of(context).pop();
      
    }, icon:  Icon(
    IconBroken.Arrow___Left_2,
  ),
  ),
  titleSpacing: 5.0,
  title: Text(
    title!,
  ),
  actions: actions,
);






Widget defaultFormField({
   context,
  required TextEditingController controller,
  required TextInputType keyboardType,
   TextInputType ? type,
  bool isPassword = false,
  bool enabled = true,
   onSubmit,
   onChange,
  onTap,
  required FormFieldValidator validate,
   String ? label,
   IconData?prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClikable = true,
  String? labelText,

  Color? fillColor,
  Color? enabledBorderColor,
  Color? focusedBorderColor,
  TextStyle? style,
  TextStyle? labelStyle,
  bool hasBorder = true,
  OutlineInputBorder ? focusedBorder,
  OutlineInputBorder?  enabledBorder,




}) =>
    TextFormField(


      cursorColor: Colors.blue,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,

      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      style: style ?? TextStyle(),


      decoration: InputDecoration(

        focusedBorder: focusedBorder,
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(),
        labelText:labelText,
        labelStyle:  TextStyle(),

        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ))
            : null,
      ),




    );

Widget defaultTextButton({
  bool isUpperCase = true,
  TextStyle? style,
  required Function function,
  Function? function1,
  required String text,
}) =>
    TextButton(
      onPressed: (){
        function();
        },
      style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.blue[50])),


      child: Text(text.toUpperCase(),),

);






Widget myDivider() => Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[400],
      ),
    );





// ignore: non_constant_identifier_names
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

// ignore: non_constant_identifier_names
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
    (route)
    {
      return false;
    },

);


  void showToast({
    required String text,
    required ToastStates state,
    double fontSize = 16,
    int seconds = 5,
  }) =>
      BotToast.showText(
          text: text,
          duration: Duration(seconds: seconds),
          contentColor: toastColor(state),
          clickClose: true,
          align: Alignment(0, -0.9));

  enum ToastStates { SUCCESS, ERROR, WARNING }

  Color toastColor(ToastStates state) {
    switch (state) {
      case ToastStates.SUCCESS:
        return Colors.green;
      case ToastStates.ERROR:
        return Colors.red;
      case ToastStates.WARNING:
        return Colors.yellow;
    }
  }

Widget baseAlertDialog({
  required context,
  String? title,
  String? content,
  String? outlinedButtonText,
  String? elevatedButtonText,
  IconData? elevatedButtonIcon,
  String? choose1,
  String? choose2,
}){
  return 
  AlertDialog(
    title: Text('$title',),
    titlePadding: EdgeInsetsDirectional.only(start:13,top: 15 ),
    content: Text('$content',),
    elevation: 8,
    contentPadding: EdgeInsets.all(15),
    actions: [

      Visibility(
        // visible: '$outlinedButtonText' == 'Đồng ý' ? true :  false, 
          child:        
          OutlinedButton(
          onPressed: (){
            SocialCubit.get(context).postImage = null;
            SocialCubit.get(context).paths = null;
            SocialCubit.get(context).editsubpostTempWhenCreatePost = null;
          SocialCubit.get(context).editsubpostDetailwhenCreate = null;
            Navigator.of(context).pop(true);
            Navigator.of(context).pop(true);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon('$outlinedButtonText' == '' ? IconBroken.Image : Icons.done_all_outlined),
              SizedBox(width:10),
              Text('$outlinedButtonText'),
            ],
          ),
      )
      ),

        Visibility(
        visible:   '$choose1' == 'Thêm hình ảnh' ? true :  false, 
        child: OutlinedButton(
          onPressed: (){
             SocialCubit.get(context).pickFiles();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(IconBroken.Image),
              SizedBox(width:10),
              Text('$choose1'),
            ],
          ),
            ),
        ),
        Visibility(
        visible:   '$choose2' == 'Thêm video' ? true :  false, 
        child: OutlinedButton(
          onPressed: (){
            // SocialCubit.get(context).selectVideos();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(IconBroken.Video),
              SizedBox(width:10),
              Text('$choose2'),
            ],
          ),
            ),
        ),
      SizedBox(
        // width: 100,
        child: 
        ElevatedButton(
          style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.blueAccent)) ,
          onPressed: (){
            // Navigator.of(context, rootNavigator: true).pop(true);
            Navigator.pop(context, true);
          },
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon('$outlinedButtonText' == '' ? IconBroken.Image : Icons.cancel_outlined),
              // Icon(elevatedButtonIcon),
              SizedBox(width: 5,),
           Text('$elevatedButtonText' == '' ? '$elevatedButtonText'  : 'Hủy bỏ',style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
    ],

  );
}

Widget buildIconWithNumber({
  required bool condition,
  number,
  icon,
  iconColor,
  double size = 30,
  double radius = 12,
  double fontSize = 13,
  VoidCallback? onPressed,
  alignment = const Alignment(1.6, -0.8),
}) =>
    Column(
      children: [
      Stack(
      alignment: alignment,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: iconColor,
            size: size,
          ),
        ),
        if (condition)
          CircleAvatar(
            radius: radius,
            backgroundColor:Color(0xFF182140),
            child: Text(
              number.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: Colors.white,
              ),
            ),
          ),
      ],
    ),
]
    );


Widget primaryButton({
  required String text,
  required VoidCallback onPressed,
  double height = 60,
  double width = 300,
  Color? background,
  Color? textColor,
  double radius = 30,
  bool isUpperCase = true,
  double fontSize = 18,
  colors,
}) =>
    Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradientPainter(
          colorSpace: ColorSpace.cmyk,
          colors: colors ??
              [
                Colors.purple.shade200,
                Colors.purple.shade200,
                Colors.blue,
              ],
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Cairo",
            fontSize: fontSize,
          ),
        ),
      ),
    );

Widget backButton(context) => Row(children: [
  IconButton(
    icon: Icon(
      Icons.arrow_back,
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  ),
  Text(
    "Back",
    style: TextStyle(

      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
]);

Widget textModel({
  required String text,
  Color? textColor,
  double radius = 30,
  // double? fontWeight,
  double? fontSize,
  colors,
}) =>
    Text(
      text,
      style: TextStyle(
      color: colors,
      fontSize: fontSize,
    ),
    );

Widget textModel13({
  required String text,
  Color? textColor,
  double radius = 30,
  double? fontWeight,
  double? fontSize,
  colors,
}) =>
    Text(
      text,
      style: TextStyle(
      color: Colors.black87,
      fontSize: 13,
    ),
    );


const defaulTextNoPost = 'No have any Posts';


  double screenWidthComponent = double.infinity;
  double screenHeightComponent = double.infinity;
