# 🌦️ How Weatherly Works

> **More Than Weather**

This document explains how Weatherly works internally.

The purpose of this document is to help a developer understand the project from the inside and, if needed, rebuild a similar weather application from scratch.

Weatherly is intentionally kept simple so that the core Flutter and API concepts are easy to understand.

---

## 1. 🧠 Big Picture

At a high level, Weatherly works like this:

```text
User
 ↓
Flutter Screen
 ↓
WeatherService
 ↓
OpenWeather API
 ↓
JSON Response
 ↓
WeatherModel
 ↓
Flutter UI
```

**The most important idea is:**

The UI does not directly communicate with the weather server. Instead, the application uses a `WeatherService` to communicate with the API.

---

## 2. 🏗️ Main Parts of Weatherly

Weatherly is divided into a few simple responsibilities:

```text
lib/
│
├── screens/        → User Interface
├── navigation/     → Screen Navigation
├── services/       → API Communication
├── models/         → Weather Data
├── widgets/        → Reusable UI
├── theme/          → Application Colors
└── utils/          → Constants
```

Each part has a different responsibility.

---

## 3. 🚀 Application Startup

The application starts from: `lib/main.dart`

The main function is:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}
```

### 3.1 `main()`
`main()` is the starting point of the Flutter application. The execution starts here.
```text
main()
 ↓
Load environment variables
 ↓
runApp()
 ↓
MyApp
```

### 3.2 `WidgetsFlutterBinding.ensureInitialized()`
Before loading `.env`, Flutter needs to initialize its bindings. This is important because `main()` is asynchronous.

### 3.3 Loading `.env`
Weatherly uses `flutter_dotenv`.
```dart
await dotenv.load(fileName: '.env');
```
This loads the environment variables from `.env`. The API key can then be accessed using:
```dart
dotenv.env['OPENWEATHER_API_KEY']
```

---

## 4. 🌱 `runApp()`

After the environment variables are loaded:
```dart
runApp(const MyApp());
```
Flutter starts the widget tree.
```text
main()
 ↓
runApp()
 ↓
MyApp
 ↓
MaterialApp
 ↓
SplashScreen
```

---

## 5. 🌊 Splash → Onboarding → Main App

Weatherly starts with the Splash Screen.
```text
Splash Screen
      ↓
Onboarding Screen
      ↓
MainNavigation
```

### 5.1 Splash Screen
The Splash Screen is a `StatefulWidget`. It uses:
```dart
Future.delayed(
  const Duration(seconds: 3),
  () {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => const OnboardingScreen(),
      ),
    );
  },
);
```
The application waits for approximately 3 seconds, then it moves to the Onboarding Screen.

### 5.2 Why `pushReplacement()`?
The Splash Screen should not remain in the navigation stack. Therefore, `Navigator.pushReplacement()` is used instead of `Navigator.push()`.

Conceptually:
- `push()`: Splash → Onboarding → (Back) → Splash
- `pushReplacement()`: Splash → Onboarding → (Back) → *Splash is not returned to*

---

## 6. 👋 Onboarding Screen

The Onboarding Screen introduces Weatherly. It provides two actions: **Get Started** and **Skip**. Both eventually take the user to `MainNavigation`.

The navigation is again handled using `Navigator.pushReplacement()`.
```text
Splash
 ↓
Onboarding
 ↓
MainNavigation
```

---

## 7. 🧭 MainNavigation

The main application navigation is handled by: `lib/navigation/main_navigation.dart`

The main tabs are:
- `index = 0` → Home
- `index = 1` → Search
- `index = 2` → Settings

Conceptually:
```text
             MainNavigation
                   │
       ┌───────────┼───────────┐
       ↓           ↓           ↓
     Home        Search      Settings
```

---

## 8. 🔢 Why `index` Is Used

Instead of creating completely separate navigation logic for the three main tabs, the application keeps track of the selected tab using an integer.

```dart
setState(() {
  index = 1; // Open Search tab
});

setState(() {
  index = 0; // Return to Home
});
```

---

## 9. 🌦️ WeatherModel

The weather data is represented by: `lib/models/weather_model.dart`

The model contains:
- `cityName`
- `temperature`
- `humidity`
- `windSpeed`
- `condition`
- `description`
- `pressure`
- `visibility`

Conceptually:
```text
WeatherModel
│
├── cityName
├── temperature
├── humidity
├── windSpeed
├── condition
├── description
├── pressure
└── visibility
```

---

## 10. 🤔 Why WeatherModel?

Without a model, we would have to pass individual values everywhere, which becomes difficult to manage. Instead, `WeatherModel` acts as one container for all weather information.

```text
SearchScreen
      ↓
WeatherModel
      ↓
MainNavigation
      ↓
HomeScreen
```
This keeps the data flow easier to understand.

---

## 11. 🌐 WeatherService

The most important API logic lives inside: `lib/services/weather_service.dart`

The main function is: `Future<WeatherModel> getWeather(String city)`

Its job is:
```text
Receive city name
      ↓
Create API URL
      ↓
Send HTTP GET request
      ↓
Receive response
      ↓
Check status code
      ↓
Decode JSON
      ↓
Extract weather values
      ↓
Create WeatherModel
      ↓
Return WeatherModel
```

---

## 12. 🔗 Creating the API URL

WeatherService creates the request URL using: `city`, `API key`, and `metric units`.

Conceptually:
```text
https://api.openweathermap.org/data/2.5/weather
        ?q=CITY
        &appid=API_KEY
        &units=metric
```
For example, `getWeather("Mumbai")` creates a request for Mumbai.

---

## 13. 📡 HTTP GET Request

The application uses the `http` package.
```dart
final response = await http.get(url);
```
This means: Send a GET request to the weather server and wait for its response.
```text
Flutter App
    ↓
HTTP GET
    ↓
OpenWeather Server
    ↓
HTTP Response
```

---

## 14. ⏳ Why `async` and `await`?

Network requests take time. The application cannot assume that the server will respond instantly. Therefore, it uses asynchronous programming:
```dart
Future<WeatherModel> getWeather(String city) async
```
And `await http.get(url);` means: Wait for the HTTP response before continuing.

---

## 15. 📊 HTTP Status Code

After receiving the response, `WeatherService` checks `response.statusCode`. The application mainly handles:
- `200` → Success
- `401` → Invalid API key
- `404` → City not found
- `429` → Too many requests
- `500` → Weather server error

---

## 16. ✅ Successful Response

If `response.statusCode == 200`, the application reads the response body:
```dart
final data = jsonDecode(response.body);
```
The server sends JSON. Flutter converts that JSON into Dart data using `jsonDecode()`.

---

## 17. 🧩 JSON Parsing

After `jsonDecode(response.body)`, the API response becomes accessible through `data`. Weatherly then extracts individual values:
- `data['name']` → gets the city name.
- `data['main']['temp']` → gets the temperature.
- `data['main']['humidity']` → gets humidity.
- `data['wind']['speed']` → gets wind speed.
- `data['weather'][0]['main']` → gets the main weather condition.

---

## 18. 📦 Creating WeatherModel

After extracting the values, `WeatherService` creates:
```dart
WeatherModel(
  cityName: cityName,
  temperature: temperature,
  humidity: humidity,
  windSpeed: windSpeed,
  condition: condition,
  description: description,
  pressure: pressure,
  visibility: visibility,
);
```
Then it returns this object.
```text
OpenWeather API
      ↓
JSON
      ↓
Extract values
      ↓
WeatherModel
      ↓
return
```

---

## 19. 🏠 HomeScreen

The Home Screen's main responsibility is to display weather information. It maintains:
- `weather`
- `isLoading`
- `errorMessage`
- `currentCity`

---

## 20. 🌱 HomeScreen `initState()`

When `HomeScreen` starts, `initState()` checks whether weather was already provided by `MainNavigation`.

```text
HomeScreen starts
      ↓
selectedWeather available?
      │
 ┌────┴────┐
YES        NO
 │          │
 ↓          ↓
Use it    Fetch default
           city weather
```
The default city is: **Tilhar**.

---

## 21. 🔄 `loadWeather()`

The Home Screen uses: `Future<void> loadWeather(String city)`

This function is responsible for fetching weather.
```text
loadWeather(city)
      ↓
isLoading = true
      ↓
WeatherService.getWeather(city)
      ↓
API
      ↓
WeatherModel
      ↓
weather = result
      ↓
isLoading = false
      ↓
UI updates
```

---

## 22. ⏳ Loading State

Before requesting weather: `isLoading = true;`
The UI displays a loading indicator (`CircularProgressIndicator`). This tells the user that the application is currently working.

---

## 23. ❌ Error State

If the API request fails:
```text
try
 ↓
API request
 ↓
catch
 ↓
errorMessage
```
The application stores the error message, sets `isLoading = false`, and the error UI is displayed. The user can try again.

---

## 24. 🛡️ Why `mounted` Is Checked

After an asynchronous request, the screen might no longer exist. Therefore, Weatherly checks:
```dart
if (!mounted) {
  return;
}
```
before calling `setState()`. This prevents updating a widget that has already been removed from the widget tree.

---

## 25. 🔄 Refresh Weather

The Home Screen also allows the user to refresh weather.
```text
User taps Refresh
       ↓
loadWeather(currentCity)
       ↓
WeatherService
       ↓
OpenWeather API
       ↓
Fresh WeatherModel
       ↓
Weather UI updates
```
This means the app requests fresh data instead of only showing the old value.

---

## 26. 🔎 SearchScreen

`SearchScreen` is responsible for:
```text
Receive city name
      ↓
Request weather
      ↓
Show loading
      ↓
Handle errors
      ↓
Return WeatherModel
```

---

## 27. ⌨️ User Searches a City

Example: User types "Mumbai"
```text
TextField
   ↓
searchCity("Mumbai")
   ↓
WeatherService
   ↓
OpenWeather API
```

---

## 28. 🔄 Search Request

The Search Screen uses `isLoading` and `errorMessage` to control the UI.
- When search begins: `isLoading = true`
- When the response arrives: `isLoading = false`
Then the UI shows either **Success** or **Error**.

---

## 29. 📤 `onCitySelected()` Callback

`SearchScreen` does not directly control `HomeScreen`. Instead, it receives a callback: `onCitySelected`.

When the search succeeds:
```text
SearchScreen
      ↓
onCitySelected(result)
      ↓
MainNavigation
```
This is a callback-based communication pattern.

---

## 30. 🔄 Search → MainNavigation → Home

Complete flow:
```text
User searches Mumbai
        ↓
searchCity()
        ↓
WeatherService
        ↓
OpenWeather API
        ↓
WeatherModel
        ↓
onCitySelected(result)
        ↓
MainNavigation
        ↓
selectedWeather = result
        ↓
index = 0
        ↓
HomeScreen
```
The Home Screen then receives `selectedWeather` and displays Mumbai's weather.

---

## 31. 🔁 `didUpdateWidget()`

`HomeScreen` also uses `didUpdateWidget()`. This is important when `MainNavigation` gives `HomeScreen` a new `selectedWeather`.

```text
Old selectedWeather
        ↓
New selectedWeather
        ↓
didUpdateWidget()
        ↓
weather = new selectedWeather
        ↓
UI updates
```
This allows the Home Screen to react when the selected city changes.

---

## 32. 🌤️ Dynamic Weather Icons

Weatherly converts API conditions into Flutter icons:
- **Clear** → `Icons.wb_sunny`
- **Clouds** → `Icons.cloud`
- **Rain** → `Icons.water_drop`
- **Drizzle** → `Icons.grain`
- **Thunderstorm** → `Icons.thunderstorm`
- **Snow** → `Icons.ac_unit`
- **Mist / Fog / Haze** → `Icons.cloud`

The application also changes icon colors depending on the condition.

---

## 33. 🌡️ Temperature Formatting

The API can return a decimal temperature such as `31.72`. Weatherly formats it for display (e.g., `31°C`). This is handled by `cleanTemperature()`.

---

## 34. 💨 Wind Formatting

Wind speed is also formatted before displaying it (e.g., `4.2367` → `4.2 m/s`). This keeps the UI readable.

---

## 35. 📅 Dynamic Date and Time

Weather Details also displays the current date and time. The application uses `DateTime.now()` and converts it into a readable format (e.g., `Mon 28 Sep, 12:30 PM`). The date and time are generated dynamically when the screen builds.

---

## 36. 📱 Weather Details Screen

The Weather Details Screen receives a `WeatherModel`.
```text
HomeScreen
    ↓
WeatherModel
    ↓
WeatherDetailsScreen
```
The screen then displays: Temperature, Condition, Humidity, Wind Speed, Pressure, Visibility, and Date / Time.

---

## 37. 🧱 Reusable Widgets

Weatherly has reusable widgets in the `widgets/` directory:
- `weather_info_card.dart`
- `weather_stat.dart`

**WeatherInfoCard**: Receives `icon`, `title`, `value`. Example: 💧 Humidity 70%. Instead of writing the same UI multiple times, the widget can be reused.

**WeatherStat**: Receives `icon`, `title`, `value`, `iconColor`. It is useful for displaying a weather statistic in a consistent format.

---

## 38. 🎨 AppColors

Weatherly stores common colors in `theme/app_colors.dart` (e.g., `background`, `gradientBlue`, `gradientDarkBlue`, `cyan`, `sunny`, `humidity`, `wind`, `cardBlue`, `cardDarkBlue`). This avoids repeating the same color values throughout the application.

---

## 39. 📌 AppConstants

Common application values are stored in `utils/constants.dart`. For example:
- `appName`: "Weatherly"
- `tagline`: "More Than Weather"
- `defaultCity`: "Tilhar"

This makes commonly used values easier to maintain.

---

## 40. ⚙️ Settings Screen

The Settings Screen currently provides application information. It contains: About App, App Version, Weatherly, More Than Weather. The About section opens a dialog containing information about the application.

---

## 41. 🔙 Back Navigation

Weatherly uses different navigation behavior depending on the screen.
- **Search / Settings**: These are main navigation tabs. Back navigation returns to Home.
- **Weather Details**: This is a separate route. Back navigation uses `Navigator.pop()` to return to Home.

---

## 42. 🧪 Complete Weather Request

Here is the complete journey of a weather request:
```text
User
 ↓
Home / Search
 ↓
loadWeather() / searchCity()
 ↓
WeatherService.getWeather()
 ↓
Create API URL
 ↓
http.get()
 ↓
OpenWeather Server
 ↓
HTTP Response
 ↓
Check statusCode
 ↓
jsonDecode()
 ↓
Extract JSON values
 ↓
WeatherModel
 ↓
Return
 ↓
setState()
 ↓
Flutter rebuilds UI
 ↓
Weather displayed
```

---

## 43. 🧩 Complete Search Example

Suppose the user searches: **Mumbai**
```text
Mumbai
  ↓
TextField
  ↓
searchCity("Mumbai")
  ↓
WeatherService.getWeather("Mumbai")
  ↓
HTTP GET
  ↓
OpenWeather API
  ↓
JSON
  ↓
jsonDecode()
  ↓
Extract: cityName, temperature, humidity, windSpeed, condition, description, pressure, visibility
  ↓
WeatherModel
  ↓
onCitySelected(result)
  ↓
MainNavigation
  ↓
selectedWeather
  ↓
index = 0
  ↓
HomeScreen
  ↓
Mumbai Weather
```

---

## 44. 🧠 Important Variables

- **`weather`**: Represents the weather currently displayed on HomeScreen.
- **`selectedWeather`**: Represents weather received from MainNavigation (SearchScreen → MainNavigation → selectedWeather → HomeScreen).
- **`weatherService`**: Responsible for communicating with the weather API.
- **`currentCity`**: Stores the city currently being displayed. Used when refreshing weather.
- **`isLoading`**: Represents whether an API request is currently running (`true` → Loading UI, `false` → Weather / Error UI).
- **`errorMessage`**: Stores an error when a request fails (API failure → errorMessage → Error UI).

---

## 45. 🧭 Complete Application Architecture

```text
                         Weatherly
                            │
                            ↓
                         main.dart
                            │
                            ↓
                       SplashScreen
                            │
                            ↓
                    OnboardingScreen
                            │
                            ↓
                     MainNavigation
                            │
              ┌─────────────┼─────────────┐
              ↓             ↓             ↓
            Home          Search        Settings
              │             │
              │             ↓
              │        searchCity()
              │             │
              │             ↓
              │       WeatherService
              │             │
              │             ↓
              │       OpenWeather API
              │             │
              │             ↓
              │       JSON Response
              │             │
              │             ↓
              │       WeatherModel
              │             │
              │             ↓
              └──── selectedWeather
                            │
                            ↓
                         Home UI
                            │
                            ↓
                    Weather Details
```

---

## 46. 🛠️ If You Want to Build Weatherly From Scratch

A developer can rebuild the project in the following order:

1. **Step 1** — Create Flutter Project: `flutter create weatherly`
2. **Step 2** — Create Basic App: Learn and create `MaterialApp`, `Scaffold`, `Widgets`, `Widget Tree`.
3. **Step 3** — Create Screens: `SplashScreen`, `OnboardingScreen`, `HomeScreen`, `SearchScreen`, `WeatherDetailsScreen`, `SettingsScreen`.
4. **Step 4** — Add Navigation: Create `MainNavigation` and connect Home, Search, Settings.
5. **Step 5** — Create WeatherModel: Create `models/weather_model.dart` and add the weather fields required by the UI.
6. **Step 6** — Learn HTTP: Add the HTTP package (`flutter pub add http`). Learn HTTP, GET request, Response, Status code, JSON.
7. **Step 7** — Connect OpenWeather API: Create `services/weather_service.dart` and implement `getWeather(city)`.
8. **Step 8** — Parse JSON: Use `jsonDecode()` and extract the required weather values.
9. **Step 9** — Convert API Data Into WeatherModel: Create `WeatherModel` from the API response.
10. **Step 10** — Connect HomeScreen: Create `loadWeather()` and display Temperature, Humidity, Wind, Condition.
11. **Step 11** — Add Loading and Error States: Handle Loading, Success, Error.
12. **Step 12** — Build Search: Create `searchCity()` and connect it with `WeatherService`.
13. **Step 13** — Send Search Result To Home: Use `onCitySelected()` and `selectedWeather`.
14. **Step 14** — Add Weather Details: Pass `WeatherModel` to `WeatherDetailsScreen`.
15. **Step 15** — Add Reusable Widgets: Create `WeatherInfoCard`, `WeatherStat`.
16. **Step 16** — Add UI Polish: Create `AppColors`, `AppConstants` and build the final dark weather-themed UI.
17. **Step 17** — Test: Test Valid city, Invalid city, No internet, API error, Search, Refresh, Navigation, Back button, Weather details.
18. **Step 18** — Build Release APK: `flutter build apk --release`

---

## 47. 🎯 Core Concepts Learned From Weatherly

Weatherly demonstrates the following Flutter concepts:
```text
Flutter Widgets
      ↓
State
      ↓
setState()
      ↓
Lifecycle
      ↓
Navigation
      ↓
Callbacks
      ↓
Future
      ↓
async / await
      ↓
HTTP
      ↓
REST API
      ↓
JSON
      ↓
Models
      ↓
Loading / Error / Success
      ↓
Reusable Widgets
```

---

## 48. 💡 Main Lesson

The most important architecture lesson from Weatherly is:
```text
UI
 ↓
Service
 ↓
API
 ↓
JSON
 ↓
Model
 ↓
UI
```

Each part has a clear responsibility:
- **UI**: Shows information to the user.
- **Service**: Communicates with the API.
- **Model**: Represents the weather data.
- **Navigation**: Controls movement between screens.
- **Widgets**: Provide reusable UI components.
- **Constants / Colors**: Store reusable application values.

---

## 49. 🌦️ Final Weatherly Flow

```text
                    WEATHERLY
                        │
                        ↓
                 Application Start
                        │
                        ↓
                    Splash
                        │
                        ↓
                   Onboarding
                        │
                        ↓
                 MainNavigation
                        │
          ┌─────────────┼─────────────┐
          ↓             ↓             ↓
        Home          Search        Settings
          │             │
          │             ↓
          │          City Search
          │             │
          │             ↓
          │       WeatherService
          │             │
          │             ↓
          │      OpenWeather API
          │             │
          │             ↓
          │         JSON Data
          │             │
          │             ↓
          │       WeatherModel
          │             │
          └─────────────┘
                        │
                        ↓
                   Weather UI
                        │
                        ↓
                Weather Details
```

---

## 🌟 Conclusion

Weatherly is a simple example of how a Flutter application can communicate with a real external API.

The project demonstrates the complete journey:
```text
User Action
    ↓
Flutter UI
    ↓
Function
    ↓
Service
    ↓
HTTP Request
    ↓
API
    ↓
JSON
    ↓
Model
    ↓
State Update
    ↓
UI
```

Understanding this flow is more important than memorizing individual lines of code. Once this pattern is understood, the same concept can be applied to many other Flutter applications such as:
- News Apps
- Movie Apps
- Crypto Apps
- Food Apps
- E-commerce Apps
- Travel Apps
- Social Apps

---

# 🌦️ Weatherly
**More Than Weather**  
*Built with Flutter 💙*