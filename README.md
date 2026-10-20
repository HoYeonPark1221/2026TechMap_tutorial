# SolarSystem DocC 튜토리얼

visionOS 26의 Spatial Layout API로 확대된 행성과 설명 창을 배치하고, 창만 떠 있는 공유 공간과
전체 몰입 공간을 오가는 한국어 튜토리얼입니다.

- [튜토리얼 보기](https://spatial-computing-techmap.github.io/2026TechMap_tutorial/tutorials/solarsystem/)
  - [1챕터 · 프로젝트와 에셋 준비하기](https://spatial-computing-techmap.github.io/2026TechMap_tutorial/tutorials/solarsystem/01-projectandassets/)
  - [2챕터 · Spatial Layout으로 배치하기](https://spatial-computing-techmap.github.io/2026TechMap_tutorial/tutorials/solarsystem/02-spatiallayout/)
  - [3챕터 · 창과 몰입 공간 오가기](https://spatial-computing-techmap.github.io/2026TechMap_tutorial/tutorials/solarsystem/03-windowandimmersivespace/)
- [행성 모델 패키지 다운로드](https://github.com/Spatial-Computing-TechMap/2026TechMap_tutorial/releases/download/assets-v2/SolarSystem-Assets.zip)
- [원본 앱 프로젝트](https://github.com/Spatial-Computing-TechMap/Solar-System)

## 구성

1. 프로젝트와 에셋 준비하기 — 시작 프로젝트를 열고 모델 패키지를 넣습니다
2. Spatial Layout으로 배치하기 — `SpatialContainer`, `depthAlignment`, `HStackLayout`, `frame(depth:)`, `rotation3DLayout`
3. 창과 몰입 공간 오가기 — `ImmersiveSpaceState`, `openImmersiveSpace`/`dismissImmersiveSpace`, `immersionStyle(selection:in:)`, `windowStyle(.plain)`

나머지(RealityKit의 엔티티·컴포넌트·시스템, 시선과 핀치 입력, 고른 행성을 앞으로 불러오는 코드)는
한 줄씩 따라 쓰지 않고 시작 프로젝트로 제공합니다.

시작 프로젝트는 `.xcodeproj`와 폴더·파일이 모두 갖춰진 상태입니다. 동기화 폴더(Xcode 16+)를 쓰므로
학습자는 폴더에 파일을 넣기만 하면 되고, 직접 쓰는 자리는 "몇 챕터에서 채웁니다"라는 한 줄 주석으로
표시해 두었습니다. 그 외 설명 주석은 모두 걷어냈고, Apple Hello World 샘플에서 가져온 파일의
라이선스 고지만 남겼습니다. 프로젝트 이름과 겹치는 폴더·파일은 두지 않았습니다 — 몰입 공간 뷰는
`ImmersiveSolarSystem`, 그 폴더는 `Scenes`입니다.

내려받을 파일은 두 개이고, 둘 다 **1챕터에서만** 받습니다. 1챕터의 **Project files** 버튼이
프로젝트가 든 `SolarSystem-StartingProject.zip`(약 4MB)이고, 약 305MB인 행성 모델 패키지
`SolarSystem-Assets.zip`은 릴리스에서 바로 받도록 본문에 링크해 두었습니다. 2·3챕터에는 내려받을 것이
없어 버튼을 두지 않았습니다. 프로젝트 zip의 `README.txt`에 폴더 구성과 직접 쓰는 자리가 정리되어 있습니다.

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

스크립트는 튜토리얼이 가리키는 에셋 릴리스 링크가 살아 있는지 확인한 뒤
`.build/SolarSystem.doccarchive`에 정적 웹사이트를 생성합니다. 약 305MB인 에셋 ZIP은 사이트로
다시 게시하지 않고 `assets-v2` 릴리스에서 바로 받게 하므로, 빌드가 그 파일을 내려받지 않습니다.

에셋을 교체할 때만 `scripts/prepare-assets.sh`로 릴리스 파일을 내려받아 `assets.sha256`과 대조합니다.
에셋을 변경하면 릴리스 파일, `assets.sha256`, 필요 시 그 스크립트의 릴리스 태그를 함께 갱신하세요.
`repository.txt`는 에셋 다운로드 위치와 GitHub Pages의 기본 경로를 결정합니다.

### 개인 포크에서 미리보기

`.github/workflows/preview-pages.yml`은 `tutorial_v2` 브랜치에 푸시하면 개인 포크의 Pages로 배포합니다.
조직 저장소에서는 실행되지 않으므로 실제 사이트는 건드리지 않습니다. 포크에서 처음 한 번 해 둘 일이 있습니다.

1. **Actions** 탭에서 워크플로를 활성화합니다. 포크는 기본으로 꺼져 있습니다.
2. **Settings → Pages → Source**를 **GitHub Actions**로 바꿉니다.
3. **Settings → Environments → github-pages**의 배포 허용 브랜치에 `tutorial_v2`를 추가합니다.
   Pages를 켜면 기본 브랜치만 허용되어 있어서, 이 단계를 빼면 빌드는 되지만 배포가 거부됩니다.

### 시작 프로젝트 ZIP 갱신

시작 프로젝트 ZIP(`SolarSystem.docc/Tutorials/Resources/SolarSystem-StartingProject.zip`)은 원본 앱의
`spatialFocusLayout` 브랜치에서 만들었습니다. 원본과 똑같지는 않고 세 가지가 다릅니다.

- 프로젝트 이름과 겹치지 않게 `Solar System` 폴더를 `Scenes`로, `SolarSystem.swift`와 `struct SolarSystem`을
  `ImmersiveSolarSystem`으로 바꿨습니다.
- 튜토리얼에서 직접 쓰는 곳(`SwitchWindows`, `SolarCard`, `PlanetFocusLayout`의 `body`, 몰입 공간 상태 등)을 비웠습니다.
- 설명 주석을 걷어냈습니다. 라이선스 고지와 "몇 챕터에서 채웁니다" 표시는 남겼습니다.

앱 소스가 바뀌면 이 ZIP과 `SolarSystem.docc/Tutorials/Resources/`의 단계별 `.swift` 파일을 함께 갱신해야 합니다.
단계별 파일의 마지막 단계는 앱 소스에서 주석만 뺀 것과 같아야 하고, ZIP에 그대로 들어가는 파일도 앱과
주석을 뺀 코드가 같아야 합니다. ZIP을 만들었으면 압축을 풀어 `WorldAssets`를 `Packages`에 넣고 Xcode로 빌드해 보세요.

배포 구성은 [GitHub Pages 공식 워크플로 안내](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)와
[Swift DocC 정적 호스팅 안내](https://swiftlang.github.io/swift-docc-plugin/documentation/swiftdoccplugin/generating-documentation-for-hosting-online/)를 따릅니다.
