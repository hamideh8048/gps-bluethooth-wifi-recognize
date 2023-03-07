import 'package:Prismaa/components/login_text_feild.dart';
import 'package:flutter/material.dart';

Widget resetPasswordWidget(BuildContext context, TextEditingController controller, final formKey, FocusNode _focusNode) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("فراموشی رمز عبور",
                style: Theme.of(context).textTheme.bodyText1
            ),
            IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_forward, size: 30)
            )
          ],
        ),
        const SizedBox(height: 75),
        Text("شماره ثبت شده در منابع انسانی",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Text("را وارد کنید.",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 50),
        Text("شماره موبایل خود را وارد کنید",
            style: Theme.of(context).textTheme.bodyText1
        ),
        const SizedBox(height: 80),
        Form(
          key: formKey,
          child: LoginTextFeild(
            labelText: 'شماره موبایل',
            hintText: 'شماره موبایل خود را وارد کنید',
            prefixIcon: const Icon(Icons.call_outlined, color: Colors.black12,),
            controller: controller,
            obscureText: false,
            keyboardType: TextInputType.number,
            autofillHints: const Iterable.empty(),
            validator: (String? value){
              if(value == ""){
                return "این فیلد نباید خالی باشد";
              } else {
                if(value![0] != "0" || value[1] != "9"){
                  return "فرمت نوشتاری موبایل باید به صورت ۰۹۱۱۱۱۱۱۱۱۱ نوشته شود";
                } else {
                  if(value.length != 11){
                    return "تعداد ارقام وارد شده صحیح نمی باشد";
                  } else {
                    return null;
                  }
                }
              }
            },
            focusNode: _focusNode,
            textDirection: TextDirection.ltr,
            onFieldSubmitted: null
          ),
        ),

      ],
    ),
  );
}