# SolarSystem DocC 튜토리얼

visionOS에서 별 배경, 태양과 여덟 행성, 회전·공전, 탭 포커스와 정보 패널을 만드는 한국어 튜토리얼입니다.

- [튜토리얼 보기](https://spatial-computing-techmap.github.io/2026TechMap_tutorial/tutorials/solarsystem/)
- [프로젝트와 에셋 준비하기](https://spatial-computing-techmap.github.io/2026TechMap_tutorial/tutorials/solarsystem/01-projectandassets/)
- [완성형 에셋 패키지 다운로드](https://github.com/Spatial-Computing-TechMap/2026TechMap_tutorial/releases/download/assets-v2/SolarSystem-Assets.zip)
- [원본 앱 프로젝트](https://github.com/Spatial-Computing-TechMap/Solar-System)

## 구성

세 가지 핵심 개념(Component/System, 공간 입력, Spatial Layout)을 중심으로 진행합니다.

0. 시작하기 전에 — 준비물, 시뮬레이터 조작, 사전 지식, 세 개념 미리 보기
1. 프로젝트와 에셋 준비하기 — 템플릿 정리, 패키지·이미지 연결
2. 창과 몰입 공간 열기 — 별 배경과 태양
3. Component와 System으로 행성 움직이기 — 핵심 개념 1
4. 보고, 집고, 불러오기 — 핵심 개념 2 (공간 입력)
5. Spatial Layout으로 창 만들기 — 핵심 개념 3

각 섹션 끝에서 빌드하고, 챕터 끝에서 실행해 결과를 확인합니다.
Xcode 26 이상, visionOS 26 SDK, Apple silicon Mac이 필요하며 Apple Vision Pro 없이 시뮬레이터로 따라 할 수 있습니다.

1챕터의 `SolarSystem-Assets.zip`에는 Starfield 등 이미지와 태양·여덟 행성 모델을 갖춘 `WorldAssets` 패키지가 들어 있습니다.
2~5챕터의 `SolarSystem-SupportFiles.zip`(`SolarSystem.docc/Tutorials/Resources`)에는 직접 쓰지 않는 설정값·문구 파일이
챕터별 폴더(`Chapter2`~`Chapter5`)로, 각 챕터를 마친 시점의 전체 소스가 `Checkpoints` 폴더로 들어 있습니다.
튜토리얼 코드를 고치면 이 zip의 `Checkpoints`도 함께 갱신하세요.

## 문서 수정 및 배포

DocC 원본은 `SolarSystem.docc`에 있습니다. `main`에 변경을 올리면 GitHub Actions가 문서를 생성하고 GitHub Pages에 배포합니다.
수동 배포는 저장소의 **Actions → Deploy DocC to GitHub Pages → Run workflow**에서 실행합니다.

로컬에서는 Xcode가 설치된 Mac에서 다음 명령을 실행합니다.

```sh
./scripts/build-docs.sh
```

스크립트는 누락된 에셋 ZIP을 이 저장소의 `assets-v2` 릴리스에서 내려받고 `assets.sha256`과 대조한 뒤,
`.build/SolarSystem.doccarchive`에 정적 웹사이트를 생성합니다. 약 300MB인 에셋 ZIP은 Git 이력 대신 릴리스에 보관합니다.
문서의 **Project files**에서도 같은 파일을 내려받을 수 있습니다.

에셋을 변경하면 릴리스 파일, `assets.sha256`, 필요 시 `scripts/prepare-assets.sh`의 릴리스 태그를 함께 갱신하세요.
`repository.txt`는 에셋 다운로드 위치와 GitHub Pages의 기본 경로를 결정합니다.

배포 구성은 [GitHub Pages 공식 워크플로 안내](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)와
[Swift DocC 정적 호스팅 안내](https://swiftlang.github.io/swift-docc-plugin/documentation/swiftdoccplugin/generating-documentation-for-hosting-online/)를 따릅니다.
