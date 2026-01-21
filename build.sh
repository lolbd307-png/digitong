#!/bin/bash
set -e

APP_NAME="Digitong"
PACKAGE="com/digitong/app"

echo "🚀 Initializing $APP_NAME project..."

# Root folders
mkdir -p android/app/src/main/java/$PACKAGE
mkdir -p android/app/src/main/res
mkdir -p ai-engine/{export,inference,models}
mkdir -p scripts
mkdir -p .github/workflows

# Android gradle files
cat <<EOF > android/settings.gradle.kts
rootProject.name = "$APP_NAME"
include(":app")
EOF

cat <<EOF > android/build.gradle.kts
buildscript {
    repositories {
        google()
        mavenCentral()
    }
}
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
EOF

cat <<EOF > android/app/build.gradle.kts
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
EOF

# .gitignore
cat <<EOF > .gitignore
# AI Models
ai-engine/models/

# Gradle
.gradle/
**/build/

# Local
local.properties
EOF

# GitHub Actions
cat <<EOF > .github/workflows/android-build.yml
name: Digitong APK Build

on:
  push:
    branches: [ "main" ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4

    - name: Setup JDK
      uses: actions/setup-java@v4
      with:
        distribution: temurin
        java-version: 17

    - name: Setup Android SDK
      uses: android-actions/setup-android@v3

    - name: Download AI Models
      run: bash scripts/download_models.sh

    - name: Build APK
      run: |
        cd android
        ./gradlew assembleRelease

    - name: Upload APK
      uses: actions/upload-artifact@v4
      with:
        name: Digitong-APK
        path: android/app/build/outputs/apk/release/
EOF

# Model downloader (placeholder)
cat <<EOF > scripts/download_models.sh
#!/bin/bash
mkdir -p ai-engine/models
echo "⬇️ Download AI models here (ignored by git)"
EOF
chmod +x scripts/download_models.sh

# README
echo "# Digitong – AI Face Swap App" > README.md

chmod +x build.sh

echo "✅ $APP_NAME project structure created successfully"
