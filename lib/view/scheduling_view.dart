import 'package:desafio_agendamento/app_route.dart';
import 'package:desafio_agendamento/view/widgets/image_card_widget.dart';
import 'package:desafio_agendamento/view/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../viewmodel/scheduling_viewmodel.dart';

class SchedulingView extends StatelessWidget {
  SchedulingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SchedulingViewModel(),
        child: Builder(
        builder: (context) {
          final viewModel = Provider.of<SchedulingViewModel>(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ImageCard(imagePath: 'assets/img_1.jpg',),
                      ImageCard(imagePath: 'assets/img_2.jpg',),
                      ImageCard(imagePath: 'assets/img_3.jpg',),
                      ImageCard(imagePath: 'assets/img_4.jpg',),
                      ImageCard(imagePath: 'assets/img_5.jpg',),

                    ],)
              ),
              const SizedBox(height: 30),
              Text("Título",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
              SizedBox(height: 5,),
              InputTextWidget(hintText: 'Título da postagem', controller: viewModel.titleController, readOnly: false,),
              SizedBox(height: 30,),
              Text("Legenda",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
              SizedBox(height: 5,),
              InputTextWidget(hintText: 'Legenda da postagem', maxLines: 5, controller: viewModel.subtitleController, readOnly: false),
              SizedBox(height: 30,),
              Text("Agendamento",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 160,
                    child: GestureDetector(
                      onTap: () => viewModel.pickDate(context),
                      child: AbsorbPointer(
                        child: InputTextWidget(
                          hintText: 'Data',
                          readOnly: true,
                          icon: Icons.calendar_today,
                          controller: viewModel.dateController,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: GestureDetector(
                      onTap: () => viewModel.pickTime(context),
                      child: AbsorbPointer(
                        child: InputTextWidget(
                          hintText: 'Hora',
                          readOnly: true,
                          icon: Icons.access_time,
                          controller: viewModel.timeController,
                        ),
                      ),
                    ),),
                ],),
              SizedBox(height: 50,),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      await viewModel.savePostToCache();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Agendado com sucesso")),
                      );
                      appRouter.go("/home");
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorConstants.primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          "Agendar",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  )
              )
            ],
          );
        })
    );}
}