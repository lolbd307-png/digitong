plugins {
    id("com.android.application")
    kotlin("android")
}

android {
    namespace = "com.digitong.app"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.digitong.app"
        minSdk = 33
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.activity:activity-compose:1.9.0")
}
