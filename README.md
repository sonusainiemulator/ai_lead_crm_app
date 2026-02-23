# AI Lead CRM App

Flutter demo app for AI-powered lead management integrated with Perfex CRM (mock REST flow).

## Demo Features
- Splash flow to authentication
- Sign In + Sign Up forms (mock email auth)
- Social login buttons (Google + Facebook mock)
- Role selection (Admin / Staff-Employee)
- Bottom navigation app shell (Dashboard, Leads, Calls, Profile)
- Notifications tab with mock reminders and CRM activity alerts
- Shared unread alerts state across tabs (auto-clear on open, restore via demo action)
- Lead listing dashboard with summary stats
- Lead detail screen with CRM-style fields
- Lead creation form with source selection
- AI lead scoring service (mock)
- Call recording demo screen with direct CRM upload (mock)
- Additional Perfex lead modules placeholders (Web to Lead, Campaign, Imported, Referral)

## Mock API Layer
- `lib/services/auth_service.dart` - mock auth/session responses
- `lib/services/lead_service.dart` - lead fetch/create orchestration
- `lib/services/perfex_api_service.dart` - mock Perfex endpoints, module list, call recording upload
- `lib/services/ai_scoring_service.dart` - mock AI score generation

## Run Later (when Flutter is installed)
```
flutter pub get
flutter run
```

## Build APK Later
```
flutter build apk --release
```

## Build Debug APK (GitHub Actions)
If Flutter is not installed locally, use the workflow at .github/workflows/build-debug-apk.yml.

1. Push this project to GitHub.
2. Open Actions tab and run Build Debug APK.
3. Download artifact named app-debug-apk.
4. Install app-debug.apk on your Android device for testing.

## Build Signed Release APK (GitHub Actions)
Use workflow .github/workflows/build-release-apk.yml.

### Required GitHub Secrets
Add these in your GitHub repository settings:
- ANDROID_KEYSTORE_BASE64
- ANDROID_KEYSTORE_PASSWORD
- ANDROID_KEY_ALIAS
- ANDROID_KEY_PASSWORD

### Keystore Preparation
1. Generate keystore (run locally once):
	keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
2. Convert keystore to base64:
	certutil -encode upload-keystore.jks upload-keystore.base64.txt
3. Copy content from upload-keystore.base64.txt (without BEGIN/END lines) into ANDROID_KEYSTORE_BASE64 secret.

### Build Steps
1. Push code to GitHub.
2. Open Actions tab.
3. Run Build Release APK.
4. Download artifact app-release-apk.

## Next Integration Steps
1. Replace mock services with real Perfex CRM REST endpoints.
2. Add secure token/session handling.
3. Connect call recording plugin + real file upload.
4. Map role permissions from backend.
