Build scripts and other tools for packaging ANE

## Requirements

* **OS X 10.9+**
* **Xcode 6+** 
* **git 2.3.2+**
To install git on osx simple run `$ git` from Terminal, usually git is coming along with Xcode. For more info see this page - https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
* **AIR SDK 18.0+**
You can download it from Adobe http://www.adobe.com/devnet/air/air-sdk-download.html
* **Java 1.7+ (JDK)** 
It can be installed from Oracle's site - http://www.oracle.com/technetwork/java/javase/downloads/index.html
* **Android SDK 8.0+** and **Android Build Tools 20.0.0** 
You can install Android Studio or use SDK Tools only as described here - https://developer.android.com/sdk/index.html. **Note:** Some minor version of Android Build Tools 21 have issues with packaging.
Using Android SDK Manager tool you need to install:
    - Tools/Android SDK Tools 22 +
    - Tools/Android SDK Platform-tools 22
    - Tools/Android SDK Build-tools 20
    - Android 5.1.1 (API 22)  (or higher)
    - Extras/Android Support Repository 15+
* **gradle 2.4+** You can install it using package manager such as [Homebrew](http://brew.sh) `$ brew install gradle` or do it manually as described here - https://docs.gradle.org/current/userguide/installation.html
* **cocoapods** To install it run in Terminal `$ sudo gem install cocoapods` https://cocoapods.org/
* **Apache ANT 1.9.5+** You can install it using package manager such as [Homebrew](http://brew.sh) `$ brew install ant` or do this manually as described here - http://ant.apache.org/manual/install.html

## Building

0. For first time you need to clone remote repository using git, go to folder where you want to have repository:
~~~
    $ cd /path/to/repo
~~~

replace `{USERNAME}` with your username on bitbucket.org and run git clone command, note that it will ask for you password:

~~~
    $ git clone https://{USERNAME}@bitbucket.org/max.rozdobudko/card.io-ane.git cardscan
~~~

0. Receive latest changes from the remote repository (it optional if you cloned repo just now) using git:

    $ cd /path/to/repo/cardscan
    $ git pull 

0. Then you should configure build script, go to cardscan's `build/` directory:

    $ cd /path/to/repo/cardscan/build

copy `example.buil.properties` to `build.properties`:

    $ cp example.build.properties build.properties

and edit `build.properties` file to have like this:

    bin.ext =
    
    # The location of the .p12 certificate file
    keystore.file=/path/to/your/certificate/selfSignedTestCert.p12
    # The password of the .p12 certificate file
    keystore.password=selfSignedTestPassword
    
    # Location of the Android SDK
    android.sdk=/Users/{USERNAME}/sdks/android
    
    # Location of the AIR SDK
    air.sdk=/Users/{USERNAME}/sdks/air/18.0.0.142

0. Then configure gradle `local.properties` (**Note**: this is not required step if you have `ANDROID_HOME` enviornement variable), go to `cardscan-android/` directory:

    $ cd /path/to/repo/cardscan/cardscan-android

copy `example.local.properties` to `local.properties`

    $ cp example.local.properties local.properties

and provide location of your Android SDK:

    sdk.dir=/Users/{USERNAME}/sdks/android

5. And run `ant`:

    $ ant

Then you finish, built `cardscane.ane` file will be located in `bin\` directory.
