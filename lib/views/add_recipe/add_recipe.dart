import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipeapp/shared/components/compoents.dart';
import 'package:receipeapp/shared/network/cache_helper.dart';
import 'package:receipeapp/shared/style/theme/colors.dart';
import 'package:receipeapp/views/add_recipe/cubit/add_recipe_cubit.dart';

import '../../main_layout/cubit/app_cubit.dart';
import 'cubit/add_recipe_states.dart';

class AddRecipe extends StatelessWidget {
  //List<String> list = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController ingredient = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRecipeCubit, AddRecipeStates>(
      builder: (BuildContext context, state) {
        AddRecipeCubit cubit = AddRecipeCubit.get(context);
        return Scaffold(
          appBar: appBar(context, 'Add a meal'),
          body: Container(
            width: getWidth(context),
            height: getHeight(context),
            color: AppCubit.get(context).isDark
                ? AppColors.primaryTextColor()
                : AppColors.primaryAppColor(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Form(
                      key: form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          addImage(context, cubit: cubit),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            color: AppCubit.get(context).isDark
                                ? Colors.grey
                                : Colors.black54,
                            hint: 'Name',
                            controller: nameController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            color: AppCubit.get(context).isDark
                                ? Colors.grey
                                : Colors.black54,
                            hint: 'Category',
                            controller: categoryController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            color: AppCubit.get(context).isDark
                                ? Colors.grey
                                : Colors.black54,
                            hint: 'Country',
                            controller: countryController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          description(context),
                          const SizedBox(
                            height: 30,
                          ),
                          addIngredients(context, cubit),
                          const SizedBox(
                            height: 20,
                          ),
                          if (cubit.ingredients.isNotEmpty)
                            ingredientsList(context, cubit),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  button(context, cubit, onTap: () {
                    if (form.currentState!.validate()) {
                      if (cubit.Image == null) {
                        flutterToast(
                            msg: 'Image is empty!', state: toastStates.error);
                      } else if (cubit.ingredients.length == 0) {
                        flutterToast(
                            msg: 'Ingredient list is empty!',
                            state: toastStates.error);
                      } else {
                        cubit.uploadImage(
                            name: nameController.text,
                            description: descriptionController.text,
                            category: categoryController.text,
                            country: countryController.text,
                            ingredients: cubit.ingredients);
                        AddRecipeCubit.get(context).Image=null;
                        nameController.clear();
                        countryController.clear();
                        categoryController.clear();
                        descriptionController.clear();

                        cubit.ingredients = [];
                      }
                    }
                  }),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget addImage(context, {cubit}) => InkWell(
        onTap: () => cubit.uploadPicture(),
        child: Container(
          width: 150,
          height: 150,
          decoration: DottedDecoration(
            shape: Shape.box,
          ),
          child: Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: cubit.Image != null
                      ? FileImage(cubit.Image!)
                      :const NetworkImage(
                              'https://i.pinimg.com/736x/5b/32/fe/5b32feafa776777a08fdcc50ab99c886.jpg')
                          as ImageProvider),
              borderRadius: BorderRadius.circular(5),
              //border: Border.all(color: Colors.grey),
              // color: Colors.grey.withOpacity(.7),
            ),
            child: cubit.Image != null ? SizedBox() : Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20)
              ),
              child: const Text(
                'Add Image +',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ),
      );
  Widget description(context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'description field is empty';
                  }
                },
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(
                      color: AppCubit.get(context).isDark
                          ? Colors.grey
                          : Colors.black54,
                      fontSize: 15),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ],
        ),
      );
  Widget ingredientsList(context, cubit) => SizedBox(
        width: getWidth(context),
        height: 35,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                  padding: const EdgeInsets.all(6),
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.2),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      Text(
                        cubit.ingredients[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                          onTap: () {
                            cubit.removeIngredientsFromList(
                                cubit.ingredients[index]);
                          },
                          child: const Icon(
                            Icons.clear,
                            size: 16,
                            color: Colors.white,
                          ))
                    ],
                  ));
            },
            separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
            itemCount: cubit.ingredients.length),
      );
  Widget addIngredients(context, cubit) => Row(
        children: [
          Text(
            '  Add Ingrediants',
            style: TextStyle(
                color: AppCubit.get(context).isDark
                    ? Colors.grey
                    : AppColors.primaryTextColor(),
                fontSize: 17),
          ),
          const SizedBox(
            width: 20,
          ),
          InkWell(
              onTap: () {
                showDialog(
                    barrierColor: AppCubit.get(context).isDark
                        ? Colors.grey.withOpacity(.4)
                        : Colors.grey.withOpacity(.1),
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: AppCubit.get(context).isDark
                            ? Colors.black87
                            : Colors.white,
                        content: Form(
                          key: formKey,
                          child:

                              defaultFormField(
                                  hint: 'Ingredient',
                                  controller: ingredient,
                                  onSubmit: (String value) {
                                    if (formKey.currentState!.validate()) {
                                      cubit.addIngredientsToList(
                                          ingredient.text);
                                      ingredient.clear();
                                      Navigator.pop(context);
                                    }
                                  })


                        ),
                        actions: [
                          alertDialogButton(context, onPressed: () =>Navigator.pop(context), text: "Cancel", color: Colors.white, backColor:AppCubit.get(context).isDark?  Colors.grey.withOpacity(.2).withOpacity(.3):Colors.grey),
                          alertDialogButton(context, onPressed:  () async {
                            if (formKey.currentState!.validate()) {
                              cubit.addIngredientsToList(ingredient.text);
                              ingredient.clear();
                              nameController.clear();
                              categoryController.clear();
                              countryController.clear();
                              descriptionController.clear();
                              Navigator.pop(context);
                            }
                          }, text: "ADD", color: Colors.white, backColor:const Color.fromRGBO(255, 59, 0,
                              1)),
                        ],
                      );
                    });
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(255, 59, 0, 1)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ))),
        ],
      );
  Widget button(context, cubit, {required onTap}) => InkWell(
        onTap: onTap,
        child: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            alignment: AlignmentDirectional.center,
            height: 50,
            color: AppColors.secondaryAppColor(),
            width: getWidth(context),
            child: const Text(
              'Add',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      );

}
