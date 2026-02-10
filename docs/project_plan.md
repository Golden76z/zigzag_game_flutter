## Zig-Zag Path Survival – Project Plan

- [x] Chapter 0 – Meta & Foundations
  - [x] Define `.cursorrules` with architecture and performance guidelines
  - [x] Create initial project documentation (`docs/` folder)
  - [x] Confirm build targets and device orientations (Android/iOS, portrait only)
  - [x] Define initial difficulty model (10 unlockable levels with progression)

- [ ] Chapter 1 – Flutter & Flame Setup
  - [ ] Initialize Flutter project (if not already)
  - [ ] Add Flame (and related) dependencies
  - [ ] Create `setup.sh` for dependencies + basic checks
  - [ ] Verify Android build runs on a device/emulator
  - [ ] Verify iOS build runs on a simulator/device (where applicable)

- [ ] Chapter 2 – Core Game Shell
  - [ ] Create main `ZigZagGame` class extending appropriate Flame base
  - [ ] Set up logical coordinate system / viewport
  - [ ] Integrate Flame game widget into existing Flutter UI
  - [ ] Wire basic game lifecycle: start, pause, resume, restart entrypoints

- [ ] Chapter 3 – Game State & Difficulty System
  - [ ] Define `GameSessionState` (score, status, elapsed time/distance)
  - [ ] Define `DifficultyDescriptor` (columns, speed, path width, zig-zag frequency)
  - [ ] Implement difficulty curve over time/distance
  - [ ] Expose difficulty presets (easy/medium/hard) via configuration
  - [ ] Connect difficulty output to camera speed and path parameters

- [ ] Chapter 4 – Path & World Generation
  - [ ] Define column/grid configuration (number of columns, column width)
  - [ ] Design deterministic path segment representation (safe path per segment)
  - [ ] Implement path generator (zig-zag, deterministic, always playable)
  - [ ] Spawn and render world/path segments ahead of camera
  - [ ] Implement cleanup of off-screen segments
  - [ ] Add optional debug rendering for columns and safe path

- [ ] Chapter 5 – Player System
  - [ ] Implement basic player component (circle or placeholder sprite)
  - [ ] Implement horizontal-only movement (touch/drag or buttons)
  - [ ] Ensure smooth movement (lerp/acceleration, not grid snapping)
  - [ ] Implement collision logic against unsafe areas/path bounds
  - [ ] Handle out-of-bounds or off-screen as game over

- [ ] Chapter 6 – Camera & Scrolling
  - [ ] Implement upward camera scrolling tied to difficulty speed
  - [ ] Ensure player remains within view with vertical offset as needed
  - [ ] Sync world generation buffer with camera position
  - [ ] Profile scroll performance and adjust update cadence if needed

- [ ] Chapter 7 – UI, States & Flow
  - [ ] Hook Flame overlays or Flutter screens for: Menu, In-Game HUD, Pause, Game Over
  - [ ] Display score (time/distance survived) and difficulty indicators
  - [ ] Implement start, pause, resume, and restart flows end-to-end
  - [ ] Ensure no unnecessary widget rebuilds on HUD updates

- [ ] Chapter 8 – Difficulty Tuning & Balancing
  - [ ] Tune base values for beginner-friendly gameplay
  - [ ] Verify difficulty scaling feels fair (no impossible layouts)
  - [ ] Add configuration hooks for future modes (e.g., hard mode, challenge seeds)
  - [ ] Document tuning guidelines in `docs/` or config comments

- [ ] Chapter 9 – Polish, Debug Tools & Future Hooks
  - [ ] Add simple debug overlay (FPS, current difficulty parameters)
  - [ ] Add toggles for debug visuals (columns, path bounds, collisions)
  - [ ] Cleanup code, ensure adherence to `.cursorrules`
  - [ ] Document extension points for skins, power-ups, and online leaderboards

