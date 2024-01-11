import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/logic/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/widgets.dart';
import 'package:weather_app/utilities/app_colors.dart';
import 'package:weather_app/utilities/assets_utils.dart';
import 'package:weather_app/utilities/constants.dart';

import '../../widgets/home/weather_section.dart';

/// starting page
class HomePage extends StatelessWidget {
  /// constructor
  HomePage({super.key});

  /// controller for location text form feild
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 20.w),
              child: Row(
                children: [
                  BoldText('Weather App'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.white,
                      controller: locationController,
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      decoration: InputDecoration(
                        hintText: 'Enter the location',
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Color.fromARGB(66, 221, 221, 221),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          context
                              .read<WeatherBloc>()
                              .add(GetWeather(city: locationController.text));
                        },
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildBody(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    //we can use blocbuilder widget as well as   context.watch<WeatherBloc>().state with builder
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        log.info('state $state');
        if (state is NotSearchYet) {
          return Center(
            child: BoldText('Search for location'),
          );
        } else if (state is WeatherLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Error) {
          return Center(
            child: BoldText(state.message),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.whiteColor,
                      size: 40,
                    ),
                  ),
                  Text(
                    (state as WeatherData).weatherModel.location?.name ?? '',
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.foregroundColor,
                    ),
                  ),
                ],
              ),
              Image.network(
                'http:${(state as WeatherData).weatherModel.current?.condition?.icon ?? ''}',
                height: 150.h,
                width: 150.w,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.cloud, color: AppColors.whiteColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.weatherModel.current?.condition?.text ?? '',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColors.foregroundColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${state.isTempUnitInC ? (state.weatherModel.current?.tempC?.toString() ?? '') : (state.weatherModel.current?.tempF?.toString() ?? '')}'
                            '${state.isTempUnitInC ? '°C' : '°F'}',
                            style: TextStyle(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.foregroundColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<WeatherBloc>().add(AlterTempUnit());
                            },
                            icon: Icon(
                              Icons.swap_horiz,
                              color: AppColors.foregroundColor,
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: DateFormat('EEEE').format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.foregroundColor,
                              ),
                            ),
                            TextSpan(
                              text: ' ${DateFormat(
                                'MMM dd, yyyy',
                              ).format(DateTime.now())}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.foregroundColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.boxBackgroundColor,
                    ),
                    child: Wrap(
                      children: [
                        WeatherSection(
                          iconpath: AssetsUtils.airQualityIcon,
                          title: 'Humidity',
                          value: state.weatherModel.current?.humidity ?? 0,
                        ),
                        WeatherSection(
                          iconpath: AssetsUtils.pressureIcon,
                          title: 'Pressure',
                          value: state.weatherModel.current?.pressureMb ?? 0,
                          valueUnit: 'mb',
                        ),
                        WeatherSection(
                          iconpath: AssetsUtils.uvRaysIcon,
                          title: 'UV',
                          value: state.weatherModel.current?.uv ?? 0,
                        ),
                        WeatherSection(
                          iconpath: AssetsUtils.rainPredictionIcon,
                          title: 'Rain Prediction',
                          value: state.weatherModel.current?.precipMm ?? 0,
                          valueUnit: 'mm',
                        ),
                        WeatherSection(
                          iconpath: AssetsUtils.windSpeedIcon,
                          title: 'Wind Speed',
                          value: state.weatherModel.current?.windKph ?? 0,
                          valueUnit: 'km/h',
                        ),
                        WeatherSection(
                          iconpath: AssetsUtils.visibilityIcon,
                          title: 'Visibility',
                          value: state.weatherModel.current?.visKm ?? 0,
                          valueUnit: 'km',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
