# FinnData project 💼

A Flutter project for the CPMDWF course midterm.\
It uses [FinnHub api](https://finnhub.io) for fetching data about stocks, that's been displayed in the app.


## Description of a project 📝
It's a stock app.\
This application allows you to search and receive information about stocks.\
To do this, you must login or register.

## How to build ❓
To generate json serializable of the created models use
 ```bash
flutter pub run build_runner build
```
To build the app for Android use
```bash
flutter build apk
```

To build the app for web use
```bash
flutter build web
```
## Screenshots from the app 📱
you first need to either SignIn or SignUp, then you'll be in Home Screen,
<table>
  <tr>
    <td align="center">SignIn Screen</td>
    <td align="center">SignUp Screen</td>
  </tr>
  <tr>
    <td><img src="/screenshots/login.png" width=300 height=533></td>
    <td><img src="/screenshots/register.png" width=300 height=533></td>
  </tr>
</table>


In Home Screen, there is a list of Market News, and you can also search on stocks and mark stocks,
using Stock Symbol search shown in the second table.
<table>
  <tr>
    <td align="center">Home Screen</td>
    <td align="center">Search Screen</td>
  </tr>
  <tr>
    <td><img src="/screenshots/home.png" width=300 height=533></td>
    <td><img src="/screenshots/search.png" width=300 height=533></td>
  </tr>
</table>

then once you click on any of the resulted list items, you will be forwarded to Stock Info Screen, where
you can see current stock price. \
Marked stocks go to the corresponding screen for your saved stocks.
<table>
  <tr>
    <td align="center">Stock Info Screen</td>
    <td align="center">Saved Stocks</td>
  </tr>
  <tr>
    <td><img src="/screenshots/stock.png" width=300 height=533></td>
    <td><img src="/screenshots/saved.png" width=300 height=533></td>
  </tr>
</table>

You can also change themes or language if you want it in Settings screen.
<table>
  <tr>
    <td align="center">Settings</td>
    <td align="center">White and Dark Themes</td>
  </tr>
  <tr>
    <td><img src="/screenshots/settings.png" width=300 height=533></td>
    <td><img src="/screenshots/dark-white-themes.png" width=300 height=533></td>
  </tr>
</table>

You can also log out from our application if you want or stay if you changed your mind.
<table>
  <tr>
    <td align="center">Log Out</td>
  </tr>
  <tr>
    <td><img src="/screenshots/logout.png" width=300 height=533></td>
  </tr>
</table>

## List of features
The app is available for both web and android, & uses firebase for storing authentication credentials.  
    

