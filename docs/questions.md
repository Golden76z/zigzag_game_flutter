## Open Questions – Zig-Zag Path Survival

Please answer or refine these before we lock in core gameplay behavior. Each question includes space for an answer.

1. **Existing UI & Integration**
   - Question: How is the existing menu/settings UI structured, and where should the game screen be integrated (e.g., dedicated `GameScreen`, overlay on an existing route)?
   - Answer:

2. **Device Orientation & Aspect Ratio**
   - Question: Should the game run strictly in portrait mode, or support both portrait and landscape? If mixed, which orientation is primary for gameplay?
   - Answer:

3. **Score Definition**
   - Question: Should the score represent elapsed time, vertical distance traveled, or another metric (e.g., difficulty-weighted distance)?
   - Answer:

4. **Difficulty Presets**
   - Question: Which default difficulty presets do you want initially (e.g., Easy/Medium/Hard), and how should they differ in columns, speed, path width, and zig-zag frequency?
   - Answer:

5. **Input Scheme**
   - Question: What is the preferred input method for horizontal movement: drag the player directly, swipe left/right, on-screen buttons, or tilt (gyroscope)?
   - Answer:

6. **Visual Style for MVP**
   - Question: For the first playable version, is a minimalist geometric style (solid colors, simple shapes) acceptable while we wire up systems, before adding final art/skins?
   - Answer:

7. **Game Over UX**
   - Question: On game over, should we pause on the last frame and show an overlay, or transition to a dedicated Game Over screen? Should there be a quick-restart button on the same view?
   - Answer:

8. **Path Visibility**
   - Question: Should the safe path be visually highlighted (e.g., distinct floor color), or should players infer it from subtle cues (e.g., tiles, light/dark zones)?
   - Answer:

9. **Performance Targets**
   - Question: Are there specific device classes or performance targets (e.g., 60 FPS on mid-range Android from year X) we should optimize for immediately?
   - Answer:

10. **Future Online Features**
    - Question: Do you have a preferred backend or service in mind for future leaderboards (e.g., Firebase, Play Games, Game Center, custom backend), so we can avoid conflicting design decisions?
    - Answer:

11. **Audio**
    - Question: Should we plan for basic SFX/music hooks from the beginning (muted by default), or defer audio integration entirely until after core gameplay is stable?
    - Answer:

12. **Persistence**
    - Question: Should we persist best score, difficulty preferences, and basic settings locally from the first version?
    - Answer:

13. **Accessibility & Controls**
    - Question: Are there any accessibility considerations (e.g., colorblind-friendly palettes, adjustable sensitivity, reduced motion) that should influence initial design?
    - Answer:

14. **Debug / Developer Mode Exposure**
    - Question: Is it acceptable to expose a hidden or settings-based “developer mode” for debug overlays and difficulty tweaking in non-release builds?
    - Answer:

15. **Release Strategy**
    - Question: Is the initial target an internal test build or a public store release, and does that influence how polished the MVP needs to be (e.g., placeholder art vs. near-final visuals)?
    - Answer:

