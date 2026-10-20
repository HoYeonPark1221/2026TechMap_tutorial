# SolarSystem DocC 튜토리얼

visionOS 26의 Spatial Layout API로 확대된 행성과 설명 창을 배치하고, 창만 떠 있는 공유 공간과
전체 몰입 공간을 오가는 한국어 튜토리얼입니다.

- [튜토리얼 보기](https://spatial-computing-techmap.github.io/2026TechMap_tutorial/tutorials/solarsystem/)
- [Spatial Layout으로 배치하기](https://spatial-computing-techmap.github.io/2026TechMap_tutorial/tutorials/solarsystem/01-spatiallayout/)
- [완성형 에셋 패키지 다운로드](https://github.com/Spatial-Computing-TechMap/2026TechMap_tutorial/releases/download/assets-v2/SolarSystem-Assets.zip)
- [원본 앱 프로젝트](https://github.com/Spatial-Computing-TechMap/Solar-System)

## 구성

1. Spatial Layout으로 배치하기 — `SpatialContainer`, `depthAlignment`, `HStackLayout`, `frame(depth:)`, `rotation3DLayout`
2. 창과 몰입 공간 오가기 — `ImmersiveSpaceState`, `openImmersiveSpace`/`dismissImmersiveSpace`, `immersionStyle(selection:in:)`, `windowStyle(.plain)`

나머지(프로젝트 생성과 에셋 연결, RealityKit의 엔티티·컴포넌트·시스템, 시선과 핀치 입력,
고른 행성을 앞으로 불러오는 코드)는 한 줄씩 따라 쓰지 않고 시작 프로젝트로 제공합니다.

내려받을 파일은 두 가지입니다. 1챕터의 **Project files**는 `WorldAssets` 모델 패키지와 이미지가 든
`SolarSystem-Assets.zip`이고, 2챕터의 **Project files**는 앱 소스가 든
`SolarSystem-StartingProject.zip`입니다. 뒤쪽 zip의 `README.txt`에 어떤 파일을 받아 쓰고 어떤
부분을 튜토리얼에서 직접 쓰는지 정리되어 있습니다.

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

스크립트는 누락된 에셋 ZIP을 이 저장소의 `assets-v2` 릴리스에서 내려받고 `assets.sha256`과 대조한 뒤,
`.build/SolarSystem.doccarchive`에 정적 웹사이트를 생성합니다. 약 249MB인 에셋 ZIP은 Git 이력 대신 릴리스에 보관합니다.
문서의 **Project files**에서도 같은 파일을 내려받을 수 있습니다.

에셋을 변경하면 릴리스 파일, `assets.sha256`, 필요 시 `scripts/prepare-assets.sh`의 릴리스 태그를 함께 갱신하세요.
`repository.txt`는 에셋 다운로드 위치와 GitHub Pages의 기본 경로를 결정합니다.

시작 프로젝트 ZIP(`SolarSystem.docc/Tutorials/Resources/SolarSystem-StartingProject.zip`)은 원본 앱의
`spatialFocusLayout` 브랜치에서 만들었습니다. 앱 소스가 바뀌면 이 ZIP과
`SolarSystem.docc/Tutorials/Resources/`의 단계별 `.swift` 파일을 함께 갱신해야 합니다.

배포 구성은 [GitHub Pages 공식 워크플로 안내](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)와
[Swift DocC 정적 호스팅 안내](https://swiftlang.github.io/swift-docc-plugin/documentation/swiftdoccplugin/generating-documentation-for-hosting-online/)를 따릅니다.
