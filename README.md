# 쇼핑숏컷

쇼핑 트렌드 영상에서 상품을 찾고, 레퍼런스 장면으로 AI 숏폼(9:16 mp4)을 만드는 데스크톱 앱입니다.

새 버전과 바뀐 점은 [릴리즈](https://github.com/aiteamjang/shoppingshortcut-releases/releases)에서 볼 수 있습니다.

## 윈도우

1. [최신 릴리즈](https://github.com/aiteamjang/shoppingshortcut-releases/releases/latest)에서 `ShoppingShortcut-Setup.exe`를 받아 실행합니다.
2. "Windows의 PC 보호" 창이 뜨면 **추가 정보 → 실행**을 누릅니다.
3. 바탕화면이나 시작 메뉴의 **쇼핑숏컷**으로 켭니다.

업데이트도 같은 방법으로 새 `Setup.exe`를 받아 실행하면 됩니다.

## 맥 (Apple 칩·인텔)

**터미널**(응용 프로그램 > 유틸리티 > 터미널)을 열고 아래 한 줄을 붙여 넣은 뒤 Enter를 누릅니다.

```bash
curl -fsSL https://raw.githubusercontent.com/aiteamjang/shoppingshortcut-releases/main/install.sh | bash
```

응용 프로그램 폴더에 **쇼핑숏컷**이 설치되고 바로 열립니다. 업데이트도 같은 한 줄입니다.

릴리즈 페이지의 zip 파일을 브라우저로 직접 받으면 맥이 "확인되지 않은 개발자"로 막을 수 있으니 위 한 줄로 설치해 주세요.

## 사용 전에

설정 > 외부 연동에서 API 키(YouTube, 쿠팡 파트너스, Gemini, TikHub)를 넣습니다. 키는 이 컴퓨터에만 저장됩니다.
