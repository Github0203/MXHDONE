import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/social_register/cubit/states.dart';
import 'package:socialapp/shared/components/components.dart';
import '../../../../models/social_model/social_user_model.dart';
import 'dart:math';
import 'package:emailjs/emailjs.dart';
import 'package:socialapp/modules/social_register/EmailNotAuth.dart';




class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);


    String getVerify = '';
    String getUIDVerify = '';
    String getNameVerify = '';
    String getEmailVerify = '';
    void checkVerify(
      String getEmail,  ) async{
    
    getVerify = '';
    getUIDVerify = '';
    getNameVerify = '';
    getEmailVerify = '';
    final QuerySnapshot resultFollows =
    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: 
    getEmail).get();
    final List <DocumentSnapshot> documentVerifys = resultFollows.docs;
    // ignore: unused_local_variable
    for (var element in documentVerifys) {
      getVerify = element['verify'];
      getUIDVerify = element['uId'];
      getNameVerify = element['name'];
      getEmailVerify = element['email'];
    }



    emit(CheckVerifySuccessState());
  }
   void checkVerifySuccess() async{
    await FirebaseFirestore.instance.collection('users').doc(getUIDVerify)
            .update(({
          'auth': 'yes',
        }));
      emit(CheckVerifySuccessState());
   }
   void updateVerify() async{
    await FirebaseFirestore.instance.collection('users').doc(getUIDVerify)
            .update(({
          'verify': '###################################'
        }));
      emit(CheckVerifySuccessState());
   }
   void checkVerifySuccessSendAgain(String getUIDVerify, String getVerify) async{
    await FirebaseFirestore.instance.collection('users').doc(getUIDVerify)
            .update(({
          'verify': getVerify,
        }));
      emit(CheckVerifySuccessState());
   }

  void userRegister({
    context,
    required String email,
    required String name,
    required String phone,
    required String password,

  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      if (kDebugMode) {
        print(value.user!.email);
      }
      if (kDebugMode) {
        print(value.user!.uid);
      }
      userCreate( 
        name: name,
        password: password,
      uId: value.user!.uid,
      email: email,
      phone: phone,
        bio:'write your bio....',
        image: 'https://image.freepik.com/free-photo/happy-man-wearing-clothing-color-year-2022_23-2149217417.jpg',
        cover: 'https://image.freepik.com/free-photo/hands-isolated-illuminating-color_23-2148791658.jpg',
        isEmailVerified: false,
      );
    })
    .catchError((error){
      if (kDebugMode) {
        print(error.toString());
        showToast(text: 'Email registed, please verify!', state: ToastStates.WARNING);
        String kkk = email;
          EmailJS.init(const Options(
          publicKey: 'RFyzzHduLJs_QKroA',
          privateKey: 'tlITjk5QsKzoU0G7FcU7o',
                        ));
    
try {
       EmailJS.send(
        'service_vxgvq6x',
        'template_40nq44d',
        {
          'from_name': 'Social App',
          'user_email': kkk,
          'message': 'Verify: ' + getVerify.toString(),
        },
        const Options(
          publicKey: 'RFyzzHduLJs_QKroA',
          privateKey: 'tlITjk5QsKzoU0G7FcU7o',
        ),
      );
      print('getEmailVerify!  :  ' + getEmailVerify);
      print('getVerify!  :  ' + getVerify);
      print('SUCCESS!');
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
    }
        navigateTo(context, EmailNotAuth(getEmai:kkk));
      }
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  var rndnumber="";
  var rnd= new Random();
  void userCreate({
    required String email,  
    required String name,
    required String password,
    required String phone,
    required String uId,
    required String image,
    required String cover,
    required String bio,
    required bool isEmailVerified,
})
  {
   
  for (var i = 0; i < 6; i++) {
  rndnumber = rndnumber + rnd.nextInt(9).toString();
  }
    SocialUserModel model = SocialUserModel(
      name: name,
       auth: 'no',
      password: password,
      queryable: name.toLowerCase(),
      email: email,
      phone: phone,
      uId: uId,
      image:'https://image.freepik.com/free-photo/happy-man-wearing-clothing-color-year-2022_23-2149217417.jpg',
      cover:'https://image.freepik.com/free-photo/hands-isolated-illuminating-color_23-2148791658.jpg',
      bio:'write your bio....',
      verify: rndnumber.toString(), 
    );
  FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
    emit(SocialCreateUserSuccessState(uId));
  }).catchError((error)
        {
          emit(SocialCreateUserErrorState(error.toString()));

        });
      //////////////  send mail vẻify
       checkVerify(email);
       print('getUIDVerify ================================>>>>>>   ' + getUIDVerify);
    
  }

   
   void getVerifySuccess(
      String getEmail,  ) async{
    rndnumber = '';
    getVerify = '';
    getUIDVerify = '';
    getNameVerify = '';
    getEmailVerify = '';
    final QuerySnapshot resultFollows =
    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: 
    getEmail).get();
    final List <DocumentSnapshot> documentVerifys = resultFollows.docs;
    // ignore: unused_local_variable
    for (var element in documentVerifys) {
      getVerify = element['verify'];
      getUIDVerify = element['uId'];
      getNameVerify = element['name'];
      getEmailVerify = element['email'];
    }

try {
       EmailJS.send(
        'service_vxgvq6x',
        'template_40nq44d',
        {
          'from_name': 'Social App',
          'user_email': getEmailVerify,
          'message': 'Verify: ' + getVerify.toString(),
        },
        const Options(
          publicKey: 'RFyzzHduLJs_QKroA',
          privateKey: 'tlITjk5QsKzoU0G7FcU7o',
        ),
      );
      print('getEmailVerify!  :  ' + getEmailVerify);
      print('getVerify!  :  ' + getVerify);
      print('SUCCESS!');
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
    }
   
    // emit(CheckVerifySuccessState());
  }
   void senmailAgain(
      String getEmail,  ) async{
        rndnumber = '';
    for (var i = 0; i < 6; i++) {
  rndnumber = rndnumber + rnd.nextInt(9).toString();
  }
    getVerify = '';
    getUIDVerify = '';
    getNameVerify = '';
    getEmailVerify = '';
    final QuerySnapshot resultFollows =
    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: 
    getEmail).get();
    final List <DocumentSnapshot> documentVerifys = resultFollows.docs;
    // ignore: unused_local_variable
    for (var element in documentVerifys) {
      getVerify = element['verify'];
      getUIDVerify = element['uId'];
      getNameVerify = element['name'];
      getEmailVerify = element['email'];
      print('getEmailVerify update!  :  ' + getEmailVerify);
      print('getVerify!  update  :  ' + getVerify);
        await FirebaseFirestore.instance.collection('users').doc(getUIDVerify)
            .update(({
          'verify': rndnumber,
        }));
    }
                        EmailJS.init(const Options(
          publicKey: 'RFyzzHduLJs_QKroA',
          privateKey: 'tlITjk5QsKzoU0G7FcU7o',
                        ));
    
try {
       EmailJS.send(
        'service_vxgvq6x',
        'template_40nq44d',
        {
          'from_name': 'Social App',
          'user_email': getEmailVerify,
          'message': 'Verify: ' + getVerify.toString(),
        },
        const Options(
          publicKey: 'RFyzzHduLJs_QKroA',
          privateKey: 'tlITjk5QsKzoU0G7FcU7o',
        ),
      );
      print('getEmailVerify!  :  ' + getEmailVerify);
      print('getVerify!  :  ' + getVerify);
      print('SUCCESS!');
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
    }
 
    // emit(CheckVerifySuccessState());
  }
  



  IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix =isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialAddPasswordStatue());

  }


}
