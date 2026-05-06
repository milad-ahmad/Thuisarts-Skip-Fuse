# Skip Fuse Evaluation: Methodology & Steps Taken

This document summarizes the technical steps and experiments performed to evaluate the **Skip Fuse** architecture (Shared Swift Logic + Native Jetpack Compose UI).

## 1. Architectural & maintainability Analysis
*   **Bridge Investigation:** Inspected the transpiled Kotlin classes (e.g., `PageViewModel.kt`). 
    *   *Finding:* Confirmed these are JNI Proxy classes containing `external` declarations and JNI boilerplate, not intended for human maintenance.
*   **Framework Compatibility Check:** Checked inheritance of transpiled classes.
    *   *Finding:* Identified that "ViewModels" do not inherit from `androidx.lifecycle.ViewModel`, resulting in a lack of support for Hilt/Koin injection and `viewModelScope`.

## 2. Feature Development Workflow (Practical Test)
*   **Scenario:** Attempted to add a new "Profile" screen from scratch.
*   **Swift Step:** Created `ProfileViewModel.swift` with `@Observable` properties and a mutation method.
*   **Kotlin Step:** Created `ProfileView.kt` using standard Jetpack Compose.
*   **Integration:** Injected the Swift-backed ViewModel into the native Composable using `remember`.
*   *Conclusion:* The tool effectively bridges logic; adding features is easy, but requires manual bridging of state.

## 3. State Management Deep Dive
*   **Tracing Recomposition:** Investigated how a Swift property change notifies Compose.
*   **Mechanism:** Discovered the internal `MutableStateBacking.kt` and `StateTracking.kt` classes. 
    *   *Finding:* Skip uses a clever "Poke" system where JNI calls increment a Kotlin `MutableState<Int>` to trigger natural Compose recompositions.

## 4. Asynchronous Work & Lifecycle Risk
*   **Cancellation Analysis:** Analyzed how `async` Swift functions are called from Kotlin coroutines.
*   **The "Zombie Task" Experiment:** 
    *   Performed a code-level trace of `suspendCoroutine` vs `suspendCancellableCoroutine`.
    *   *Finding:* Confirmed that Kotlin cancellations **do not propagate** to Swift. Swift tasks are "detached" and continue running even after the UI component is destroyed.
*   **Manual Fix Verification:** Developed and documented a pattern using Swift `clear()` methods and Kotlin `DisposableEffect` to manually manage task lifecycles.

## 5. Tooling & Debugging Friction
*   **Debugger Testing:** Attempted to inspect field values (held by ViewModels) and modify state at runtime during a breakpoint.
*   **The "Opaque Barrier":** 
    *   *Finding:* Debugging tools cannot see through the JNI barrier easily. Field inspection often fails or requires explicit evaluation of native getters.
*   **Compose Previews:** Attempted to render previews for logic-connected components.
    *   *Finding:* **Critical Blocker.** Previews fail because the native JNI runtime (`.so` files) cannot be loaded into the JVM-based Preview environment. Workaround: only use primitive types as composable dependencies. But this can only go so far.

## 6. Performance Observations
*   **JNI Overhead:** Analyzed the cost of property access within loops (e.g., rendering lists).
*   **Profiling:** Used "Profile HWUI Rendering" on-device.
    *   *Finding:* Observed larger/longer spikes during Compose measurement phases, likely due to the high frequency of JNI transitions required to fetch data from the Swift peer.

## 7. Production Readiness Assessment
*   Compiled a final list of "Stress Test" questions for production, covering:
    *   APK size impact of the Swift runtime.
    *   Scalability for 50+ modules.
    *   Complex error propagation (Enums with associated values).
    *   Native interop (passing Android `Uri` or `Bitmap` to Swift).
    *   CI/CD pipeline duration and complexity.
