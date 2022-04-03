sudo apt -y update && sudo apt -y upgrade
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor
flutter run -d web-server
