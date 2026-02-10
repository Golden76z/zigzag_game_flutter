## Zig-Zag Path Survival – Project Plan

- [x] Chapter 0 – Meta & Foundations
  - [x] Define `.cursorrules` with architecture and performance guidelines
  - [x] Create initial project documentation (`docs/` folder)
  - [x] Confirm build targets and device orientations (Android/iOS, portrait only)
  - [x] Define initial difficulty model (10 unlockable levels with progression)

- [ ] Chapter 1 – Flutter & Flame Setup
  - [x] Initialize Flutter project (if not already)
  - [x] Add Flame (and related) dependencies
  - [x] Create `setup.sh` for dependencies + basic checks
  - [ ] Verify Android build runs on a device/emulator
  - [ ] Verify iOS build runs on a simulator/device (where applicable)

- [ ] Chapter 2 – Core Game Shell
  - [x] Create main `ZigZagGame` class extending appropriate Flame base
  - [x] Set up logical coordinate system / viewport
  - [x] Integrate Flame game widget into existing Flutter UI
  - [x] Wire basic game lifecycle: start, pause, resume, restart entrypoints

- [ ] Chapter 3 – Game State & Difficulty System
  - [x] Define `GameSessionState` (score, status, elapsed time/distance)
  - [x] Define `DifficultyDescriptor` (columns, speed, path width, zig-zag frequency)
  - [x] Implement difficulty curve over time/distance
  - [x] Expose difficulty presets (levels 1–10) via configuration
  - [x] Connect difficulty output to camera speed and path parameters

- [ ] Chapter 4 – Path & World Generation
  - [x] Define column/grid configuration (number of columns, column width)
  - [x] Design deterministic path segment representation (safe path per segment)
  - [x] Implement path generator (zig-zag, deterministic, always playable)
  - [x] Spawn and render world/path segments ahead of camera
  - [x] Implement cleanup of off-screen segments
  - [x] Add optional debug rendering for columns and safe path

- [ ] Chapter 5 – Player System
  - [x] Implement basic player component (circle or placeholder sprite)
  - [x] Implement horizontal-only movement (touch/drag or buttons)
  - [x] Ensure smooth movement (lerp/acceleration, not grid snapping)
  - [x] Implement collision logic against unsafe areas/path bounds
  - [x] Handle out-of-bounds or off-screen as game over

- [ ] Chapter 6 – Camera & Scrolling
  - [x] Implement upward camera scrolling tied to difficulty speed
  - [x] Ensure player remains within view with vertical offset as needed
  - [x] Sync world generation buffer with camera position
  - [ ] Profile scroll performance and adjust update cadence if needed

- [ ] Chapter 7 – UI, States & Flow
  - [x] Hook Flame overlays or Flutter screens for: Menu, In-Game HUD, Pause, Game Over
  - [x] Display score (time/distance survived) and difficulty indicators
  - [x] Implement start, pause, resume, and restart flows end-to-end
  - [x] Ensure no unnecessary widget rebuilds on HUD updates

- [ ] Chapter 8 – Difficulty Tuning & Balancing
  - [ ] Tune base values for beginner-friendly gameplay
  - [ ] Verify difficulty scaling feels fair (no impossible layouts)
  - [ ] Add configuration hooks for future modes (e.g., hard mode, challenge seeds)
  - [ ] Document tuning guidelines in `docs/` or config comments

- [ ] Chapter 9 – Polish, Debug Tools & Future Hooks
  - [x] Add simple debug overlay (FPS, current difficulty parameters)
  - [x] Add toggles for debug visuals (columns, path bounds, collisions)
  - [ ] Cleanup code, ensure adherence to `.cursorrules`
  - [ ] Document extension points for skins, power-ups, and online leaderboards

