prepare:
	flutter channel beta
	flutter upgrade
	flutter config --enable-web
	flutter doctor
	flutter devices

create:
	flutter create app_name

upgrade:
	dart pub upgrade --major-versions

run:
	flutter run -d chrome

