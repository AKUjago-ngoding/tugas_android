# Silabus Lanjutan — Enterprise Track (Paralel Silabus Resmi 30 Hari)

> Progress resmi: **Hari 8 — GridView, TextField** | Update tiap sesi: centang + catatan singkat
> Sumber: `.github/instructions/flutter-enterprise-mentor.instructions.md`

## Cara pakai
- Checklist jalan paralel silabus resmi, bukan ganti.
- Tiap sesi: baca file ini dulu → konfirmasi hari resmi → ajar topik enterprise relevan → centang.

---

## Fase A — Paralel Hari 1-14 (Dasar & Widget/Layout)
_Target: fondasi production sejak widget pertama_

| # | Topik Enterprise | Map Hari Resmi | Status | Catatan |
|---|---|---|---|---|
| A1 | Dart null safety edge cases (`?`, `!`, `late`, `required`, flow analysis) | 1-4 | [ ] |  |
| A2 | Generics dasar (`List<T>`, `Future<T>`, type inference) | 1-4 | [ ] |  |
| A3 | Extension methods & collection helpers | 5-9 | [ ] |  |
| A4 | Struktur folder scalable (feature-first vs layer-first) — pilih 1, konsisten | 5-9 | [ ] |  |
| A5 | `const` constructor & `const` widget — kenapa cegah rebuild | 5-9 | [x] | Preview Hari 8, perdalam Hari 10-14 |
| A6 | Penamaan file/class/variable (lint `analysis_options.yaml`, `very_good_analysis`) | 5-9 | [ ] |  |
| A7 | Git workflow benar (branch `feat/`, conventional commits, PR review) | 1-4 | [ ] |  |
| A8 | Widget lifecycle & rebuild mental model (↔ React component tree / `useState`) | 10-14 | [ ] |  |

## Fase B — Paralel Hari 15-21 (State Management & SQFLite)
_Target: state & data layer naik level_

| # | Topik Enterprise | Map Hari Resmi | Status | Catatan |
|---|---|---|---|---|
| B1 | `setState` → Provider → Riverpod / Bloc-Cubit (trade-off, kapan pakai mana) | 15-17 | [ ] |  |
| B2 | Local storage lanjutan: Drift/Isar vs SQFLite, migration strategy | 18-19 | [ ] |  |
| B3 | Dependency Injection dasar (`get_it` / `injectable`) | 15-21 | [ ] |  |
| B4 | Unit test & widget test pertama untuk fitur CRUD | 20-21 | [ ] |  |

## Fase C — Paralel Hari 22-30 (Integrasi API)
_Target: networking & arsitektur siap production_

| # | Topik Enterprise | Map Hari Resmi | Status | Catatan |
|---|---|---|---|---|
| C1 | Networking robust: Dio + interceptor, retry, typed error handling | 22-24 | [ ] |  |
| C2 | Clean Architecture ringan (data/domain/presentation) untuk CRUD API | 25-27 | [ ] |  |
| C3 | Caching & offline-first dasar | 25-27 | [ ] |  |
| C4 | Flavors & env (dev/staging/prod), secrets handling | 28-30 | [ ] |  |

## Fase D — Setelah Hari 30 (Lanjutan Mandiri)
_Target: rilis & scale_

| # | Topik Enterprise | Status | Catatan |
|---|---|---|---|
| D1 | Testing lengkap: unit, widget, integration, golden | [ ] |  |
| D2 | CI/CD: GitHub Actions / Codemagic, code signing | [ ] |  |
| D3 | Modularization / package-by-feature | [ ] |  |
| D4 | Performance profiling (DevTools) | [ ] |  |
| D5 | Security: `flutter_secure_storage`, cert pinning, obfuscation | [ ] |  |
| D6 | Design system & theming skala tim | [ ] |  |
| D7 | Accessibility & localization (`intl`) | [ ] |  |
| D8 | Rilis Play Store / App Store | [ ] |  |

---

## Log Progress
| Tanggal | Hari Resmi | Topik Enterprise dibahas | Status |
|---|---|---|---|
| 2026-09-06 | 8 | Inisialisasi track, mapping Fase A | A5 preview |
| 2026-09-06 | 8 | A5 `const` vs `final`, bedah `tugas4.dart` GridView/TextField | A5 partial — paham definisi, belum identifikasi `const` mandiri |

## Next Step (Hari 9)
Lanjut Hari 9. PR: tambah `const` ke `EdgeInsets`/`Text`/`SizedBox`/`Divider` di `tugas4.dart`, cek `flutter analyze`. Next topik: A1 null safety + A4 struktur folder.
