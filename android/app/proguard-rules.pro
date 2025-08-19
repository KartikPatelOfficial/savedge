# Keep Razorpay classes
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Keep ProGuard annotations
-keep class proguard.annotation.** { *; }
-dontwarn proguard.annotation.**

# Keep Firebase classes
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Keep Gson classes
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# Keep all model classes
-keep class * extends java.io.Serializable { *; }

# Keep all Parcelable classes
-keep class * implements android.os.Parcelable { *; }

# General rules
-dontwarn java.lang.invoke**
-dontwarn **$$serializer
-keepclassmembers class **$WhenMappings {
    <fields>;
}