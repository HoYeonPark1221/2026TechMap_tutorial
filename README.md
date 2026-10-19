# SolarSystem DocC 튜토리얼

visionOS에서 별 배경, 태양과 여덟 행성, 회전·공전, 탭 포커스와 정보 패널을 만드는 한국어 튜토리얼입니다.

- [튜토리얼 보기](https://spatial-computing-techmap.github.io/2026TechMap_tutorial/tutorials/solarsystem/)
- [프로젝트와 에셋 준비하기](https://spatial-computing-techmap.github.io/2026TechMap_tutorial/tutorials/solarsystem/01-projectandassets/)
- [완성형 에셋 패키지 다운로드](https://github.com/Spatial-Computing-TechMap/2026TechMap_tutorial/releases/download/assets-v1/SolarSystem-Assets.zip)
- [원본 앱 프로젝트](https://github.com/Spatial-Computing-TechMap/Solar-System)

## 구성

1. 프로젝트와 에셋 준비하기
2. 행성 엔티티 만들기
3. 보고, 집고, 불러오기
4. 하나의 앱으로 조립하기

첫 장은 새 프로젝트 생성부터 별 배경 추가, 로컬 패키지 연결까지 실제 Xcode 캡처와 함께 안내합니다.
다운로드 파일에는 Starfield.jpg와 태양·여덟 행성의 모델 및 연결 텍스처를 갖춘 SolarSystemAssets 패키지가 포함됩니다.
`Package.swift`가 있는 패키지 폴더 전체를 프로젝트 안으로 복사한 뒤 **Add Local**로 앱 타깃에 연결합니다.
앱을 따라 만들 때는 Xcode 26 이상과 visionOS 26 이상을 사용합니다.
Apple Vision Pro 실기는 없어도 되며, visionOS 시뮬레이터에서 끝까지 따라갈 수 있습니다.
시뮬레이터에서는 시선과 핀치가 마우스·트랙패드 클릭으로 대체됩니다.

## 문서 수정 및 배포

DocC 원본은 `SolarSystem.docc`에 있습니다. `main`에 변경을 올리면 GitHub Actions가 문서를 생성하고 GitHub Pages에 배포합니다.
수동 배포는 저장소의 **Actions → Deploy DocC to GitHub Pages → Run workflow**에서 실행합니다.

로컬에서는 Xcode가 설치된 Mac에서 다음 명령을 실행합니다.

```sh
./scripts/build-docs.sh
```

스크립트는 누락된 에셋 ZIP을 이 저장소의 `assets-v1` 릴리스에서 내려받고 `assets.sha256`과 대조한 뒤,
`.build/SolarSystem.doccarchive`에 정적 웹사이트를 생성합니다. 약 249MB인 에셋 ZIP은 Git 이력 대신 릴리스에 보관합니다.
문서의 **Project files**에서도 같은 파일을 내려받을 수 있습니다.

에셋을 변경하면 릴리스 파일, `assets.sha256`, 필요 시 `scripts/prepare-assets.sh`의 릴리스 태그를 함께 갱신하세요.
`repository.txt`는 에셋 다운로드 위치와 GitHub Pages의 기본 경로를 결정합니다.

배포 구성은 [GitHub Pages 공식 워크플로 안내](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)와
[Swift DocC 정적 호스팅 안내](https://swiftlang.github.io/swift-docc-plugin/documentation/swiftdoccplugin/generating-documentation-for-hosting-online/)를 따릅니다.
