# Repository Guidelines

## Project Structure

Box3D is a C17 rigid-body physics library. Public API headers live in `include/box3d/`. Keep implementation details and private headers in `src/`. The C++20 sample app lives in `samples/`, unit tests in `test/`, and performance benchmarks in `benchmark/`. Check `shared/` for reusable simulation scenes before adding one. Hull, mesh, and tree assets live in `data/`.

## Build and Run

Run these commands from the repository root on Linux so the samples can locate their assets.

```sh
cmake --preset linux-debug           # Configure a Debug build
cmake --build --preset linux-debug   # Build the library, tests, and samples
./build/bin/test                     # Run the full unit suite
./build/bin/test ShapeTest           # Run just the shape suite
./build/bin/samples                  # Launch the interactive sample browser
```

Use CMake 3.22 or newer. For Windows and macOS build commands, see [README.md](README.md).

## Coding Style

Build without compiler warnings. Format changed C and C++ files with the repository’s `.clang-format`, for example `clang-format -i src/body.c`. It specifies tab indentation, a 120-column limit, and left-aligned pointers. Use snake_case filenames and follow existing symbol names such as `b3Capsule` and `b3ComputeSphereMass`. Document public APIs with Doxygen comments.

## Testing

Add regression cases to the relevant `test/test_<subsystem>.c` file. Use the project’s C test macros from `test/test_macros.h`, including `ENSURE` for assertions and `RUN_TEST` to invoke cases. When adding a suite, list its source in `test/CMakeLists.txt` and register its entry point in `test/main.c`. The runner accepts an exact suite name.

## Commits and Pull Requests

Discuss the change first and wait for the maintainer’s `ready-for-pr` label before writing code. Branch from `main` in your fork and keep each PR to one logical change. Use short, descriptive commit subjects like the project’s “Improve compound serialization.”

Include `Closes #123` with the approved issue number in the PR description. Complete the template by running the unit tests and all samples, ensure CI passes, and sign the CLA when prompted on your first PR. Follow [CONTRIBUTING.md](CONTRIBUTING.md) and the [README’s LLM usage policy](README.md#llm-usage).
