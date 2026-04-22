# Skip PoC Evaluation Report: Swift for Android (Skip Fuse)

## Executive Summary
Skip Fuse represents a more mature and flexible architectural approach compared to Skip Lite. By sharing only business logic and networking in Swift while maintaining **native UI** for each platform, it solves many of the "Uncanny Valley" issues found in the pure transpilation model. In this model, Skip acts as a high-fidelity language bridge rather than an abstraction framework. This design choice grants developers immense power and flexibility but shifts the burden of lifecycle and resource management directly to the engineering team.

---

## 1. Code Cleanliness & Architecture
- **The Bridge Artifact:** Transpiled Kotlin code consists of **Proxy classes** full of `external` functions and JNI boilerplate. They are NOT intended for human maintenance.
- **"ViewModel" State Holders:** The transpiled classes (e.g., `PageViewModel`) do **not** inherit from `androidx.lifecycle.ViewModel`. They are regular Swift state holders bridged to Kotlin.
    - **Philosophical Choice:** This approach ensures the business logic remains identical across platforms.
    - **Consequence:** They are incompatible with standard Android dependency injection (Hilt) and do not natively support `viewModelScope`. Standard Android lifecycles must be bridged manually.

## 2. Type & Naming Fidelity
- **Mapping:** Swift types (Strings, Optionals, Enums, async/await) map accurately.
- **Opaque Logic:** While names are preserved, the actual logic remains a "black box" behind the JNI barrier. Properties are often accessible only via native getters.

## 3. Natural Jetpack Compose Integration
- **State Management (The "Synthetic" MutableState):** 
    Skip uses a clever internal mechanism to bridge Swift's `@Observable` to Compose. Swift's `ObservationRegistrar` triggers JNI calls to a Kotlin `MutableStateBacking` class, which increments a `MutableState<Int>` to trigger recomposition.
- **Idiomatic Patterns:** Standard Compose patterns (`remember`, `Scaffold`) are used, making the UI layer feel like a standard Android project.

## 4. Developer Experience & QoL (Major Pain Points)
- **Initial Impression:** 8/10.
- **Practical Android Engineering:** 8/10 (Reflecting the tool's success as a high-fidelity logic bridge).
- **Previews:** **CRITICAL BLOCKER.** Standard Compose Previews fail if they instantiate a bridged ViewModel or a `MutableStruct` because the native JNI runtime is unavailable in the JVM preview environment.
- **Debugging Opaque Barrier:**
    - **Field Inspection:** Debugging tools require explicit evaluation of all native-backed fields.
    - **Step-Through:** You cannot "step into" business logic as it crosses into Swift.
    - **Runtime Modification:** You cannot modify ViewModel state during debugging because setters are JNI calls to private Swift properties.

## 5. Lifecycle & Cancellation (Intentional Cooperative Model)
- **The Design:** There is no automatic bridge between Kotlin coroutine cancellation and Swift task cancellation. This is a **deliberate architectural choice** to maintain semantic parity with Swift's `withCheckedContinuation` and avoid "double-resume" crashes.
- **The "Zombie Task" Risk:** When a `LaunchedEffect` is cancelled (e.g., user navigates back), the Kotlin coroutine stops waiting, but the underlying Swift `Task` continues to run unless the developer has implemented cooperative cancellation checks.
- **Developer Responsibility:** Developers must be disciplined about manual lifecycle management, mirroring the patterns used in native Swift development.

### **Implementation Pattern (Manual Structured Concurrency):**
To ensure proper cleanup, developers must manually rebuild the link between the Kotlin scope and the Swift runtime:

**1. Swift (ViewModel.swift):**
The iOS developer must maintain a reference to the active task and implement a `clear()` method.
```swift
public class PageViewModel {
    private var activeTask: Task<Void, Never>? = nil

    public func getData() {
        activeTask?.cancel() // Cancel previous if any
        activeTask = Task {
            let (data, _) = try await URLSession.shared.data(from: ...)
            if Task.isCancelled { return } // Cooperative check
            // ... process data ...
        }
    }

    public func clear() {
        activeTask?.cancel()
        activeTask = nil
    }
}
```

**2. Kotlin (View.kt):**
The Android developer uses a `DisposableEffect` to trigger the bridged cleanup when the Composable leaves the composition.
```kotlin
@Composable
fun PageView() {
    val viewModel = remember { PageViewModel() }

    DisposableEffect(viewModel) {
        onDispose {
            // Signal crosses JNI barrier to call Swift's clear()
            viewModel.clear() 
        }
    }
}
```

---
### **Technical Wishlist: Ideal Cancellation Support**
To achieve parity with native development, the Skip transpiler would ideally generate cancellable coroutines. Currently, no `jniCallId` exists intrinsically for these calls; it would require Skip to manage a map of active call UUIDs.

**WHAT WE WISH SKIP DID (Conceptual):**
```kotlin
// In the transpiled Kotlin PageViewModel.kt
open suspend fun getData(for_: UrlPath): Unit = suspendCancellableCoroutine { continuation ->
    // 1. Skip starts the call and returns a unique ID for this specific execution
    val callId: String = Swift_callback_getData_async(Swift_peer, for_) {
        continuation.resume(Unit)
    }

    // 2. If Kotlin cancels the coroutine, it automatically signals Swift
    continuation.invokeOnCancellation {
        Swift_cancelAsyncCall(callId) // JNI call to kill the detached Swift Task
    }
}
```

---
### **Bridge Rationale: Parity vs. Platform Safety**
The decision to use non-cancellable `suspendCoroutine` is a deliberate choice by the Skip team to maintain **semantic parity** with Swift's concurrency model.
- **Exactly-Once Resumption:** Using `suspendCancellableCoroutine` would cause a Kotlin cancellation to "auto-resume" the coroutine. When the Swift JNI callback later attempts its own `resume()`, the app would hard crash due to a double-resume.
- **Predictability:** By prioritizing mapping Swift's async primitives 1:1, Skip prevents "hidden" cancellation behaviors that don't exist in the original Swift source code.
- **Reference:** [Skip Bridging Guide](https://skip.dev/docs/bridging/).

## 6. Performance Observations
- **JNI Loop Overhead:** Every property access in a loop involves a JNI call.
- **HWUI Spikes:** Profile HWUI rendering reveals larger spikes compared to pure native implementations, likely due to frequent JNI transitions during Compose measurement/placement.

## 7. Testing Strategy
- **Shared Logic:** Must be tested on the Swift side using `XCTest` or `SkipUnit`.
- **Kotlin Bridge:** Difficult to unit test on the JVM (Robolectric) due to JNI dependencies. 
- **UI Testing:** On-device tests (Espresso/Compose) work as JNI is available.

---

## 8. Remaining Questions for Production Readiness
Before adopting Skip Fuse for a large-scale production app, the following areas require further investigation:

1.  **APK Size Impact:** Docs say +60MB are added to APK size due to .so files.
2.  **Multi-Module Scalability:** How does the build system scale with 50+ Swift modules? Do JNI bridge generation and compilation become significant bottlenecks?
3.  **Complex Error Propagation:** How are nested Swift `Error` types (enums with associated values) handled in Kotlin? Is it possible to perform exhaustive `when` checks on them? Would be cool to map these to the future kotlin rich errors 😍
4.  **Native Interop (Android to Swift):** How easily can native Android objects (like a `Uri` from a file picker or a `Bitmap` from a camera) be passed into and processed by Swift functions?
5.  **CI/CD Pipeline Complexity:** What is the overhead of maintaining the Swift Android SDK on CI runners, and how does it affect total pipeline duration?

---

## Final Thoughts
Skip Fuse is a powerful bridge for teams that value UI fidelity and shared business logic. While the lack of standard ViewModel integration and automatic cancellation propagates a "maintenance tax," these are **intentional design trade-offs** rooted in language parity. 

For the Android engineer, the motto is **Caveat Emptor**: you are responsible for the lifecycle of your native peers. If a team accepts this responsibility and implements strict patterns for manual task management starting from the Swift side, Skip Fuse becomes a robust and highly capable production tool. It successfully eliminates the "Uncanny Valley" of cross-platform UI, leaving only the friction of the JNI barrier.

**QoL Score: 8/10**
